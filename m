Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAF149C40
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408490; cv=none; b=QwYG2Qc9V/nFVb5xqNFn+wYcB/7JXQyNbJYusmVQCZynmqp7rqGZoDRbwSfuXwkQwoeIucagwL+KhibJzP4QEJEJozIHxnIHqMV//h0mZHjFyAwwdbKssZaPd6vjOMF0cO4S8aB4jCDQKemwsME6Oa/ITId3FZye9i8sxIgl8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408490; c=relaxed/simple;
	bh=DVcRpH39JbZ2NlinO28OwFRUnKhsscnZY/cIDx68tRA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ut5y1vsnQZJseHxOdQnF6ZwgiU3Mukrm/B6HDcp01jOQ5vWYoR4yBoS5v2nhGHRnE9dwzSWL57CYFL30/8IT51+n/bCctuOElOO32BU8mC3+p87XSnqx1fOQWsbVVietO8kjMN+rJPt/vNYWWr19kiO3kuHG5vWFKXD9EhsDQig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePyOFlr0; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePyOFlr0"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70c9cda7f1cso1001598a34.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724408488; x=1725013288; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wh8Bjn4Vv+MFxxk4s1591aflDDmrballXRtAgXXf7KI=;
        b=ePyOFlr02pm4tieAYdunYATDfs7ZD24O/KDeKz9Mkkop06cyLWR6utnorTtXmgsman
         WG9ngsF06GTlKQkrK7cCU4duzZ46k482C4fcim9xSzUaN1IWftrlXcZB5B40fulh+Ybs
         O/YT1YtXaFU+BFClRRTEu7pIf0bsCKxLQ4NuSLwrE2Rf+nasG5raqRN5Be1O+67hHzZJ
         1duKoe49BlEOyknkkNT6ZLraoAYAhk1vFj6Ep+gMP3NdjAfdp7zdr8JbwI6sg/UhHopy
         6PgtSKBilqgUasZco7LO6yfOCKbg1FRBKyZbiFt7lGtksdtWQnZknPI3j33NUL5MSONV
         y/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724408488; x=1725013288;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh8Bjn4Vv+MFxxk4s1591aflDDmrballXRtAgXXf7KI=;
        b=tFr5zQ8svb2loguvIGbkfrNRWXIjKRrgIqhdUR66Z4G2LUTLHs9pPMEMEC60opgGJG
         H7v7UcJwiBnhwi63pxhVg3yW7l6KOU2K/UBi1QpZK6PMr4aYCH/C9QKWHW/9tFMdyIl+
         RokxaDHmFBhWM85vxlfPSSHOfDWejgq8b24g88G92JE0cx8HCQhdH2Oo7KIGnEeHBRIP
         XV1FGAs8143rkmMhBlJyEAFaeIpVItVdYsKVF3tqQ7ctQob8VSJP70ScT7tlgM8jmv+n
         BFuJSHFN2w9CaW7PZSsQohPQ4GfFF1BhxJnzfEV9REfwhjmO2U7a7eSkp8IuUKu8eWWS
         Yo3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4LLi21IqukKMOg8BMYaQBK4AMcfTaYXAOLEpLyLdX+9Fn0h2Z4PYmpfeqtQrUcAj6WfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhORF+1R6Bh3vlDxRMSSXpcl3GUb8GLnyqDa1S696b0KA9ZR4E
	kJKN47+ztT+QktPPbi+slI4m9DHjd9BB9TzuEeP8MO6zPflrAPue+BIeOEaS4p+ePEryvEF1uLr
	Qa59XywMStEHD6586bZnEvE5tBdo=
X-Google-Smtp-Source: AGHT+IHy+dAEcydcZ0uOLUBWpAFfpT0UOppNRzhKxw1nbaVr0iCfR1ECeYxpQaLK0H2+3mxdVXomKZFBSPzVpnCNYvA=
X-Received: by 2002:a05:6808:1396:b0:3d9:3ded:1fc3 with SMTP id
 5614622812f47-3de2a8503acmr1669762b6e.17.1724408488309; Fri, 23 Aug 2024
 03:21:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Aug 2024 03:21:27 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <026820562882afb31d7224c90722e09bef835340.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im> <026820562882afb31d7224c90722e09bef835340.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Aug 2024 03:21:27 -0700
Message-ID: <CAOLa=ZQarx37De=xmD73D3dPzxp0j8pfb-TBc4u6nKkJn_TT1g@mail.gmail.com>
Subject: Re: [PATCH 08/10] reftable/reader: keep readers alive during iteration
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="00000000000064d74b0620572383"

--00000000000064d74b0620572383
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The lifetime of a table iterator may surive the lifetime of a reader

s/surive/survive

> when the stack gets reloaded. Keep the reader from being released by
> increasing its refcount while the iterator is still being used.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reader.c     |  2 ++
>  reftable/stack_test.c | 49 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 64a0953e68..f877099087 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -175,6 +175,7 @@ static int table_iter_init(struct table_iter *ti, struct reftable_reader *r)
>  {
>  	struct block_iter bi = BLOCK_ITER_INIT;
>  	memset(ti, 0, sizeof(*ti));
> +	reftable_reader_incref(r);
>  	ti->r = r;
>  	ti->bi = bi;
>  	return 0;
> @@ -262,6 +263,7 @@ static void table_iter_close(struct table_iter *ti)
>  {
>  	table_iter_block_done(ti);
>  	block_iter_close(&ti->bi);
> +	reftable_reader_decref(ti->r);
>  }
>
>  static int table_iter_next_block(struct table_iter *ti)
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index bc3bf77274..91e716dc0a 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -1076,6 +1076,54 @@ static void test_reftable_stack_compaction_concurrent_clean(void)
>  	clear_dir(dir);
>  }
>
> +static void test_reftable_stack_read_across_reload(void)
> +{
> +	struct reftable_write_options opts = { 0 };
> +	struct reftable_stack *st1 = NULL, *st2 = NULL;
> +	struct reftable_ref_record rec = { 0 };
> +	struct reftable_iterator it = { 0 };
> +	char *dir = get_tmp_dir(__LINE__);
> +	int err;
> +
> +	/* Create a first stack and set up an iterator for it. */
> +	err = reftable_new_stack(&st1, dir, &opts);
> +	EXPECT_ERR(err);
> +	write_n_ref_tables(st1, 2);
> +	EXPECT(st1->merged->readers_len == 2);
> +	reftable_stack_init_ref_iterator(st1, &it);
> +	err = reftable_iterator_seek_ref(&it, "");
> +	EXPECT_ERR(err);
> +
> +	/* Set up a second stack for the same directory and compact it. */
> +	err = reftable_new_stack(&st2, dir, &opts);
> +	EXPECT_ERR(err);
> +	EXPECT(st2->merged->readers_len == 2);
> +	err = reftable_stack_compact_all(st2, NULL);

Shouldn't we verify that `EXPECT(st2->merged->readers_len == 1);` here?

> +	EXPECT_ERR(err);
> +
> +	/*
> +	 * Verify that we can continue to use the old iterator even after we
> +	 * have reloaded its stack.
> +	 */
> +	err = reftable_stack_reload(st1);
> +	EXPECT_ERR(err);
> +	EXPECT(st2->merged->readers_len == 1);

Oh we do it here, I would've expected it above the `st1` reload. And
probably expected `EXPECT(st1->merged->readers_len == 2);` here to
confirm that we still have the readers.

> +	err = reftable_iterator_next_ref(&it, &rec);
> +	EXPECT_ERR(err);
> +	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0000"));
> +	err = reftable_iterator_next_ref(&it, &rec);
> +	EXPECT_ERR(err);
> +	EXPECT(!strcmp(rec.refname, "refs/heads/branch-0001"));
> +	err = reftable_iterator_next_ref(&it, &rec);
> +	EXPECT(err > 0);
> +
> +	reftable_ref_record_release(&rec);
> +	reftable_iterator_destroy(&it);
> +	reftable_stack_destroy(st1);
> +	reftable_stack_destroy(st2);
> +	clear_dir(dir);
> +}
> +
>  int stack_test_main(int argc, const char *argv[])
>  {
>  	RUN_TEST(test_empty_add);
> @@ -1098,6 +1146,7 @@ int stack_test_main(int argc, const char *argv[])
>  	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
>  	RUN_TEST(test_reftable_stack_update_index_check);
>  	RUN_TEST(test_reftable_stack_uptodate);
> +	RUN_TEST(test_reftable_stack_read_across_reload);
>  	RUN_TEST(test_suggest_compaction_segment);
>  	RUN_TEST(test_suggest_compaction_segment_nothing);
>  	return 0;
> --
> 2.46.0.164.g477ce5ccd6.dirty

--00000000000064d74b0620572383
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 45f9c59730b4fef7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iSVlxWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTZDQy8wUXVjRXhsdWZ2YVZTL3NEcHJTczJ1WVBwUQoxdDN1dlF4Vlhj
cUhKcm9yYXhNcWJBL2M5YkxHblpHY2tvc0tXVVhMRlJXOTAybElMOENIdFJLUWd3ODhFWSt3Cmh5
djRITEVyTUhZQ2h0SGVzK1orbDdUY1lMTVQxM29LeFJkaDVYWDNBQUJ4ODNEak9mdjJ5L0l2SG5K
cUtKNWwKdXVveGZHSzNvMVRmcU9FK0laejN0RnhIRHZUWTJRRzJqNDQvQjBOMmZKTHFPdUNBK2Nn
U1FhUzR0Qkd2RjhURgpGQmRBRXFjbHVFNzRRK3U1Rm5XWHhIVVVsdWJEQVZLWGJhYkJma1lxMS81
UXhnTlpHYXQvRU1SdXdaOHlhazR4CmwrS2F4V01wTW5GeWZxK0RGZFpQdWMyVi9HbzhLOUZXUE1U
S0FsZkJ3Sk9BMnV0a1kyaTBsd3BqTzgzQUIvSVgKdzViK0g3NHcyb3RKUlFjM09VakRLOXpPdnQr
N1BRd21LUUVVeEZQbG52TWRZOUlOMkxSMkNoRS9PMkR5SWQxUwpNWlpmUVRPczFDVGVhdEpvamtk
ODNCQjRTaGJvdXR0ZysyVWl0UDNydXR4U3ZFUVUvN2VhK1dHbE0vNlBreFhTCjRhUWRtMktPSGs5
NFVhRVNUZ0kwS2RsdzBIZ2RLK3dTcWQ5WUx3OD0KPXJQb3MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000064d74b0620572383--
