Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD663A2E07
	for <git@vger.kernel.org>; Wed, 13 May 2026 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697343; cv=none; b=cAtU673WeXV8+SXc23pJ1vnUE05MKaTDquxM7JDKghMigYSiiHZdZjcW19YWhzOmn8qgPsONO1DK+6JNv7tr5t45VynH5r41R3PITjP8oX9RgjThIzQjslcRWW/8mcXNdNurmQ3WLcwg3Pl/6cUOKKqxQRMmrkalV6pCqj64g0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697343; c=relaxed/simple;
	bh=TL2zDqNYA2+TB2hDJjqDfxEm6KQjgkNILhqRDQKToos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3xVUf5GDg05IHjApQu85V3MZ6FfHrKRwgMzNv/EJctTq5watuxD6YGFRI+8SP4xiSN57LafxfBeBK8POPD3Y+le30/k+SZdR9jKCH3j9L4mj5aBR7jK0UU3EngvmrYGlEJvL5MhGToF/jTrm2hTUViLW9/3mFmiMtY98hyL7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/n1DFp8; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/n1DFp8"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6314287380bso3548840137.3
        for <git@vger.kernel.org>; Wed, 13 May 2026 11:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778697341; x=1779302141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiD8rQxP6FsTpbR0KM3wLWrjU0c4Sqhl+1deTTtBP5g=;
        b=R/n1DFp8Fmw3VzVf+CZQ63C7SQIr1EpDTEGh4+0vyNV6xOwkKE0833pUKwIURIwPKt
         m5XQtjObkYB3VHl7wwbagD31uk5G2mYkAS07bC+v020KF4hhgjFAxu+jSc8lbSKBw9Ow
         RfnJssMuOFAXYZ8JTBfnYLCjuTCGF7TdeANPRIkO+a9YcCPp48SnjKhCM1AFIiuQJm0U
         oX4XINLt3aETFjmxJRMsBBjJv9ineB1dA2NRFmdCfWisX/BwmT4mvXPXAEP8Q/RDeT45
         S99hlUaA7SSR35IdEbo3BG2FxUh88Hk5n/1FzlaM/pymQx1mKUmAerX34qLXcuLOfMyV
         xEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697342; x=1779302142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiD8rQxP6FsTpbR0KM3wLWrjU0c4Sqhl+1deTTtBP5g=;
        b=XMdM2BK3pCkdkVezt42PitQ4cCty/EnSCfdJaSQhz+64AtyFJlMZ7oMwzyuxnrOgh4
         v5VQc0RZ/9cvPeP4vPkbn0PBcsViXLoafS3Cy1vuGfX0e5s4PnPZZogPHozVfCCkFIB4
         femeMpoWZQX/MabX84H8gOxaVRRiJGbV7ET35C0qD63ljiUUEvpKYCZjPlnr0la5HvyD
         ol6yJaeV4FHBpAjp1Oq4EUvA5s0x8so20a3kJiVWZ3BuGDqs99cQ8p2wnZmbML/bH9Fh
         POOUEC8HIx2TALTfCc+etco5NkCYEkh3a1Df/O/HPBQMGZ5cBeXcaV/A3lnkUYCCBfdS
         2tcw==
X-Gm-Message-State: AOJu0YzPHnVWbsEfIeiAvxe5Npbi69Ma5M5rr3i1syyuOgl1AdGY056N
	cYZ9RpltEdN9wtcSRCeDWMR1VZXRbXtxm/qn4sKqVccT1KJPhLjd9x84
X-Gm-Gg: Acq92OG2hUpKBmG83hPxZz6/ghV46QC+O8+SmJ7bAXIHBmwS1T9pv4iID8DatRT5HF+
	SYwV9qz2vKY6CO3Sf+LLiHUm5XqrHB242p8Cw2+WpMXTeFZyZnzVoaS0DVPumL3hrA9T7KSKOs5
	MchP64bH84Ou3aHuiEqR5Q2f+jJ2tQeN3ZNuY/lF5KwuheU+MRKqXRBs3NSNngRH4Zb86/KC6Wx
	K3wW/IkzzX4syY0ioqsdpmVLl1PGlZVUcYZDw5qtr6aqHsWUYG69DK8vBDm0OOhGlrR5oGtzlQi
	uvrh3+y3BogR9XqL0JM8fLin4WV3aEThuSzI+2Xusq+IspTPjOldvdk9xjMndSFiFaSeN6nqn8Q
	TmxI+sigTbzjpDuozn20ubEGwEd/grk0ecnxZe2c3Qbp+r6oYL4CCdumvlA9GUu/WoF6TAZtZuG
	eJ9b3wbtNgepFwjfAkb9szBareO40OaAQMCd7OgzSpfiWW/9aJEqbSaCGjaigPxwpLzuQShjDrU
	cD4HB4G
X-Received: by 2002:a05:6102:2927:b0:62f:31d9:7bf with SMTP id ada2fe7eead31-637754eace2mr2890990137.17.1778697341660;
        Wed, 13 May 2026 11:35:41 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63140216a98sm10662566137.8.2026.05.13.11.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:35:41 -0700 (PDT)
Message-ID: <130ecbf0-7456-48da-ac20-d5364a1b5577@gmail.com>
Date: Wed, 13 May 2026 14:35:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] path-walk: support blob size limit filter
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <a1ab70405d6209a11b2eb752c154361060f1675d.1778523189.git.gitgitgadget@gmail.com>
 <agKDbUoZeiux3jdj@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agKDbUoZeiux3jdj@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/2026 9:33 PM, Taylor Blau wrote:
> On Mon, May 11, 2026 at 06:13:04PM +0000, Derrick Stolee via GitGitGadget wrote:
>> [...] Blobs whose size cannot be determined (e.g. missing in a partial
>> clone) are conservatively included, matching the existing filter
>> behavior.
> 
> Makes sense, but...
> 
>> Notice that this inspection of object sizes requires the content to be
>> present in the repository. The odb_read_object_info() call will download
>> a missing blob on-demand.
> 
> ... this says that we do download missing blobs on-demand. Should we be
> (temporarily) disabling 'fetch_if_missing' for this phase, or using
> odb_read_object_info_extended() with the OBJECT_INFO_SKIP_FETCH_OBJECT
> bit set?

I don't know that we'd want to set this everywhere. The case that is
technically correct, but probably not ideal, is someone running 'git
pack-objects --filter=blob:<size>' from a blobless partial clone. They
are asking for something inefficient to create, but we _can_ still
create it. 
> I don't know enough about 'git backfill' to know whether the current
> behavior is more reasonable than the above suggestion, so please let me
> know if I'm missing something here!
For 'git backfill', a size limit filter doesn't make sense as it's all
about the client making decisions about how to download batches of
objects based on the local tree data. Filtering on size isn't something
that the client can infer in advance of downloading everything. Further,
the direct blob requests to the server can't be filtered by size, by
design.

Thanks,
-Stolee

