Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A248357D18
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117543; cv=none; b=hJvtzoiHWXVIby1l2iqG1Hg09nHF2+pbgDCIZpOvgmMa+dqKqRSbL7s0yx9WAdkLGbPYxYKq7imeZJl7EavAAfGHUY3k2PsAFtcRKi9YbV1G8Y8cIWfxTX6+JAiiiZbsfqHztLizwkIsav5JCLDSqPAPXucCkDPsmKxfl3jKRpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117543; c=relaxed/simple;
	bh=26brt9Q2GH5evyCaYqEf+3ngdCeAQqSMxszaBHXrpUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1p0zndSaI8VnJ0MbY9TLgorBk7x0YXHhxOs644o08LEeLsPS+pU4mGq/q5YvsgAFrHJfvdCIs8CtV/c4f+KNVXacDZqI1p1jDyZZPESpriof2a9TFbd2SHCEmtdhsJTdpWcL4giUXOWfmbvjHx66nnjgRZ/ScFPEGqwCO4hXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=dL/wVQ8j; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="dL/wVQ8j"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65AIq19x012508-65AIq1A1012508
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:52:02 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXO1x-00EeLa-Sx
	for git@vger.kernel.org;
	Wed, 10 Jun 2026 21:52:01 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 21:52:01 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 623cbb29;
	Wed, 10 Jun 2026 18:52:01 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 1/3] doc: config: terminate runaway lists
Date: Wed, 10 Jun 2026 21:51:46 +0300
Message-ID: <20260610185148.23920-2-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260610185148.23920-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-08.utu.fi (130.232.247.48) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=g8sX+uuzjDMNU8w0juveAbXthwArHyIksaWQFRDt7Sw=;
 b=dL/wVQ8jFi/HSwAby5XJyj0A69VT88D3ahpSk9Hx4tardBAAX6WPZdGq14cYSCsJljFnZauS7OCd
	mp2CKmsQjF3hgHOqos57xZXsmFByHDXhcPTT5I6u8E4A1DS/EYMiLz3naygC/IYb03PnPNg1R0+6
	LI1FYg6ftUug0VWWM9rOBMYHy5Sh9+Hvd9+E08WisHK+x4qzJdg2Wb0NM5raWqzB3rojRqHCGOv5
	sNGzTSG6EWMcRekpiHqIkFbGbbExaGv0AAfoxcVqsueC/FylzJLgysPJ0jaPoOd6tJ4bUDMy8/o4
	Xr0dcBjth9B6hgROV2QJFzOpXiiI2hEul3pScQ==

There are many places in git-config(1) where paragraphs that should
logically come after a list are instead appended to the last item of
the list.  This is a well-documented quirk of AsciiDoc, and can be
mitigated by enclosing the list in an open block:

	--
	* first item
	* last item
	--
	+
	New paragraph after the list.

Fix the issue accordingly.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/config.adoc          | 4 +++-
 Documentation/config/promisor.adoc | 2 ++
 Documentation/config/safe.adoc     | 2 ++
 Documentation/git-config.adoc      | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index dcea3c0c15..fc48c1c461 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -276,13 +276,15 @@ boolean::
        When a variable is said to take a boolean value, many
        synonyms are accepted for 'true' and 'false'; these are all
        case-insensitive.
-
++
+--
 	true;; Boolean true literals are `yes`, `on`, `true`,
 		and `1`.  Also, a variable defined without `= <value>`
 		is taken as true.
 
 	false;; Boolean false literals are `no`, `off`, `false`,
 		`0` and the empty string.
+--
 +
 When converting a value to its canonical form using the `--type=bool` type
 specifier, 'git config' will ensure that the output is "true" or
diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index b0fa43b839..39af63dcb8 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -63,11 +63,13 @@ If one of these field names (e.g., "token") is being checked for an
 advertised promisor remote (e.g., "foo"), three conditions must be met
 for the check of this specific field to pass:
 +
+--
 1. The corresponding local configuration (e.g., `remote.foo.token`)
    must be set.
 2. The server must advertise the "token" field for remote "foo".
 3. The value of the locally configured `remote.foo.token` must exactly
    match the value advertised by the server for the "token" field.
+--
 +
 If any of these conditions is not met for any field name listed in
 `promisor.checkFields`, the advertised remote "foo" is rejected.
diff --git a/Documentation/config/safe.adoc b/Documentation/config/safe.adoc
index 2d45c98b12..5ae4476b24 100644
--- a/Documentation/config/safe.adoc
+++ b/Documentation/config/safe.adoc
@@ -2,10 +2,12 @@ safe.bareRepository::
 	Specifies which bare repositories Git will work with. The currently
 	supported values are:
 +
+--
 * `all`: Git works with all bare repositories. This is the default.
 * `explicit`: Git only works with bare repositories specified via
   the top-level `--git-dir` command-line option, or the `GIT_DIR`
   environment variable (see linkgit:git[1]).
+--
 +
 If you do not use bare repositories in your workflow, then it may be
 beneficial to set `safe.bareRepository` to `explicit` in your global
diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 00545b2054..8439ce97df 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -221,6 +221,7 @@ Use `--no-value` to unset _<pattern>_.
 +
 Valid `<type>`'s include:
 +
+--
 - 'bool': canonicalize values `true`, `yes`, `on`, and positive
   numbers as "true", and values `false`, `no`, `off` and `0` as
   "false".
@@ -239,6 +240,7 @@ Valid `<type>`'s include:
   escape sequence. When setting a value, a sanity-check is performed to ensure
   that the given value is canonicalize-able as an ANSI color, but it is written
   as-is.
+--
 +
 If the command is in `list` mode, then the `--type <type>` argument will apply
 to each listed config value. If the value does not successfully parse in that
-- 
2.30.2

