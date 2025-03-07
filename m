Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F5A1FECB6
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390034; cv=none; b=U7zYdvUqG/LIWdtmFkIX78w3V5xOWsTYsQJrRnzhl5UGxwZk6Aiv08w9Mw1vcivSW8IpFTmg/AvUDfWHSLTEolG0H8eAVcbNxvAsV/enzEi8ofuIibEKuIS2eGnFmBiWQGWfPjsdUw6tCWm9Bq552or/scaHH5YcZBbZgxAfA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390034; c=relaxed/simple;
	bh=ObVp319vyrlZ4D943GHj2jlCwHZH6gGPwYQbLj6UW1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZwvF+eiELP52S6Dbr5I2x2jpjrVcMYB3UryYqAbe++0icg2BYUt/1o1Yfwb0PasWT/pzmCXNudDoM9ER619FyY8bbhuclzPTU8zZ7l49jL7cW+6QC2LD97Lp+pwedakkgsH8dHgpQXSwMq7ouUwNx9OdA7pl9L5koJTp1gPOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HhOTBh0l; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HhOTBh0l"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2196803276.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741390031; x=1741994831; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6RhbB3Nla1S/5p97SWZSPhrLauxa5KdTXZwz9Ke8/Uc=;
        b=HhOTBh0l/uptCHFTXgA21XyTEx1m9l+wvGkH8fPGXfVMfYCpViX99/uKVZ8klhBpmb
         xYIzrehnuMicymuzOCg6wyw/sNbcWdqELQ96wkoMsD45Gql6cUjE6z4oURy9aBmyImRN
         KhS1zWQiDM/stq/STV4Pb046kJavBX83nGzrKpUwxmglufwUVeIOxDDkuGPb9Vk2lh0J
         Daz8mq7b/0BttGtQhOVVCxGXdVash8hKfz+GMh/bPQzQPZzZKK7GTNQR4ZmJ/0lwcNK4
         NMWDWOlOhxKO7Jdh6vSQsyFBK4q5dpo8TPDXPLWfEAATStLZ5h9DTEZIpkK3QicMPPQQ
         XgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390031; x=1741994831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RhbB3Nla1S/5p97SWZSPhrLauxa5KdTXZwz9Ke8/Uc=;
        b=WFRzfJ5h735798IeQ1a6yPjMuzS8OpmOjHSwCbJdDBlu4bplHZhwdlwISIMxfNaFWT
         QaDfsE8AcQHIkniCbAWGUuC3Wxeke1ILHVF6QyvZ0Hnwr56KX2CQSzwM/PI9IiQYrxBS
         1J8Wp/pLmX3kCyErsqO8X0msIYQOHrZf4Uyb+76rvQCK46ztZOwV8qPBUM7SlrSB2qOZ
         KBzsa2DNmGH57J/a66g5Ic1enFRA/eG1k/v+69z75SYXA+wZ324YWOYOFEblbivwTt0r
         b4M9IBL8KEjM0IUwkwyUXmgy5bw+4dhHwcj7/6hR0gJyMJ5AJ2kdA5t3tOBsENSpapBp
         tvdQ==
X-Gm-Message-State: AOJu0YxSnf7uMB32HdniHiUHP+cQPvEBupa4a21ZnSTuJE0RNBYhwh1m
	b0DU1m+2whT649aRtcju+isCx0ZLMw4BOvukPPsnk9dVzw1+BiqmGSnuoP4UANi7B3oZJgCSA01
	e
X-Gm-Gg: ASbGncvfo9c2TWLL2atcbgvgN2UvGebgmyu/Kk0l7zzfWc9Zw2dc8NqXGDRk3Zwq7LJ
	f0G8PHFW6trnHudJ3yEU193eEd02PEzGSlbr0mR8n15pcudrt3vKKO643qU0gxrPn2Q9FS2gMHI
	Vosmsp9qO9ZLv2MI515hOhTnXbHNzSGOoGVdUExDeBCZn3rfpDWYb0rIc4Fwq2zBwYS272BnXkP
	MyJgaz+HXPRan3oPGoZ7FOGf9UvnzVEPPBPWLZAWHFqUpXIf1KnZbhHoOMOjwHcidLn+uVZ97zW
	Q+pycNcHeYoAGvliZMQ0LxWvKi03lPSVj2b68FWmDKcAffs1uMMC4+87yZd/neuOzjHDHE83TFU
	HwTZEf5Zo5iLSXLN5
X-Google-Smtp-Source: AGHT+IHP/bU0OhmxpA3mVSsbLyJMZaLsCDsM2LyA5iqU3Q0MzyaTBXp2qDvvP/g3ujHQ9vd6Psws6w==
X-Received: by 2002:a05:690c:4441:b0:6fd:4718:9bde with SMTP id 00721157ae682-6febf2d84c2mr69518847b3.9.1741390030717;
        Fri, 07 Mar 2025 15:27:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2c46defsm9461127b3.105.2025.03.07.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:27:10 -0800 (PST)
Date: Fri, 7 Mar 2025 18:27:03 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH] fetch: fix following tags when fetching specific OID
Message-ID: <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>

In 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22),
unconditionally adds "HEAD" to the list of ref prefixes we send to the
server.

This breaks a core assumption that the list of prefixes we send to the
server is complete. We must either send all prefixes we care about, or
none at all (in the latter case the server then advertises everything).

The tag following code is careful to only add "refs/tags/" to the list
of prefixes if there are already entries in the prefix list. But because
the new code from 3f763ddf28 runs after the tag code, and because it
unconditionally adds to the prefix list, we may end up with a prefix
list that _should_ have "refs/tags/" in it, but doesn't.

When that is the case, the server does not advertise any tags, and our
auto-following breaks because we never learned about any tags in the
first place.

Fix this by only adding "HEAD" to the ref prefixes when we know that we
are already limiting the advertisement. In either case we'll learn about
HEAD (either through the limited advertisement, or implicitly through a
full advertisement).

Reported-by: Igor Todorovski <itodorov@ca.ibm.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Peff and I talked about this today, and neither of us could find any
reasons not to pursue the approach listed in the footnote of

  <20250221072558.GA572877@coredump.intra.peff.net>

, but this is a more conservative approach that should fix the issue and
apply cleanly on top of 'maint'. It may be worth picking this into 2.49,
even though we are already quite late into the -rc cycle, this is a
fairly nasty bug.

 builtin/fetch.c      |  4 +++-
 t/t5503-tagfollow.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fe2b26c74ae..a06d1305016 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1777,7 +1777,9 @@ static int do_fetch(struct transport *transport,

 	if (uses_remote_tracking(transport, rs)) {
 		must_list_refs = 1;
-		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+		if (transport_ls_refs_options.ref_prefixes.nr)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    "HEAD");
 	}

 	if (must_list_refs) {
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 195fc64dd44..8495730e264 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -160,4 +160,19 @@ test_expect_success 'new clone fetch main and tags' '
 	test_cmp expect actual
 '

+test_expect_success 'fetch specific OID with tag following' '
+	rm -f $U &&
+	git init --bare clone3.git &&
+	(
+		cd clone3.git &&
+		git remote add origin .. &&
+		git fetch origin $B:refs/heads/main &&
+
+		git -C .. for-each-ref >expect &&
+		git for-each-ref >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done

base-commit: f93ff170b93a1782659637824b25923245ac9dd1
--
2.48.1.1.g965d2fe18fa
