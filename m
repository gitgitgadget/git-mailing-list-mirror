From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/3] pretty: make it easier to add new formats
Date: Sun, 2 May 2010 06:22:32 -0500
Message-ID: <20100502112231.GA2806@progeny.tock>
References: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
 <1272798044-10487-2-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 02 13:28:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8XLK-0004FZ-3i
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986Ab0EBLWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 07:22:41 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:39345 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756Ab0EBLWk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:22:40 -0400
Received: by iwn12 with SMTP id 12so2070327iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 04:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MCeqgtyQUezm8E3rRG8WQP6rryfFf45pg+ANMXs13VQ=;
        b=WRf3UgNIyQQt4f8OHRCT8nsmA4KDn0hPPPhKFORCtFsr3bpddo332wWVy4YNbu+gWW
         sLcTSznnTwT17PtCEl8sc0niXZGOlm3mcH/49HyDpD0xFWzgKVkE7g49kQU4VfEob7rD
         EITaabTBL7suiY9liObg4+kVqmceZ6Dj6u4ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mE1oVzST2TrczV6UxAKMu9fCkmI/s8lQlRq94gluJEiYGSSHJiVRS2WvSzqqilUtH0
         Z5aqENWljYr5xoavhAFcLu4m6t+O/xft7BhE44zyuB0DypbWMIGHDncDO/x5eV1d8KV4
         1HVr1y3AQp9y/eJ89X4n59vVBItX1Sn+k80+o=
Received: by 10.231.144.69 with SMTP id y5mr7207473ibu.46.1272799358460;
        Sun, 02 May 2010 04:22:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm3355327iwn.0.2010.05.02.04.22.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 04:22:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272798044-10487-2-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146164>

Will Palmer wrote:

> As the first step towards creating aliases, we make it easier to add new
> formats to the list of builtin formats.
[...]
> +	commit_formats_len = ARRAY_SIZE(builtin_formats);
> +	commit_formats = xcalloc(commit_formats_len,
> +				 sizeof(*builtin_formats));
> +	memcpy(commit_formats, builtin_formats,
> +	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
> +}

nitpick: it should be safe to s/xcalloc/xmalloc/

With or without such a change, the patch looks good to me.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the clean patch.

diff --git a/pretty.c b/pretty.c
index ecac8f5..41c0145 100644
--- a/pretty.c
+++ b/pretty.c
@@ -40,7 +40,7 @@ static void setup_commit_formats(void)
 		{ "oneline",	CMIT_FMT_ONELINE,	1 }
 	};
 	commit_formats_len = ARRAY_SIZE(builtin_formats);
-	commit_formats = xcalloc(commit_formats_len,
+	commit_formats = xmalloc(commit_formats_len *
 				 sizeof(*builtin_formats));
 	memcpy(commit_formats, builtin_formats,
 	       sizeof(*builtin_formats)*ARRAY_SIZE(builtin_formats));
