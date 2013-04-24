From: Tair Sabirgaliev <tair.sabirgaliev@bee.kz>
Subject: Re: [PATCH 1] gitk: on OSX bring the gitk window to front
Date: Wed, 24 Apr 2013 15:48:27 +0600
Message-ID: <3EE7D8B9-5FAE-43F5-9BE3-C4AE2A75B57D@bee.kz>
References: <1l1scng.k9ly7ci7gjd2M%lists@haller-berlin.de>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, paulus@samba.org
To: lists@haller-berlin.de (Stefan Haller)
X-From: git-owner@vger.kernel.org Wed Apr 24 11:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUwJa-0000VF-VN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 11:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394Ab3DXJse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 05:48:34 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47528 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab3DXJsd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 05:48:33 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1011113wey.5
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bee.kz; s=beekz;
        h=x-received:content-type:mime-version:subject:from:in-reply-to:date
         :cc:content-transfer-encoding:message-id:references:to:x-mailer;
        bh=f6W5hdN4oIkGdMalyaLbmLJzxOy8i0NLhH4WlKmf6yE=;
        b=Ks4PrGUo3wRfslf3fyLYxuhqzfTzSK848JOncwzkz8ZLlXHptP84KUtCc5feWL+rkU
         4didX8ThUNCjq4Q1xo8ktHF39ohR4TElSDIU9RFTojmj6Mp4iLBmry0XnqWNwGCkxi2c
         nJ4SbCAmYwvVtZoPs5W7SmhKu59Qpus9pxqn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:content-type:mime-version:subject:from:in-reply-to:date
         :cc:content-transfer-encoding:message-id:references:to:x-mailer
         :x-gm-message-state;
        bh=f6W5hdN4oIkGdMalyaLbmLJzxOy8i0NLhH4WlKmf6yE=;
        b=aKxWZTejBVpPeMuM29+iAZAc+JWo2Z/r0T7K4hGcZ/OoqjlBYPL2RGdoaL9mcJf2Jb
         B/YoO4JODPp45o0kruTv82UwPelQHNBRxzROit2yU+D+Y6nVAufST2/TuJWPCydWza78
         z9khWATj7l8pi0xR4vz08a55OIqo1YCin4bqd7a9Nx6Iq0jN704uVgYlmuIRwlIE13FZ
         e38yIcFu1oU/CC0Qt1DuXs1m3JkdibiBz5rNJlpbCaJWfPHrqs3TlTp65p29PDruXLoD
         iuCE6ASJE4HYXFA4p4L+BBr7GpGIzD6/fLMEKaZDImAsISX+fcXZe85KaYOJF2PwFJr/
         iSww==
X-Received: by 10.180.97.233 with SMTP id ed9mr25784665wib.32.1366796912018;
        Wed, 24 Apr 2013 02:48:32 -0700 (PDT)
Received: from [10.0.1.173] ([2.133.28.83])
        by mx.google.com with ESMTPSA id o5sm2989201wix.3.2013.04.24.02.48.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 02:48:31 -0700 (PDT)
In-Reply-To: <1l1scng.k9ly7ci7gjd2M%lists@haller-berlin.de>
X-Mailer: Apple Mail (2.1503)
X-Gm-Message-State: ALoCoQkpF2Lv8aJi8aUvttdoJdweUlx0js8R/MylZdxGFChhn/Ga2fjw1oXC5KZ23nc8migH8hGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222243>

On OSX Tcl/Tk application windows are created behind all
the applications down the stack of windows. This is very
annoying, because once a gitk window appears, it's the
downmost window and switching to it is pain.

The patch is: if we are on OSX, use osascript to
bring the current Wish process window to front.

Signed-off-by: Tair Sabirgaliev <tair.sabirgaliev@gmail.com>
Thanks-to: Stefan Haller <lists@haller-berlin.de>
---
 gitk | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/gitk b/gitk
index 572f73f..66e59b1 100755
--- a/gitk
+++ b/gitk
@@ -11687,6 +11687,15 @@ if {[catch {package require Tk 8.4} err]} {
     exit 1
 }
 
+# on OSX bring the current Wish process window to front
+if {[tk windowingsystem] eq "aqua"} {
+    exec osascript -e [format {
+        tell application "System Events"
+            set frontmost of processes whose unix id is %d to true
+        end tell
+    } [pid] ]
+}
+
 # Unset GIT_TRACE var if set
 if { [info exists ::env(GIT_TRACE)] } {
     unset ::env(GIT_TRACE)
-- 
1.8.2.1
