Received: from bi.d.mailin.fr (bi.d.mailin.fr [185.41.28.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142A17E4
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bi.d.mailin.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sendinblue.com header.i=@sendinblue.com header.b="hK9HXjha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendinblue.com;
 q=dns/txt; s=mail; bh=paGFajYSK01CCuuL6N8nXExiJZKJPbdxSNTjqLj48Cg=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:in-reply-to:references:x-csa-complaints:list-unsubscribe-post;
        b=hK9HXjhajCl8Xepe1/dJKtzyTA9bvC8InmQF4IZNumkZyEQ/X30hTb8dn9/bT2THFq3N65XPxwd3
        Iy8LaYSF9cH9z3METlhZrOyzwrzBRCpvRSHkurkZPTB3GTniBPCPIGtk0lYVaaSDGIsMD48ZkRIj
        o/VWIJs0y6/yaAymFsY=
Received: by smtp-relay.sendinblue.com with ESMTP id 0acda1a0-2665-4e0f-8188-9bc8713f402d; Wed, 10 January 2024 02:03:51 +0000 (UTC)
X-Mailin-EID: MjQyODY0MDE0fmdpdEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwMTEwMDIwMzQ3LjY3MzE1NS0yLWJyaXR0b24ua2VyaW5AZ21haWwuY29tPn5iaS5kLm1haWxpbi5mcg%3D%3D
Date: Tue,  9 Jan 2024 17:03:43 -0900
Subject: [PATCH v2 1/5] completion: complete new old actions, start opts
Received: by brittons-large-Vivobook (Postfix, from userid 1000) id 33552520265; Tue,  9 Jan 2024 17:03:49 -0900 (AKST)
Cc: Britton Leo Kerin <britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110020347.673155-1-britton.kerin@gmail.com>
References: <9e180f50-4bf4-4822-9b02-2a1b50114e09@smtp-relay.sendinblue.com> <20240110020347.673155-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <0acda1a0-2665-4e0f-8188-9bc8713f402d@smtp-relay.sendinblue.com>
Origin-messageId: <20240110020347.673155-2-britton.kerin@gmail.com>
To: <git@vger.kernel.org>
X-sib-id: ojA49iRkJrr6azM_X72HmGZT1GOCQyUBjG-nnTloWTmCtxspLaFCfGocF4ba9NkkxZ-TFTT_-x7RHvq-5wWgcbE3qU0xuJxu6rEGYkVqERHZJvVNeNtKw-adtFyJ7XR9hq6Q1Zbg4r7TUsNm7OU_TtZ7xh8sxR3R01GlGGxE4Sgv
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 185.41.28.109:6940237_-1:6940237:Sendinblue
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


