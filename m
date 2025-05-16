Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09D23182F
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389152; cv=none; b=XY6dS3cRz3K6Ui4LWxWCxwmdWQu921+41F0rmrwPSUCDr/X4cp0kt3oNnbRea3jUonABgRUU2G32XxRFs7usiPUILwb4194bUsNLj92qjIFlvsnTzWS33RPyH8P8kqkfXSHCBhOOq0sBIy1hrDc37EdZac6MwmE1sH8MFlQCVcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389152; c=relaxed/simple;
	bh=EeTRCh6/EvUKCUF22D5almd2w7cPuINd5AN9FB3XdCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EakAeel9Q+g9PBtxdktM7cm6PWe5KiTKEBJfMQAZSY8w4df+04SaVW65FAN275aIDbgOjxhNHxV10dMUxAohaDd7Noa233qn8i2GoW/wHRNAQKcHEp81pJUp8dqjhCEd+KXA+ZKbdhTQUIj8GJ/SpV9keb7Y8b1uvOOOGW+IDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tj68p4V4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kxnBQQGe; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tj68p4V4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kxnBQQGe"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 40166138020F;
	Fri, 16 May 2025 05:52:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 16 May 2025 05:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747389149; x=1747475549; bh=3iFCpRYd0z
	vp7ePYzTmIsJDaPpA19tNFTH7uBazTP5g=; b=Tj68p4V44bJp+2XyzlVuz+x8/5
	MkBVyhEKbW2gzN5zNcu40/km1O7WwWQL8UD64YzMApL+8CJ9B0xJtnkmgXeQ9TiN
	+QEWBUFCGjHvU7lJaUYmYq/l/2lsQ1vfyQZIKY0QLOHfwYrD/qG6LqFJ6VODT4uR
	zlThGxDaPthO50GbsawTJQ9c9k8eCKZH/ztf69BXuhX8IsO2RO+6tdEDUGagdCnA
	NCCtSxpc3S/M1Spv3b6tLyTGOwPVu22LF64zhszUeHIYLfGdVyTBFUahtX2L7osD
	I35FJmpjEB1s2JysDGDJ65WVODZ9z1tqUaqIgG89HzcoRZCFFWRaNkO0ggoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747389149; x=1747475549; bh=3iFCpRYd0zvp7ePYzTmIsJDaPpA19tNFTH7
	uBazTP5g=; b=kxnBQQGegrWXEzCSYWHxZGLbZvCV1qlMOuReVep/FwOf8uY3F/N
	Cq7gE0v7Rbkk1WIuMYd/dRFNCWSZwExBYsJNubcVjUzNfgJPeHAt9amTYoZXiTp3
	g7YJhGNGB2DmDzntxE/piZjdJJS36mBS4Q1n3/wecumqOmjgILLP+C5UEsm9pg7s
	+6gyDIatoxuG15SiF9k5LSL4Da3EiEbfiWFHvUigdgZtaot4TOdFzTwFn4/PeO50
	1aA4PvzSJxTJfudh+7iLWOMhv4oAfwTuF/HZxdTS1WKAwmaYTPs87CjXujx0QORo
	+gHRveMK4RiMKFr15tYCAFgFvylrQxRWUdw==
X-ME-Sender: <xms:3QonaFoBWQvzUXJ03Zd_LUwCy2cDHQmjITbmm6RDyBdWuKHSlFrDZg>
    <xme:3QonaHqLCl968Y3QArbQdj5B6VEcT4pBFQbcDNV0cnHQ1deZWoJcH6ttkVEHhiQ94
    0HRQL5yAL9zdKmifQ>
X-ME-Received: <xmr:3QonaCNXpUg-W2vniK3PIJpACy7KeRhUmAwJCMA8Z1-Ovt1RA9_9PqSrM_JU6kzpCKvKqB21k4Sk25m_YRc7kqhpnJAMreNgRyCBM-Ju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddvgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:3QonaA741m0hE6jUa6HEQDiXWZn_hfgazC76ATyQLogEa53vhUwWmQ>
    <xmx:3QonaE72j_RJKSCJ6H9TTHUiq84ZAMSUU7i-h_qdhfP5tAGobEVYQg>
    <xmx:3QonaIiPZK2BOy8HqmstfpTdO62EqSzMY--gUmS5zmvhvJxxa1vbcA>
    <xmx:3QonaG7ewuDcorNLN9BW3LqLHA2tBA_XYMZ4sk2gQcUJzdo65z7p5w>
    <xmx:3QonaBwResY--MMbnDq037-CwHnfP2JEuaOI1Ju3WZWwLUr3R1CGNTJp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 05:52:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1382941d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 16 May 2025 09:52:27 +0000 (UTC)
Date: Fri, 16 May 2025 11:52:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/13] fsck: stop using object_info->type_name strbuf
Message-ID: <aCcK2lfr8048Kh7E@pks.im>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516044953.GF22242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516044953.GF22242@coredump.intra.peff.net>

On Fri, May 16, 2025 at 12:49:53AM -0400, Jeff King wrote:
> When fsck-ing a loose object, we use object_info's type_name strbuf to
> record the parsed object type as a string. For most objects this is
> redundant with the object_type enum, but it does let us report the
> string when we encounter an object with an unknown type (for which there
> is no matching enum value).
> 
> There are a few downsides, though:
> 
>   1. The code to report these cases is not actually robust. Since we did
>      not pass a strbuf to unpack_loose_header(), we only retrieved types
>      from headers up to 32 bytes. In longer cases, we'd simply say
>      "object corrupt or missing".
> 
>   2. This is the last caller that uses object_info's type_name strbuf
>      support. It would be nice to refactor it so that we can simplify
>      that code.
> 
>   3. Likewise, we'll check the hash of the object using its unknown type
>      (again, as long as that type is short enough). That depends on the
>      hash_object_file_literally() code, which we'd eventually like to
>      get rid of.

Oh, I'd very much welcome if this code path went away completely.

> So we can simplify things by bailing immediately in read_loose_object()
> when we encounter an unknown type. This has a few user-visible effects:
> 
>   a. Instead of producing a single line of error output like this:
> 
>        error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object is of unknown type 'bogus': .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
> 
>      we'll now issue two lines (the first from read_loose_object() when
>      we see the unparsable header, and the second from the fsck code,
>      since we couldn't read the object):
> 
>        error: unable to parse type from header 'bogus 4' of .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
>        error: 26ed13ce3564fbbb44e35bde42c7da717ea004a6: object corrupt or missing: .git/objects/26/ed13ce3564fbbb44e35bde42c7da717ea004a6
> 
>      This is a little more verbose, but this sort of error should be
>      rare (such objects are almost impossible to work with, and cannot
>      be transferred between repositories as they are not representable
>      in packfiles). And as a bonus, reporting the broken header in full
>      could help with debugging other cases (e.g., a header like "blob
>      xyzzy\0" would fail in parsing the size, but previously we'd not
>      have showed the offending bytes).

Yup, I would claim this is an improvement, as well.

>   b. An object with an unknown type will be reported as corrupt, without
>      actually doing a hash check. Again, I think this is unlikely to
>      matter in practice since such objects are totally unusable.

Agreed.

> We'll update one fsck test to match the new error strings. And we can
> remove another test that covered the case of an object with an unknown
> type _and_ a hash corruption. Since we'll skip the hash check now in
> this case, the test is no longer interesting.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fsck.c  | 13 ++-----------
>  object-file.c   | 12 +++++++++---
>  t/t1450-fsck.sh | 29 +++--------------------------
>  3 files changed, 14 insertions(+), 40 deletions(-)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 6cac28356c..e7d96a9c8e 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -614,12 +614,11 @@ static void get_default_heads(void)
>  struct for_each_loose_cb
>  {
>  	struct progress *progress;
> -	struct strbuf obj_type;
>  };
>  
> -static int fsck_loose(const struct object_id *oid, const char *path, void *data)
> +static int fsck_loose(const struct object_id *oid, const char *path,
> +		      void *data UNUSED)
>  {
> -	struct for_each_loose_cb *cb_data = data;
>  	struct object *obj;
>  	enum object_type type = OBJ_NONE;
>  	unsigned long size;
> @@ -629,8 +628,6 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
>  	struct object_id real_oid = *null_oid(the_hash_algo);
>  	int err = 0;
>  
> -	strbuf_reset(&cb_data->obj_type);
> -	oi.type_name = &cb_data->obj_type;
>  	oi.sizep = &size;
>  	oi.typep = &type;
>  
> @@ -642,10 +639,6 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
>  			err = error(_("%s: object corrupt or missing: %s"),
>  				    oid_to_hex(oid), path);
>  	}
> -	if (type != OBJ_NONE && type < 0)
> -		err = error(_("%s: object is of unknown type '%s': %s"),
> -			    oid_to_hex(&real_oid), cb_data->obj_type.buf,
> -			    path);

This one is a bit curious. But because we know that we have reported
this error in `read_loose_object()` already we don't need to print the
error over here anymore.

> diff --git a/object-file.c b/object-file.c
> index 1127e154f6..7a35bde96e 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1662,6 +1662,12 @@ int read_loose_object(const char *path,
>  		goto out_inflate;
>  	}
>  
> +	if (*oi->typep < 0) {
> +		error(_("unable to parse type from header '%s' of %s"),
> +		      hdr, path);
> +		goto out_inflate;
> +	}
> +
>  	if (*oi->typep == OBJ_BLOB &&
>  	    *size > repo_settings_get_big_file_threshold(the_repository)) {
>  		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)

So this is where we report the new error now. Makes sense.

Patrick
