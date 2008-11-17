From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 17 Nov 2008 11:37:07 +0100
Message-ID: <4ac8254d0811170237o78060cb3k4a64dceaa3a475d0@mail.gmail.com>
References: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 11:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21Uv-0006nL-M4
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbYKQKhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbYKQKhK
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:37:10 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:37914 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbYKQKhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:37:09 -0500
Received: by gxk4 with SMTP id 4so1452620gxk.13
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 02:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AuMaD/FhdjLtEYwDreGn5BHlSWotLmrV/SVGMDyU8p8=;
        b=Ot52c8cQ6oqOmGiveX+J5HqYiocqn7PId0NVPLUNJ8q7zUHU06zVtTInT/ZV535DXL
         B6W9MjNducMpHnTFG+rEpOh/1s9r/UPPDsmcwNV2BebpJ2Z2Mjm/rRpCGPcNt5ymvpRp
         Q6hIkk9e2kKkfZWFZWT4ExoGoE0tjfQswC0m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AEBb3h19lm8T9YJBVjeanaWkXI4z4UUDoxlWAbBEgsDsAa+pazLJiYR/548MtKSR8u
         YeSJ7vGNQKXChatrwoxvL0g0uwdeO0VHld4C5EyBDIowZArMMl8CUpnKEHBeFRbuMk4+
         oLFCmTAqgK3iwfKmU+96um9CtslI0oZs8kH4E=
Received: by 10.64.151.10 with SMTP id y10mr3569463qbd.95.1226918227455;
        Mon, 17 Nov 2008 02:37:07 -0800 (PST)
Received: by 10.64.119.3 with HTTP; Mon, 17 Nov 2008 02:37:07 -0800 (PST)
In-Reply-To: <1226776980-9674-1-git-send-email-tuncer.ayaz@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101212>

Junio,

I think you need to have something like the following applied on top of
what's in pu to be able to use "pull -v -v -v" and be able to count the
occurrences via parse-options.c. What do you think?

--- git-pull.sh 2008-11-17 11:32:19.000000000 +0100
+++ git-pull.sh.b       2008-11-17 11:33:03.000000000 +0100
@@ -26,7 +26,7 @@
        -q|--quiet)
                verbosity=-q ;;
        -v|--verbose)
-               verbosity=-v ;;
+               verbosity="$verbosity -v" ;;
        -n|--no-stat|--no-summary)
                no_stat=-n ;;
        --stat|--summary)

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
