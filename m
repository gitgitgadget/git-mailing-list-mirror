Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299834;
	b=Os7bUanD0TcYNPb6Cglnhwb9iAoPx33Cv9s8qZQTaiigC8e60AbB/LgGi4OtIn87SfF+
	 hc30NpJ2FODAs8oB/ci3+lbK0hsIQNXCVBO4FWHE3Icy0gh9t0jdsW2O3rpI7xGQ4VLET
	 TzdqZ6QTQoMofvVGRG3g230fItzYSkUFGfqSC0XB5lr6n8x/J7MPzKPxXt4conO1oSTue
	 Isw0/d6XMW/HsWkL1KfyPjnvMgY9yZ4WjJu7qdQDMXGbPO7BBK5SUg11Z8C1Ww3PYyO/8
	 a1TJWdhb5mDal0M0TjxRoU/GLXPMZNL5u6hKif2M+lSL/Z+8WVouJpoYsMz0Bocexjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299834;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=UsxGS1ubUtBOmDRFPSg11xjujpt0R2/f1HNSG8MB++s=;
	b=AwShJSEa1NfvZq31PTVwM9+64+F6762tchANnqENTq/y9Zy6tQegqc2/4dkbC+i7ksIp
	 o4L3WNB+qgzTIdKs27+NzT2YIxF0omZHQd9Cw07GkfUSmQ21Tto7e/j/LpZbNleNGPUE3
	 LG0ig5D+NI9/JzFWqAfhkUQg6CJNnazThILshlyWSOKSVYOmh7a4aexec3+KHTH3yKEoW
	 CMBmV51pHQFeZ84lxSk4r/JwUZeHiO2NxdriN/yRwtr2kun82ZxrQI3oENAyVuHfJaUJt
	 8juMlRXqC0cVlElLZlThLyZS94R2D0JYX0BluUURvItVwKqElIycM5rtyaNbIkvNSTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=BHBRv0Y0;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED78F606A321
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED78F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=BHBRv0Y0
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69TInbEB018924-69TInbED018924
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 29 Oct 2026 20:49:37 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xMVBx-00Cjvl-11;
	Thu, 29 Oct 2026 20:49:37 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 20:49:36 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 6c335c3e;
	Thu, 29 Oct 2026 18:49:36 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>, Patrick
 Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff
 King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v3 2/2] lint-docs: check the guide list in command-list.txt
Date: Thu, 29 Oct 2026 20:48:34 +0200
Message-ID: <20261029184834.2273-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261029184834.2273-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261029184834.2273-1-taahol@utu.fi>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhI
 WkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEheSFhIWEhYSFpYSAsHDA0oAwAJHQ8bCgkDA0YGCQUNSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlfSA8BHBscDRoo
 GAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhYSFlbSBgNDg4oGA0ODkYGDRxIWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=UsxGS1ubUtBOmDRFPSg11xjujpt0R2/f1HNSG8MB++s=;
 b=BHBRv0Y0p2VO2/z1mT1aEXns8arAYFR8baMNxmDKgp5AKME0guwrjHNq3UxFRj7QTEe5so9b/aVI
	w69Rixw8G5nE/0+6f1g08PNJCS1CecNVLme3RCEAfqqIymORDBqnHeDqcAlEmAQqxQ2r56ErHqOR
	b3imCT1cQjsd+VHApx7Us9LwSKJJoZ99KyIa6SJZOnp8vKJIcBHEo+n8wvhxsrCJBn2EuF9oRpfc
	GiPBD9FAbaCjr5gcBJDw+ha1/+QdF+yPdGiTQacq9grRhmgajaypmkPt/mE3sU+FlHo2PKG5Cu3z
	9QbyvMqGMs040iub6wvI0neYDz0ioPsOGKRSFQ==

Since 2135e1ad70 (command-list.txt: add missing 'gitcredentials' and
'gitremote-helpers', 2020-08-05) there has been a comment in
Documentation/Makefile reminding developers to add new guides also to
command-list.txt.  However, there is no linter script to enforce that.

Adapt Documentation/lint-manpages.sh to fill that role.  Extract
MAN5_TXT and MAN7_TXT from the Makefile and check command-list.txt
against them.  Exempt gitweb.conf(5) and gittutorial-2(7) from the
new linter routine.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/Makefile         |  2 ++
 Documentation/lint-manpages.sh | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..8e28ac784b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -67,6 +67,8 @@ MAN7_TXT += gittutorial-2.adoc
 MAN7_TXT += gittutorial.adoc
 MAN7_TXT += gitworkflows.adoc
 
+MAN_GUIDES = $(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))
+
 HOWTO_TXT += $(wildcard howto/*.adoc)
 
 DOC_DEP_TXT += $(wildcard *.adoc)
diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index a0ea572382..31ee3cbe72 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -1,21 +1,23 @@
 #!/bin/sh
 
 extract_variable () {
+	file="${2:-../Makefile}"
+	directory="$(dirname "$file")"
 	(
-		cat ../Makefile
+		cat "$file"
 		cat <<EOF
 print_variable:
 	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
 EOF
 	) |
-	make -C .. -f - print_variable 2>/dev/null |
+	make -C "$directory" -f - print_variable 2>/dev/null |
 	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
 }
 
 check_missing_docs () (
 	ret=0
 
-	for v in $ALL_COMMANDS
+	for v in $ALL_COMMANDS $MAN_GUIDES
 	do
 		case "$v" in
 		git-merge-octopus) continue;;
@@ -29,6 +31,8 @@ check_missing_docs () (
 		git-stage) continue;;
 		git-legacy-*) continue;;
 		git-?*--?* ) continue ;;
+		gittutorial-2) continue ;;
+		gitweb.conf) continue ;;
 		esac
 
 		if ! test -f "$v.adoc"
@@ -87,6 +91,7 @@ check_extraneous_docs () {
 BUILT_INS="$(extract_variable BUILT_INS)"
 ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
 EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
+MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"
 
 findings=$(
 	if ! check_missing_docs
-- 
ta/command-list-guides-sync-lint

