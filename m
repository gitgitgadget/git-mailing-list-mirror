Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA231D5ADD
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851185; cv=none; b=Sjlxw1Xb2qA6wr7wpyhzRW0JzE5ZwsvAkn/+sf3JL269QW7mV3+BBwENZwgGdAdQIitPnqXbkI50Hx9qimJNSJZhMNVqqaBWCQGQAGwNP4UEKsd14paB8ak4V26+37NTTG7gTOMtHL0K2y12wHVXX62elgwHahyTbRvLtN1KwaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851185; c=relaxed/simple;
	bh=HOjrvMPSLxdSp7ZXGdR5fcGTyZYtNwgiGAKfbbdJCqE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3sNBWkTcualSESEyC58NEiskGdGRbE7O08CcDSdjHHVundPDR0XWKEyIJ8WPALrysMVlYYqhItWO9eJErAjGHu/ZiyNAJs4bf3e/VngGSNQk0lx+5mrj3jOZqcIY43k4BggnSVas97IGfA2KY3TYwSn30+xlf+akeZLvEVwL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQnxV7BA; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQnxV7BA"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84fcd9f4e98so506112241.0
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729851182; x=1730455982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MqoyQeSFiNWa/eRUcc+xq+/HYfUCyPKByoDkSjPm7aM=;
        b=bQnxV7BAn/m/angGjCTj0Xmn3m1TLjqDEKzx/7QL+2NQg8OxcTiRsnuimFej951Rrj
         REi2Q97xBh3M9YfkZDYoxImtj3Bv/CI9b8iikFidvQDDdIS/ADS6qay5Zair9DD/AGYx
         lRo//GL20Ax1MOP1RxdiXHE+s9cxJULHl1wEx/PsT+QhafW9rsIjo39NYkhJ9HVBWuyL
         /rSkDYOe10PDRde9oZ3mtnoXHhie5VjUZuaM5f2lp8hT94qu/Lm7qbtWTtf0TxqxNGXe
         tuTcacSo76DgEpDkIlawWXIB/FQ/mdvyxVI5l97707gRdmSvo9cf0+GH0+GNHgdUUQok
         gK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729851182; x=1730455982;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqoyQeSFiNWa/eRUcc+xq+/HYfUCyPKByoDkSjPm7aM=;
        b=U/FhmnRwRo19GHl4tSoDc1OLm22dR0P/8MOhZM/dL3Ugt7ZwnC6NsaN95AOoiKp8Dm
         XsAHd6AmuvqabLfRNmRcbfLJ8CbEdLU0i1hlhBjXSmn8R3E/Vzq9GxaTAZtvY5AfqtAz
         mJ8e4DFgbmweIr4hE013m6VJMneJKC7SsMCTdI3sYgi5QavSiuFKhrsntwiHyH1yD+QS
         b/9iPQAljlLWkrakGIfRt1IPZPSaK49PPjzXlRrMdkV7tkkJWBeHbFgwFsQDym+mb0Sg
         6IM/P96qH7GjN8f3IdqHy2OkN+LuMBn53ZPIM3q6qxyRMWD9C6O5RxhD6Vpn9jpE56ay
         MYKw==
X-Forwarded-Encrypted: i=1; AJvYcCUFjPz72FFrFL8cibjFxX5kSfSL9Olj/KZWrOVjX07z55gqiRsbBEhxLq6z5TGa+UUug/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0iahTK+Y+IAjxL3aYvTp6Z20xzgDAG0QQnbiqbavUn9QrnTRA
	D3ch6Qr3Rws7L2aq/+3fb3uqCJDbIm1i79I9x4ro0DEVuEcjEdvAZIzRr8aQYglj5FI8hq8NyEJ
	iaH/eoGBew2qDPx/8IKTzjRzAbkA=
X-Google-Smtp-Source: AGHT+IFDXRfnFEKOKdEmWcXuSRKrU7JAEfPKn7PzrrjMI3UrwSnazRnmM01MuDCp4Qsar/lRHO1fj7Tzppg+93k+5is=
X-Received: by 2002:a05:6102:3a08:b0:4a3:fc62:3ea8 with SMTP id
 ada2fe7eead31-4a751a8ca3amr12414782137.3.1729851181294; Fri, 25 Oct 2024
 03:13:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Oct 2024 06:12:59 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241024205359.16376-5-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com> <20241024205359.16376-5-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 06:12:59 -0400
Message-ID: <CAOLa=ZS4XLNBeXewQ8O7tpobQfF9C9LKP--MVYghVR52hcqgWA@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] transport: add client support for object-info
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, chriscool@tuxfamily.org, 
	toon@iotcl.com, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000002d0e1a06254a5d9e"

--0000000000002d0e1a06254a5d9e
Content-Type: text/plain; charset="UTF-8"

Eric Ju <eric.peijian@gmail.com> writes:

[snip]

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 800505f25f..1a9facc1c0 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1347,7 +1347,6 @@ static void write_command_and_capabilities(struct strbuf *req_buf,
>  	packet_buf_delim(req_buf);
>  }
>
> -

Seems like this was introduced in Patch 1/6, including the function
below which is not used in that patch.

>  void send_object_info_request(int fd_out, struct object_info_args *args)
>  {
>  	struct strbuf req_buf = STRBUF_INIT;
> @@ -1706,6 +1705,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  	if (args->depth > 0 || args->deepen_since || args->deepen_not)
>  		args->deepen = 1;
>
> +	if (args->object_info)
> +		state = FETCH_SEND_REQUEST;
> +
>  	while (state != FETCH_DONE) {
>  		switch (state) {
>  		case FETCH_CHECK_LOCAL:

[snip]

>  /*
>   * sought represents remote references that should be updated from.
>   * On return, the names that were found on the remote will have been
> @@ -106,4 +114,6 @@ int report_unmatched_refs(struct ref **sought, int nr_sought);
>   */
>  int fetch_pack_fsck_objects(void);
>
> +void send_object_info_request(int fd_out, struct object_info_args *args);
> +
>

Nit: Would be nice to have a comment here explaining what the function does.

>  #endif
> diff --git a/transport-helper.c b/transport-helper.c
> index 013ec79dc9..2ff9675984 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -709,8 +709,8 @@ static int fetch_refs(struct transport *transport,
>
>  	/*
>  	 * If we reach here, then the server, the client, and/or the transport
> -	 * helper does not support protocol v2. --negotiate-only requires
> -	 * protocol v2.
> +	 * helper does not support protocol v2. --negotiate-only and cat-file remote-object-info

Nit: could we wrap this comment?

> +	 * require protocol v2.
>  	 */
>  	if (data->transport_options.acked_commits) {
>  		warning(_("--negotiate-only requires protocol v2"));

[snip]

>  static struct ref *get_refs_via_connect(struct transport *transport, int for_push,
>  					struct transport_ls_refs_options *options)
>  {
> @@ -418,6 +489,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	struct ref *refs = NULL;
>  	struct fetch_pack_args args;
>  	struct ref *refs_tmp = NULL, **to_fetch_dup = NULL;
> +	struct ref *object_info_refs = NULL;
>
>  	memset(&args, 0, sizeof(args));
>  	args.uploadpack = data->options.uploadpack;
> @@ -444,11 +516,36 @@ static int fetch_refs_via_pack(struct transport *transport,
>  	args.server_options = transport->server_options;
>  	args.negotiation_tips = data->options.negotiation_tips;
>  	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> +	args.object_info = transport->smart_options->object_info;
> +
> +	if (transport->smart_options
> +		&& transport->smart_options->object_info
> +		&& transport->smart_options->object_info_oids->nr > 0) {
> +		struct ref *ref_itr = object_info_refs = alloc_ref("");
> +
> +		if (!fetch_object_info(transport, data->options.object_info_data))
> +			goto cleanup;

So if we were successful, we skip to the cleanup. Okay.

> +		args.object_info_data = data->options.object_info_data;
> +		args.quiet = 1;
> +		args.no_progress = 1;

Not sure why we set quiet and no_progress here.

> +		for (size_t i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
> +			ref_itr->old_oid = transport->smart_options->object_info_oids->oid[i];
> +			ref_itr->exact_oid = 1;
> +			if (i == transport->smart_options->object_info_oids->nr - 1)
> +				/* last element, no need to allocate to next */
> +				ref_itr->next = NULL;
> +			else
> +				ref_itr->next = alloc_ref("");
>
> -	if (!data->finished_handshake) {
> -		int i;
> +			ref_itr = ref_itr->next;
> +		}
> +
> +		transport->remote_refs = object_info_refs;
> +
> +	} else if (!data->finished_handshake) {
>  		int must_list_refs = 0;
> -		for (i = 0; i < nr_heads; i++) {
> +		for (int i = 0; i < nr_heads; i++) {
>  			if (!to_fetch[i]->exact_oid) {
>  				must_list_refs = 1;
>  				break;
> @@ -494,16 +591,26 @@ static int fetch_refs_via_pack(struct transport *transport,
>  			  &transport->pack_lockfiles, data->version);
>
>  	data->finished_handshake = 0;
> +	if (args.object_info) {
> +		struct ref *ref_cpy_reader = object_info_refs;
> +		for (int i = 0; ref_cpy_reader; i++) {
> +			oid_object_info_extended(the_repository, &ref_cpy_reader->old_oid,
> +				&args.object_info_data[i], OBJECT_INFO_LOOKUP_REPLACE);
> +			ref_cpy_reader = ref_cpy_reader->next;
> +		}
> +	}
> +
>  	data->options.self_contained_and_connected =
>  		args.self_contained_and_connected;
>  	data->options.connectivity_checked = args.connectivity_checked;
>
> -	if (!refs)
> +	if (!refs && !args.object_info)
>  		ret = -1;

This is because, now we don't necessary always fetch the refs, since
sometimes we're just happy fetching the object info. Would be nice to
have a comment here.

>  	if (report_unmatched_refs(to_fetch, nr_heads))
>  		ret = -1;
>
>  cleanup:
> +	free_refs(object_info_refs);
>  	close(data->fd[0]);
>  	if (data->fd[1] >= 0)
>  		close(data->fd[1]);


[snip]

--0000000000002d0e1a06254a5d9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c4651fa5c6c12c38_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jYmJ5Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWJpQy9vQ0VBNCs2UDFvLzJUbVdCakxlUlllYTh5SQpyR1JDRjYvQW4x
SVI0VlNyZCtDS1JsNmdtb2kyTjlKNVpEeHJSSHN2ODVnQzlrVEtiUmZtMlRZTTQyU3lsNjB5CkE3
NkFoMm5qK0RFcThTRE1lUGZ0czZyaDZQMmJyV2I0dFZ1d0JaYkhlZVp2RDAyYkoxWlhraWpZaDll
ZU5WdksKNHVNdkJiOGJvK1ZLV09FNFBVN0tVNVRZQTBFTEZkbmxTcWN2VVBNY0pJWEhBOTRPc0tZ
VytxelFORFVoMjZ3YgpUaURLOXh1UEZlTlltK2xvYVFpVXR0V0pNOXE1c1VzNXNOWDJyWnRyUks2
WFgwZDh4WU92bGtSdTdINGg5bWs3Cjk1aHJsT09qckNNcWYyWTZON2xaNU1lOGZKQm1aSGFEd3l2
a3BJOUV1TGtvNkZ2SFZrZFQvSG5CUmlhVzVxYkoKbVhXMHQ1MkdGSUZQVk5sa2RvYksxdEM4UjZp
RW5Qb20xWTVkQlJ2ZGpPbDM4Y0w0Mk92SzFLMTV6aGk3WlYxNApaVTFobHphbitLUXNHZm8rQ0Uw
QlZMT0p4V084TUdDQkl4UlVKeXNtK2Z6VW1pZzd1SVhVK1FZbXdncmsxTmZaCkNwVUk3SGVDa1Vq
bGk2ZnZYcW5ENlRHVWw4RFNrb3dDbkVpRkw3ND0KPUM4VlgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002d0e1a06254a5d9e--
