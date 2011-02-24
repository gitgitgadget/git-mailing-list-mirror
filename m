From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] trace: add trace_vprintf
Date: Thu, 24 Feb 2011 15:08:36 -0600
Message-ID: <20110224210836.GE17412@elie>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142814.GC15477@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 22:09:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsiR1-0000re-DC
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 22:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab1BXVJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 16:09:10 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63704 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab1BXVJI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 16:09:08 -0500
Received: by vxi39 with SMTP id 39so829750vxi.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 13:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XjKIKMrJ5I3DnKjBute17hHwVRUXGAcXBpwDCB5mBsE=;
        b=JUQ0fMVp+Ib1RgOxxIlCFjKMFLPd7X/G0C4kohPY54PiJd1lvxK0BKJBfIdhSvShIU
         pSyp3ceqKBe+1pb5uMgZYrWlknjKEuQ9qx5s1QRHu8Zxszd4uNk0wR7FvvyTsUVYGjN0
         L3tLkfK61EH/W25cfHsw3Bcxaq7/6scAUCVJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vnJqqQbTM/3L5dUHMJzQSY05hV8kn53s0tPlmdaGxevRUK6KuDNUbg5Ox43V4gtLZ+
         YRyCvn/hP6pMld8KfWGIGYlkbJRA9VnYNqLqU4pXdCFfKZFttJvPA3HuAaeobE6qXiSg
         QXuVZK4rdJo819pOW2vlS2yzkVny7RLiVFdM8=
Received: by 10.52.167.33 with SMTP id zl1mr2570202vdb.53.1298581722833;
        Thu, 24 Feb 2011 13:08:42 -0800 (PST)
Received: from elie ([69.209.53.52])
        by mx.google.com with ESMTPS id b5sm1896040vcx.28.2011.02.24.13.08.40
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 13:08:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110224142814.GC15477@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167862>

Jeff King wrote:

> --- a/cache.h
> +++ b/cache.h
> @@ -1067,6 +1067,7 @@ extern void alloc_report(void);
>  /* trace.c */
>  __attribute__((format (printf, 1, 2)))
>  extern void trace_printf(const char *format, ...);
> +extern void trace_vprintf(const char *format, va_list ap);

Micronit.

Though now that I think of it, the format(printf, n, 0) attribute
doesn't seem to be used anywhere in git currently.  Is it unportable?
---
diff --git a/cache.h b/cache.h
index 08b23b2..288d4d0 100644
--- a/cache.h
+++ b/cache.h
@@ -1067,6 +1067,7 @@ extern void alloc_report(void);
 /* trace.c */
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
+__attribute__((format (printf, 1, 0)))
 extern void trace_vprintf(const char *format, va_list ap);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
