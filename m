From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 03/16] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Sun, 3 Oct 2010 08:47:58 -0500
Message-ID: <20101003134757.GA17084@burratino>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-4-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 15:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2OyR-0004Jb-M6
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 15:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab0JCNvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 09:51:21 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42351 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab0JCNvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 09:51:20 -0400
Received: by qyk32 with SMTP id 32so1011971qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7Q+pgGnshqW3rx2u7/FoJcBE4lrA8U1Mfzni5Io7JN4=;
        b=vPM0AqHj+sv/xnLCXNhV9hzsyxhd7c0boM1o+w9OBRwxjL+BVpOXRt0TOzsqKPPzRF
         7pymnoKr5uhwEKArzhE5BmbCMdvjJBC2g+odvKtyeziY2jxWySHRkmm/qjLs1lO2imQq
         WEkWSOyQpgLCSuAxl2H6R2fDhr+8vjfYjGVXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Db7A1ozp1ysvM3iKeFjRol7F++D0e4itJCg2AQ7ZkRK9qfm47apO+kKW168S7bThm9
         a7mWpbbjgmH31DKPaFmz/X7afax/9R4HfoME72qkD7wbTtyyHxQgx694dUbbccSIm2m4
         R5L0KPHltKAaTzfli+IIlwsvBVoLy0rcE6/8k=
Received: by 10.229.1.93 with SMTP id 29mr5818610qce.293.1286113879414;
        Sun, 03 Oct 2010 06:51:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id f15sm4048241qcr.37.2010.10.03.06.51.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 06:51:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286082644-31595-4-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157872>

Elijah Newren wrote:

> Signed-off-by: Elijah Newren <newren@gmail.com>

For the confused: this patch takes advantage of patch 1 to clarify
the t4017 (diff exit code) tests.  No functional change should be
involved, except better error messages when tests fail with -v.

> --- a/t/t4017-diff-retval.sh
> +++ b/t/t4017-diff-retval.sh
[...]
> @@ -145,20 +122,14 @@ test_expect_success 'check honors conflict marker length' '
>  	git reset --hard &&
>  	echo ">>>>>>> boo" >>b &&
>  	echo "======" >>a &&
> -	git diff --check a &&
> -	(
> -		git diff --check b
> -		test $? = 2
> -	) &&
> +	git diff --check a
> +	test_expect_code 2 git diff --check b &&

Missing &&?

With that exception,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
