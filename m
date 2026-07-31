Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC93E2768
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785539787; cv=none; b=hvmPLfh0fJ0tFw71K9Z9z/48WU2puaazYDRunlhzjzJsrYw6loJ1BchpG6RLHs36UTSsgChWaeC3CANUueWph36FYWBxwUm7y+H8Emi+kN2w20mTzKLjGnws6Naats7jWlYxXDCrR26xzHgX887CFet8vaJgwrh3tsIkgMixroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785539787; c=relaxed/simple;
	bh=m3tdEaMQQUJMygGzckdi2lqNaAoW0cqFZGPJG24+7Xs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUGljSp++WJQuvI8HlndoEDwck+Sziy0WVRkFKijYdPlg7VW2mctDTejc//DoJcWnAS1PI5kzqELvpEqaWgwJRirWcHywfKW9PqtcRE0goaumN0PTov8+3ZnswbdHCxqROzwOlrXNGhgo7nrecEZx7vtPnuALv0vv0aBrK5amcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tPElj7S7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JoZMNchv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tPElj7S7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JoZMNchv"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 86B4DEC0252;
	Fri, 31 Jul 2026 19:16:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 31 Jul 2026 19:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785539784; x=1785626184; bh=GHuZ09Uns8
	EZUbBmw4fJgulCQYj5GxCaVh2xgS6n2n4=; b=tPElj7S7GMs7pInDOEI0aJJfbJ
	hFaZponl1QRszE1K5m7oTaesxpnASA2ceDPUue1TKqW//JrkzLRE4AdpNyYmgBON
	tre7X2UL67bLuo3pMFMe9U+kcoI7QTs/6U+5yZl81znOYMYXxlynxppAEWL2xKEM
	skumXM2o787G/R5O5K5KXKr7puIs7FRGWcT21pHH3Yi8kxBSXMvn3JenxuADbNMH
	5vy/mh9ts1+kDxpbOXpKDRYLGXeSCS9ftCzOk/qqHNRD7VHYgHcEGcpF3tRmp1QL
	2DUW4dFvzFCB/gWHFjVHdyPQJdrBqtIqSFl6n5c+yEkFW80YE1xjupgLKV/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785539784; x=1785626184; bh=GHuZ09Uns8EZUbBmw4fJgulCQYj5GxCaVh2
	xgS6n2n4=; b=JoZMNchvwSWL8vRoFkeNZw6rSJLIguemixBiKK7uU/CL6+HvGEY
	hWFJAYscOJqRCWvfKJdEk8TBTGpGbhKiGVergGY51gx9PG3wGE6yGMBkZ+ghtTK0
	e16vkhXgno78Q5VauB+LdCH/xM2wfu19fvvGjgGJ6D3A9mDiO4IeS+Voj0nI8GuN
	lvimN7B4wT6B23e12zJEqY5S2qVfZKe035u6VZYODJ2pAE61mF7qV25LbstgSSY5
	rzP6L0RuJqKM+YpbYde/PdTS5Mjj1MOUWrb53UvzIZjFznIS06djdgQjE107fBaV
	ZlUo4YYLxhUhtfe2ZtQEfR9flvFkCOh/Y4w==
X-ME-Sender: <xms:yCxtasAH7yw9hnk3tdIGw18VRhp4Y6MUIR8ZiOfvV-dNTiAiG5Cezw>
    <xme:yCxtalaz6aJwEUMupDYXKJPvYudlLdzCSjd9eZZAIssY6xBfJOyDYbxNv5RGSXwxm
    RtcXi4PXQOxHxuD0pb_kmO79XhluggcAkTo7rekYcoi8xz9FinVQ7U>
X-ME-Received: <xmr:yCxtan4y-94TiNuEGWafyNI-O7McBKXEFENA1UP4Avsw4Hl97ukoxNVNj2M4345_-IorZmJZzRNBzcdD_VvjH7eSZ23S1p_WMg>
X-ME-Proxy-Cause: dmFkZTFVsjkjriew/0stboLF4gtGS1ND7/ngMXZhJUEDcR7H/vCVtlxvhb6ebfh2aD+8EG
    GuhEP/98bgTVfoBn8GUq8LDQHMLugAsO1P5LYTcGwQt6G+5yNetShP45ZJKTKGxNwNBdtm
    Di4PcRCTgBNBny0iC4/I9sqa/TSv6XOwbSZxvsAZbX7WFGIZYU4lYdQaFz9oG6BZ7UYGF/
    w7ulGA9qfKrIMJ9oEpgJJkZNoCyKOg63cjmK+mC+PUjAeoSiq0ybjiPtEg6PLRTHa78wrk
    RwH6sHT2FZ7rvuxO44VOHn4Fk0GMer69cqqBP83UcBsIPmQJ05xsSuoJlrHZKx7CZs1rq+
    62HTgBv39BWRW87RkYW7iAZlBxVlREGTxn1kMHLLixaUwkt8uQivuBlrCrMyJJfromv9jW
    IafOHDXuqvxcBK4VLbdugCWVjjQ37814Fdm8UZrRcPCe8OlpWCpvdqt/LJh5UmREvJD3dh
    /Ck9uNWBdU/O4Nhl1klCow7CCC9g6nl2AjzaEKK8JxA0kVBvVV+YCTvmKqneqM4HdGb4t2
    HfVC4HB6cC4gtvy84+U3mOng3gIc3vV3BVPOkyNXjSh0tcz0PIVX5PXEIgBZC5MizkFMgI
    itQsDTY2FssXOynmte+ZUXcRhVpVPOecd+/KX37YRavLpsgS5HeFCnTBM3Hg
X-ME-Proxy: <xmx:yCxtaubdGvaRpbXUTPw6W99V_P0i4ccGVsIW_0KOhIrDiu_RYVdZ0w>
    <xmx:yCxtaujb6iWenDP4XwfNFV0-tnkveJ_56FSxcQYqzurj6DTLQuRtOg>
    <xmx:yCxtan9rbhSsXQOc_Mtg7AHWw7CNglsnAOa2NpGMe-w5MrGWJ32bLA>
    <xmx:yCxtahon5XjhB8xNrPwwoliJnLg9PCeitoPQW_uuO-1m394DIdYgEA>
    <xmx:yCxtappbnbILEASNqZDz77Hec4HJguZ-yo-l_mumA4ZMh3VY8Y2B05rH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 19:16:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 1/6] fetch-object-info: request all supported
 options dynamically
In-Reply-To: <20260731-objecttype-support-v2-1-af577461ed57@gmail.com> (Pablo
	Sabater's message of "Fri, 31 Jul 2026 21:49:34 +0200")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-1-af577461ed57@gmail.com>
Date: Fri, 31 Jul 2026 16:16:22 -0700
Message-ID: <xmqqwluaagxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> In send_object_info_request(), size is hardcoded to be the only option
> sent. In order to support type and future capabilities, replace the
> hardcoded size with a loop that requests everything on
> object_info_options list.
>
> This is safe because the list has already been trimmed previously in
> fetch_object_info() to only contain options that the server supports.

Thinking along and aloud to follow the code, my understanding of how
the relevant data flows in the code path to get here is as follows:

 * 'cat-file --batch-command' processes the remote-object-info
   command, and parse_cmd_remote_object_info() populates the
   object_info_options string list.

 * It puts 'size' and 'type' into the list if needed.

 * get_remote_info() is called, and the string list is attached to
   the '.object_info_options' member of the '.smart_options'
   structure of transport.

 * transport_fetch_object_info() calls fetch_object_info_via_pack(),
   where the local args structure receives in its
   '.object_info_options' member the value pointed to by the
   '.object_info_options' member of the '.smart_options' structure
   of 'gtransport'.

 * fetch_object_info_via_pack() finally calls fetch_object_info(),
   which uses server_supports_feature() to check and discard
   elements from this list that are not supported by the server.

This is how the 'args' structure seen by send_object_info_request()
gets prepared.  The "already been checked to only contain" comment
in the code refers to the loop in fetch_object_info() that uses
server_supports_feature().

So, after tracing the code flow up to this point, I agree with the
"This is safe" claim made in the proposed commit log message.

I always get confused while following code paths in the transport
layer; my ulterior motivation for this comment is that writing it
down once may help refresh my memory the next time I need it.

Thanks.


> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> index ba7e179c44..ec8a80b3be 100644
> --- a/fetch-object-info.c
> +++ b/fetch-object-info.c
> @@ -12,13 +12,16 @@
>  static void send_object_info_request(const int fd_out, struct object_info_args *args)
>  {
>  	struct strbuf req_buf = STRBUF_INIT;
> +	struct string_list_item *item;
>  
>  	write_command_and_capabilities(&req_buf, "object-info", args->server_options);
>  
> -	if (unsorted_string_list_has_string(args->object_info_options, "size"))
> -		packet_buf_write(&req_buf, "size");
> -	else if (args->object_info_options->nr)
> -		BUG("only size should be in object_info_options");
> +	/*
> +	 * The list has already been checked to only contain valid and
> +	 * supported fields, so just request everything remaining on it.
> +	 */
> +	for_each_string_list_item(item, args->object_info_options)
> +		packet_buf_write(&req_buf, "%s", item->string);
>  
>  	if (args->oids)
>  		for (size_t i = 0; i < args->oids->nr; i++)
