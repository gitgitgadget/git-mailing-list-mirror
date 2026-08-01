Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993D3B8405
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785560147; cv=none; b=ipuqNhaRkoOX59GsmDLEuw09bGvDRrDGc76/yy0lwMMBr4tB0QjWtAhjbXB4l3z6+VwUE+8SRQmETAe4WyXnKdwD6/Wj73DLh0fOvcYOjPrOM2Gegh716tL3XETL5r8jHVyU3z45zrHJz1foQOSWSpjKbjd3JrcU4RlGYb2I6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785560147; c=relaxed/simple;
	bh=36mA8TRry4/lXOa/v2f3kX1gwlTGXQfY8E3I/Wao0EY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZbTDz0xhuhbioO9bSKfXEY9Ce+hci2WmBvXdaLHuTl+K52Xu0wdVf3hYl+qq9vF1e25Zg3xZrwhqe+1rbAdUgZjY9wtxbriH1jgr01wQMYJwcGbGUZMSIDrTRZ3e9bzELIUDh4YSNnaPF5MmKVXKVTkWrneMuvJTAQm5EXPiaAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y9vNXnGi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T2T34q5b; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y9vNXnGi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T2T34q5b"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E0D2C1D0006E;
	Sat,  1 Aug 2026 00:55:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sat, 01 Aug 2026 00:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785560143; x=1785646543; bh=6SX7AlJG1Q
	xX0s0oxumJeu5jyAy/smvSP0ByllUGUvY=; b=Y9vNXnGiifUR3lS31hvQEBsXTT
	F+w87kbD5KwV0eo5elyZmVl1aYyQ5bJH2SKkHOlydDw0HpgLyejsqDXGAGSK3jb+
	fGc7D8/ILlm4GWeAcD33iQEr2dxwalV63cOaugOVRQ5GeCPcc/zAinI1UAiAq4UY
	HshQ7l1EoDWGOJOW/qRoIZectEQBpyzRW5WdM0ktc1NWTZwlLGRj1gQrmEdnjxtg
	kOka4o4Fl7CccqH/1hHkGbXwlSRj+ELauVSKqs5sQaUg/qgKrqC+cuGqARE+cOQz
	/YfTSuzPlIglm8xF5+JS2j8NjmcutqLrt+/JEhN40cpdqkpJTO4SN9VORfxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785560143; x=1785646543; bh=6SX7AlJG1QxX0s0oxumJeu5jyAy/smvSP0B
	yllUGUvY=; b=T2T34q5b/ov/eV35BXH5hklAqa1QrzmnMCvQnJy3oWfzrZ24ZGo
	N3dFeHJW+V+BY+VOQawAQbai30DJrkANR0Dstlz0giw+wJ+b7Cl6/e2Fug2E73cJ
	D12JCjvKrsIRJDILYYrHBT3vl7bCZ+MMd1+XMhMrY3I27UThnYgMmmN0mSEN2pdg
	uA4HIL3d1GayyvmQmKEUJm33NKW4QCBbsvMDa0wnyQ/26akUa27t6kWF8tMXZGxA
	2bnIguHJ3zaQhhLCpPioZNA9oiGMSWqhM51OY1a7oArRo9AeEmD9zPruhao7bNev
	4lMTh9hqh3+EMUra88yaXw8b4eklOSii//w==
X-ME-Sender: <xms:T3xtah4CL_ZkYPFkQHgJNwL4y85A0B5bKplBWM6qkB1vrf8xIi-SQA>
    <xme:T3xtalzBvyAPZgt0FYt24xRQDO_CS3z4ZIKRWitoHRb5r5_wd8iZp3x9r1g0FmfBx
    9acTCRVa-WzOkRZY5C6lkxdUVz73LP7xN-XsZEGJC9wjnnhJx1XKw>
X-ME-Received: <xmr:T3xtagyPQOV6rCBVRHx_eSuEYv29JFHWaZXjYZzsyhBeeqWXnOEyym-SO0vT4IOm5Yx6H17m03bX67Qo2jpykR3YZfzlnM8vNA>
X-ME-Proxy-Cause: dmFkZTFqXd0aI6sXrnE1Pci4uiZUZ93XytGwPdg45iQZD2zLOqHeOZZpIPmU0H559yMY1i
    qacrmtjXVozErUWJ3RgUmokTkKaCrUwCo0v7khpYbNsmCzpwaASXRZc2HKmFoSUlzT6ND9
    eGvz6hEe+/69VVJPFAU3v0qOjR999MYDrnGanmFWVwISG3FGJlT5M4yirr6Kaendvhf+Ux
    aew4zC2BFLDljhUXui0XlC8ezJLN/CCTRB8uoq6mhZyXkrA6rV+/6aAcQfuRYzQtL3zOUZ
    m410+XPqB/BuAdUifMiHAb2SwvCPQQhINR2nDbIiBBCpGAPYliA6zU3Nxvskhr6fsJyKbb
    X+jF2MZO5Z96DZrDXPyM4RQGZfxXBGd/zznLXoGob7JMzkN9raM+LGJVERjJeHT6e1QYYc
    QF1zLftGw/vbOC17eZmfpUtA1oBzhG8AXJVMNk/WtDgMvQkOvoj1kORaZyRvHVrF2OEF+y
    qw99ej4kxofEj79PX0wedW2u4gaEByAhoqqfnx3VCRim6DlhJHK/dFrI4lTldl5S03V5v2
    qgGdhO70kbpMOL1ko0EWtMWzjBDs2jcTTlyjb96s7DErnDbA6Ph1SZlzviuRhUrzGo3LEq
    Gr+zdjBRNi7YkIH3PCLQxUi20l4Hv0QQ02SUu8uRyhz9kapDiXpdzFwMbe0Q
X-ME-Proxy: <xmx:T3xtalzasmmfrzdTIzMAZNF1Bn77nmt-yHzj9FhVoZUwDzfNR6UApA>
    <xmx:T3xtaiZeO_vdSai8xwolDQtfBzAFZ-hQ6o_njG8bn9sEWuHvuHSTgw>
    <xmx:T3xtauWT4RHloLmPU4_g8zx-vD6f4fswSkHi1e5Z1x7U7u0hTzzwDg>
    <xmx:T3xtaoj-QIsxYlDSAV7vWLgH0rpTCJPNl9zMcV2cRGVjWQpxkyZtuA>
    <xmx:T3xtapBHK6Oibw3qUX3kPQkmHgi5X-O8QmZokwPkl6eSAv3WqdhXijHH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 00:55:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 3/6] protocol-caps: add type support to object-info
In-Reply-To: <20260731-objecttype-support-v2-3-af577461ed57@gmail.com> (Pablo
	Sabater's message of "Fri, 31 Jul 2026 21:49:36 +0200")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-3-af577461ed57@gmail.com>
Date: Fri, 31 Jul 2026 21:55:42 -0700
Message-ID: <xmqqecgia181.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Teach the server-side object-info handler to accept type as a requested
> field. When the client includes type in its object-info request, the
> server returns the requested object type.
>
> While touching send_info(), wrap an over-long line and fix the bit field
> style of requested_info.size.
>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  protocol-caps.c      | 21 ++++++++++++++++++---
>  t/t5701-git-serve.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/protocol-caps.c b/protocol-caps.c
> index 02261be14d..27e0f85b10 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -11,7 +11,8 @@
>  #include "strbuf.h"
>  
>  struct requested_info {
> -	unsigned size : 1;
> +	unsigned size:1;
> +	unsigned type:1;
>  };

OK.  This matches this bit in our .clang-format file:

    # Add no space around the bit field
    # unsigned bf:2;
    BitFieldColonSpacing: None

> @@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  	if (info->size)
>  		packet_writer_write(writer, "size");
>  
> +	if (info->type)
> +		packet_writer_write(writer, "type");
> +
>  	for_each_string_list_item (item, oid_str_list) {
>  		const char *oid_str = item->string;
> +		enum object_type object_type;
>  		struct object_id oid;
>  		size_t object_size;
>  
>  		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
>  			packet_writer_error(
>  				writer,
> -				"object-info: protocol error, expected to get oid, not '%s'",
> +				"object-info: protocol error, expected to get "
> +				"oid, not '%s'",
>  				oid_str);
>  			continue;
>  		}
> @@ -93,7 +99,8 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  		 * If an object is not recognized by the server append SP to
>  		 * the response.
>  		 */
> -		if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
> +		object_type = get_object_info(r->objects, &oid, &object_size);
> +		if (object_type <= OBJ_NONE) {
>  			strbuf_addstr(&send_buffer, " ");
>  			goto write;
>  		}

We were already learning the object type as part of the existence
check anyway, so we will ...

> @@ -103,6 +110,9 @@ static void send_info(struct repository *r, struct packet_writer *writer,
>  				    (uintmax_t)object_size);
>  		}
>  
> +		if (info->type)
> +			strbuf_addf(&send_buffer, " %s", type_name(object_type));
> +

... add it to the payload.

>  write:
>  		packet_writer_write(writer, "%s", send_buffer.buf);
>  		strbuf_reset(&send_buffer);

ANd then the payload is sent in one go.

> @@ -124,6 +134,11 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
>  			continue;
>  		}
>  
> +		if (!strcmp("type", request->line)) {
> +			info.type = 1;
> +			continue;
> +		}
> +
>  		if (parse_oid(request->line, &oid_str_list))
>  			continue;
>  
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index b4d6beef11..d7445571b1 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -366,6 +366,33 @@ test_expect_success 'basics of object-info' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'object-info supports type' '
> +	test_config transfer.advertiseObjectInfo true &&
> +
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=object-info
> +	object-format=$(test_oid algo)
> +	0001
> +	size
> +	type
> +	oid $(git rev-parse two:two.t)
> +	oid $(git rev-parse two:two.t)
> +	0000
> +	EOF

This is not something we can change in the middle of this topic, but
the input format looks rather curious.  We tell the other side that
we are going to ask about size and type but on two separate lines,
and then throw each object one by one.

> +	cat >expect <<-EOF &&
> +	size
> +	type
> +	$(git rev-parse two:two.t) $(test_file_size two.t) blob
> +	$(git rev-parse two:two.t) $(test_file_size two.t) blob
> +	0000
> +	EOF

And the output format is even more curious.  Again, we say size and
type on two separate lines, but (object name, size, type) come on a
single line.  I would probably have designed the "these are the
fields" declaration at the beginning to also be on a single line,
in both directions.  It is not like we are afraid that a line would
grow too long.  If we were worried that placing these "size" and
"type" labels on the same line would make the line too long, we
would certainly be showing object name, size, and type on separate
lines.

Anyway, the code change looks like what anybody would expect to see
in a change to add support of "type" to a codebase that supports
"size".  As an incremental change, I didn't see anything wrong in
it, even though the basic protocol design smelled a bit strange.

Thanks.

> +	test-tool serve-v2 --stateless-rpc <in >out &&
> +	test-tool pkt-line unpack <out >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'bare OID request' '
>  	test_config transfer.advertiseObjectInfo true &&
