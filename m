From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/26] completion: support git-worktree
Date: Tue, 16 Feb 2016 20:29:09 +0700
Message-ID: <1455629367-26193-9-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:32:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfk5-0004oK-2d
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbcBPNc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:32:27 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36621 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280AbcBPNaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:03 -0500
Received: by mail-pf0-f176.google.com with SMTP id e127so105498550pfe.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iCDG0tX/J6vB7f/G0ozR+zIxm7usu/AuWT3bmasUFww=;
        b=Ex+SrQXkRwKWaRLOh0Sva0IOajvtXo7ET6NjEA2xdsfd/rfw9tOvf7yPiCYfHhubcm
         djHjOhCNwmUD1Nera5HJtd+cFI4gKOBrBKGwqjMkksfDDiKyz2asN01v6WZQ83tANavx
         VmCXcpN7hF0IEPg/lBoBS8opIKVYc6VbMEaRWTNBbjiXAyb8xep7949DWmdVRU7Xzx52
         PWzIGvZR6/yfoXHoxGM16KSx/UorSs3BQcg8LV7YuMXWFrLkZngQBjo2Tf/tL6m+TlN3
         i1U+RKIJ9rl32t32yWWyxPf2urIsRi3/ZNYGnryYtaAjNh1HjiimLrx4H564T57PN2/Q
         V5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iCDG0tX/J6vB7f/G0ozR+zIxm7usu/AuWT3bmasUFww=;
        b=VGclzJGzH82rRip/67n9YIiryi/Jt+ForlOMprZ4aMWUPsNfKrLMTTJ5JzAEp09hYW
         4yBSs2qlce2834eIIkmzL2tUGf63bgwnmQ4/pu+0UK1/2UrzhlJBjdNckQ5I6GPPaEym
         drhPjTteHJwaG36w70Tfenu3D99SgBew0lrBe+YzKn9+qLqduNkgq5mOgPf1XcIcYmNM
         SxaD3j0axmiCUTGz8AUHhm6cRsPHjRvPWPuNSS7MbANjsTk6iCgaiymQ6bzoggisuOdD
         4rRqLIyUAiKIPROvVM2YA779vRRFEKTP1oy24vBnRiMxGa5EKk6f95ksPQlPfCexkqbf
         1k8A==
X-Gm-Message-State: AG10YOQ6WdpKWfUYLa4IAY6EHwl4dYnioZqTy5Gx4BV0tuaymDG+0wuGcQB17B02UvooWQ==
X-Received: by 10.98.71.15 with SMTP id u15mr30908951pfa.161.1455629403146;
        Tue, 16 Feb 2016 05:30:03 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id t29sm45961708pfi.8.2016.02.16.05.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:25 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286403>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 45ec47f..099d52e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2594,6 +2594,29 @@ _git_whatchanged ()
 	_git_log
 }
=20
+_git_worktree ()
+{
+	local subcommands=3D"add list prune"
+	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
+	if [ -z "$subcommand" ]; then
+		__gitcomp "$subcommands"
+	else
+		case "$subcommand,$cur" in
+		add,--*)
+			__gitcomp "--detach --force"
+			;;
+		list,--*)
+			__gitcomp "--porcelain"
+			;;
+		prune,--*)
+			__gitcomp "--dry-run --expire --verbose"
+			;;
+		*)
+			;;
+		esac
+	fi
+}
+
 __git_main ()
 {
 	local i c=3D1 command __git_dir
--=20
2.7.0.377.g4cd97dd
