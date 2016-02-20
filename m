From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] git-compat-util.h: move extension stripping from
 handle_builtin()
Date: Sat, 20 Feb 2016 18:35:47 +0600
Message-ID: <20160220123547.GB1389@localhost>
References: <1455955858-30081-1-git-send-email-kuleshovmail@gmail.com>
 <20160220084804.GB17171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 13:40:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX6qG-0007iF-5J
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 13:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbcBTMkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 07:40:06 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35230 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbcBTMkE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 07:40:04 -0500
Received: by mail-lf0-f41.google.com with SMTP id l143so69501258lfe.2
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 04:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kMZNhjTSBuKNK6Mu4Hq/EasSWTar6UCez8olCaO02lI=;
        b=t+a3TmKp28K2Dc9r20wlnin1hZTeMk4xR93ossfkfzT6AranV2N8bPu5iJWr+fwMVK
         wCZ7STo2ObBjk08NSiTXl7SDAA0WkRThH9iv05KP/wMz7efada1pApbqNxVX4AgmlbYM
         zRvnFfyXeGL9KIEEDH/d2kUkzxszMpVpE/55T8W3XCec6ZFH2vTTH4VWSo9ko5RkKy3n
         wTGkGDgIwWmC8GK9ieewC6gH7X7z1ZAMzFB1CC7srYeZ/Jblvi/deXFciei9u9qY9GtE
         4c3xilRqyKapIIeODKL0vbIP7bdFkOHeS2n2SChgvM5nvd8EqebnRlxelzjqqPNwDjfp
         4ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kMZNhjTSBuKNK6Mu4Hq/EasSWTar6UCez8olCaO02lI=;
        b=G0++ZRZ2J8an8ohHK80og0i6dRThnToZGV4tkXzrh0y1wU7cp8PPmwyVC2b5xVJHoK
         uT43GqYshtOmIOQrNTLH47f4gsXIbMbDoGZx7hxXW3u3Km3/1baP2r196ATjks4PGEnb
         11yWu3qkunwinQekSRY836Phg3I9NPeT3LiJddEOALpH2nZydGCnz5jlepqnWUhnj3rV
         PMRdFchr+q78NYBJCeCvlN1Vmk1w1b66vkGr0IiO/o8HkQj5GzGe0EaQCbpt39LjQu7t
         7ddhIjslAT489GljKBHD/HBlkEhCPfeVzEYvqF+F2LY+5FgJH62W+dYKv2biBWbkTutg
         m2WA==
X-Gm-Message-State: AG10YOSKPbZtI6VNPma8c1kGIXRyxiAMaJR4c7yiyqrKwoc4obPzH6uO5Y4OeTFnQ0xmvA==
X-Received: by 10.25.212.207 with SMTP id l198mr7200232lfg.163.1455972002077;
        Sat, 20 Feb 2016 04:40:02 -0800 (PST)
Received: from localhost ([37.151.37.102])
        by smtp.gmail.com with ESMTPSA id rx1sm1234128lbb.22.2016.02.20.04.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 04:40:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160220084804.GB17171@sigill.intra.peff.net>
X-Operating-System: Linux
X-Date: Sat Feb 20 18:25:53 ALMT 2016
User-Agent: Mutt/1.6.0-rc0 ((null))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286779>

Hello Jeff,

On 02-20-16, Jeff King wrote:
> On Sat, Feb 20, 2016 at 02:10:58PM +0600, Alexander Kuleshov wrote:
> 
> I'm not convinced that moving the functions inline into git-compat-util
> is actually cleaner. We've expanded the interface that is visible to the
> whole code base, warts at all.
> 
> One wart I see is that the caller cannot know whether the return value
> was newly allocated or not, and therefore cannot free it, creating a
> potential memory leak. Another is that the return value is not really
> necessary at all; we always munge argv[0].
> 
> Does any other part of the code actually care about this
> extension-stripping?

Nope, only this one.

> 
> Perhaps instead, could we do this:
> If we drop this default-to-empty value of STRIP_EXTENSION entirely, then
> we can do our #ifdef local to git.c, where it does not bother anybody
> else. Like:
> 
>   #ifdef STRIP_EXTENSION
>   static void strip_extension(const char **argv)
>   {
> 	/* Do the thing */
>   }
>   #else
>   #define strip_extension(x)
>   #endif
> 
> (Note that I also simplified the return value).
> 
> In the case that we do have STRIP_EXTENSION, I don't think we need to
> handle the empty-string case. It would be a regression for somebody
> passing -DSTRIP_EXTENSION="", but I don't think that's worth worrying
> about. That macro is defined totally internally.
> 
> I suspect you could also use strip_suffix here. So something like:
> 
>   size_t len;
> 
>   if (strip_suffix(str, STRIP_EXTENSION, &len))
> 	argv[0] = xmemdupz(argv[0], len);
> 
> would probably work, but that's totally untested.

Good suggestion. I will try to do it and test.

Thank you.
