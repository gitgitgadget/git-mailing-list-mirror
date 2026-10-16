Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8D560AB7
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171149; cv=none; b=Jfutd+zenyoHUt3ynCmX6gEIRbLQzbYp96ZXUEde+RlJ8oUJFPKD4b86w+l53NCsBmO44RKdnCf5MWkNJWUduVLQg/5ODmUP7XopzHIS7b4F2j9zb7SeSEyYD0Rr8pd5oa9PUi/8ENNq8IriIZ21CASavLeoRQLQ48cMvRAZ7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171149; c=relaxed/simple;
	bh=63Il0fIkRxyQAW5LKpYtAiVZugt3XlyOJiCSYj+zwKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jr+iyVYzkiDSti3j75ySL9pQTL6j0A03Xxu8FBFHAuXnmfMwGFFHE4sjwVfK5elF5mfi5MA+yGuC8NWOfTl8YVdqy5qPZVU5bMX48fBUBHORttQYLe4tIHeWpUf9cqBb4wVGaPhBpde2FUdp31gkt8aagQNcDtUrEjLGltERZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hpn1nLaC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpn1nLaC"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afbd2c386so35807f8f.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171146; x=1792775946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XubYbRPMu6do9DehIRg6m1BkVLaWKsoSvPYNBO6SO+k=;
        b=Hpn1nLaCe6R+XyIXbTgZvM+Eb8xQDVutQV3BbNzooKUsS9zoIXtPsqy8W8lU3nhexj
         tIFcHWGJoGlZ682NQZyywogeAuCdjCFMSCfB2Aevoh67uyMx087HxcEdjWF+UkbMDH8h
         xkopjhjhlTc3ob8N1RI96viOq6mG4sSAp8I8XGWEXhIitybIRqnkKMsSKZz+g3tIL6fX
         XvEWK0ZWtv2a+XtNE3JL0bYF7sVvnixrrxNZl0uFbGrSVR2cgoE5Zh7d7qk7WamPLjr6
         w4rHeiwsAiwgs7EhJcuF3eFW+H9DwFFaumCjF3KpzIEWEZZJlLN6tgQrSrbAWK284yAW
         xZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171146; x=1792775946;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XubYbRPMu6do9DehIRg6m1BkVLaWKsoSvPYNBO6SO+k=;
        b=FsEJfws1YWjwdnZy0mWJgXqnfHHhYivW7MFB9s7XIzT3kodek98VGD5ezNztZPU4ki
         E4YC5JuKhfxpd+iKra4vDErGVZdWh8X7sjh5f8Rm428HEPhEgcdJ8v6S89fnrw/ceDbN
         QwuCoBSnx4R+4s7/FYfi0Onlxq4vnIg2ojOSAu3OXN3UNEwvu0FnbVBCRO/ynknCCSQ1
         OL7tDGuekhy0ilhHLNTeoU/SMNvamoQu998nrQzTVaUDaG5/Sq6Zjz477lRfZBgR3FJT
         WI09PTUypBzz0or9w45TByct1Vwc++IQQs06Yle6smI/AYORt0r8MnLpJuo9j5KTJei1
         qdhg==
X-Gm-Message-State: AFq9FYKWHTp453QnPgk6HqXEoVeLWCca9XDuTfktlQutJOaW2LlPq8wG
	i2BTzgvvPolQfwodf7lHJfojURk3YAq34wAnOBgH1yyr10zLlW6NhQFD
X-Gm-Gg: AYBFou0pZp1JUxii5zAbpoQMe9VtIDTfhfguieWBuBT3bvjQnyi1QpM982VMVXcnFxu
	PtDJJORPZv/0lrHbyS940oBGvJt0pCmWNv1jqvX6EF+L8Th3QrmB4GB7qLiERkqFeraa388zOs4
	0DoKCuA9U6KUsnHb5aCOZ+UBO1PzroDPle0RXBP+uoSAkbmNFrlAlmmHnTgdqAQFOkPt8VDb3HB
	h7hTZqdS80o/ZlcIRdm31Pb2ZmYpH4uBxoHSUzs7vubHDBCyTBaoA4FvbIKKsfPONGfq2GZu1jZ
	8jxIfjHt64rG6JSl2Ouvso28WaH3NDQ+cyKQCw71S1qoTgE6BDVISgx3NxgPD/XXKMmDxVu2c3Z
	zXk4HXBNfMhPOjtW4zxy32z8v+foZjsiCs3p0Ps++z3vxbjB0OtR38PudPAYajOXB7oMPvhgMsr
	FW71DsyamGAqHQTQD4aZZBUJ2KD6VrVE+3jXRSLe5HaWckp/LSQCpqksRDbSnhRUjMomwEQn92h
	wDGOHwZ6bqmGGx5+vPdTpzvQ0PvM7yjtsYVFrDeIWpBsxy7mteoy8JQC7s+MDiJ5/Suf4WIHSvr
	QVLQ1XszXftM0s5vruO766tEoy1gdWXOsUphx5XKqEMu
X-Received: by 2002:a05:600d:4446:20b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-4a1d75f9e85mr7767555e9.15.1792171145757;
        Fri, 16 Oct 2026 10:19:05 -0700 (PDT)
Received: from antek-thinkpad.tailf34d0b.ts.net (217.96.148.114.ipv4.supernova.orange.pl. [217.96.148.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf983b88sm59294335e9.7.2026.10.16.10.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:19:05 -0700 (PDT)
From: Antoni Borowski <antekborowski11@gmail.com>
To: gitster@pobox.com,
	peff@peff.net
Cc: git@vger.kernel.org,
	jpoimboe@kernel.org,
	Antoni Borowski <antekborowski11@gmail.com>
Subject: [Microproject] describe: do not translate --debug output
Date: Fri, 16 Oct 2026 19:18:35 +0200
Message-ID: <20261016171835.90420-1-antekborowski11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqq4ieotc9x.fsf@gitster.g>
References: <xmqq4ieotc9x.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The --debug flag is aimed at developers debugging describe's search
strategy, not at end users. Translating this output makes it harder
to grep for known strings, compare logs across locales, or paste
output into upstream bug reports written in English — all things
developers routinely need to do.

transport-helper.c already follows this convention: its "Debug: ..."
messages are plain C strings with no gettext wrapper.

Drop the _() and Q_() wrappers from describe_commit()'s debug-only
fprintf() calls accordingly, and prefix them with "Debug: " to match
transport-helper.c's style.

Signed-off-by: Antoni Borowski <antekborowski11@gmail.com>
---
 builtin/describe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a5..775f9f27f1 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -351,7 +351,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 	if (!max_candidates)
 		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
-		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
+		fprintf(stderr, "Debug: No exact match on refs or tags, searching to describe\n");
 
 	if (!have_util) {
 		struct hashmap_iter iter;
@@ -419,7 +419,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			}
 			if ((c->object.flags & best_within) == best_within) {
 				if (debug)
-					fprintf(stderr, _("finished search at %s\n"),
+					fprintf(stderr, "Debug: finished search at %s\n",
 						oid_to_hex(&c->object.oid));
 				break;
 			}
@@ -477,14 +477,14 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 		}
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			fprintf(stderr, " %-*s %8d %s\n",
+			fprintf(stderr, "Debug:  %-*s %8d %s\n",
 				label_width, _(prio_names[t->name->prio]),
 				t->depth, t->name->path);
 		}
-		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
+		fprintf(stderr, "Debug: traversed %lu commits\n", seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
-				_("found %i tags; gave up search at %s\n"),
+				"Debug: found %i tags; gave up search at %s\n",
 				max_candidates,
 				oid_to_hex(&gave_up_on->object.oid));
 		}
@@ -565,7 +565,7 @@ static void describe(const char *arg, int last_one)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (debug)
-		fprintf(stderr, _("describe %s\n"), arg);
+		fprintf(stderr, "Debug: describe %s\n", arg);
 
 	if (repo_get_oid(the_repository, arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-- 
2.56.0

