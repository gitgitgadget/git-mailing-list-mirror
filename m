From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 08:59:46 +0530
Message-ID: <CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 05:30:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul9rX-00046x-W8
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 05:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab3FHDa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 23:30:27 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:53379 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab3FHDa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 23:30:26 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so12454808ied.14
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vqdUfmt1J0Wr4mOih1cNMPMyfjxdHj30GK04TdNgodE=;
        b=0iGQgZgTi6foSvwhRk8jfxjrmua9Nj8dh4ewPEUXf05NpOdCCErvG4KlhubYJDoZBg
         Rs1PYtw/aKcoEMBTBUtkpgrHLGbjOM9p9YP8e3Z+5oPddaxWXUEwBIew2X2H6Sbwi5kb
         eUk7niH1JKh4SNGl8QjGcIBPPUUW4pV6kJS+YjvsgJ9m/1GW1t968Je1a56QCKjZHR+g
         Vh7MxPmjdsyduV4kLzUxo/qH5IAZjNcVtXtFKQaL+ugc+twap3KXwPMtBh6HCpYVo5ps
         A8KgzfYyx8uD7uLei+ldj3bHK0QeFy4mFxekPMG6vQHuJ9mPIMYh6CywE/U6Acldr1k9
         qNZw==
X-Received: by 10.50.141.230 with SMTP id rr6mr197720igb.89.1370662226381;
 Fri, 07 Jun 2013 20:30:26 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 20:29:46 -0700 (PDT)
In-Reply-To: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226783>

Felipe Contreras wrote:
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index a5e69f3..ff370a3 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -71,8 +71,7 @@ testrebase() {
>                 test_must_fail git rebase$type related-onto-branch &&
>                 test_path_is_file $dotest/autostash &&
>                 ! grep dirty file3 &&
> -               rm -rf $dotest &&
> -               git reset --hard &&
> +               git rebase --abort &&
>                 git checkout feature-branch
>         '

Incorrect.  I don't assume that --abort works yet, in this test.  It
is non-trivial to get --abort to work with autostash, and this is
tested in a separate test: see "rebase$type: --abort" in the same
file.
