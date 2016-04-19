From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH resubmission] config.mak.uname: Cygwin: Use renames for
 creation
Date: Tue, 19 Apr 2016 10:10:55 +0100
Message-ID: <20160419091055.GF2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 11:11:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asRgZ-0008Cl-9V
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 11:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbcDSJLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 05:11:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36322 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbcDSJK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 05:10:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id l6so3231143wml.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nuLZveIDNZvnBaPgi+lDQ/L6VRV6fwUaP/Uhlh/ebqo=;
        b=vekhbtu+HrL7aOJHf8nR0MwjLNaoV63FRiup/GBn2j7S/drzWtU4gJoa2P810aBZoz
         /th/7T6l1x5mNgg64jrrexrZdbnGfY/tsFBmy1RwDjgnPkJBn9DLteidl72C24iKCHrl
         ayC7fSV7lEgxOWMQi7qTRA5Ui01vWjsyJ7+cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nuLZveIDNZvnBaPgi+lDQ/L6VRV6fwUaP/Uhlh/ebqo=;
        b=E7zlCmfRoMN9LeTKMxiHC+Sb7MLEzNKg/hWz7r9A0hVBmO+3GFiNts9ZQrfKc5Vca8
         9oLIrsU+9TPJQ3hIF7oCmLgcmFDzxSa6j5n3gfc1Tz1uNpdeg5/CxWDWn102Z8f3m+Hq
         39m4Os9MbdCM9pbeT1sSr5gKxY2as9BHgVon3lEfpF8WlF2yX3A98PFvk+fiyspKkqUT
         IaSVKdij11BTg3yP/j1ikGe3GuccK09yX92ZqzEfDVT/L6zgARdZJL9+fG+yreH3wjgf
         StUcBJBr0CWSFJTQDYBCAggOxu0NyPcqt3zAb14ICEv+NP94MnRxiqXGlj5BRJXoYJ9c
         2ptA==
X-Gm-Message-State: AOPr4FUJfL4qO2sc0n1xoC+hSeTYoXQBHQePbkY4uN153fZU4HD7qSJKe5fYsJZbYiZMsw==
X-Received: by 10.28.226.213 with SMTP id z204mr1771154wmg.99.1461057058332;
        Tue, 19 Apr 2016 02:10:58 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id w202sm3174890wmw.18.2016.04.19.02.10.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 02:10:57 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291853>

When generating build options for Cygwin, enable
OBJECT_CREATION_USES_RENAMES.  This is necessary to use Git on Windows
shared directories, and is already enabled for the MinGW and plain
Windows builds.

Reported-by: Peter Rosin <peda@lysator.liu.se>
Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

This patch has previously been discussed on the mailing list (see
http://thread.gmane.org/gmane.comp.version-control.git/275485), back in
August 2015.  The conclusion then was that the downstream Cygwin builds
should take this patch for a few Git releases, and then resubmit the
patch to be taken upstream if it was causing no problems.

As the Cygwin Git maintainer, I've been applying this patch downstream
since v2.4.5-3 (where the "-3" is the Cygwin build/patch number), and
I've seen no reports of problems caused by this patch, and the reports
of Git on Cygwin being unable to work with Windows shared directories
have stopped.  As such, I'm resubmitting.

 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 943c439..be5cbec 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -187,6 +187,7 @@ ifeq ($(uname_O),Cygwin)
 	X = .exe
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
+	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
-- 
2.4.5
