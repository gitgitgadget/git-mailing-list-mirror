Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E55BC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 13:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiHANaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 09:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiHANaH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 09:30:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEAB3C8D7
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 06:30:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso1700391wme.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jl2m/UGCFPeZGImdIQyWiXlLs094UK7XRJ1LJcMlHQU=;
        b=J8syuLf5GLVQulgtu9YegcjCVwQR0E9oJp3lOahz7G+tI4FIz+3vIyKs6+DstWpADu
         tGNgbeiNZBX0ecZO/mL4FJIExYf94t9ga3EiighN7z7/dry4UHaDegRfkdKR7nSP1rpo
         On18fRuXzcSp2YboB3coY90kFPJEyTzesimU7ZTbhK+YYY0/7ecf5O2ojstoByIn2RkX
         iNZh6ckSWBTRNnaAaM1YBrTvUK1h+jzKfuSY6NkdXFc0LYxZULT4L4XUhIfq4uMCGCoJ
         iyZFvo8BO/RsX5+ceNvKb8x6mHD9GSYR3GZJT5XgqmZeODHZRPmKXbM5qO/ZhcaeFRGJ
         SGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jl2m/UGCFPeZGImdIQyWiXlLs094UK7XRJ1LJcMlHQU=;
        b=DxhEzufV4hoIl51EqRvOV8se3MRbBa++l3NynN8mW89MDAOR6J5jEH5ODHMi3ZADri
         5QE9qDZstFMOmI/QhZC5n3+zXTCPPTNVb40zcTQkaNYVFulpK5audCNyA/QzBdcfVe1u
         Vq0T0wigeT37Pt2yeMSzsSYe/y/HvYOFOoCZzp9BBTp5JdiWT2X9gczjfmZwdDk4KN8I
         0oXX+Y2141Xa8VM+wFzkJ/Gl7j1F6wXkcAXTalp0VND38iifJV2HB3PpOBFd1E992X8m
         8vlM3oJyejjI5IlRPtd2v9UltviQQqg0vE2/QXWzX+f/XJsz6n7u01Att7e/Gd3k+xGx
         jzLg==
X-Gm-Message-State: AJIora/r2JmePeK9ZIZDHtNI4kHtnhtmMYBBg1tg+gzavFBReVQKXUAu
        fvMVYvMBaxgV0izYwOTk/DM=
X-Google-Smtp-Source: AGRyM1vJ30yJ23yaWyB0ur0BT0H96laDS3z62TxZhHU34MdBRdj2AfXqa0jHsx+MXQ+CB8lM0dPB8w==
X-Received: by 2002:a05:600c:190b:b0:3a3:45c5:9f43 with SMTP id j11-20020a05600c190b00b003a345c59f43mr10885219wmq.130.1659360604329;
        Mon, 01 Aug 2022 06:30:04 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id j6-20020adff006000000b0022063e5228bsm2689968wro.93.2022.08.01.06.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 06:30:03 -0700 (PDT)
Message-ID: <b33ec478-8858-faa7-2678-f02559426539@gmail.com>
Date:   Mon, 1 Aug 2022 14:30:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 5/6] transport: add client support for object-info
Content-Language: en-GB-large
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-6-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220728230210.2952731-6-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 29/07/2022 00:02, Calvin Wan wrote:
> Sometimes it is useful to get information about an object without having
> to download it completely. The server logic has already been implemented
> as “a2ba162cda (object-info: support for retrieving object info,
> 2021-04-20)”. This patch adds client functions to communicate with the
> server.
> 
> The client currently supports requesting a list of object ids with
> features 'size' and 'type' from a v2 server. If a server does not
> advertise either of the requested features, then the client falls back
> to making the request through 'fetch'.

I'm confused by the 'type' support, I might have missed something as I'm 
not familiar with this code but I couldn't see where we parse the type 
returned by the server.

> +	for (i = 0; i < args.object_info_options->nr; i++) {
> +		if (packet_reader_read(&reader) != PACKET_READ_NORMAL) {
> +			check_stateless_delimiter(transport->stateless_rpc, &reader, "stateless delimiter expected");

This is one of a number of lines in this series that are way over the 80 
column limit.

> +			return -1;
> +		}
> +		if (unsorted_string_list_has_string(args.object_info_options, reader.line)) {
> +			if (!strcmp(reader.line, "size"))
> +				size_index = i;

Should we be checking for "type" as well? Also does protocol-v2.txt need 
updating as it only mentions "size" as an attribute.

> +			continue;
> +		}
> +		return -1;
> +	}
> +
> +	i = 0;
> +	while (packet_reader_read(&reader) == PACKET_READ_NORMAL && i < args.oids->nr) {
> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;
> +
> +		string_list_split(&object_info_values, reader.line, ' ', -1);
> +		if (0 <= size_index) {

To avoid a possible out-of-bounds access we need to check that 
size_index + 1 < object_info_value.nr in case the server response is 
malformed

> +			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
> +				die("object-info: not our ref %s",

I'm a bit confused by this message is it trying to say "object %s is 
missing on the server"?

> +					object_info_values.items[0].string);
> +			*(*object_info_data)[i].sizep = strtoul(object_info_values.items[1 + size_index].string, NULL, 10);

As Junio pointed out in his comments in v4 there is no error checking 
here - we should check the server has actually returned a number. Note 
that strtoul() will happily parse negative numbers so we probably want 
to do something like

const char *endp
errno = 0
if (!isdigit(*object_info_values.items[1 + size_index].string))
   die("...")
*(*object_info_data)[i].sizep = strtoul(object_info_values.items[1 + 
size_index].string, &endp, 10);
if (errno || *endp)
   die("...")

Should be we checking the object id matches what we asked for? (I'm not 
sure if protocol-v2.txt mentions the order in which the objects are 
returned)

Should we be parsing the object type here as well?

> @@ -392,8 +468,25 @@ static int fetch_refs_via_pack(struct transport *transport,
>   	args.server_options = transport->server_options;
>   	args.negotiation_tips = data->options.negotiation_tips;
>   	args.reject_shallow_remote = transport->smart_options->reject_shallow;
> -
> -	if (!data->got_remote_heads) {
> +	args.object_info = transport->smart_options->object_info;
> +
> +	if (transport->smart_options && transport->smart_options->object_info) {
> +		struct ref *ref = object_info_refs;
> +
> +		if (!fetch_object_info(transport, data->options.object_info_data))
> +			goto cleanup;
> +		args.object_info_data = data->options.object_info_data;
> +		args.quiet = 1;
> +		args.no_progress = 1;
> +		for (i = 0; i < transport->smart_options->object_info_oids->nr; i++) {
> +			struct ref *temp_ref = xcalloc(1, sizeof (struct ref));

Using CALLOC_ARRAY() or p = xcalloc(1, sizeof(*p)) would be safer here 
(and everywhere else where you have used xcalloc()) as it ensures we 
allocate the correct size.

> diff --git a/transport.h b/transport.h
> index b5bf7b3e70..5512fdb140 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -31,6 +32,12 @@ struct git_transport_options {
>   	 */
>   	unsigned connectivity_checked:1;
>   
> +	/*
> +	 * Transport will attempt to pull only object-info. Fallbacks
> +	 * to pulling entire object if object-info is not supported
> +	 */

Is it definitely true that we fallback to pulling the entire object? - 
there is at least one place above where we do

 > +	if (transport->smart_options->object_info) {
 > +		die(_("--object-info requires protocol v2"));
 > +	}
 >

Best Wishes

Phillip
