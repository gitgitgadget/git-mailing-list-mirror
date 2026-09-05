Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFA24E66D4
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628416; cv=none; b=Mg9nfZYK9KBWZ25I+50hZk1kIDKFjxVslM13+l25LAh7Aw5Npq9v1vNfohWX57zhXrQlLNF2/Jd0YuBi/calBaMVmoe4LO99kTNdbsTkdanGE0KE+moK8oY8tltoV2bzQNdxHi2kYwRypOvLQpeikHxGZXAo4VdpfjqVjmf3s+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628416; c=relaxed/simple;
	bh=ddX8ttWJl2zHfwcBKHgN/2G+G7NR1x0S5wJW0Vrvel8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyb3AJe17NIphH2H5SO0Fl+73qJqPolvyDNJYvQfWbp/xyrE0veU31YWBeP0EQJ8Nvr/fRaLntsQCO22o49w0xP4r2aa7zszh+tM6yYDyNghelyoz48MflP8JgUuv2vTDP0d5ncJPxerlDq97+JoEOd92D2d+Ru8uw1nOppYH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=jXeGwgfJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="jXeGwgfJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso18192895e9.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628413; x=1789233213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+1Wg1OHObIRX9SUBC2Bwv7iwYXRfuQNHv2QJnAVXAo=;
        b=jXeGwgfJndJnKTk2aXR6QHojygAvgQtDDakVcJs6YeD/JNsb3436S2x9FWmO6e8WZ6
         TLOYS2nk2HabqZ1CF790cVGMEOnRRyH7SlCxazV0j3K/s+wL7hdt7oNJqvqcUm/j+hw2
         hqHfANF0b3hd8CS3Qf42fLmCs5CpM7zs/1BvM7cxKbw+0shiJ1w4FT6ZNr5ugFnRe54D
         Gpr6pl3vi2yKFFxUzXcx+Dv2nqxYcbJqpGFbUyJJJbiC8RE71QcwTxLaYJQZs8kajWY3
         K2tMRyomCrsSD3Wgg+AaVAv6uaGJNWC/CKcF/HfIB3wg86gn/dHR6p+n//P+cWfNuJbn
         J05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628413; x=1789233213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+1Wg1OHObIRX9SUBC2Bwv7iwYXRfuQNHv2QJnAVXAo=;
        b=sGuzTfLFvGndYmzS4TfpumwSRxyvy2rirR9JfU3cFgL4XU7AaxvTeX+V6waMURWRa5
         z+aSlHYdC3NRlcEgDUp2hZ29L8DijkndRCWyJ5DtLtQpHKAYXSgVH/BWwyG5X+AO+WY/
         BIQci/qpKU69EmuEmq0kUCMyB0MltmjNEWIn1RkgU0jIpauPzyfKhhOyxBmVPq3mIM9G
         TYdGy9G/3Rm8HUhMukazpmMaoVfyM1SP1FLvisFSecFFkiIi/Z68gclJMNIQariD5bpg
         iwPi+XzZN2ynqWUfoG9zbne6fludTfdd+ggEGOeI6JWNVNMmXtkOSgVSSEEUISXH3UMl
         +k2g==
X-Gm-Message-State: AFuF++mvFblsNmdpsF/KfWU6XoaDpbpQpYvtTs+k9B4/QQAlIpwFGdtm
	W89bv3LUEcArqCUFZziXdnBUwGlmPP3AXZC/emVof3a0Zdgf8J+4tqRGQcyFkpqROoO8EkWT6eq
	MtTVPC5JjSlJy
X-Gm-Gg: AYBFou3t5nQtpz62aQOr414qY3lXozECRqx48i/3bAJJjgxsD+oJ0TZTahBVJOn7F1f
	okxa9R9cvzknZlRSxTAfODQfU4+N8ClQMcxWa8keY3giJnATZScN9aOCdi/2nhsOWE/meACWd+B
	VpoGn9fDruDLYxoXqNeKvmWrd3PgdbmdHgh/PoY5QEV2KerpdZ5fAe3TqRL6FHS6Yop1V3iXOiA
	OunLWWK38vbjIAhQ6nsJwma9y4eLEVw/wyAraUQeQD4064cHWzX9HS3Zz1rmEeUSu5cNUXJ5WKX
	JxwbDtOH79ZW/96vpnXIfQ45cftHFegLR2nG1NryxYEZPMmqJgPJms5c41FSa9iMeOwo2BG7mtX
	/hL5nWnikVHduoc+SjvRQWzODDG6fNHcV7qIyB8XgEfytfWhvgsx10BVzW876KWba1oEPCLaChC
	aG5nH/EbERvn/RzA88LDVrsc+iqk5VbsoPl372vd2mO/NoHQvni6pU8URejWlZLKlaalChpGn4/
	8WTMnk=
X-Received: by 2002:a05:600c:64c6:b0:49c:fa20:cc02 with SMTP id 5b1f17b1804b1-49cfa20ccaemr108358575e9.25.1788628412627;
        Sat, 05 Sep 2026 10:13:32 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5927b68sm272038735e9.1.2026.09.05.10.13.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:32 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH v3] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Sat,  5 Sep 2026 20:13:30 +0300
Message-ID: <20260905171330.34646-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903010547.85469-1-f@lex.la>
References: <20260903010547.85469-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 99a1f9ae10 (push: add reflog check for "--force-if-includes",
2020-10-03), is_reachable_in_reflog() stops walking the reflog of the
local branch at entries older than the newest reflog entry of the
remote-tracking ref. That timestamp is read by a callback of
refs_for_each_reflog_ent_reverse(), so when the remote-tracking ref
has no reflog, the variable that holds the timestamp stays
uninitialized.

With the files backend a remote-tracking ref created by "git clone"
has no reflog and does not get one until it moves. On my machine the
leftover value exceeds any real timestamp: the walk stops at the very
first entry, never reaches the "Created from" entry that "checkout
--track" wrote, and the push is rejected with "remote ref updated
since checkout" although nothing on the remote has changed.

The cut-off is an optimization that rests on an assumption: an entry
older than the moment the remote-tracking ref last moved is not
expected to be the one being looked for. Without a reflog there is
no such moment, hence no cut-off to apply. Initialize the timestamp
to zero to say exactly that: timestamp_t is unsigned, so no entry
compares older than zero and the comparison never fires. Using
"now", or any fixed age, would instead cut the walk off at the first
entry older than that bound, which is how the failure happens in
the first place. The price is paid only when no matching entry is
found: the walk then reaches the oldest entry and falls back to the
merge-base check over what it collected, where the cut-off would
have stopped it earlier.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes since v2:
  - reworded the first paragraph as you suggested
  - explain why zero is the fallback rather than "now" or a fixed age
  - dropped the Assisted-by trailer

 remote.c            |  2 +-
 t/t5533-push-cas.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 00723b385e..6d301698ca 100644
--- a/remote.c
+++ b/remote.c
@@ -2751,7 +2751,7 @@ static int check_and_collect_until(const char *refname UNUSED,
  */
 static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 {
-	timestamp_t date;
+	timestamp_t date = 0;
 	struct commit *commit;
 	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872d..bb8878c593 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -396,4 +396,22 @@ test_expect_success '"--force-if-includes" should allow deletes' '
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow forced update when remote-tracking ref has no reflog' '
+	rm -fr dst src &&
+	test_when_finished "rm -fr dst src" &&
+	git init --bare dst &&
+	git push dst main main:branch &&
+	git clone --no-local dst src &&
+	(
+		cd src &&
+		# a clone leaves the remote-tracking refs without reflog
+		# entries with the files backend, but not with reftable
+		git reflog expire --all --expire=all &&
+		git switch -c branch --track origin/branch &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		git push --force-if-includes --force-with-lease="branch"
+	)
+'
+
 test_done

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

