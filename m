From: Michael Naumov <mnaoumov@gmail.com>
Subject: Fwd: [PATCH] Remove terminal symbols from non-terminal console
Date: Tue, 6 Nov 2012 10:17:21 +1100
Message-ID: <CABHRWd16k6B4Ybvc4k7z29_A9Q2wZVXA__Bov8Pst4cc2H0cmg@mail.gmail.com>
References: <CABHRWd1T=a8Mze20G9koiTr0L2Nrq0g3vGLC9mEZ7rA45vgfSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>, gitster <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:17:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVVva-0006jS-E7
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 00:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004Ab2KEXRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 18:17:43 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:57058 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab2KEXRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 18:17:42 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2882861wey.19
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=T3P4feXqZlhiTd9MU3hsN50FA9LFQNTWZdmu3imJZIo=;
        b=0tiauu2ct/Ab2JRFC1r2rHGYUXLGtI2ylWQ1T4r8jVEU1dQrP0s1mj5gcrnRRXt06f
         Q0xckKAdTQKI3gh5zLCaBoSRQ8R/DoPB6Gmjovw/S2cTEoGNg4hKI4/Vek0oRbFWFqfh
         BzZLJ2I/o+0LX7c4kCb1eMucz1YSqTIaaVM7KlDYpicSf1BbrYMwn9u/TYXDDW4WnteT
         zeM/Wt8bUQw/oWkBu0tyPfUULi26bSFowo1w0Einheom4NHHI0Vn5KGLlaIMNM4MFOhT
         5+NUahNjkYK1OCIpllfDMUWI5ChAsb/lKNH9Zw54MgA9HZj0CrIf/kee8XJvhZoRKTS5
         w1TA==
Received: by 10.216.71.76 with SMTP id q54mr3992446wed.171.1352157461421; Mon,
 05 Nov 2012 15:17:41 -0800 (PST)
Received: by 10.217.53.65 with HTTP; Mon, 5 Nov 2012 15:17:21 -0800 (PST)
In-Reply-To: <CABHRWd1T=a8Mze20G9koiTr0L2Nrq0g3vGLC9mEZ7rA45vgfSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209092>

As per discussion on msysgit user group:
https://groups.google.com/forum/?fromgroups=#!topic/msysgit/U_a982_a3rc/discussion
we found the following patch is required to get rid of weird terminal
characters for other tools such as GitExtensions for Windows

---8<---
diff --git a/sideband.c b/sideband.c
index d5ffa1c..bd3e5a8 100644
--- a/sideband.c
+++ b/sideband.c
@@ -29,7 +29,7 @@ int recv_sideband(const char *me, int in_stream, int out)

  memcpy(buf, PREFIX, pf);
  term = getenv("TERM");
- if (term && strcmp(term, "dumb"))
+ if (isatty(out) && term && strcmp(term, "dumb"))
  suffix = ANSI_SUFFIX;
  else
  suffix = DUMB_SUFFIX;
---8<---
