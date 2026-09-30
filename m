Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9BF51A73A
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793097; cv=none; b=lMwRkIX1DMdN6zJ2f3bxyshy7OIv9Yt++67J/vmih7kOHMl/CVyWHzxmIUWwCMQ59sCyLW4Shooz4QEv/XC+FJiGHxi/86cis+RXba6XbBmq7E2QCkWqt+J9CrvKkZzr3l3vODwUOTFlI5QtInmSa1yVIwKtcLngzu3qfj+A/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793097; c=relaxed/simple;
	bh=2WyDMGV/m7ffvnmjwIhcprThaD/7comGJ0vZOWEfVGk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Khb286J+LvMGyuggmE6UdbGo5Pq6V37Yt5FBfHEV3F5t38BaaGLmHpU/v3JK/PzN55R0f6NHklnZgVttrtR+qreCPuoHWfLX2H6KkO5bx4S0Z8Y46Fv4QGY3rosWxZuaHqjh4Q1LkNUk3olLKlOeZTcIZzt7TAR+sMWg6Qy3Fv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYqjm57D; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYqjm57D"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b05fdb2f9so224752f8f.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793093; x=1791397893; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DbWdXjotQoRQnB79Cpp7A/iI45tDf6Vjxe6wF/fgfiI=;
        b=RYqjm57DQBmW46qKzu30XphsVEOq8CwK0LdLGj/z/JN8Hvj+xEX840N9crRYelq3LP
         QK3qKs2EUrgrgKz1TMvCCIaBLWAykP9VoJMbq8ON6ynNEbBd2gWBUHmTZgNtybO2BrwA
         a4fh9nfdSNU65b6Fax+vK+gVgyNYlgfrugrFvtM1gozJVaXLX5ZPi2snANdCJSrwUA4P
         83uTajsn2NbuOe9B3NvNX8X8ys/aQ+Fs2+y75zrywtmN5CP428kwYQMEiql1FpqUwlF3
         wuZXPMRAGu+Ms7O61L464zgT8kJIY3iV6AfW6Ijzc598ON6AjLmIc0dhELRvcsBpLYKA
         d/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793093; x=1791397893;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DbWdXjotQoRQnB79Cpp7A/iI45tDf6Vjxe6wF/fgfiI=;
        b=cf3Qa9uRlzpnRSPloGwgCtHe6PLyvzvwC+GO1LeV2n69ANv3OuMsDaBpvCrRgYqPPY
         g5jbFXiGceLGXxk1iNnGlimxjy4db5o4XeVFunFtLBCIj5Ipcu7EQHUouEdi9teSJMci
         XqmNKekCDnkxMBSNg0KsbtWb3Rg2wdJIUnIHS6TfcgMS6G1x14LfAOLLPXEGQJ6SCBlb
         HMSyPjI/SX9LQTGUKkA9H3+KnlusZrmx6ZrjfM5KveNqEgX0yEsPdqM1RdytjH6lqdhO
         bh2SYQVciRmPRbVYJwkfWy/QFY7DW6XlM3jIjogiB7yVLoBDLUi82MZe4GcOl3aFNpvZ
         g0Ig==
X-Gm-Message-State: AFuF++mSGua/H6IqYfLyIPrGey6kHCfEFQ1IN9cjEX8n3GpsZ709b8hL
	m6mMbdAHhd5UuDTm/J6mRqoBmGr6xlpE1NMa7ks2vHnAYwBc1Q+/sKG3
X-Gm-Gg: AYBFou0BoF4Gm5qGCPNLSjj4rED3fJ5OKBPS/YXHsXmnsct+uGJ9Wzda3QPwIwimxFA
	CWP3t+LeQBbxnDL+F6wfsFzOHvhk1zeIdTFrqPFkq5ja6C6ZQsk61efDf9hciMCF+8870J87tHO
	5v8dd4V8jnn/ShOdI4iIYWSIVWj3CLxsYT4KNdkkIrxsmXr5UTWcxkvLAsQrsWyTzQnRZ4a2RFh
	oZPYPent2h2zyrt+mwy3zzBKTK5gkNjbaj5LZV1cHTTBmspigqy5bFwaMwyPPJSGHa1mYhulJmG
	fdzp+yGp70KrFZosg1D+rzfTxKaUpf1V1Rz4Lx4hEQg1krjwD9cQ7WnBnyGRyQVVppeCyOogR1I
	HfjXx9MOX6sDRBaN3SHirKitba8CcpK3IHc5AO9/JaEIamIHOYKTG+ETJOOoda3BAdJoBQoMi6e
	nEXIdtkzXYxRJrTxL7L91+TK4IsLliINU6zy/HuBxt5JQI8boIBXHTpqTrmNaZzF6e6B94SAiFf
	8X1h1MdGSxffDmcRyj4RT9rw+HtEToL29Db1D2kI6jK66hbc276x8tBYF4xvTLy6fRU6zZOXdTc
	GzP2QnwjKSMD8qK6SAE9RtfhAvmNRmX9RI8HNjrMj24tdKMdbSz8+UlcEgNPzeaLHpTacIVg+EO
	LzeNlLrXl3GnQFuTstC5XC6trHdoUzTkoBg==
X-Received: by 2002:a05:600c:354e:b0:4a0:b6:460f with SMTP id 5b1f17b1804b1-4a01b132a27mr38725905e9.33.1790793093242;
        Wed, 30 Sep 2026 11:31:33 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:5109:cb7:aac5:8093])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f979c05sm2137765e9.3.2026.09.30.11.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 11:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 19:31:31 +0100
Message-Id: <DLSV653N0668.1OZOWE9P5ZJV6@gmail.com>
Cc: <git@vger.kernel.org>, "Derrick Stolee" <stolee@gmail.com>
Subject: Re: [PATCH RFC 5/5] backfill: report total size of missing blobs in
 --dry-run
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
 <20260930-backfill-dryrun-v1-5-1128f247ee01@gmail.com>
 <xmqqqziabqw8.fsf@gitster.g>
In-Reply-To: <xmqqqziabqw8.fsf@gitster.g>

On Wed Sep 30, 2026 at 6:17 PM WEST, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> +
>> +	if (!ctx->object_info_enabled)
>> +		goto cleanup;
>> +
>> +	if (!ctx->object_info_transport) {
>> +		struct promisor_remote *promise =3D
>> +			repo_promisor_remote_find(ctx->repo, NULL);
>> +		struct remote *remote =3D NULL;
>> +
>> +		if (!promise || !(remote =3D remote_get(promise->name)))
>> +			die(_("--dry-run requires a promisor remote"));
>> +
>> +		ctx->object_info_transport =3D transport_get(remote, NULL);
>> +
>> +		if (!ctx->object_info_transport->smart_options)
>> +			die(_("failed to get object info: smart options required"));
>> +	}
>> +
>> +	results->wants_size =3D 1;
>> +	status =3D transport_fetch_object_info(ctx->object_info_transport,
>> +					     &ctx->current_batch,
>> +					     results);
>> +
>> +	if (status =3D=3D FETCH_OBJECT_INFO_NOT_ENABLED ||
>> +	    !results->sizes) {
>> +		ctx->object_info_enabled =3D 0;
>
> Yuck.
>
> Because we cannot tell if they allow you to look at the information,
> this cannot be helped, but it means anybody that looks at this
> ctx->object_info_enabled member to decide what to do must be careful.
>
> Is it guaranteed that results.sizes[] have been populated as long as
> status is not FETCH_OBJECT_INFO_NOT_ENABLED?  Can there be other
> errors that makes result.sizes[] unusable?  If that is the case,
> then it would be cleaner to have a dedicated ctx->sizes_valid member
> rather than relying on ctx->object_info_enabled member to carry this
> information ...

Not quite, transport_fetch_object_info() can also return
FETCH_OBJECT_INFO_ERR when finish_connect() fails in
fetch_object_info_via_pack(). I'll change the condition to:

	if (status !=3D FETCH_OBJECT_INFO_OK || !results->sizes) {

With FETCH_OBJECT_INFO_OK, fetch_object_info() only allocates
results->sizes when the server answers with the "size" attribute,
and it die()s on any incomplete or malformed response, so a
non-NULL sizes[] is always fully populated. A NULL sizes[] with
FETCH_OBJECT_INFO_OK means object-info is available but the server
does not support "size".

Agreed, the member is also cleared in that last case, where
object-info does work but "size" is not advertised, so I get that it can
be misleading. Since its only use is deciding whether to report the=20
total size, I'll rename it to ctx->sizes_valid instead of adding a=20
separate member.

>
>> +		goto cleanup;
>> +	}
>> +
>> +	for (size_t i =3D 0; i < results->nr; i++)
>> +		ctx->total_batch_size +=3D results->sizes[i];
>> +
>> +cleanup:
>> +	free_fetch_object_info_results(&ctx->object_info_results);
>>  	oid_array_clear(&ctx->current_batch);
>>  }
>> =20
>> @@ -157,12 +201,25 @@ static int do_backfill(struct backfill_context *ct=
x)
>> =20
>>  	dry_run_batch(ctx);
>> =20
>> -	printf(Q_("After backfill, %" PRIuMAX " blob would be fetched.\n",
>> -		  "After backfill, %" PRIuMAX " blobs would be fetched.\n",
>> -		  (unsigned long)ctx->total_batch_nr),
>> -	       (uintmax_t)ctx->total_batch_nr);
>> +	if (ctx->object_info_enabled && ctx->total_batch_nr) {
>
> ... and use it here.  Within the design presented in this series, we
> know we have asked the other end at this point, and the above
> function may have turned ctx->object_info member off if the
> information is not there, so this may be safe.  But as I said, I am
> not sure what happens when fetch-object-info returned other kind of
> errors.

The condition above is checked on every batch, and any status other
than FETCH_OBJECT_INFO_OK or a NULL sizes[] clears ctx->sizes_valid
(currently ctx->object_info_enabled), so by the time we get here it
is only set when all the batches returned valid sizes.

