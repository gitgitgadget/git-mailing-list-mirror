Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BD4399E2
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869686; cv=none; b=RZonRp8dipRe9klS2Qvu/uwwgsnpHrABLUkb7ktouPLeB3m/BWDebqF4Nz2k2BnQlSZOez0HKd7e8vPZcWie6uds5gobkvz1rv903k+o5gYFwEAoRuzg5tDOBMfR7CRPBODRjl59h3A2X0dvXMe+HFXI4ENbcjcH4/l6E9HyU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869686; c=relaxed/simple;
	bh=w/X6qwQJrmI9d5XerGSI9xzHwB1nyxh8wgIsOYPaL1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qp6Kl1EXe//NZWkypLSYw7jP2U2Z3iOQplaoUeWvt8CcpzSLTofTQl1wAQji0RFsOYGTeO/M+CELKAOvuNYtAcpGB7D93uFr0ngckMh7H2XChkI0MbW0IKoD3aR40UXeu1FMb7Uq/nIHoNjBsYVg/sKTBX7ZiS2FPmeAME/C71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ytgMq1np; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hl5WVvzo; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ytgMq1np";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hl5WVvzo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 96A6AEC018E;
	Tue,  4 Aug 2026 14:54:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 04 Aug 2026 14:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785869683; x=1785956083; bh=R81WZTO0DJ
	3r7NGRtxg3pcicCy8NBv/wkHb6sbrDKjM=; b=ytgMq1npnFQZwn+6+YkikCIS86
	ndCr88/oTKJysXNvMRJngzEOKeGBUS7Bm4R63RnXHaD8NYDVODNRefc5XkFHmn3U
	0GDUjjmvQhTK1eUbZx6sGTLCx0Oe2K/CNZUcNNpLKB7LS9z3BML00yyxqV2n5ob5
	3lwy75iaYVbWZxqg2voYuiZlV3ZCXVALAIB+u4Q66sGXvdaMv4dNTg7alFBxMcZZ
	OTLiFMLCsd8hsUaQdeotFqAtYIRyVq+TzztKc65iVya03+Ye+y1rdScWLJv3iJbL
	06Kim87Q3yGNoeqMoUwHJzNUF0mFdvK1CznsIXxC6LwTwMEASPKgIn0h8Ysg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785869683; x=1785956083; bh=R81WZTO0DJ3r7NGRtxg3pcicCy8NBv/wkHb
	6sbrDKjM=; b=Hl5WVvzo1tqEHpRITlTHdMFy7VMvz6fCOZPQbVKKnX6QVYHNAaW
	DFquQJnt8NdA/Ks4+3t/hyp8a9nt91qsl7SC4tQ0CFgEF6o49OOnWtcRsMUiABFQ
	kTIjmGdWKYm8PD3K1xCm4/ngrrYIG+RS6DP4YDuZ7Sk4aAgnyovO0Ywj6jNfsmaq
	WuCU6HrDkKcj54O6yPcJtksPkQzu/+40P5kYMZmrX3YNhwLKye/78qN/NbLpxzsN
	7cVPbtoIj1BGfrosDZ2G1TUR494biRha5nl4vasGDhgBsJSPsq73UOMVnwqg2z60
	yv+h7i8Qw9ieQpCTaAQotgKtuP8PGiirUdA==
X-ME-Sender: <xms:czVyapcR8X7kBbpOIsJ8iCS4z8o9DExV7vY0P0_RLFepQrY-R3bB4w>
    <xme:czVyauoeeH2I9QCLsc7FXj0gDXWGuJ9-LLWTaezx3tI98FpHY26r21EFLonxyVlyI
    TBzzcOuOEsBBBAymIhtDVdfeTVCoX7oq3Ww5A22rp5hdLtADwjhHQ>
X-ME-Received: <xmr:czVyav5tIfi20Jshow-QJK0LYlD0g4-nxJ5SvoZiKV40vjwvangsKjmgPfydStII3rhlQQNr_8aciB8WufZUg_7RiTGg7MUZ3g>
X-ME-Proxy-Cause: dmFkZTFQgNRxmK7lbKGyT6suuyEAieguCTs2W2q5y7S0WVpJJB/WQlR9Z8KlF9rb1FsP5G
    OkE3k78miENqBNw2A7lUyCvx24Jg/FEOFQsImh8T571KIwwohSV9aL4qoj4UEsxWvFOyLy
    ypYK4J6JHfTxK6na/ZWunw7kq6F+sW5z85I4Js0ejsvCanYTIG1h0IJZRjw51uqXQQ1Axr
    M/yEpTdN4oIUkfOn3c9ye7GRcfe5ryaeYFm3XNQmtL0Fw/JOludtx67wcmKRD2rQleQ4Km
    EodExNhM3p1T8qen2n3TCSiKpWf/8qjPzZn+l5e08RGTdhAIi0VkEhygtjaE1gA3IInAE+
    MqiaGvCZz1IilCxp7oRjuuzByfpdDSZv0zCuZMbLgyh7XLbMgZGrlCEvYdkLAp3vh1cHGN
    tHxBUAEAD8VhooYjOoirq/SNCGM0rRros5rsnpHT4yfBBrALjjUgJQkyxhW4N4WEPAX5qK
    vdh5SuOfBESjGIkNNH0IXaETv2vPy4/lMigWJPSLjP3CQocJn3DZG2r7PWi+OhJTuQqqUI
    wmh0fsZ28/NKsJx/BsdF6Xx5xqqvvamLdXtgiMTyUvB/rwcoXNTSJmBgE+jTUQeFwMdQRF
    SfvRQ9H503vZPZaolJEykwvFNlYN/IaXr7w7VnJXKmvY+Oc4N7KCdq7TlI3Q
X-ME-Proxy: <xmx:czVyasqMAEI32IGt6TMBK68X4KS_nfS5_jogX1IjDKDzVwv1rZSJHA>
    <xmx:czVyapjpUvloSUsCycMNMq9W17Rds5WqWYPkItpbcsBLvnHQHjI79A>
    <xmx:czVyauKG3dhsAbchFt-H4EpskUgulV9TM-1R09QoEWT422X65FOKKA>
    <xmx:czVyahCErB-5uSplXGk2zRVEGKJyWWHTOQG-zI-dTOyV0mQN1bVKWA>
    <xmx:czVyauxJz4J-8PYXr0EB8O1SoMvMsjbbyKkVtyLafX5AOXMFdE8b-5DE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 14:54:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] odb/streaming: support streaming arbitrary object
 types
In-Reply-To: <20260804-pks-odb-stream-unification-v1-3-86d70e82345e@pks.im>
	(Patrick Steinhardt's message of "Tue, 04 Aug 2026 09:25:31 +0200")
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
	<20260804-pks-odb-stream-unification-v1-3-86d70e82345e@pks.im>
Date: Tue, 04 Aug 2026 11:54:41 -0700
Message-ID: <xmqqpkzxvhqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The object database supports the ability to write object streams into
> it. This functionality is used when we encounter a blob that is larger
> than "core.bigFileThreshold" so that we don't have to soak large files
> into memory.

I am still not sold the benefit of using a single "stream" type both
for reading and writing yet at this point in my reading (I am not
yet done 50% of the series yet at step 3/7), but I agree that it
would be a good thing to be able to stream objects that are not
blobs.

> diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
> index 01bb81c63c..4f76db5496 100644
> --- a/odb/source-inmemory.c
> +++ b/odb/source-inmemory.c
> @@ -293,7 +293,7 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
>  	hash_object_file(source->odb->repo->hash_algo, data, total_read, OBJ_BLOB, oid);
>  
>  	ret = odb_source_inmemory_write_object(source, data, stream->size,
> -					       OBJ_BLOB, oid, NULL, NULL, 0);
> +					       stream->type, oid, NULL, NULL, 0);

It is a bit annoying that we treat 'inmemory' as if it were a valid
single word both in the filename and in the function name, but more
importantly, hash_object_file() (used to compute the object name of
the object we are writing into the variable 'oid') still hashes
assuming that the object is a blob.  What is the implication of
feeding the data to odb_source_in_memory_write_object() as
stream->type (which is not necessarily OBJ_BLOB) with that 'oid'
whose object name was computed as OBJ_BLOB?
