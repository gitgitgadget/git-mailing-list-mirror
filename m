From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 2/2] Documentation/git-pull.txt: teach 'git pull --rebase' the --[no-]autostash option.
Date: Sat, 27 Feb 2016 23:11:42 +0530
Message-ID: <1456594902-21182-2-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Cc: pyokagan@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 18:42:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZisz-0005Wo-0c
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992536AbcB0Rm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 12:42:29 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36297 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992533AbcB0Rm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:42:28 -0500
Received: by mail-pf0-f194.google.com with SMTP id q129so196715pfb.3
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 09:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IeR0syz/wcYFVkiGFLY5ZkcTG6qo37ylWRKsXxY/ZBg=;
        b=bN66rVp1K62W/cdwgb7CLtn9+cIHjtx6XlbJz25GfQdXXRnm3pZeJ5BP6/gYa8TL65
         +79ibggkaNTwct7nu2IcEBPFSoSF7CeolbT9zSOifH6C0b+1bybVgKyTAY/tfK7k8bL3
         e8a/PxonyNFGqiAkk3YNDjG1QmUG0kqt6mkWJ404SVxaw+4Ji+AqZD4XISy0ZhozFtNd
         J4vb0Ij8p799GQ9GFFIbyVwQCxkVynX3zvnax7hrv8PH9PvOqVRoSJ2Jt3PjGxu75osQ
         hnP6gM+5AbVEdVWFTElaRPMm8NiZE5R3E/FprQH5nOAK7ej7mUqhN52LtHMsy5y1A/M2
         o0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IeR0syz/wcYFVkiGFLY5ZkcTG6qo37ylWRKsXxY/ZBg=;
        b=VSMEyKG75xrrf9ZaZ56uVnYJmRLSG1ITAYTBsBgCxHpaEa+2kSVqfjnTRcAauFIy38
         EEQzJLR1zbTjQgQyKFsSVo768LGu/1hSYF2VBIqM9EN/YhO1LnK7SnPVi3rjed5AH7+R
         la+RiGHEY+wmJ1nMFht5JJzNdrgl4p26UfBKXS7J2lRgaADcP9SS/GgeUJMY1shFVFvo
         Pm9VhAI8ZCoe5C2cEOoOTRFcdsacaGGUmhub4OLVkS6tLX+KmYfCzP6gEEkL08uyg/VA
         xJ5Im9dVLTKlQT12gdRiT2uDfyUlL3wLfMIlOu07Upkvv28ElI7XgUxE/3XoAcZuETWk
         ENvQ==
X-Gm-Message-State: AD7BkJK4uEydbYlgeXf9M7IaOnFOb7fKXAoftTuQ/dLVTVd81J8hVRT0ywnbZdsS2JQMLQ==
X-Received: by 10.98.11.88 with SMTP id t85mr10716705pfi.98.1456594948115;
        Sat, 27 Feb 2016 09:42:28 -0800 (PST)
Received: from localhost.localdomain ([1.39.36.221])
        by smtp.gmail.com with ESMTPSA id i23sm27358456pfj.68.2016.02.27.09.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Feb 2016 09:42:27 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287710>

git pull --rebase understands --[no-]autostash flag.

This flag overrides config variable "rebase.autoStash" 
if set (default is false).

When calling "git pull --rebase" with "--autostash",
pull passes the "--autostash" option to rebase, 
which then runs rebase on a dirty worktree.

With "--no-autostash" option, the command will die
if the worktree is dirty, before calling rebase.
	
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 Documentation/git-pull.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index a62a2a6..ce22c52 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -128,6 +128,22 @@ unless you have read linkgit:git-rebase[1] carefully.
 --no-rebase::
 	Override earlier --rebase.
 
+--autostash::
+	Automatically create a temporary stash before the operation
+	begins, and apply it after the operation ends. This means
+	that you can run rebase on a dirty worktree.
++
+This option is only valid when '--rebase' option is used.
++
+[NOTE]
+Use with care: the final stash application after a successful
+rebase might result in non-trivial conflicts.
+
+--no-autostash::
+	If the '--autostash' option is enabled by default using the
+	configuration variable `rebase.autoStash`, this option can be
+	used to override this setting.
+
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.7.1.340.g69eb491.dirty
