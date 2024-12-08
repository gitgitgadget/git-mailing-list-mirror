Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CBE1B960
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733645567; cv=none; b=aEKtS6/rpp1P7PDy00WI2qPtFejtPh8nmv9MofRehfPN/mvB/UfFqH0G88cNBbZixd4icRLh+TaLdGhd3/cFUqAl/rf9aaFOQ4Pp5FtyiprHH+U9pTfwhR2mNPNW/ljP0uzfiKUImRgWOVqtNKYz9K/2Aw0l9JMSJF0D0NQ+yAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733645567; c=relaxed/simple;
	bh=8TlqgXYkeKE2anDBleRD6v8CmsT39NubFTKG+lEhdwA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=p0bptOKkz1R4LIKECNfrJ0LWY2C0HOPaIViB3SZWOxzup7tRLf6Pi0s8hCQ5phxxrbe8DuXOgTayNv7Vc2SCBct9t7z+7y3kOZsP+7LjO/xLUTA7llqHistGW004G/kVYcja8MME/fUgNOgvjI+QAl5c3gTeT79MOk72ZSbcny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao8EAO5T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao8EAO5T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434f74e59c7so213285e9.3
        for <git@vger.kernel.org>; Sun, 08 Dec 2024 00:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733645564; x=1734250364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPfKA3cHhCIKxBxResRZbk0rYWcfQCPnBpFat7OksNU=;
        b=Ao8EAO5ThvOAJZcK91ibIHeCqJmHVrBjWrpx5gthixiFGToch7Qg1g/FFlWWD1v2PR
         fcY5vJWcz+99X0bfzTFy2CzOfWoM5+1cNqJH+8oIUaereyMTlAAf3GhR7RnJ2SlD2l9z
         rq8zDUMI5UZM6881WdQOqYYyekLrSF7IN4n5ef4KNI5QfDdZAvelbKVHKcWJFhc0v4mP
         0poZNyAHMqFLunJY1I1J19TrOKHBT9E5l5nd2gSAdVj2WZmpA5lPhZ3Tm5eEjYC9BFre
         OgCIlqs4b4M87KE1DllWZ2BIMmnJ/0F1aL0yPOTk3loT4moJ/11gcr4AckDKMDNDvdHf
         KvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733645564; x=1734250364;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPfKA3cHhCIKxBxResRZbk0rYWcfQCPnBpFat7OksNU=;
        b=R+6iPvbp/NSyrsMTWYyG5Jb3/BdYzjOZ+C52U5oPL+CqtoZ2s8a/UNJqMoulFyGVwU
         eFVcwrPPWEWL37ExO9IOkQ8+TfID44fw7yVgUu+DfpqfcNunhSQVbPDxM+1xFi6BvknK
         PuQBPlSJarjn6Cx4pk/OvfKdq5BxESPHN44anpSezBu/5ZVuRI5NFye2TwIFze1thd6S
         EdshUyArfwBqZhXZIc8fXnT7rgnxYo6ebHxwU8IMYEKnITqd/YPTD5Elo8IS3lIvHVh0
         E4EFeEGhhTKdyfVXC5/qjd5zZXsngnoc+YYotWK37TV/82aO9Yq6LJTOVWlJ9zbg+DrJ
         6sdw==
X-Forwarded-Encrypted: i=1; AJvYcCWPcQadNo4K7bFsUg+CYuE+JUj8t9FSJNDDm3gjQKWPB1Atr6gCs8EzaRNjauOlIO2KeHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0MdecxbOYDPm0Y179c/1IQsighUmgTQcUo/eZaXXYrI4kFjo
	cEGvhutMYpAY/qwquLjKnm6DFmlaCJCi05biLvZCCef9uPU1p+oJO1gltQ==
X-Gm-Gg: ASbGnctQJpYrJrlfNP37MuqFHiyoCyq+yTdHDt/5YwBFwrh/GljGHlp3qxkEtQPJH6y
	wFuEkxfqK0K326gT7GcmZFmaj4L9JR4f16L8uNukOaqXIghcWmuIZ3yAoQjOoyRIRM3o5JqnJVa
	TOm9+mzNwF/RvTaE57DFOcCBfTB9Cn2i7HsqKlzDcm09jfCzZQoewD/OErFJfk2/rcmh9+7rpd+
	TOTC6mnQTcw4s78BcMGM9KuNraoznuwKg1TBIc4
X-Google-Smtp-Source: AGHT+IH289UTPq+np+YOJ53jZUWh3q4MdCljiu3xNmt0wbFIx9pwFS5tkIY/ncBcsV3yFl65nMDcVw==
X-Received: by 2002:a05:600c:4684:b0:432:d735:cc71 with SMTP id 5b1f17b1804b1-434dded7e52mr68725935e9.25.1733645564447;
        Sun, 08 Dec 2024 00:12:44 -0800 (PST)
Received: from gmail.com ([88.14.46.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbdd8sm9364264f8f.95.2024.12.08.00.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 00:12:44 -0800 (PST)
Message-ID: <43a66f17-c910-498a-8faa-f801194e6c8e@gmail.com>
Date: Sun, 8 Dec 2024 09:12:43 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] object-name: advice to avoid refs that resemble hashes
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
 <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
Content-Language: en-US
In-Reply-To: <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If we detect a reference resembling a hash, we advice the user to
avoid using it and delete it.

Let's use the `advise_if_enabled()` API to display the advice with the
aim of achieving simplicity and consistency in how the advice is
presented.

While we're here, let's add some tests for this advice to gain
visibility if we unintentionally make changes about it.

Finally, the change from `const char*` to `const char[]` is to avoid
problems with "-Werror=format-security".

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 object-name.c                       |  9 ++++-----
 t/t1512-rev-parse-disambiguation.sh | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/object-name.c b/object-name.c
index c892fbe80a..baf5422013 100644
--- a/object-name.c
+++ b/object-name.c
@@ -943,7 +943,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 			 struct object_id *oid, unsigned int flags)
 {
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
-	static const char *object_name_msg = N_(
+	static const char object_name_msg[] = N_(
 	"Git normally never creates a ref that ends with 40 hex characters\n"
 	"because it will be ignored when you just specify 40-hex. These refs\n"
 	"may be created by mistake. For example,\n"
@@ -951,8 +951,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	"  git switch -c $br $(git rev-parse ...)\n"
 	"\n"
 	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
-	"examine these refs and maybe delete them. Turn this message off by\n"
-	"running \"git config advice.objectNameWarning false\"");
+	"examine these refs and maybe delete them.");
 	struct object_id tmp_oid;
 	char *real_ref = NULL;
 	int refs_found = 0;
@@ -964,8 +963,8 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
-				if (advice_enabled(ADVICE_OBJECT_NAME_WARNING))
-					fprintf(stderr, "%s\n", _(object_name_msg));
+				advise_if_enabled(ADVICE_OBJECT_NAME_WARNING,
+						  object_name_msg);
 			}
 			free(real_ref);
 		}
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 70f1e0a998..18bf4f0046 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -371,13 +371,26 @@ test_expect_success 'rev-parse --disambiguate drops duplicates' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ambiguous 40-hex ref (with advice declined)' '
+	git config set advice.objectNameWarning false &&
+	TREE=$(git mktree </dev/null) &&
+	REF=$(git rev-parse HEAD) &&
+	VAL=$(git commit-tree $TREE </dev/null) &&
+	git update-ref refs/heads/$REF $VAL &&
+	test $(git rev-parse $REF 2>err) = $REF &&
+	grep "refname.*${REF}.*ambiguous" err &&
+	test_grep ! hint: err
+'
+
 test_expect_success 'ambiguous 40-hex ref' '
+	git config unset advice.objectNameWarning &&
 	TREE=$(git mktree </dev/null) &&
 	REF=$(git rev-parse HEAD) &&
 	VAL=$(git commit-tree $TREE </dev/null) &&
 	git update-ref refs/heads/$REF $VAL &&
 	test $(git rev-parse $REF 2>err) = $REF &&
-	grep "refname.*${REF}.*ambiguous" err
+	grep "refname.*${REF}.*ambiguous" err &&
+	test_grep hint: err
 '
 
 test_expect_success 'ambiguous short sha1 ref' '
-- 
2.47.1.407.gf6b6eee3e5
