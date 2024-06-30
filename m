Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7B4CB23
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719783242; cv=pass; b=F4snFcCA62brulGFXt8PZzrjEcZdhYiNPyad1yOJr8/trhsHylq9+ziMCE2w3KzIb3DW7wIt5yi+WePcYr+aYYE54Fl57HjiMTwbw0qYkJQp7OiOk6PnKm70Td95PAgwal3bszSNiFIPOwiqJj9UEuYSmll69lVm84dbRPuLBRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719783242; c=relaxed/simple;
	bh=tGbQqEDd5HP+pRwn7GCUxO+3nR+08YgAToNyTLEkNd8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5WEUZvg8KEqfE7Gxt74R/h5rN3chha9ga0CTSHohFVPKbBQmwnWL6gbUvxKHMH3hRUaNcP4KBmTBgkct6tJA2oXv3oi/m7GudCmxsXR5JbJQXBMTU0qvTZn3LXkLIH9nIJyf9b6TThe20Kje++ZT7kyL5MrxIZMakGPb4MTWZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dom7Ir1j; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dom7Ir1j"
Received: from localhost.localdomain (unknown [IPv6:2001:1ba8:120c:f201:e842:876:cf00:268])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mikko.koivunalho)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WC2VQ57TfzyYw;
	Mon,  1 Jul 2024 00:33:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1719783231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtRj1DSuwWVzrSAPCnm7dFrYqTZ6lU7v29hLTZeL/Mw=;
	b=dom7Ir1jaK8GKON6kV+Zc4jGi8bVzYhsb4riSqaBBrbl2qmW0PiuwQOdCdRJVsyNdX/oaY
	vyTmY/QY4wLrhe5p6VcPDDLfjquUaFNxulS1gFf39W2T8zg2DVgG28i8BiZHx9KE1DLqWW
	D/vyHhWJLQBkHW9n/8pOZx0MhNyMi1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1719783231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtRj1DSuwWVzrSAPCnm7dFrYqTZ6lU7v29hLTZeL/Mw=;
	b=UOCAUrerjtFLu1UuSc6+Thgr3shW/lWhtXUllq5iKcaU6qiOvnoilwuZC7WztFgW+uhjxR
	6wyBNEdyXSQLBCgYPVxl0j1DA6ClPq4xQFyDgY6lI5rgPsgADFU19E/CHaq8C6VekKcT5o
	KpFEg4CqaNco+lrrffo4o+xlZYYYtro=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mikko.koivunalho smtp.mailfrom=mikko.koivunalho@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1719783231; a=rsa-sha256; cv=none;
	b=QKs0kMrZCQJunKcqj60tcNtDavaNad9efzf8IP2KpMSYTNGYoOFgkc5nrAQsfG+IKNY7IO
	Bl8iE6ZGo1pl4Ylrg+DZJHE8xZhfKummAuqZGJWVWyRyzAkVA2Fa02WeXnQtCpAXYTaNam
	KamdNxh7OBwgfsBuEsn9jeiGBLXbEnE=
From: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
To: git@vger.kernel.org,
	Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Roland Hieber <rhi@pengutronix.de>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 1/3] completion: Add hook in Bash completion for commit message
Date: Sun, 30 Jun 2024 23:33:34 +0200
Message-Id: <20240630213336.2212166-2-mikko.koivunalho@iki.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
References: <20240630213336.2212166-1-mikko.koivunalho@iki.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mikko Johannes Koivunalho <mikko.koivunalho@iki.fi>
---
 contrib/completion/git-completion.bash | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 60a22d619a..5350531c8f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -81,6 +81,34 @@
 #     case insensitively, even on systems with case sensitive file systems
 #     (e.g., completing tag name "FOO" on "git checkout f<TAB>").
 
+#   GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK
+#
+#     Name of an executable or a script which returns a commit message.
+#     Use this, for example, to always start a commit message with a predefined
+#     prefix. Example:
+#     # Extract Jira ticket number from branch name:
+#     extract_ticket () {
+#       if [[ "$(git rev-parse --symbolic-full-name HEAD)" =~ ([[:alpha:]]{3,}-[[:digit:]]{1,}) ]]
+#       then
+#         echo "\"${BASH_REMATCH[1]^^} "
+#       fi
+#     }
+#     GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK=extract_ticket
+#     # Doing commit:
+#     git commit --message=<TAB>
+#     # you would get (without the closing double quote):
+#     git commit --message="ABC-1234
+#
+# You can set the following Git configuration variables to influence the behavior of
+# the completion routines:
+#
+#   completion.commitMessageCallback
+#
+#     Name of an executable, script or shell functions which returns a commit message.
+#     See above environment variable GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK.
+#     The config variable gets overriden by the environment variable if latter is present.
+#
+
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
@@ -1824,6 +1852,18 @@ _git_commit ()
 			" "" "${cur##--cleanup=}"
 		return
 		;;
+	--message=*)
+		if test -n "${GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK-}"
+		then
+			__gitcomp_direct_append "$(${GIT_COMPLETION_COMMIT_MESSAGE_CALLBACK})"
+		elif test -n "$(__git config completion.commitMessageCallback)"
+		then
+			__gitcomp_direct_append "$("$(__git config completion.commitMessageCallback)")"
+		else
+			__gitcomp_direct_append " "
+		fi
+		return
+		;;
 	--reuse-message=*|--reedit-message=*|\
 	--fixup=*|--squash=*)
 		__git_complete_refs --cur="${cur#*=}"
-- 
2.30.2

