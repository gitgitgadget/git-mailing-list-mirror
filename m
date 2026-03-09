Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26C86277
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052619; cv=none; b=pWoi6+8/bQhcvcSSsuNems2Ql7zJHO7+72AjxIEeJz5DDiRP/b0Zwv8t0b65PvRsujM3qy1QTSFGclTrEK74XtiDXvW8pkhtcAOBDeDLjgGTcB/efiB63bVPSOMus8kXiQPKlt0ocDEiQODX75+gH6KEID5/dDd+8LygAHTXfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052619; c=relaxed/simple;
	bh=dcDwosTWwEzeuUiNetJimWX5ZFVtjH/h0aJg+xiKpv8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WVBG4ifVjuW2fAsgSxMrHvhV+0ybpCSQif7KjhI8ENpPI0RmP2fvNDXNN2QXwJfGreyLuCjBLQe6XN3ouTFTlQQTRJvxZSPqiHQeWoSiwXE1Q3Bcdw0u/IxRF8llnq3KPKnbqDWIK0YPAXpVLWzivY2p2iy8ZGQZBkkcxc1IzAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQAa9p7l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQAa9p7l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48534237460so14529115e9.3
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052616; x=1773657416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyllIcduxDyjHO+6YuTm0YxArbc4mMvxtHp3dfvaXf4=;
        b=lQAa9p7lIksKlEO5uFoMthsyGYBmSW2iooMRla7A8+0eA4JsT3/Vo1mimB4G+IcETE
         b4zp17K0odtScRhTsJg4PSZ4Sp66/rQzTEiu66GHWpLInVpje3GXv5+55F+Pm29V5PsR
         1e2e8jPyG4gvb879wK4OdNlYt19WdGcezK2nBqRg/ht/ReABz0+JD5pS9Sc+7L5Ovh3r
         zAwoP97Evs3Har5G6+LrDqf9zFQ+LchVKgRQsnn5ySTXgxwNgn8tU99wtdzFK6IXoDzd
         E1G4tulq4w38H4+tM/9OkPMnUtQeAkLUgI9yG3ZAOEIlqm+iYvcnDgwA5shzjE0l/MG0
         +bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052616; x=1773657416;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyllIcduxDyjHO+6YuTm0YxArbc4mMvxtHp3dfvaXf4=;
        b=JjJPW6OqREyOoFVVHMfEq3kCKK2MPqfMlO58GSnaQrKGutUlcbiZ4DtaAE4Ayudsf5
         aY7ll3lhscy/KGOAwbxAWLWBru3riGumlPYuefKilMkLMYoXGjZ/2ysKfEnfBiCdyP0S
         1pJGAfFOmoePjVgrYk68s7Wa9axt/BniR5Snibv9DQ2iKDCpOv2xrjN44uA+gCfUtz52
         Y8rE38WeJGxs0L6CzqLwP5h72UbTwEAG0EP9DZqSBr6g24gURwyy9lXcylRqwr43b0NA
         53Y1CW/+8oBPfdtVE+H52pMLxaRwdLAPnztrniwlk2jwk9+vqeijZ9ffH4wYxrv5F3se
         5PKg==
X-Gm-Message-State: AOJu0Yx3css5vvSZUv3qqr9h0jt1HC5PiGmL6Y+18ZwJrZD92yRCm33S
	JH0IHzGIHE2/Jj+rkyAsLUexEzMx9faOFQYXafFYGhVmv0rkDG02tXFR
X-Gm-Gg: ATEYQzy/QoqzV+o+1A4I8N95uSMoHpk/iKX78Ge9T5mO4BFXwl8B3/rlXnayf/YX5e5
	qCRTrlHTARJEGknzla6gWcTHcJjBvusT3Weq2jZ9C+k/0Yc0Wj2WuB2IUBoMRaEIeiNqdAsFg92
	wY5PMK20shN4SbOWyXjM3fL5/FL9NRPfoNiM4EDpPe1f/CHTjD+/vpi/5jkqYN25jQ+EoE3HMhu
	UZnQL02fU4mIF+idDlDHSu9gcpx/4RfbzGOGcmXojAznBt0pNnYK4pdXQCCOif5TP/n2f6v8/wA
	4inqT/syanKm8AKZoTFeabX1mYnRS+nZJ2cUA0L2gBwBrDPjwaVm6c5tQKY7DyTnM3XPxrqazb7
	YjJ/S1DuSvnfPPypn2peKKJpQYWTmXCt+DmySiGgcmuKsCfIKggdCoMDpaxkMdW+NqauuK8aWR2
	RRJad8JV7+i5kjIQFZa+Xz/jSHOdZSCENENfTr+d95YQj2kWnVhLc2DwR77ACUcDGgJmh06cXYL
	MSkww==
X-Received: by 2002:a05:600c:3e15:b0:485:2f8b:55e9 with SMTP id 5b1f17b1804b1-4852f8b5ca8mr107891085e9.26.1773052615508;
        Mon, 09 Mar 2026 03:36:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48540ae5484sm4273485e9.2.2026.03.09.03.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 03:36:54 -0700 (PDT)
Message-ID: <de777714-49f1-41d4-a645-b173ca0e2b31@gmail.com>
Date: Mon, 9 Mar 2026 10:36:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v8 1/6] interpret-trailers: factor trailer rewriting
To: Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>, Li Chen <me@linux.beauty>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260224070552.148591-1-me@linux.beauty>
 <cover.1772808594.git.phillip.wood@dunelm.org.uk>
 <0d08b361995f4d117b3c80a7e403c1a821d10a5f.1772808594.git.phillip.wood@dunelm.org.uk>
 <xmqqo6l0zn2p.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqo6l0zn2p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2026 21:04, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Li Chen <me@linux.beauty>
>>
>> Extract the trailer rewriting logic into a helper that appends to an
>> output strbuf.
>>
>> Update interpret_trailers() to handle file I/O only: read input once,
>> call the helper, and write the buffered result.
>>
>> This separation makes it easier to move the helper into trailer.c in the
>> next commit.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> Signed-off-by: Li Chen <me@linux.beauty>
>> ---
> 
> If "Li wrote it and signed it off, Phillip is relaying" is what is
> happening, the sign-offs are in reverse order.  If "Li incorporated
> what Phillip wrote earlier in his larger work", then the sign-offs
> may be fine, but it would be necessary to hint that that is what
> happened in the proposed log message.  I cannot quite tell which is
> the case.

It's the latter, I posted a diff[1] and Li based this patch on that diff

Thanks

Phillip

[1] 
https://lore.kernel.org/git/7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com/
>>   builtin/interpret-trailers.c | 57 ++++++++++++++++++++----------------
>>   1 file changed, 32 insertions(+), 25 deletions(-)
>>
>> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
>> index 41b0750e5af..69f9d67ec0e 100644
>> --- a/builtin/interpret-trailers.c
>> +++ b/builtin/interpret-trailers.c
>> @@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, const char *file)
>>   	strbuf_complete_line(sb);
>>   }
>>   
>> -static void interpret_trailers(const struct process_trailer_options *opts,
>> -			       struct list_head *new_trailer_head,
>> -			       const char *file)
>> +static void process_trailers(const struct process_trailer_options *opts,
>> +			     struct list_head *new_trailer_head,
>> +			     struct strbuf *input, struct strbuf *out)
>>   {
>>   	LIST_HEAD(head);
>> -	struct strbuf sb = STRBUF_INIT;
>> -	struct strbuf trailer_block_sb = STRBUF_INIT;
>>   	struct trailer_block *trailer_block;
>> -	FILE *outfile = stdout;
>> -
>> -	trailer_config_init();
>> -
>> -	read_input_file(&sb, file);
>> -
>> -	if (opts->in_place)
>> -		outfile = create_in_place_tempfile(file);
>> -
>> -	trailer_block = parse_trailers(opts, sb.buf, &head);
>> +
>> +	trailer_block = parse_trailers(opts, input->buf, &head);
>>   
>>   	/* Print the lines before the trailer block */
>>   	if (!opts->only_trailers)
>> -		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
>> +		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
>>   
>>   	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
>> -		fprintf(outfile, "\n");
>> -
>> +		strbuf_addch(out, '\n');
>>   
>>   	if (!opts->only_input) {
>>   		LIST_HEAD(config_head);
>> @@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>>   	}
>>   
>>   	/* Print trailer block. */
>> -	format_trailers(opts, &head, &trailer_block_sb);
>> +	format_trailers(opts, &head, out);
>>   	free_trailers(&head);
>> -	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
>> -	strbuf_release(&trailer_block_sb);
>>   
>>   	/* Print the lines after the trailer block as is. */
>>   	if (!opts->only_trailers)
>> -		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
>> -		       sb.len - trailer_block_end(trailer_block), outfile);
>> +		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
>> +			   input->len - trailer_block_end(trailer_block));
>>   	trailer_block_release(trailer_block);
>> -
>> +}
>> +
>> +static void interpret_trailers(const struct process_trailer_options *opts,
>> +			       struct list_head *new_trailer_head,
>> +			       const char *file)
>> +{
>> +	struct strbuf input = STRBUF_INIT;
>> +	struct strbuf out = STRBUF_INIT;
>> +	FILE *outfile = stdout;
>> +
>> +	trailer_config_init();
>> +
>> +	read_input_file(&input, file);
>> +
>> +	if (opts->in_place)
>> +		outfile = create_in_place_tempfile(file);
>> +
>> +	process_trailers(opts, new_trailer_head, &input, &out);
>> +
>> +	strbuf_write(&out, outfile);
>>   	if (opts->in_place)
>>   		if (rename_tempfile(&trailers_tempfile, file))
>>   			die_errno(_("could not rename temporary file to %s"), file);
>>   
>> -	strbuf_release(&sb);
>> +	strbuf_release(&input);
>> +	strbuf_release(&out);
>>   }
>>   
>>   int cmd_interpret_trailers(int argc,

