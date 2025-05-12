Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184D25A2CB
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041051; cv=none; b=ls5qav2g18+PvFZ/EOIViLkM/4lvxGtDxWk/gOFm2se/8/OjZSJn2rqS+OTDZiRylLPqH1zUrvi7C2TPzgh3dtu9N6sgxM6Segp9cmvSNj7KkvdPGRGPtdE6XyFF2nUJ0h3eKLwHNq4Fn6u7SDxrAK/GEKECUfUgSdrjFhlebNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041051; c=relaxed/simple;
	bh=tAxMer+qhvA3jbyTX+ab8FbIXjSCaX5EH+oHaM89ARs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz8gKcy6qDSXwrSyQ6xGgZOFMpUnq90tOFkwTMMiz4d/A14ziKf+xBKFGPq5NxFwG7i2g76vdyw3E1fPpRP3zaWFD9NoD9Aln5f/2gKSFzW+nb1sOiCHRcNunMIgDvt6u7rRnRj/PeQjdoLFL3o200528FDPzdurU5Dnb1iSoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqnPUTXp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqnPUTXp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso25182295e9.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747041048; x=1747645848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx2+3SvKXpjNRu2Cy2rXksb6oYZr7DxXEOYtFurIl0g=;
        b=dqnPUTXpjGug+nGq5nEDuxhzXzKXhnlpBeNVgbChX7ZW6z7Khb7D6eoOth9h65P19S
         IMNqsT4Is3FpWJxJ7iMn70uyYQaL5s5Stl6xGd9RaEf8LLfE3JNMGCSgO+6gW/1pd+AY
         LGB81jrtI82ez5JOHqLP2uHViLLlC9kWeetXofs+MPSxyWGGa4IjEdCb3Gdsl28BdQqS
         1K4HWnou2u0gdPgJiEaBfXzRQ9MQxRRxm80C2jUwEZnmlL8ntyLOU9I4bJ+eQaNeHyHx
         mVblRPsnzA4LLKvaSvWO9V9JNNSVhGgsAKp3UQYqEtF9bHe9nBuktUH/hL3nmNUflUoe
         caJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747041048; x=1747645848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rx2+3SvKXpjNRu2Cy2rXksb6oYZr7DxXEOYtFurIl0g=;
        b=Jaj/dyA4yslhrEMVT2qxDsjQfuuz4dEtDMQtk6vJnowa7FNV61vraW0fP/meBlPLza
         +8X26SIUQnjVJLf7Vk3O69CIpwl+lql3S+dPtKd68g7nCfJQJIRsUHjqx3SGQrfyknA0
         ni+SMLT2jSoVTbSh9x06/+JYEUxFm+JQLGILVfRJji1Ywv1duUiEYGsqgeKjJ/xMGN2P
         SFcn3YjnwZFbIox2b9w9EPi/QMijx2Rr1YMVahrT2lA1kobsLGsSlr54CoVO0yn6FDC7
         lqbG4sZ2hTPsaakDtZIoF97WqRpNadYwram/UY8lwDy35JCQ257QY9x8swanyRy82hge
         O3xg==
X-Forwarded-Encrypted: i=1; AJvYcCVNg4XVX6EJ7vExYAcMegXjFNhiDlXn34taNPlk+WVAHlp9juz8rD1kNwTg8YNnR7QO9rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhI5QOV1v9EQp6RaExONalOCOtnmJXQaeb9R9LjnLx8hLHkEk
	fn08+ktg1HMXDoEYGDHYUtsdwEVERf+Pvi3BWqeWjTktcGJ4r2xJ
X-Gm-Gg: ASbGnctLpkIZ5K/IveuOiKUi1TDnO+0DyE7nUfZeWPCrR6mhdUnh/zFTEux6yVjDnHx
	3FRR61o1+YaqcLuadhIxcYtQlCH/DPT6zjOsxzxzI1r4GHeRinyRwqyIdvX5QMBaVsgRvqOicZn
	X9vTRC/E+pph5m68TYwocZ4Lk8pyJHsH5/kvO84DV7dEfJwIeckbsFkjeT4gq7XJ94jQNcjqHSg
	o3d0FLkWs5lbBS9OYtD3CvXgw84XeklICmYHHl/gXhX5zfcWvvO+IxPUNNbR+lEp8TQxvn1iDS7
	9TmE3PkwmqiR7VoR5xD3y/bIB3LQgzhq30HfKjLrZ1UOk+be7NF3e1tf4YUliv30AZrJxoDGPcS
	7rg3lUY/TraYuV0VF6ehGfwrk1so=
X-Google-Smtp-Source: AGHT+IGxmGJuES4zXJ6mls3Y05n92Uzy48CeqPYdDlriK9N2EsuM1goRn0wHbsxVPUaYDghvU3xBmw==
X-Received: by 2002:a05:600c:548d:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-442d6d44918mr98684735e9.14.1747041048101;
        Mon, 12 May 2025 02:10:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3aecb0sm163555975e9.28.2025.05.12.02.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 02:10:47 -0700 (PDT)
Message-ID: <94b26c62-c8da-49ba-a4f1-66da20956c0b@gmail.com>
Date: Mon, 12 May 2025 10:10:46 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-5-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250508234458.3665894-5-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 09/05/2025 00:44, brian m. carlson wrote:
> 
> @@ -1962,6 +1971,99 @@ static int write_commit_with_parents(struct repository *r,
>   	return ret;
>   }
>   
> +static int do_import_stash(struct repository *r, const char *rev)
> +{
> +	struct object_id chain;
> +	struct oid_array items = OID_ARRAY_INIT;
> +	int res = 0;
> +	int i;
> +	const char *buffer = NULL;
> +	struct commit *this = NULL;
> +	char *msg = NULL;
> +
> +	if (repo_get_oid(r, rev, &chain))
> +		return error(_("not a valid revision: %s"), rev);
> +
> +	/*
> +	 * Walk the commit history, finding each stash entry, and load data into
> +	 * the array.
> +	 */
> +	for (i = 0;; i++) {
> +		struct object_id tree, oid;
> +		char revision[GIT_MAX_HEXSZ + 1];
> +
> +		oid_to_hex_r(revision, &chain);
> +
> +		if (get_oidf(&tree, "%s:", revision) ||
> +		    !oideq(&tree, r->hash_algo->empty_tree)) {
> +			res = error(_("%s is not a valid exported stash commit"), revision);
> +			goto out;
> +		}
> +		if (get_oidf(&chain, "%s^1", revision) ||
> +		    get_oidf(&oid, "%s^2", revision))
> +			break;
> +		oid_array_append(&items, &oid);
> +	}

This loop could use some improvement - it does not use the loop
variable, it accepts any commit with an empty tree as a valid exported
stash, it is pretty lax about checking that the commits in the chain
have either zero or two parents, it does not check if the second parent
looks like a stash and it is forever converting between strings and
object_ids. I think it would be better to loop over commits rather than
object ids then you can walk the history using the pointers to the
parent commits. Something like

	if (repo_get_oid(r, rev, &chain))
		return error(_("not a valid revision: %s"), rev);

	this = lookup_commit_reference(r, &chain);
	if (!this)
		return error(_("not a commit: %s"), rev);
	/*
	 * Walk the commit history, finding each stash entry, and load data into
	 * the array.
	 */
	for (;;) {
		struct commit *stash;
		struct tree *tree = repo_get_commit_tree(r, this);

		if (!tree ||
		    !oideq(&tree->object.oid, r->hash_algo->empty_tree) ||
		    (this->parents &&
		     (!this->parents->next || this->parents->next->next))) {
			res = error(_("%s is not a valid exported stash commit"),
				    oid_to_hex(&this->object.oid));
			goto out;
		}
		if (!this->parents)
			break;
		stash = this->parents->next->item;
		if (repo_parse_commit(r, this->parents->item) ||
		    repo_parse_commit(r, stash)) {
			res = error(_("cannot parse parents of commit: %s"),
				     oid_to_hex(&this->object.oid));
			goto out;
		}
		if (check_stash_topology(r, stash)) {
			res = error(_("%s does not look like a stash commit"),
				    oid_to_hex(&stash->object.oid));
			goto out;
		}
		/* TODO:
		 *  - store commits, not objects
		 */
		oid_array_append(&items, &this->parents->next->item->object.oid);
		this = this->parents->item;
	}

I've appended a fixup commit below that applies on top of your
patch. The fixups for this patch and the previous one can be fetched
with

   git fetch https://github.com/phillipwood/git.git bc/stash-import-export-fixups

if you want to use them.

Best Wishes

Phillip

---- >8 ----
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] fixup! builtin/stash: provide a way to import stashes from a
  ref

Strengthen the checks on imported commits to ensure that the chain of
imported stashes consists of commits with exactly two parents where the
first parent is either the root commit or another imported stash commit
and the second parent looks like a stash commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
  builtin/stash.c | 43 +++++++++++++++++++++++++++++++------------
  1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 02cf344ed9..7d3a8c03a0 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -2011,25 +2011,44 @@ static int do_import_stash(struct repository *r, const char *rev)
  	if (repo_get_oid(r, rev, &chain))
  		return error(_("not a valid revision: %s"), rev);
  
+	this = lookup_commit_reference(r, &chain);
+	if (!this)
+		return error(_("not a commit: %s"), rev);
  	/*
  	 * Walk the commit history, finding each stash entry, and load data into
  	 * the array.
  	 */
-	for (i = 0;; i++) {
-		struct object_id tree, oid;
-		char revision[GIT_MAX_HEXSZ + 1];
-
-		oid_to_hex_r(revision, &chain);
-
-		if (get_oidf(&tree, "%s:", revision) ||
-		    !oideq(&tree, r->hash_algo->empty_tree)) {
-			res = error(_("%s is not a valid exported stash commit"), revision);
+	for (;;) {
+		struct commit *stash;
+		struct tree *tree = repo_get_commit_tree(r, this);
+
+		if (!tree ||
+		    !oideq(&tree->object.oid, r->hash_algo->empty_tree) ||
+		    (this->parents &&
+		     (!this->parents->next || this->parents->next->next))) {
+			res = error(_("%s is not a valid exported stash commit"),
+				    oid_to_hex(&this->object.oid));
  			goto out;
  		}
-		if (get_oidf(&chain, "%s^1", revision) ||
-		    get_oidf(&oid, "%s^2", revision))
+		if (!this->parents)
  			break;
-		oid_array_append(&items, &oid);
+		stash = this->parents->next->item;
+		if (repo_parse_commit(r, this->parents->item) ||
+		    repo_parse_commit(r, stash)) {
+			res = error(_("cannot parse parents of commit: %s"),
+				     oid_to_hex(&this->object.oid));
+			goto out;
+		}
+		if (check_stash_topology(r, stash)) {
+			res = error(_("%s does not look like a stash commit"),
+				    oid_to_hex(&stash->object.oid));
+			goto out;
+		}
+		/* TODO:
+		 *  - store commits, not objects
+		 */
+		oid_array_append(&items, &this->parents->next->item->object.oid);
+		this = this->parents->item;
  	}
  
  	/*
-- 
2.49.0.300.g813f75aecee

