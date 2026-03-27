Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D41DBB3A
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571401; cv=none; b=AXALiRm9IaKwzcCrlKdpKwevR403Kn3HZH9bWZRaOLsZ6P8KOcLDZNmgXDkh5MNup0EPU4J/NWOhQct2YlFP/RAIZHXwyrHPHR8w30lK8vH+j+S/A4HiuiNFZPFwJk+HMh/s2aCTQHVuOPDIYL/Zlen7rIU8B/E2h+OwXBFqOvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571401; c=relaxed/simple;
	bh=TRKmBORvCIc4G5dKF6yrwZuLxpmIRNnV6vlHD4Yi/k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQLQW3IKb92/i8O/fWyu17PpBdyw0nf30ufYztR80SLToFgyAqgCmfv0nHe6X0MxOxCI9mMJFilgYZfz/9DN4n+PoUPARP8mu11UI2uG9sije2zQbSCDDTCzI4WE4UKeROSYUPLpSDbhtEww6YQ/KVbT29d+S4doJEC1Rvdqgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltob96RI; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltob96RI"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89c4f7f8650so26508366d6.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774571399; x=1775176199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VP2mCm/dZ4OBR0o+bViaBO1WT7pbRoywzbPXFaw4Rng=;
        b=ltob96RIJlcPamB0rxAGv/qZgpXSHzYoA3BqX/q8iLvHB65nq+YPmTz8aRbG1vqKrU
         fKUAHf5fF/ovLtTTIMDlUId+gLN8m1dALDqtdWUcNn6alH6RVrSinamRs3y86ndD7rz1
         3YUmuhnsk1qwKeLfa1mRs7HQb24P3clG8x9wHxoSduDFNod+tu4scRZNka2FpEH0WeCS
         anF3Y7gvYVM5QnNn7ENzZpTbAOoJGYHrKO93ZASLAofuQXXsb3jJiQgq2eGSVZuQwM+I
         kJqSTAFnmCyeHqoUvFNZGhR0nfbJ0UWWqxYe7WhsOj5SW1BzB2+0u4nWFAMOr5cpkiLr
         4oqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774571399; x=1775176199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VP2mCm/dZ4OBR0o+bViaBO1WT7pbRoywzbPXFaw4Rng=;
        b=rRLkFKfIFQCfv58TCmW/9JgIPtd9h2zGdYhZWbjqMi1mYP+buLrIGSEFYfrmMwRkcA
         0SI3daUd+vIubw/oagZC8llxuSUsyRgHuihMJQmrsy/o1bbDSEpE5xrbFvCR/sE/OvVq
         eaZnVpmF+OUJZModynCd6qHZ1c2L1MlIOviTy6jcQ8nKGYqKQyLKoJVy4QnOnGAXU1Yt
         iYpBbjyggCeit/vdnzUyzNNcOiqEZDRWyQkvIrFCocQRp8oC44vkbkP7JKcpVlCugxno
         iMs/wrfvU7bZPeNoxT/UsykRIFKmKwhP3bIysKX8e+jhQ+FyM2pIgs/Kd2K38KwjFWx6
         M5Sw==
X-Gm-Message-State: AOJu0Yxrk1mfq+PgdBwVLQYYFEFw3fLD70A4ZJiUZl625Ud8LiBum8Kh
	K5x6kVqAtqAVa0Nb69YOJzNoKe4FmmhVN04OkWwqanVKHDxg4u576nZksiW7AQ==
X-Gm-Gg: ATEYQzymWGzjaPHU5dm0oM8IiIsA/9JXsnAskpUzvnZDbRx8rcOdjt9ps+wTox+A4JA
	0Vxa04RXmfTkIiph6slXvMkfwiDzYvj9B7gDhS4ngDKd023PHc2rXz01IIddXUqZYdW7og5s8H+
	rg8GAQpVI9Z3xlcPKS9pkCpnUiJc+UQ6vmMA+Oe6302BoAlssHhh/gy6VeKXySdiPl86PKmH7Zv
	1DQaHfP/qyr2/QtYomg68HnCKHl6ucues26JxToJorsR361yhe3y2ow78wG84kTiVNzGRCqvoXf
	+SSUBtg0Pf0mO8xMP49EwzK9st9NOg/BEyh4caOoNXRCiOwBguBMwQditoV6sVhnUps1ohM69QU
	fE0lSxyKzTA+ZXbDrmYNPG2LwSIZ5yWWp8QAJm7vDx1jVqbWDYXrQUWC18DlvaaNN27+OgJWLx5
	apXyuSnMAW38C4ZT2UwA0szLD6ThMVt6V7LG1sXl5kmRWaXK46NqQ0hrcWa+lXNX3p3+cBVIe+h
	3KKjzW/2wJzW6UTQuSlXLzDDtaQt0YBA3vSHtXOz03bVXEV2R8=
X-Received: by 2002:a05:6214:5d8b:b0:89a:2b9:ccf2 with SMTP id 6a1803df08f44-89ce8ed6e17mr5664596d6.53.1774571398861;
        Thu, 26 Mar 2026 17:29:58 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b4:9c00:290f:88d4:7aaf:d058? ([2605:a601:a6b4:9c00:290f:88d4:7aaf:d058])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89cd5a18eddsm37310156d6.30.2026.03.26.17.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 17:29:58 -0700 (PDT)
Message-ID: <b6e6ea33-76f0-42f8-9546-2e900f239530@gmail.com>
Date: Thu, 26 Mar 2026 20:29:57 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] pack-objects: refactor
 `read_packs_list_from_stdin()` to use `strmap`
To: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
 <d5cb793f0eb0028f1f521fec4723ad2b00592638.1774482701.git.me@ttaylorr.com>
 <9e320604-7367-4f48-a943-f7d22feb2672@gmail.com>
 <acWoqXUwVUB2/65T@nand.local> <xmqq8qbensw5.fsf@gitster.g>
 <acWz48NfB+dlbHAz@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <acWz48NfB+dlbHAz@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/26 6:32 PM, Taylor Blau wrote:
> On Thu, Mar 26, 2026 at 03:11:06PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:

>> If these STDIN_PACK_* constants would ever appear _only_ within the
>> context of talking about the .kind member of the stdin_pack_info
>> struct and cannot possibly appear anywhere else, then there is no
>> point naming the enum.
> 
> Yup, I agree. I'm inclined to leave the enum anonymous for now, since
> the only place we would need a name for it is the suggestion Stolee made
> above, which I think does not correctly handle an edge case where packs
> are specified multiple times.

I see that I messed up where a '|=' should be and where a '=' should be.

	const char *key = buf.buf;
	enum pack_input_kind kind = STDIN_PACK_INCLUDE;

	if (*key == '^') {
		key++;

		/* THIS ONE SHOULD BE EQUAL */
		kind = STDIN_PACK_EXCLUDE_CLOSED;
	}

	info = strmap_get(&packs, key);
	if (!info) {
		CALLOC_ARRAY(info, 1);
		strmap_put(&packs, key, info);

		/* THIS ONE SHOULD BE ADDING THE FLAG */
		info->kind |= kind;
	}

	strbuf_reset(&buf);

Sorry that I was less careful with the code and hadn't tested it
locally. (I still haven't, but I still think it's worth a little
more attempt to benefit from this structure, especially with your
addition of handling '!' later.

> As it is currently, the enum is only used in the context of the .kind
> member of the stdin_pack_info struct, and we don't ever declare a
> int/unsigned variable to hold the kind outside of that context (which
> would be gross ;-)).

Once you start creating a type, that tends to create the desire to use
that type in a new way. My _preference_ is to name the type because it
unlocks new ways of working with the data without needing to rewrite
the definition.

If the small tweak to my version works, I do think that the readability
of the new organization would be worth it.

Thanks,
-Stolee

