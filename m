From: David Barr <davidbarr@google.com>
Subject: [PATCH 5/7] vcs-svn: fix cppcheck warning
Date: Fri, 25 May 2012 00:04:17 +1000
Message-ID: <1337868259-45626-6-git-send-email-davidbarr@google.com>
References: <1337868259-45626-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 16:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYfl-0004SF-Si
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab2EXOFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:05:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50024 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab2EXOFh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:05:37 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so11360466dad.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AdYRgkscf/Es0MFxvP69Z0r21mTn+70rRCg/5Sw5GPw=;
        b=JBkZsdyG32BLZLFwnuEQgBcUiAdV9CiusIbvO853nmFahmkIZbFoPJSQuIM6NxTGdc
         J+/v3PurtwSErePtbBQUBq/iHPTzOmIBfJOifN8wTvqh97Fa6hkR3KFiPdoMpU1A/ak6
         zMA5fJIXV6YXYU91dAHzM42/Vjys6uoNhMsN7W8vWzqZS4m2R5Pp4OG1NirkxwQ371Xp
         NCh4yzIURpcJUXUGP/lRbS76VgELd3XA54LqE3oIq4GL/ILGJi9m8rOQs6dANhH+RbHl
         h9JsUPxqyaYKfULLVI7wXM5vDi9H5t1DfUJv8d9yS3KK08xi2EFZWUOhnkDU4nsz9WCS
         M8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=AdYRgkscf/Es0MFxvP69Z0r21mTn+70rRCg/5Sw5GPw=;
        b=pi3yJ8atxzkPxWBJdvjLftaY2pRXJb2+85LJQMeJH4PYG8WPUyp3sGXo3UGafCPg7h
         wTKsG/e69UJvD5Iy/+M29vKIl8BDDgw3riXO+1vetRta2wBsb/i3mfyiFoBwuhALZuEN
         klnHM90zMhlJywSMrJmzy7CStrILX3zJl6UQm8ue+1thJrj5lRdcvAyzTf4lzvZl2bPq
         LTvTn+6tkAh865RJ5CBGIeoXE21vxJQLML35S/hxqKZ25672hR2b3ctD1QhSuWwrZ6l6
         4qu1SJXHAEzU3tjD1SfIcAdn9RNMa6CQMN3ct/AlxV5/lNPtFOwwduQFfTXK3EAdvTB0
         3VMA==
Received: by 10.68.190.131 with SMTP id gq3mr193393pbc.17.1337868337041;
        Thu, 24 May 2012 07:05:37 -0700 (PDT)
Received: by 10.68.190.131 with SMTP id gq3mr193366pbc.17.1337868336834;
        Thu, 24 May 2012 07:05:36 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id rv8sm5565332pbc.64.2012.05.24.07.05.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 May 2012 07:05:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1337868259-45626-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQn9xcpz32QHfrr/NArSdCeQvrHmjdRVKlF9EZbGJK15ufBJ7wHcRYQ7GR7odNg7A3uYOYuQZg1Bg69FMS71SfogW6hqWL8gUvm/G1cVBWxQjKoDROxjfzdloQ8AwNcDaO3mzMA9gf3FNmtH/BPqBCgD3yTrQZFMmL+1aAl5TmiSQqycPls=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198382>

[vcs-svn/fast_export.c:211]: (warning) Using sizeof with a numeric constant as function argument might not be what you intended.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/fast_export.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 0b2b7b9..d06a81c 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -208,7 +208,7 @@ static long apply_delta(off_t len, struct line_buffer *input,
 		die("cannot apply delta");
 	if (old_data) {
 		/* Read the remainder of preimage and trailing newline. */
-		assert(!signed_add_overflows(preimage.max_off, 1));
+		assert(!signed_add_overflows(preimage.max_off, (off_t) 1));
 		preimage.max_off++;	/* room for newline */
 		if (move_window(&preimage, preimage.max_off - 1, 1))
 			die("cannot seek to end of input");
-- 
1.7.10.2
