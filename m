Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A499819AA75
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061238; cv=none; b=MkaynLcLE2vxMvaEUMOsEcdAwN7kczzyYxa2LHcBAECb/TrwRJZiN8znWy+rP687/9K1QBYULSxnbM4pvM6j0ZBabVq8QpfJ0I3G+uQOR7P2LZ938g7RS4Be8IrRhWMLJ9g0BbdhbVGsTw5EG/ZGpoQ7Ys+lstPOwHwcDairfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061238; c=relaxed/simple;
	bh=M3wSCoRUK0Vhk3d46lyJcz3R+VcEWqOTzitgJ+VxIig=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qZeVYIKiO9FRcnfVUdaF/Upcx93B71IBE335FDZoH5GNOVg11kSlROi2na93jSYSigBPsnNnnl1PkjKcel7QmevjRCpc43PGDk2lA7Gq636e0k0YWwEKYPvwpBTOEqdret/ILuZ9/+cK76UiJ2DjWrsKlYWUMoeoNNNF/yt+mMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLTZAoX7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLTZAoX7"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso5627495e9.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726061234; x=1726666034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M3wSCoRUK0Vhk3d46lyJcz3R+VcEWqOTzitgJ+VxIig=;
        b=bLTZAoX7pxbCnA4V/JedALmT0WmjTf76vgwtOxyGlDP0zybl4RFSs6KPYJrwyRo11T
         zyL4fhM4oVK4Hv0SpUVkup4NrD9lf4sJAz6L/XpCNN6/Btw2brQ6aqRFEQpINT2qiQPG
         QAL0Z1XlkDiBORyiNEFpPshakhQROLFORmbIJQVzj4iEOfytvxo2CYuWfGputhjC8OXt
         vEt05Hq3hWbzqlHyNJy+PNadg3emzDyhqmA2RKZ3VrX1Q7cFW1xd9G8uMWi9qV/lZTZY
         BMCW6qAwgWLHom92rbKi8vLrr+ZdyrbwRXh2PtWwlS/nu68SrfLdaVl15x+Re8c3lCNd
         4QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726061234; x=1726666034;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3wSCoRUK0Vhk3d46lyJcz3R+VcEWqOTzitgJ+VxIig=;
        b=p7brNyqe/Qypd86LGKcdeodhzX/dpMH2T7OwLXQ/Zg86yIQUuCk8xu6Hod+/kspGOf
         U4Z5Rirn22zqFMLCVoD6AHSzIUUhyMkmu+aVfr4JaYiDLCqtlOo/f74v3JqJEZ5SeaK4
         LDW/CksRgB2DUBmS6sgJP3Sfk0BWAHls0KoCXOuuQnfaAtf+we4P+du2xuLDJj1slG1D
         10+jV8JteXoWloQY3bBbMSzMyCYnml87kSe9PM17pCK3uli96QXlP/G9r0LlMnjXKhvy
         oA1VcGOLYXmKPjCjvT0VjjH6UWYObewkDSDGRSoyjLWCWd3FqPkJzDnbnSVBNb5MpBlF
         1ong==
X-Forwarded-Encrypted: i=1; AJvYcCXf+V8uDyPNMktiKEJREsbgR1uCm8itNnVEA+1MA/amary4V2u1k2zrd+z/4/j4swU9tKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXu/JkJHyENjDDaHukPrg3KKOTk+bZuh56C5XxvMrWHnFMU0x9
	A8ZPPP5CBi1dKQun39xXzWYOgtBejuNChKJNQsDNaOcJi1R80Bun
X-Google-Smtp-Source: AGHT+IEJl3qV8SrZJdhOK5gyplo/8YIdIVm68sTj0GtEmrXBZqk2gOIzg5kBvW3Ft++VPmm4Ax1NuQ==
X-Received: by 2002:a05:6000:144e:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-378a8a7aabemr4849596f8f.22.1726061233097;
        Wed, 11 Sep 2024 06:27:13 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb116f44esm135040715e9.45.2024.09.11.06.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 06:27:12 -0700 (PDT)
Message-ID: <4c4f51c7-62d9-4257-b072-d2d2b5a8baa2@gmail.com>
Date: Wed, 11 Sep 2024 14:27:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [ANNOUNCE] Outreachy mentor sign-up deadline is Wednesday
 September 11th at 4pm UTC
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Christian Couder <christian.couder@gmail.com>, git <git@vger.kernel.org>,
 Git at SFC <git@sfconservancy.org>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Tilda Udufo - Outreachy Organizer <organizers@outreachy.org>
References: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>
 <Zt6pbMP3Rpjy-pC_@pks.im> <Zt6rC7TtUvxWGXN-@pks.im>
 <ecf84ea5-2f4a-4a80-b7d4-0198f2fd6ee8@gmail.com> <ZuFju0xlybZ_6Ps5@pks.im>
Content-Language: en-US
In-Reply-To: <ZuFju0xlybZ_6Ps5@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/09/2024 10:32, Patrick Steinhardt wrote:
> On Tue, Sep 10, 2024 at 07:31:44PM +0100, phillip.wood123@gmail.com wrote:
> Thanks. I've created the project and invited you as a co-mentor.

Thanks for that, I've filled out the form to sign up as a co-mentor.

Phillip
