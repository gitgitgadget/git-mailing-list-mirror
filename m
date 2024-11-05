Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1F1B5336
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790716; cv=none; b=ik6VLjmC9I3QyoEa61bc2eevitCnHbD5p5hksdyHYffFogjsLLFOIziQy/MIQuH17q7a41Wjr0lW4smxF2p2IU3r/XW34AGSweXN5KIXkRu5cqh4BRM/4UcJmZW7cKklQeSzfOs6hX9U/qyQoZLZGdbPYKyBKOI1FGWeWEULt1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790716; c=relaxed/simple;
	bh=7+ANiNJXx88ngNs69iLiNAYWnRlrniEB+AgxvIBp6M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM9QJRcwROkUyzLIzPyJbT2/3ChIIeAEN9xHdOUPHZoVIYZN4Hz5XlmeLIt9fW8RyTGQeC9MIB8XxvYYE0KxCNFn6SE6IEVR6lMgk9MRfjxP7LUobx8ec3aczV4M0fyJ9ctERiPtSfl6wO8xfIXx1cDi6wxO4UzsTdyDFVX4wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=5YF65H26; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBzXkdWP; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="5YF65H26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBzXkdWP"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 155C31140176;
	Tue,  5 Nov 2024 02:11:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 05 Nov 2024 02:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730790713; x=1730877113; bh=VmPlpTzPKh
	sNMcSqyRJJtpDnElYG5/riqN6sJdoAAjw=; b=5YF65H26wos3HrsBjrvfdDRmLn
	+AkB5SDxHBsuaQ6dgEB/HYb0lz59QcNZdmnUm5Br2KEUOmmOXk5VFscoOJVTr+iw
	SfHb/Dils9PAA9qhJWHJsaHT/indx4mi+LrIEEUZJr9Swx6U+kKeHc06OE3SLfwA
	v81567L58eD7QSapv/LAfZ3J8db28mbTIYb6O5KeUgAecmL16TAONhbkE86bqbEs
	GPcYQgxOB5IAMKynMSHeHhXMh7wxQeYGEkXS9LRgXYsBDHZvw6zTinZOqzoae7zf
	sKq3YKpkqtz63kDFGUSGPzqkcdHQupSfyg4FJ5J3ODUMLqEdgPiQ5F9LVJzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730790713; x=1730877113; bh=VmPlpTzPKhsNMcSqyRJJtpDnElYG5/riqN6
	sJdoAAjw=; b=PBzXkdWPCSbhXstbGZdiwEarYgoGY2wyEjJPkLEj5jeBF/DTINB
	XaqeJmK73CHlXrRBJ/JkCOCDLrp4LXEW+INOL26RoMwuxfODmeHfVL6IKzciXBsI
	TDPSua/sAM1oAXaBKL6Phh9X+YIjRciePN1UU5WObWZJC/WWRr/zKz7+t5cspl6B
	rhI6TxWf+gx8s6TNOXJ3W4HwjvAEN88pDjcB8UQNxbbYiwWmRzPHOJg59r7jcJAB
	FKHh+gq1E4w2qQbJdH568ss99tY3j5WMfQaxg7CX4Ad7hqDKZ5qKfDtbYIWFiSgF
	GGOC7mtlD9tQ5I0dnEVFJ6C/U0GeWTApIIg==
X-ME-Sender: <xms:OcUpZ0qkjTqaZEd51WpawBGPNrJc-ovMO9o-FkzmqrARtjHKdt0z7w>
    <xme:OcUpZ6qLFxhn13GEAZEgT4ZUiA5BLnNQjNQ8LVEXA4jMqAM82ZiSDRDZv31mdhtzG
    V7hPH5MklYjvS3umA>
X-ME-Received: <xmr:OcUpZ5OLmY0jzzPd0cKhvjdXII46filHOWNx4RDWNW1qEGYfVIZSBdeHLww5FRWjvFo_JPgwcYtcT_js0HAYOJCSNubtSvhDIa4h1vKrAweK9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejtddtgeffkedujeejgeduhefghedtgfdtieduleeu
    lefgueetheeludegueeuveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:OcUpZ77rLahKdQKG5dbklNmf7i-YUP8tF5Fa3HVQmS-9Rh5RC5-Nog>
    <xmx:OcUpZz7YxTA-1iqZhoM9MiHJHrcglaYLJl8jBYxVcvTXxA1M-izw6A>
    <xmx:OcUpZ7hikyIi2ckZIYWSw9OAlFspz5rbxa_1RqdiIwNjpUHKJcDCVQ>
    <xmx:OcUpZ97pryeF9WJpq-JIP7iGQrkbLx50oAbYBVsPFZGQv3hC4M4cPQ>
    <xmx:OcUpZ22W9WP7myFpjaGynv_awAVExONRcMtHJNO5QLf7DMVATSNUPEer>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 02:11:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d73222ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 07:11:31 +0000 (UTC)
Date: Tue, 5 Nov 2024 08:11:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 3/9] ref: initialize target name outside of check
 functions
Message-ID: <ZynFMnYgpCbYwQOs@pks.im>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYZy-9deyT6I9a@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZYZy-9deyT6I9a@ArchLinux>

On Mon, Oct 21, 2024 at 09:34:31PM +0800, shejialuo wrote:
> We passes "refs_check_dir" to the "files_fsck_refs_name" function which
> allows it to create the checked ref name later. However, when we
> introduce a new check function, we have to re-calculate the target name.
> It's bad for us to do repeat calculation. Instead, we should calculate
> it only once and pass the target name to the check functions.

It would be nice to clarify what exactly is bad about it. Does it create
extra memory churn? Or is this about not duplicating logic?

> In order not to do repeat calculation, rename "refs_check_dir" to
> "target_name". And in "files_fsck_refs_dir", create a new strbuf
> "target_name", thus whenever we handle a new target, calculate the
> name and call the check functions one by one.

"target_name" is somewhat of a weird name. I'd expect that this is
either the path to the reference, in which case I'd call this "path", or
the name of the reference that is to be checked, in which case I'd call
this "refname".

> @@ -3539,6 +3538,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>  			       const char *refs_check_dir,
>  			       files_fsck_refs_fn *fsck_refs_fn)
>  {
> +	struct strbuf target_name = STRBUF_INIT;
>  	struct strbuf sb = STRBUF_INIT;
>  	struct dir_iterator *iter;
>  	int iter_status;
> @@ -3557,11 +3557,15 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>  			continue;
>  		} else if (S_ISREG(iter->st.st_mode) ||
>  			   S_ISLNK(iter->st.st_mode)) {
> +			strbuf_reset(&target_name);
> +			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
> +				    iter->relative_path);
> +
>  			if (o->verbose)
> -				fprintf_ln(stderr, "Checking %s/%s",
> -					   refs_check_dir, iter->relative_path);
> +				fprintf_ln(stderr, "Checking %s", target_name.buf);
> +
>  			for (size_t i = 0; fsck_refs_fn[i]; i++) {
> -				if (fsck_refs_fn[i](ref_store, o, refs_check_dir, iter))
> +				if (fsck_refs_fn[i](ref_store, o, target_name.buf, iter))
>  					ret = -1;
>  			}
>  		} else {

The change itself does make sense though. We indeed avoid reallocating
the array for every single ref, which is a worthwhile change.

I was wondering whether we could reuse `sb` here, but we do use it at
the end of the function to potentially print an error message.

Patrick
