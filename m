Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BDB19C556
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786127; cv=none; b=VSJd5uTDi2K/+k9Ih5v421OcanyraeuWNV7+OS1Qokwx/A27Hpu7oMptdztW15wy7Z0NhiS0MFaVdlcVZk0ISR6v5+5+wLo9LO2CwaeUdSLr5tzSfe7uyQzw28zfLWQ0TMhSnR0n47RlK/GUMZpHOR2smFY/4jv25Qt1iI3V5x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786127; c=relaxed/simple;
	bh=9X4i04xBbOH9MtUIqmtX6XyJ0sSp/RvsKQ3dAQnO3+0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Hd7vPA3sNbVrRspD3djyp6C3dwXnU8peYOt2oANomBc/o3xmmYBshKkXJ6jOr42DzDFiTXDuF1MTSlokW6sA/usMTNr4YKXeO9hlnMGymhpPyXqvV2ze/s0Hf/W0cr3ToEPw7cnCW+KgyO48WabrM4FE0y6X+kOgZzRFIAMcPoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yb5tscS3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yb5tscS3"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso1704915a91.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2024 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733786125; x=1734390925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=598Egc0QOpQMPuSeVDGG9ydW/+9hQu+EOVD4Boa8Nl4=;
        b=yb5tscS3MwbjIZ+qiApJT0G+o1GWMbLaRet3UgzKEACYMKI5CgGaYQ9orO9RVPEdFT
         T1uQ6pyl7MSaiKeId00h3Zrn1P/t446uSnBbqp3MtMyBsvebZopW5Abz6lhwBZBtDF4c
         BzcSUE1Abn1owvDbifJYorj4q+/uvdZN2vecFTfVmrFnJK8lO9Vms9frY/JmY4JaSA4y
         3C4PQF1ML77EgcypAK/NC69+fiIiolT1FqG1XbxKlha0J3wb280wCVUmQGSjYLj/ptQx
         mO/U8rpZiOmpoD2WbD1XHFTkrk61ra+Ne5xC3Iri5Xi7crJEITLtutugZWHh74D6yO8d
         tsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786125; x=1734390925;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=598Egc0QOpQMPuSeVDGG9ydW/+9hQu+EOVD4Boa8Nl4=;
        b=G3176ZHwIWrZcmxqPZgHKfgXM5ITXmdVuejzKzg6joUq45zVUmbXQP+gtuVBya6mEd
         Us4Lz3Db1FS8FQucZoSg/9F/1HarOZYGTpcia7WM5SFw0L5cYuUikCC10MarKIIgIZ+1
         b/urxAdrCPteYzNw/ALv2oJIfW2GZshpjmEuIr+nWDkmSMQjTUWZgvv4G6tPzSWUCMIw
         dfqg8if/4554Y50b4V03yWyM9MkJW2PzQyLdp95QkXmrHROErJmHPnHx4NqE9I+lXjcw
         MKoU/PkJZM4sQYjyxVGQM+WtX9CkB8DTk0g4PrJt89QKvLTfkocGsq17Fpdcz269QfWL
         qLew==
X-Forwarded-Encrypted: i=1; AJvYcCX02OaPMwPI9mXQQjaZeKkjUI6SCY8+6xrlivTuefxXXbPHaxk3UXwrzgcSEkBSaB/P9sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBbJvndtW/gBHlJM/uf+7O8ivTqA1SBcOTscmrK4+2iw8XxDh
	3cIBquf5xr9oH29XoV0o/3bbjy8jvy6Drbw+r9OPvS8NOyJDRCKipGXeRMkU6OpEzCalOx7XN9v
	Z2KT+oHmaqXkLnhoT8yDSl4Xq76OhUg==
X-Google-Smtp-Source: AGHT+IHGZAybbFyl8N0bhgDROgZxqHzIf+ba+eB0FCRVUTsa0EXtYkQiL1hMeS6XQ77IYxjnfD+ZyO38GN5k2ZAB2NfG
X-Received: from pjbqc16.prod.google.com ([2002:a17:90b:2890:b0:2ea:d2de:f7ca])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5204:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-2ef6a6bdc2amr24349452a91.17.1733786124750;
 Mon, 09 Dec 2024 15:15:24 -0800 (PST)
Date: Mon,  9 Dec 2024 15:15:22 -0800
In-Reply-To: <454b070d5bb0f64e11cab993b126ef5d37a3615b.1733181682.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209231522.841908-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/8] pack-objects: create new name-hash function version
From: Jonathan Tan <jonathantanmy@google.com>
To: Jonathan Tan via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

"Jonathan Tan via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/pack-objects.h b/pack-objects.h
> index b9898a4e64b..15be8368d21 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -207,6 +207,34 @@ static inline uint32_t pack_name_hash(const char *name)
>  	return hash;
>  }
>  
> +static inline uint32_t pack_name_hash_v2(const char *name)
> +{
> +	uint32_t hash = 0, base = 0, c;
> +
> +	if (!name)
> +		return 0;
> +
> +	while ((c = *name++)) {
> +		if (isspace(c))
> +			continue;
> +		if (c == '/') {
> +			base = (base >> 6) ^ hash;
> +			hash = 0;
> +		} else {
> +			/*
> +			 * 'c' is only a single byte. Reverse it and move
> +			 * it to the top of the hash, moving the rest to
> +			 * less-significant bits.
> +			 */
> +			c = (c & 0xF0) >> 4 | (c & 0x0F) << 4;
> +			c = (c & 0xCC) >> 2 | (c & 0x33) << 2;
> +			c = (c & 0xAA) >> 1 | (c & 0x55) << 1;
> +			hash = (hash >> 2) + (c << 24);
> +		}
> +	}
> +	return (base >> 6) ^ hash;
> +}

This works because `c` is masked before any arithmetic is performed on
it, but the cast from potentially signed char to uint32_t still makes
me nervous - if char is signed, it behaves as if it was first cast to
int32_t and only then to uint32_t, as you can see from running the code
below:

    #include <stdio.h>
    int main() {
        signed char c = 128;
        unsigned int u = c;
        printf("hello %u\n", u);
        return 0;
    }

I would declare `c` as uint8_t or unsigned char.
