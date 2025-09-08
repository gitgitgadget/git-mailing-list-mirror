Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7D83019A3
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335065; cv=none; b=m4XZOj4clHaEkfv6SVMWRrBfofSLiJI6R+dkEkxDYM7dAjhsge1CVVJV9zm7q7dQnfWmdCSjdGKJAjq6PL4A0qIwXWOZC975HaXHvMQJ1D7NEbotN/iPTXUpYgEmJcXHJtPUSwntx87hj0lJQXelP+GQ/UUeVwpb7qZXem96tys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335065; c=relaxed/simple;
	bh=243l8fFLQCy9Es/EK5ZQIeTR4RVggt4aTj4P1f15xB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPfEhpQwOC362s4cPPDEs1wZrmjUAlgTjKwbECX5tIkjaTclooTSr6DBfeUqv68ngDaVNOtCQDb76AVkSfW1enrHRY7spUYrTHMyVJVGdPhzk6JVMVl5ENbGqyoN3TPbvowRKCWZvy+UW7jUaXZpqyWiiknGIKwhRfGWD7QcnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JckPKT59; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JckPKT59"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so5893778a12.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335062; x=1757939862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7VrbejAMfKL87wOrA34e1dYD7vH7aSHrtc8mKGqFCc=;
        b=JckPKT59v0qzueCIpngfKrs3OVpcPB+uRtb9hZuMWy55na6oEGZ+XF41Z+MfKYWgPi
         oTpe+9cOFDuOyLYnfwIdRpkzbZ42yvSqg62deHN8oWdGB2Vzp5Qvp3PA5xLYzf1i1206
         pts7e+nhBeY9wM0X2eiqunaeVhLWTr7cbOp/SnmnX4zpmDlxrFNuVdaGX/lqQyEZisqf
         KINzDeApfzkxr5h//XLgGd8LXbT8yqiUDAMFOBMyCm4Feap05+Wx5GRZs8qYabCJhNr2
         D5nGraER3DcLawZnIw7Z6Pjk87yPpoxG0f9Qc4O92a6PeWktppS5aa+SzC+EZibv1iZx
         XpNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335062; x=1757939862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7VrbejAMfKL87wOrA34e1dYD7vH7aSHrtc8mKGqFCc=;
        b=FBEGQoSoMhBUeXf48dAbLJ7/EPPNeLD8Uo2e99Rmblc84tgGtBDHoXWnivpNooaTmH
         4Yhd+Syhes4oGUuTf8ieuKEPJqqPI81uGkJ7YTaL4KkzmcaUVQHGW+0VTk+jaJekzNSS
         HkCwH37EBc6ByBpso5d0MTVenHCAg5iQt3OqmKO+q3NCc3+cVknpV7Jx1ODCKVnWu77z
         dRLwI6a/TCZuRdNq0z8hgBCHs1njjq50oyN68E0cx3Le4/lyUkN3AO1q55qnEM6JRF+j
         JQEkZCJdQUfX/CvyYSqcTM0AUef9HhTO1J1gcNhR2n7nVV/lM5GKKIyKlw+b9Z6p74RO
         T9gg==
X-Gm-Message-State: AOJu0YxromDD1ImbpTKUtOejPNgK05LyqQJdGW3spsrNq/SAui4srNA9
	t3LNSazw4Z3eFanCrK/JCMBUXBs6MLa0qFEJQVumrQXA121EpqQHOdcR
X-Gm-Gg: ASbGncs44fHj+IcleJm7sSh+n87ptiFXo5wrj1iy6uTtJOngBbLh6PudDEOrJ3xnVH8
	2/6NQIAFqrB231D1xKrUQekmD41Zy/IbyhLoVVkU1hK4fVFsBz4vZ7jywMM6Bn9sKkEt/ZZrm1h
	cVWte4IoQM0RCEcNJVlXt6ACf1iXfCMBquMOPgGRb0Qhgp2mYhoUFyjxDYj8LR2j0i1Kbl+84dx
	aL3wo4ryCKn4UVz5I9U0bRDLYvJiRpdhAmKwCHLSmfC35oIlj9kpO4/EhR/ooJ2tjE4qis5wgDk
	OVoAAKkV+dIAdbsAfnOXklu7a52Qwfvg+8h6L/OaSKmSjUlfwodlj12ulMi0R5QHn87A/pnFbXE
	f/mNrdJjzUgD7khP9cLN7FZKBeXHNIzGWjiy7s5A=
X-Google-Smtp-Source: AGHT+IFqx3ezgH7ZBEoY+chq6S4q0s15ypm3qjy4qbdGGaLxLaDLcmnK9jxjq67qxdvzT3J+TXqfRg==
X-Received: by 2002:a05:6402:34d3:b0:628:62d0:fdab with SMTP id 4fb4d7f45d1cf-62862d10569mr3183576a12.11.1757335061386;
        Mon, 08 Sep 2025 05:37:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:c9f4:d82a:f11d:d7f9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm23257445a12.2.2025.09.08.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:37:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 08 Sep 2025 14:37:37 +0200
Subject: [PATCH v2 3/4] refs/files: handle F/D conflicts in
 case-insensitive FS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-3-b2eb2459befb@gmail.com>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
In-Reply-To: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4292; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=243l8fFLQCy9Es/EK5ZQIeTR4RVggt4aTj4P1f15xB8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi+zhHlr7JFv2om8oGf0xfA2WvRxUFYLD1B8
 WimnYBpju6OUIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJovs4RAAoJED7VnySO
 Rox/CAkL/1zRLszssZtJNmW8MnrQqlHmoiiZMwi1EdPhX2UxvF3PfawKrSFaRZgGAOQ1E9AOr5S
 95eoJQb1Q+rIXg8TFV2E0QIw3GO8FE50PPIQgZcoosCOtapU5JMLL5wiHyxdLQN/V0cDP0y5Sy9
 1cOI3+8/5zXKiglObIlIA1hp2RE57gvjt3AHMa/rdLzDgLVgBMPG/AkJtWPRgMMikCB0juqQOVY
 oDyW21EUsUNvt8c9jza1FtSKQNz+O4MNAQhEMC6GJMUDGYa85PecPJ1EPWhXV+Zxwm5+w1rdUxv
 0p/XBgg9uDN2wyVtP//J1FvWTyN4iEwiqzn+jmKyc9gZ+Cq2uVvHm2svkG9CDTWtyI3RjxUofr+
 MRLQJwC+0vbP/1DebAaRbZFhVMlfTVSzozwo3N7fmAP0pXMRXOnBwuV3eeNZjFRf7G4rFAty+sr
 wnBU3h1LAoQ/5PtcuFWw1nxj93uOThq6vrTA4U28f0rklTkIRBcl/S7jTMEw5HDdVIcQIV4BXx4
 iY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When using the files-backend on case-insensitive filesystems, there is
possibility of hitting F/D conflicts when creating references within a
single transaction, such as:

  - 'refs/heads/foo'
  - 'refs/heads/Foo/bar'

Ideally such conflicts are caught in `refs_verify_refnames_available()`
which is responsible for checking F/D conflicts within a given
transaction. This utility function is shared across the reference
backends. As such, it doesn't consider the issues of using a
case-insensitive file system, which only affects the files-backend.

While one solution would be to make the function aware of such issues,
this feels like leaking implementation details of file-backend specific
issues into the utility function. So opt for the more simpler option, of
lowercasing all references sent to this function when on a
case-insensitive filesystem and operating on the files-backend.

To do this, simply use a `struct strbuf` to convert the refname to a
lower case and append it to the list of refnames to be checked. Since we
use a `struct strbuf` and the memory is cleared right after, make sure
that the string list duplicates all provided string.

Without this change, the user would simply be left with a repository
with '.lock' files which were created in the 'prepare' phase of the
transaction, as the 'commit' phase would simply abort and not do the
necessary cleanup.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 19 +++++++++++++++++--
 t/t5510-fetch.sh     | 20 ++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2730713d23..85f2e14e93 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -888,8 +888,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 		 * If the ref did not exist and we are creating it, we have to
 		 * make sure there is no existing packed ref that conflicts
 		 * with refname. This check is deferred so that we can batch it.
+		 *
+		 * For case-insensitive filesystems, we should also check for F/D
+		 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
+		 * the refname.
 		 */
-		item = string_list_append(refnames_to_check, refname);
+		if (ignore_case) {
+			struct strbuf lower = STRBUF_INIT;
+
+			strbuf_addstr(&lower, refname);
+			strbuf_tolower(&lower);
+
+			item = string_list_append_nodup(refnames_to_check,
+							strbuf_detach(&lower, NULL));
+		} else {
+			item = string_list_append(refnames_to_check, refname);
+		}
+
 		item->util = xmalloc(sizeof(update_idx));
 		memcpy(item->util, &update_idx, sizeof(update_idx));
 	}
@@ -2814,7 +2829,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 			       "ref_transaction_prepare");
 	size_t i;
 	int ret = 0;
-	struct string_list refnames_to_check = STRING_LIST_INIT_NODUP;
+	struct string_list refnames_to_check = STRING_LIST_INIT_DUP;
 	char *head_ref = NULL;
 	int head_type;
 	struct files_transaction_backend_data *backend_data;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6f8db0ace4..08dbea6503 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -53,6 +53,12 @@ test_expect_success "clone and setup child repos" '
 		cd case_sensitive &&
 		git branch branch1 &&
 		git branch bRanch1
+	) &&
+	git clone --ref-format=reftable . case_sensitive_fd &&
+	(
+		cd case_sensitive_fd &&
+		git branch foo/bar &&
+		git branch Foo
 	)
 '
 
@@ -1572,6 +1578,20 @@ test_expect_success REFFILES 'existing reference lock in repo' '
 	)
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive_fd &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "failed: refname conflict" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/foo/bar >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

