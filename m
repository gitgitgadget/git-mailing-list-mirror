Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E8280CFC
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331033; cv=none; b=VB/RCZrNGq+cCtsDHCiRH9Yh6E1rKbTDNh64G8EIsWijHnzn5svC/899qqD48lqhctV7J7RSAES43D1CkkLryVB8rycSR1dBIJi99Hp0OwcyRTHxawlCyoT8ZtbuEYIGsc07ZE+r0po1pNIUCtWtZduPV++yv1NARydf2ikPl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331033; c=relaxed/simple;
	bh=pe72oIyVbUnaAuBwpYEqzwkSbw2OwpZaM0O8NP33Y9o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iu76fQaTYpqDffx6g3FokEmJVZDF1WgWfykKuaz2ICS9VmXZje4f/NiePTHnmqmRAU31k4sLYo3aGKoxtaA19dZVymhaesDMrCDj+86TOYp0FWPTUzsTz9GJmWxT7fmLBGJzzby4WdTtZK37hfzMVub5xAuGne1OR4eVv42TH7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcU7Geel; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcU7Geel"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-525b44b7720so1992982e0c.0
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745331031; x=1745935831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ET0BwqRldZk9TXticKlTrg8kQouRAE2zn9w8zSs/Yh0=;
        b=BcU7GeelopmN+qUnGM6BOSywVB0lUz12xoZNrlPEs5K/VJrN3T5UgJ+PT5XAmLmwJs
         e4nCwruCXTFJm7afX1fTcFF1AK5ionKnAQ+dNbBlzmYNUgRX9XWq9xIhd9W4l/5yiuSh
         aNEUOAcuGD3X+MU2fC4FUv1y55ufeIdNTl7aQHL0oXEXD44tu6wUjmPQ8QdYTSljufBK
         E/yQxBrUdNq1emdXOg/CCbksvg7RVSdUdlck+MYvUMy59P0FzEs+MZM2I5RjfxCJttZX
         B/t6jSAyBseKLTxTmcDMWJkbA+H7E+rORaSrHKH29/hXvJhUjyZnADnBcKA+jopcm3Td
         b/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745331031; x=1745935831;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ET0BwqRldZk9TXticKlTrg8kQouRAE2zn9w8zSs/Yh0=;
        b=DsVoglFYtsNJGHgBx4iNbVftekBq4T0Cug1MGRbDSoJJTKP6Z2wKhEClzkqzko5Nr1
         gafB1bxf/Ua4r+7HJdnS8dp6LvyD0+sb2ygUg06jcdDNdWXXvUeTaue9tg3cU40cLJ6G
         Z/uGwiPvVanPCZsogjil80R8JE7K64JnJXeybSpE3hoNGZumP4LtT5oL9X2GkTh8+4Xj
         9vPb2A2NfXuhQ2kZQn4KKYIwcZQT+N6QC5ImXYVL/o4tdUpC0+OId5oXfzqNVwax+VFm
         3758CBqWTKTLJOMzy3pUgVfMnAXWBCmfakWh6fT+EFhOxos0s3Y+DQn/CDyRCLIxxDme
         3f3Q==
X-Gm-Message-State: AOJu0YwizOB6ltAhxIUaWG2qUwCdxcIeaWsHrpWayXCfYFU1TIi3tj0J
	BIRT8mHpKGb7Ei5Y9aOLq6IpslLy0xNzPWMfWip0xJ25aqDtjZSxRd7YRIlUZ0YEcft4oN1aSS/
	HkfWz8wVyqYYNvgiMKnzUpOZwKeY=
X-Gm-Gg: ASbGncvAo+/Ol63Bh7NlbKx8xLbf8fecrn7BbYR/kMEKaG9MWLxM8mZhws0aXRTAMSj
	311buhduhfA1ESOEkuxsA4v6kyQrpQdopkfP0YsjNsmP58vy2tP16KXSnrqtN9VI+eZ+yC1g4qR
	TEE3P9SqszQJwwzGGjCFhPLheyqANy05bdea5ytbdYtC1K18tIJs4OEgVFAkvegFIrtJM=
X-Google-Smtp-Source: AGHT+IEe6jygSPK310C0CPSUPNrtGbEzYFS6r/Ey9fSurxZJLQ+UQI//xFn0BbbF9/wtQkjSEZ1nLfIz5AX2GTcWXjo=
X-Received: by 2002:a05:6122:3c53:b0:527:c550:c06b with SMTP id
 71dfb90a1353d-529254a2a51mr10183753e0c.6.1745331030950; Tue, 22 Apr 2025
 07:10:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 10:10:29 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 10:10:29 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <CAOLa=ZSR=7TEWLHa-wzBB4x+4+-BH3UC3G7s24Bc26JH63QKOA@mail.gmail.com> <17c2eb4f-e291-4189-9846-0f42bdead01d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Apr 2025 10:10:29 -0400
X-Gm-Features: ATxdqUHAp54VKazvTGs2ocBG_Jwy0GO3eVedyKw8ckthqxLwosnfJhSJCwWXp_4
Message-ID: <CAOLa=ZRmwnjytxoqG0fJWXFjaZcGQ9g=PFmx9N5Thuq64C24GQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's hdr-check
To: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk, 
	Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000001dacab06335e8cf5"

--0000000000001dacab06335e8cf5
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 21/04/2025 16:33, Karthik Nayak wrote:
>
> Thanks for putting this together, I've left a couple of code comments below.
>
>>      Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>
>> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
>> index 37541f3d10..a09fcf4d72 100644
>> --- a/.github/workflows/main.yml
>> +++ b/.github/workflows/main.yml
>> @@ -414,6 +414,16 @@ jobs:
>>       - name: prepare libc6 for actions
>>         if: matrix.vector.jobname == 'linux32'
>>         run: apt -q update && apt -q -y install libc6-amd64 lib64stdc++6
>> +    - name: install git in container
>> +      run: |
>> +        if [ -f /etc/alpine-release ]; then
>> +          apk update && apk add --no-cache git
>> +        elif [ -f /etc/almalinux-release ] || [ -f /etc/redhat-release ]; then
>> +           dnf -y install git
>> +        else
>> +          apt -q update && apt -q -y install git
>> +        fi
>> +        git config --global --add safe.directory "$GITHUB_WORKSPACE"
>
> I'd be tempted to check for which package manager to use by using
> `command -v`. That way the only distribution specific knowledge we need
> is the package manager and we don't have to worry about the names of the
> various release files in /etc.
>
> 	if command -v git
> 	then
> 		: nothing to do
> 	elif command -v apk
> 	then
> 		apk add git
> 	elif command -v dnf
> 	then
> 		dnf -y install git
> 	else
> 		apt-get -q -y install git
> 	fi
>
> The commands above omit anything that updates the package cache as we do
> that anyway in install-dependencies.sh and we only really care about
> getting some version of git installed here. It also uses apt-get to
> match what we do in install-dependencies.sh
>

Yeah this makes sense, we don't have to worry about specific
distributions.

> I also wonder if we should ditch the checkout action and use something like
>
>      git clone --depth=1 --single-branch ${GITHUB_REF_NAME} \
> 	${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}.git
>
> so that we know we will be building from a git repository.
>

Possibly, but I'll leave this out as I feel we're already straying from
the topic now. Let me know if you feel strongly about it.

> Best Wishes
>
> Phillip

--0000000000001dacab06335e8cf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aac859cbfc070bdb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSG8xQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNUQ3Qy80dTQzQ3hmUUJ5QU9VNkpocG1oZDJoejhJRQppUmduaDI5Tklk
TURxajVRV0tEWUhqTmt3aW9paWx1SzkxUWFlc1pNQnV2amEvckZxanRGSTRoeS9NVlNBOUJ4CmE3
bnY4OVlHVXlzRG5FV1Rjb1lFV2VKT25MbUxkVGNlYVczYmJpbkhnNGFhaFdUcHIrUUE5MnZnd3Y4
YzB0a1UKYml3WUhkcFFTRThseHBEME9hUk15U3BBNWpRU0xUZ3M3ejVYenBIamx4cGlvMnJSb2Nx
dlVUTHE2dndOZGlHUgozcmFCWHNWV2lEMDZUemt6OUxEYlZOdTBodTN1WVZLc0hSV012bjVKdVEw
NEs1dlMzNUdhdXgzYzRXNzlocXhBCkFHTUtCWXpmYkEzQlVTUjFmc0tZdFhXbDU3UzF5eU5KNHkx
YlFud0VNMmUreC9DVHVKK2k3bkpnbU5EYlJFOFYKK0xMMHZzRjcxWVlPb3NpT3BqdENvVG56YkFM
K2x4OHRiWFJTTjhiZnBtZlZFZ2tCVGtpOEc5LzE4bE05R0JtUApiNEs3SFRDUkd4ZGRaMWh5Q29T
d0tNc0Jqd1UyTUFEWVpKbVE1OEcvZ0orRy82RmhOWlNlZlREcXhjQUtUSEtpCm02aEYvZTc2Y2E4
WTFXMzJKUk9wZTVtRnd2eGlzYThOeG1zb0hraz0KPXRMSDEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001dacab06335e8cf5--
