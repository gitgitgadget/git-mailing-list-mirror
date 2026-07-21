Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204014446F4
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676620; cv=none; b=O9lTIJH9Ff+zBlQARoM77h/hGicFZgf7RlU29sg+drCuT02QZ+97EBck/qMIeZUW52pr6626Mwb8CokaKyJumfZzTXbLSPUgz8lkMmezrZ5bbflNp5ZN+vTAAUAoQzv4rad7N+fAKgNi7UAxmSHwJXaGjvUBl3/v3a+venBqxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676620; c=relaxed/simple;
	bh=WAhSIeOpD0X6k11rc8bYw/nOgjzY3yKRb7Bq/czSlvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVncJorhFfJQc2ICpPI5TiUaZvZup6CPIh5WbdoHax6AE1ZZHDzbIj9TAIGnC2FNenfC/nfoAPNQ7cbx0GXQXKgMTG0JAfQMpvp7bquXWnVWDHpsZhgsbIN0GytF47AUzJdc+32rl37W2ovG/fEfTLSYtW9oA9cqP1qZb2uHNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ghBPIopt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ghBPIopt"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f03db59e9eso14645326d6.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 16:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784676614; x=1785281414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1qu/610kEEP7lBSncZKuIsdgx+/Dc5NURAWjC5clJ7g=;
        b=ghBPIoptWHqZcWK/lT4EVEeYn+Y7OKWHT6Bimgy3eEVONaYJM+2pRUK4dlDwjN+mL4
         IAo3oiy9TehGLf8tDIMJbzynY/Ui3EG0yUBq9kBUI18FFz4ZlmnJGRmnbcG+QaOvfrla
         n+JpA68dS/iylg6a7EcqtRcgbKmrTqKnEs4GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784676614; x=1785281414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1qu/610kEEP7lBSncZKuIsdgx+/Dc5NURAWjC5clJ7g=;
        b=Yn3rPkxYKi4wHHFWGqv0OvH2bkfVRlyPAoa6ahoRgctg96wNPMbFBK/0ya/2TSzmnU
         bIDiRNzurJvbrjW/nmZ0nVgvq3tX1y+crFBz7O1KVmYl/PF1zn4+cvQm5oCpwc6OoSV4
         pG7uryp+lNHSUZEhUGTi6OhMWN/WCrp9SAQD/+Z2RmHq2CfPjgncPbFe3BP5wcJ2aFsT
         Qp3ntf2VvgF2YlkD4gA/px+2xtMPQ1UC2ilJJqZSDahlEnJqh7NY1uWY60FeIx8eTwoD
         YnTSujoHs9O/ly5EZZ+r6mNYoDBbTw+kwsGgXGbifAdNldv6eUQOkNb58u4JkGvxFCx3
         E5nQ==
X-Gm-Message-State: AOJu0Yz/r6xnsM2W+pG1nTgblMgJI9dDSzl7txfRUIeFlmAqEVkxGi+0
	T2WNOLfsQ2JEyl350asRa3Me5j/IHZJwKbJ5X8r4wlR+V87TkFiP3qZxtpiMnE+5QhhHxSXFxKv
	cgyKu4Kk=
X-Gm-Gg: AfdE7cme9fEW5Tdr+8dz8WSSzvJtB6WUctHdECmSMf94KXL7cfKLcDRBD7IkC6YN5kp
	Dh05M9j9U8TZ23uOSRV5CjRjLeXK9ZHL0AU0gk+n/0EkSwoIeMfF/HoL1GeY9++DaR8cVAz9t80
	1mM3/6CUroz6TlrHvhGdSxr/pTtBUafbGLrAXj0TjsXKiKFef6fNUzK/bQ36R+UTwKJ6KLFRZVH
	fPMb3BdRYVp4fcIdwv2z2OQl5rNL6g8OtEevMZlie4y9SsD1X5uR4V3skSUIo/uT6WXduYfrbVB
	0qlnDZ4/zwiRMkUlxTjbm426bToqBLIn7VVer6v0fw+Pz9giDVAXM9ROxkm4czICgsmdxzZ4bBT
	+ie+V2cdj3AyHr6GGZzApq75eRPPR/BjnwPjiPY6UkD0kl2INR5ZHu6t+R+7Ax3nUg+0swOINSd
	p4JQT5eoNafBas18su+hkO2so6iG72sCtJuxS6EjGSREdCfaZawFH3WonqN7Q74sZjCm3taXYnd
	pEA/z9r7Edltx9W0g==
X-Received: by 2002:a05:620a:a102:b0:930:afae:129f with SMTP id af79cd13be357-930e70eddf6mr387707485a.8.1784676613639;
        Tue, 21 Jul 2026 16:30:13 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a0b2c7sm16008585a.24.2026.07.21.16.30.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 16:30:13 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v3 1/3] http-fetch: correct --index-pack-arg documentation
Date: Tue, 21 Jul 2026 16:29:40 -0700
Message-ID: <a6a40b80461377452a0b2c9204c3a659ab60a7d5.1784676106.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.337.g1ee5d7e027
In-Reply-To: <cover.1784676106.git.tnyman@openai.com>
References: <cover.1783982021.git.tnyman@openai.com> <cover.1784676106.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --packfile mode accepts one --index-pack-arg=<arg> option per
argument passed to index-pack, but its documentation and option
dependency errors still refer to the plural --index-pack-args form.

Correct the spelling and describe the repeatable per-argument form.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 Documentation/git-http-fetch.adoc | 8 ++++----
 http-fetch.c                      | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 2200f073c4..09b5d675ee 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -50,11 +50,11 @@ commit-id::
 	URL and uses index-pack to generate corresponding .idx and .keep files.
 	The hash is used to determine the name of the temporary file and is
 	arbitrary. The output of index-pack is printed to stdout. Requires
-	--index-pack-args.
+	one or more --index-pack-arg options.
 
---index-pack-args=<args>::
-	For internal use only. The command to run on the contents of the
-	downloaded pack. Arguments are URL-encoded separated by spaces.
+--index-pack-arg=<arg>::
+	For internal use only. An argument to the command run on the contents
+	of the downloaded pack. This option can be specified multiple times.
 
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
diff --git a/http-fetch.c b/http-fetch.c
index f9b6ecb061..601a77c3c1 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -155,7 +155,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
+			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-arg");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -164,7 +164,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
+		die(_("the option '%s' requires '%s'"), "--index-pack-arg", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
-- 
2.55.0.openai.131.g83a728de1eb6

