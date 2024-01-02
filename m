Received: from aa.d.sender-sib.com (aa.d.sender-sib.com [185.41.28.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013715EB9
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="XT8TETw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=paGFajYSK01CCuuL6N8nXExiJZKJPbdxSNTjqLj48Cg=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=XT8TETw1L8hD5tMbu/VZyFTIsc9sZpTjA2I9lM+0PPR8YEhJHFX+Fmpzft5ubLhdfu+Eh0t6Q7VF
        BXAANkKCLoEBP06Z0VEzMlUndaChlm+cbbNULN8Pp9YV8M3WERdqboLI9vABxBbVCp43apVYC6pv
        pAqxOveYYZQ4QBTraYI=
Received: by smtp-relay.sendinblue.com with ESMTP id ac2d9b41-be28-45b8-9113-da59a85d791e; Tue, 02 January 2024 19:57:53 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTAyMTk1NzQ0LjQ3ODUwMy0yLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5hYS5kLnNlbmRlci1zaWIuY29t
Date: Tue,  2 Jan 2024 10:57:39 -0900
Subject: [RFC PATCH 1/6] completion: complete new old actions, start opts
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id BA93B520263; Tue,  2 Jan 2024 10:57:50 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102195744.478503-1-britton.kerin@gmail.com>
References: <20240102195744.478503-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <ac2d9b41-be28-45b8-9113-da59a85d791e@smtp-relay.sendinblue.com>
Origin-messageId: <20240102195744.478503-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: qzd6UUIkvhX59XAz_WefTgjhL-Z9_BVnWo6OGeX_q-Ov2e1TXgCrRfpJ-NXcdv_uIBRYmP0s_s2eMR6OCnxVLiM5-5RzihIErR0GZqkUXBQPtee3lF1q_LDFMgyiI971fcfkXUFU754aYHYbDFzN4NNbVnI2gd3BGjQnS7qyrT4b
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.128:6940237_-1:6940237:Sendinblue
From: "Britton Leo Kerin" <britton.kerin@gmail.com>

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash =
b/contrib/completion/git-completion.bash
index 185b47d802..15d22ff7d9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1449,7 +1449,7 @@ =5Fgit=5Fbisect ()
 {
 	=5F=5Fgit=5Fhas=5Fdoubledash && return
=20
-	local subcommands=3D=22start bad good skip reset visualize replay log =
run=22
+	local subcommands=3D=22start bad new good old terms skip reset visualize =
replay log run help=22
 	local subcommand=3D=22$(=5F=5Fgit=5Ffind=5Fon=5Fcmdline =
=22$subcommands=22)=22
 	if [ -z =22$subcommand=22 ]; then
 		=5F=5Fgit=5Ffind=5Frepo=5Fpath
@@ -1462,7 +1462,20 @@ =5Fgit=5Fbisect ()
 	fi
=20
 	case =22$subcommand=22 in
-	bad|good|reset|skip|start)
+	start)
+		case =22$cur=22 in
+		--*)
+			=5F=5Fgitcomp =22--term-new --term-bad --term-old --term-good =
--first-parent --no-checkout=22
+			return
+			;;
+		*)
+			;;
+		esac
+		;;
+	esac
+
+	case =22$subcommand=22 in
+	bad|new|good|old|reset|skip|start)
 		=5F=5Fgit=5Fcomplete=5Frefs
 		;;
 	*)
--=20
2.43.0


