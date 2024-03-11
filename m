Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244C5810D
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710193392; cv=none; b=MdKQPr8xsx5VG4CecNtxiipZOSiRmxLHczkC9i1rciptd9PLFppilxVV0kOz2dj+LRo9HEwC04jj1LxNULMlDXP/h3OFelmyu3hR8AXU6syHr0f9TwMWhxulVLEvrT6wvRiWqkk7TmPKfsEBBBK6q5l1+xhHEjP+xiwh9VfaYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710193392; c=relaxed/simple;
	bh=DkEiT+qNf9WfieR64ZrKMw5RzGZF7qqN8WHz7RFLv4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4LwRs8TGRhzss5cSytiKP8j7Z6hlBQqjE+vlIc4g9WG0sIP6zHiFMCIZ4IWRGdYHuvAMIkIeYU1ER2JbJb2v8ZrB+wqfQWJkF5U3zDzok4Y+qC6+ZuGR7wt1DuwbCsRa4kfwPYi8W4iEdPxBf5e7+5O2cYbManLJemNNAaOtS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsPePRhk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsPePRhk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so6318850a12.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710193389; x=1710798189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=op7Vc90Qwq13r7abnBycbmIYZmPmVmdEJZzGVRxGCtA=;
        b=KsPePRhkW5p5Dxa7zsJpys4+Hh7dUFdcteXUvq3baiyUtONNrgouFWlG/dJ7hs2Fz7
         2hUn3z70ZovXSDRqNGgZKvO6yn/dW398+Ua/ExClqDq/OpcJgNQIrN/BRdfN8fF9g4oB
         IbdsqQCA1ktpF5Ynf+fInRCOaQ9mUHrMW+17lNCYczA068+irO84Wz/tffxg6PSQqgZi
         Bt/Gzj6HybmqCqyRtvFCnK6G/0DGoDlDESSb43Cv+JEKyFBQ+UnGvon+nuaVCQl42AIO
         Ddc8VKcM3ZxVxB8FYrB5bRfMDmYBgy1j5oBmM14zc3fdjb6jwv4lmc9ISf2xiwM1a4LC
         e63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710193389; x=1710798189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=op7Vc90Qwq13r7abnBycbmIYZmPmVmdEJZzGVRxGCtA=;
        b=gtru9HVL/tpMDHs6hB+C8M09gGtcgdCzLRN9yaA0byscZxA6INgeYM3xgxSjwQziXu
         7whq6sfAckLajBIsRSI4cMEO/gfUerV0WnCtJgRqDS7b+G1yGiBm5lzVwAg8K3quVcZc
         AI0COmOeYDn5JXend8a5sbw+vvNV9VZ5Mtp5gvCUmuo3J5g5rS8TKdH9+ep03ineyx4z
         nhEGwjhjB2kXCq/j32mJIusFI3J3dRZv8j2bAS7H+wBmSxx7XT4THz3qXzV2EiaTCkzB
         /FrWd9XjhaJ/Rxq1bpqa0M/ZR/gB7Nd4bnQzxIxkZcaGEiFe5WKU7LzoghyQKcVWMNUx
         sSQw==
X-Gm-Message-State: AOJu0Yxk7ThQuyPIkZo1N3vOKm+3WhGtaIIla6F8sxNN8ONDIPxmPmI7
	g8lYKJestCHON50wSSErsAK+AJa8+ygxlryYlD7L8tXHM7g7d79YLV3eUSbUe6Q=
X-Google-Smtp-Source: AGHT+IFi3MiN1kuyL9Uf6S37n/MWdM/RQLsHifbLlaO1HxGMXTz9HfQ1EB0Sa7sM0sX7CXf+tDM40w==
X-Received: by 2002:a50:cc9c:0:b0:564:f6d5:f291 with SMTP id q28-20020a50cc9c000000b00564f6d5f291mr5148585edi.34.1710193389452;
        Mon, 11 Mar 2024 14:43:09 -0700 (PDT)
Received: from ?IPV6:2a04:cec0:103f:4e2b:599c:222:2133:41a7? ([2a04:cec0:103f:4e2b:599c:222:2133:41a7])
        by smtp.googlemail.com with ESMTPSA id b20-20020aa7dc14000000b005684fa1c4dbsm2192953edu.52.2024.03.11.14.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 14:43:09 -0700 (PDT)
Message-ID: <3c98b049-4eb8-4441-aae7-4789a8f74d9b@gmail.com>
Date: Mon, 11 Mar 2024 22:43:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] doc: git-clone: format placeholders
Content-Language: fr
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
 <9a949d98a3ec8b7730b5a6b66e8ef8bb62cd06aa.1710097830.git.gitgitgadget@gmail.com>
 <xmqqbk7ku2ak.fsf@gitster.g>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <xmqqbk7ku2ak.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/03/2024 à 18:05, Junio C Hamano a écrit :
> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>  --bare::
>>  	Make a 'bare' Git repository.  That is, instead of
>> -	creating `<directory>` and placing the administrative
>> -	files in `<directory>/.git`, make the `<directory>`
>> +	creating _<directory>_ and placing the administrative
>> +	files in `<directory>/.git`, make the _<directory>_
> 
> It is hard to decide what the right thing to do is to the earlier
> one on this line, isn't it?  It is not fully verbatim, even though
> its "/.git" part is.
> 

Like the synopsys of the manpages, if there is a "constant" part in the
word, it is deemed to be verbatim. Only when the placeholder is standing
alone (usually the sentence is about it) must the placeholder be marked
up as emphasized.

Also, headers of description list needn't be marked up.

Maybe worth some additional rules in the guidelines...

> Everything else in this entire series looked good to my cursory
> read, but I'd appreciate extra sets of eyes, of course.
> 
> Thanks for working on this topic.

There are manpages that are really inconsistant, and even malformed
(such as gitremote-helpers), but the order of fixing will be to focus on
the most often viewed ones first.

