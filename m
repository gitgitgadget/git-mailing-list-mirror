From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/4] buitin-status: Add tests for submodule summary
Date: Fri, 14 Mar 2008 02:14:44 +0800
Message-ID: <46dff0320803131114v3218cc5etdd729b53d3a0d44d@mail.gmail.com>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-2-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-4-git-send-email-pkufranky@gmail.com>
	 <1205416085-23431-5-git-send-email-pkufranky@gmail.com>
	 <47D93875.1050407@viscovery.net>
	 <7vprtyxzzd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrxl-0002gM-4y
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbYCMSOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbYCMSOx
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:14:53 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:8134 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYCMSOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:14:52 -0400
Received: by an-out-0708.google.com with SMTP id d31so843395and.103
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7JyHK4VbIp+TPuG6L/6M8qHwEocH4W3m4VW/ttPbpj8=;
        b=f2MAkgYSAIO9/GUyd6bJq5sMrKxv677zIZSWvwjQ+KgvXnqn36a6UWO8tod9EfxGhu9DZoc4CjxSVoxpX3ZymNc9pFFLL0GjXjcbeATAWoqWYevGEsBjH47RgJEORH2Ol0l5YuNpFLvNZH+519CeDw4vyUi73hahlOtS8M13Apk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q6/1O/7DOYA3iOgaxM+KTxJLcAi0xYDAYYcqJQaoAApLcnTTgXOeXy+CZmmNuc7ydV5pjcYx/76qVyP9HvczCUjUr1JMG+J+ioMizhPXqynAOjuXmuwn9MpouF2tzdiqX+9IWFWRlxSa+0Ow1QDOhvHAB7whpyrcVWa9PpKtU9Q=
Received: by 10.100.105.15 with SMTP id d15mr73919anc.61.1205432088042;
        Thu, 13 Mar 2008 11:14:48 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Thu, 13 Mar 2008 11:14:44 -0700 (PDT)
In-Reply-To: <7vprtyxzzd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77122>

On Fri, Mar 14, 2008 at 2:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>  > Ping Yin schrieb:
>  >> +cd sm &&
>  >> +head=$(git rev-parse --verify HEAD | cut -c1-7) &&
>  >> +cd ..
>  >
>  > I think you can make these three lines into:
>  >
>  > test_expect_success 'get short SHA1 of submodule HEAD' '
>  >
>  >       head=$(cd sm && git rev-parse --verify HEAD | cut -c1-7)
>  > '
>
>  "git rev-parse --short=12 --verify HEAD" or whatever minimum length you
>  would want would free you from an ugly "pipe to cut".
>
Thanks.

diff --git a/t/t7502-status.sh b/t/t7502-status.sh
index 7a9a08f..80e2a7b 100755
--- a/t/t7502-status.sh
+++ b/t/t7502-status.sh
@@ -187,9 +187,7 @@ test_expect_success
        git diff expect output
 '

-cd sm &&
-head=$(git rev-parse --verify HEAD | cut -c1-7) &&
-cd ..
+head=$(cd sm && git rev-parse --short=7 --verify HEAD)

 cat > expect <<EOF
 # On branch master



-- 
Ping Yin
