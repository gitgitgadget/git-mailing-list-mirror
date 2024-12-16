Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D381FFC53
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734338206; cv=none; b=Yba4sZ/iAtqr/3O5Tc0zHoNy/61mHUSK+hgOCdO58gMH7W/hKkNHExbOCheDpYx7m1BAPHjOBdY5lCOWsfHXCD1NBQNE6tvZRmlZ55DO7+FasNhMHrr3ixaoKeNg3LegPOtGUuoP4VU45Y+GWF+f5q5dcDn7ArhuyV8E/IW6tTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734338206; c=relaxed/simple;
	bh=UMAQgy/5xewSWL71Z0F+d292VnAu7E4rbe57yEbn0v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh/RfNQ02VFrZWuERzCL+kLobKfuHB9Vy0KlB5DbtKqGZBRW4oJJL0Ff6nPKFk8xl7OJ6ttuh+kDX6gZrvxVKS9GsjJckrbPm6hSx0nrqQmToGWYIyALqAf5Ew+xPgKUyLg4og7xm6S6+bKVTuQuOUxEzUwffY+7agAV4ldtWRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gc/pu0d/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C019vy0p; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gc/pu0d/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C019vy0p"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FF3611400A8;
	Mon, 16 Dec 2024 03:36:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 03:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734338202; x=1734424602; bh=IGd7x5VFUr
	xU1ngmNfPXMFqn8MqDF4g68E0JZDyOuw4=; b=Gc/pu0d/r+tLfqxnHaOT42UrTp
	lNvHaaJkdI/SRgYGgIveySUiDYZwX+UEqWP1qwDNW/mYWCjfhPVG4dOdCBqwd46t
	zq0/z8zcy0H4lokX5/ITdapGXVat+LM1Nio32xPCEslc3OVnpmVd47VDLJutnib8
	KJe1p7WH9x5FAGTDT8pvlUBVPaLvy7wnrarTRmIwnQr/uyi0+oag8lN0lkma3XD8
	e9tttua1GcMkMsNbCbA6HGKrIRDl6Avf5WcCvSuYcCxqmXuZLtzPRKrbdsa4RmDM
	BLSupUxxoYfk03Xs9SCX7BnIZh0Q5fjwlahAUsxgyKzuyHJM/vh3YLVz1hMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734338202; x=1734424602; bh=IGd7x5VFUrxU1ngmNfPXMFqn8MqDF4g68E0
	JZDyOuw4=; b=C019vy0plqt++w+dN/37S5ZpLV1qNLggJFEloHhqVg1VROCDlhU
	pItbbRUm50qYkV1/zLrxjtXm2XV/CMk1YRs5tp/aZFIQeLiAMztwuqF5ZL/0d/Ti
	A4Pio5Vn/JyXjTNQsiNnRthm5ugdDQrKZajndmeub3DFhPPC76RBZ/V4lPw80zfD
	O2odAdJSnADPEe62vgBmTM6RC1pEnOzbWB+K2X1KugGr+/piszmolwtyz9Is3+s2
	WnzqD2sAvKzJHKpygD1p7HWB2KB41b/ri1hfdOeDxItJ9NRynMrL4gxmYKHVZN/4
	a2F++k09dnWwQQlYcPFk2dj/CiqHjydng3g==
X-ME-Sender: <xms:muZfZ7a1UE4D5FhVGkJWQvZCUG0x6f2JARVSz2hjMMfgnhS10LpQQw>
    <xme:muZfZ6b-XHtHW8q0Yz0ltryvTGD3YpSXatbZBh16-hREUFz5tCTizCL0tyPbZfvNo
    junYoQ3_Oov2h3Uxg>
X-ME-Received: <xmr:muZfZ9_oyb-YX6boz42ySoptI2B6c9af9z2-gtTWzWMvaMiC9_Fqd5lLMfMRn0vtmxGgAQhDYOSkOUfyC_ueeds5loa_loX7pE6WhygnhGhVHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihhhihiho
    uhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:muZfZxrtp2SYB1ggwoPXSr9y306MWvYxpZYLNlz1YWj6zY1mdX53Xw>
    <xmx:muZfZ2oUwRbJlzVj1EHmsN5vmvr-c0tey-DsdWLXANzYU6QZ8lnoIw>
    <xmx:muZfZ3SJK2fcRDUOQw061aollTbxp_cWwZ7HMwPXVG5M8TvFT9Cq8g>
    <xmx:muZfZ-pPlczK-nXC92Xgj0ba7i7is6CDbDUab4EH1rmC_IhVk4Y97g>
    <xmx:muZfZ_kxpVNQYt-Rmg42bu2cgL-5VkIdwWCMpiqoH2y5MDHgVThEoenL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 03:36:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b6bad10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Dec 2024 08:34:56 +0000 (UTC)
Date: Mon, 16 Dec 2024 09:36:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 6/8] send-pack: new return code
 "ERROR_SEND_PACK_BAD_REF_STATUS"
Message-ID: <Z1_mgG7sqNtHWFnQ@pks.im>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
 <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
 <77f5e128fc1b66a9c8b0df3ce274a98921800685.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f5e128fc1b66a9c8b0df3ce274a98921800685.1733830410.git.zhiyou.jx@alibaba-inc.com>

On Tue, Dec 10, 2024 at 07:36:26PM +0800, Jiang Xin wrote:
> diff --git a/send-pack.c b/send-pack.c
> index 6677c44e8a..f1556dd53c 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -630,7 +630,7 @@ int send_pack(struct send_pack_args *args,
>  				reject_atomic_push(remote_refs, args->send_mirror);
>  				error("atomic push failed for ref %s. status: %d",
>  				      ref->name, ref->status);
> -				ret = args->porcelain ? 0 : -1;
> +				ret = ERROR_SEND_PACK_BAD_REF_STATUS;
>  				goto out;
>  			}
>  			/* else fallthrough */

Okay, this change looks sensible -- instead of having different
behaviour with `--porcelain` we now have the exact same behaviour with
and without that flag set, which is good.

> @@ -761,11 +761,6 @@ int send_pack(struct send_pack_args *args,
>  	if (ret < 0)
>  		goto out;
>  
> -	if (args->porcelain) {
> -		ret = 0;
> -		goto out;
> -	}

We don't reset the error code here anymore.

>  	for (ref = remote_refs; ref; ref = ref->next) {
>  		switch (ref->status) {
>  		case REF_STATUS_NONE:
> @@ -773,7 +768,7 @@ int send_pack(struct send_pack_args *args,
>  		case REF_STATUS_OK:
>  			break;
>  		default:
> -			ret = -1;
> +			ret = ERROR_SEND_PACK_BAD_REF_STATUS;
>  			goto out;
>  		}
>  	}

And this is the equivalent change without `--atomic`.

Also, none of the existing code paths used to set `ret = 1`. We do call
`ret = receive_status()` and bubble that up, but neither that nor any of
its transitive calls set `ret = 1`, either. So this should be fine and
we don't seem to have conflicting error codes.

> diff --git a/send-pack.h b/send-pack.h
> index 7edb80596c..ee88f9fe9f 100644
> --- a/send-pack.h
> +++ b/send-pack.h
> @@ -12,6 +12,9 @@ struct ref;
>  #define SEND_PACK_PUSH_CERT_IF_ASKED 1
>  #define SEND_PACK_PUSH_CERT_ALWAYS 2
>  
> +/* Custom exit code from send_pack. */
> +#define ERROR_SEND_PACK_BAD_REF_STATUS 1
> +
>  struct send_pack_args {
>  	const char *url;
>  	unsigned verbose:1,

It might help to document `send_pack()` accordingly and point out the
special return code.

> diff --git a/transport.c b/transport.c
> index 47fda6a773..454d7f21a9 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -914,6 +914,13 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
>  	case protocol_v0:
>  		ret = send_pack(&args, data->fd, data->conn, remote_refs,
>  				&data->extra_have);
> +		/*
> +		 * Ignore the specific error code to maintain consistent behavior
> +		 * with the "push_refs()" function across different transports,
> +		 * such as "push_refs_with_push()" for HTTP protocol.
> +		 */
> +		if (ret == ERROR_SEND_PACK_BAD_REF_STATUS)
> +			ret = 0;
>  		break;
>  	case protocol_unknown_version:
>  		BUG("unknown protocol version");

And here we ignore the error code to retain compatibility.

Is there any case where this causes a user-visible change in behaviour
already? If so, we can add a test for this?

Patrick
