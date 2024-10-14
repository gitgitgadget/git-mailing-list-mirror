Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68A1CF7D0
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938674; cv=none; b=lNlsI9jQTdb+1MBA605NQRgvw0hSIMFvzI9mZYGQfJAN7Hptyv2Y6eZTbYvb5MHo5FaE/3ZlxbBgVgtrnjv9Xo+GoN0lgiByMxXwgwIH8nVj/bNKUZy4WwN6vcB610eXbgbwgiQ8OIm83KdpslHHFj1YFVsCtAzNK/PPzO+RBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938674; c=relaxed/simple;
	bh=s9xW7L4yUb6PlkmdlvcGsos0maVa08R1PUbaOj9mPnM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9aQ0ssKHPMOwHsVY+RjKZw4Mxem/XfEivhBxnzVVglfeK6fbNM3UInQiLXjPLI0U2F6h2xAS1BdKzqFVGDpnsbnXwLfewdAZjNf9Ld3Qxgfokn8vDUBNhib9c2nPnEHwLVo56ExVwQCmntSFGeePXYZ+XbpNHPteP2Zu9lwLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZoiyRDXP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rm6/Ae/g; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZoiyRDXP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rm6/Ae/g"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D8D7013800E0;
	Mon, 14 Oct 2024 16:44:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 14 Oct 2024 16:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728938671; x=
	1729025071; bh=6/bzj2naTsJB2wyMsM36wq1DCdA71n/CI09DTLX5Eko=; b=Z
	oiyRDXP7XCWFQ334RvbakvS42QJLjE3SX+7glzl2pAh/Da9rHjEnbnBD9VPzUWk2
	aApmkBhbNEM+EU2GA75Sx3MxKhcrNCqShaKlFDq+JWpNjCuH5miiPCGGWe3ekAVr
	MXk2I/vyDRSvBK2pyztRol9jW0zShNmD4EyuaF2rjkZSDo3yoqRZgHqprLXWtldZ
	oYOEvOQxHI05+VQf2rLZZ+A76dC90eeUHgan+vXcx3+mjWlM4Ytz2pbKwfNABrQd
	XUz/RfcwpsPNyzqf7RxCvm/6KYfYb6jVip7BJZ8V7AFFxL1p8/HG/+wiG0r+Woh8
	87HTZpak3CRDtYvQ+mA7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728938671; x=1729025071; bh=6/bzj2naTsJB2
	wyMsM36wq1DCdA71n/CI09DTLX5Eko=; b=Rm6/Ae/gItSDjAOTqyBYmF24NwWx7
	6wY8PbIEw88CWWJ0fw0KDnxCkSdx00eMAubYWKE/sgBxAmnT7yq4kXtN28kTMYVt
	I47dPcmkq5APRsjcG+5n1ehnOr/JsoG5ux7rnhQttblrlkClDMXmiwSF3yIlYb1A
	czB9SNfrLCh9JpTfW3FJnJbM5NU+xlcKP9534IGvhLrEb+ax0zoXwnqaQH8v0FPV
	BUDcyEk9UTO5A5u8lpz+QDVKMgXm0JIRbqLMC+I0WQ041eMJLXbiVKN3R6yixeZ+
	nVrMzkj8m0snIgg5uP6AJdIBw9iRBv9FYZQ6dxVE5LjUeELd0w7rCJIhA==
X-ME-Sender: <xms:r4INZx-N7t2YyVNrvTg40oha8WkhLU9Tn2dXIfPR8rtdt6HEORnGEQ>
    <xme:r4INZ1sM5hMouSUwDNF9BQ-zyZ-JGXee1IvmCrDwd5KROEN_IAQUzTnAR0bpunSr8
    wmxm6isEkRBaUBAaw>
X-ME-Received: <xmr:r4INZ_BcUW2FfFO6MDr4uknqWpl53n6LeJSyjHvjGRm7gsCmUAFV24_vu7_pqxGfXY2-iEsbgPbmb85Vwd9BjwmBR3cuL7sLnC6J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:r4INZ1eeR7eIJTUrYZMoUrsuy7mtQqWDNLbU152Wi4CyveGnWllgbA>
    <xmx:r4INZ2NZOAhKTyw_jvhh9cq3Lq2C6wvCvW5KH7vuFNRckQXy6zVsgA>
    <xmx:r4INZ3mdd-I8egFpFVUUPREyKxzvnL7eCIp7dPkaZHp19uk4R48_Jg>
    <xmx:r4INZwtUknAzMqzSYvVuk-ubegv2wPke2Y0pLOe1OzDMqPHi4HnjaQ>
    <xmx:r4INZ_YP4jMsvQCkM7Jlo7z-jWFZ3YNtiizG49T_XJ6HhstYaQmJs_jd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 16:44:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/3] config: values of pathname type can be prefixed with :(optional)
Date: Mon, 14 Oct 2024 13:44:26 -0700
Message-ID: <20241014204427.1712182-3-gitster@pobox.com>
X-Mailer: git-send-email 2.47.0-148-g19c85929c5
In-Reply-To: <20241014204427.1712182-1-gitster@pobox.com>
References: <20241014204427.1712182-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes people want to specify additional configuration data
as "best effort" basis.  Maybe commit.template configuration file points
at somewhere in ~/template/ but on a particular system, the file may not
exist and the user may be OK without using the template in such a case.

When the value given to a configuration variable whose type is
pathname wants to signal such an optional file, it can be marked by
prepending ":(optional)" in front of it.  Such a setting that is
marked optional would avoid getting the command barf for a missing
file, as an optional configuration setting that names a missing or
an empty file is not even seen.

cf. <xmqq5ywehb69.fsf@gitster.g>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt                  |  5 ++++-
 config.c                                  | 16 ++++++++++++++--
 t/t7500-commit-template-squash-signoff.sh |  9 +++++++++
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8c0b3ed807..199e29ccea 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -358,7 +358,10 @@ compiled without runtime prefix support, the compiled-in prefix will be
 substituted instead. In the unlikely event that a literal path needs to
 be specified that should _not_ be expanded, it needs to be prefixed by
 `./`, like so: `./%(prefix)/bin`.
-
++
+If prefixed with `:(optional)`, the configuration variable is treated
+as if it does not exist, if the named path does not exist or names an
+empty file.
 
 Variables
 ~~~~~~~~~
diff --git a/config.c b/config.c
index a11bb85da3..4a060f1d82 100644
--- a/config.c
+++ b/config.c
@@ -1364,11 +1364,23 @@ int git_config_string(char **dest, const char *var, const char *value)
 
 int git_config_pathname(char **dest, const char *var, const char *value)
 {
+	int is_optional;
+	char *path;
+
 	if (!value)
 		return config_error_nonbool(var);
-	*dest = interpolate_path(value, 0);
-	if (!*dest)
+
+	is_optional = skip_prefix(value, ":(optional)", &value);
+	path = interpolate_path(value, 0);
+	if (!path)
 		die(_("failed to expand user dir in: '%s'"), value);
+
+	if (is_optional && is_empty_or_missing_file(path)) {
+		free(path);
+		return 0;
+	}
+
+	*dest = path;
 	return 0;
 }
 
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4927b7260d..e28a79987d 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -46,6 +46,15 @@ test_expect_success 'nonexistent template file in config should return error' '
 	)
 '
 
+test_expect_success 'nonexistent optional template file in config' '
+	test_config commit.template ":(optional)$PWD"/notexist &&
+	(
+		GIT_EDITOR="echo hello >\"\$1\"" &&
+		export GIT_EDITOR &&
+		git commit --allow-empty
+	)
+'
+
 # From now on we'll use a template file that exists.
 TEMPLATE="$PWD"/template
 
-- 
2.47.0-148-g19c85929c5

