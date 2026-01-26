Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF01DE8AE
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458669; cv=none; b=lFWQD1i1A9bzeNtZRzFDkddaaTArdMibwDfuKDowPQjA4mT3WkehoezF1sFJF5LKTXNavA/O/ZEq2iGDPcJp+NC5oc6kFPA5lcV8HhEc8daSHu0LGNhsMZ2BdoYDFlBJm4U7tQ14YbqolULFQw2A5xI7E7F6VL9Casyg6qkhEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458669; c=relaxed/simple;
	bh=CD9l85XXmBsvEDsbL2L98qeUK4IieQ9+tUan/zFx/ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i+alSrUp6y9NzOpvr1EkMVDzuGPL/gd+WOEbSbgNXNPG4oSaVixkG575Bje5p5DljZUI7LMydqBvVlOtJAlUYyUVnExmykK0CHmfeBrgMRtkDl4eNpFa1+OzNcEbIuKdaNpzD7IJLKPv4r7DyiB2hQ73Sx1gf5uoKr++Oh2mvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBI318hf; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBI318hf"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-89469143ebcso41650246d6.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 12:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769458667; x=1770063467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TJpBeuTG619R4ELbmnFYC85CzUpyPz22vrr2+7xqis=;
        b=MBI318hfd60EcxRexvhe1/ESMqYtTlQzBmBZs8rmEmWLYSOkKlG+mj2E8HbkjmMm5V
         IbzLe6q+FVayDvMg1PS+ti5w3n/4wAwAJPgvdS6rBPQNsZslDUDpxd7/WzlsGVaGU+4y
         ug9beH431qHFfHOPEwUTw1F1VgymIJJfQfFxCgodRYXnPi575+zbE+gWYqo7d2G/LhUU
         eI91Kw/lVvzyY7zzIIaHVeu5DblMhgpdHQSuWVN8ps0ZmEa4TOdM5wO8lL91zWJsf2nO
         F/TOLK9sZpKYQCpaG3dDK1eZiku0M8RX7WAIevatP65AvSsy9RZ9f4UfMLaNFx9ExcKJ
         I9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769458667; x=1770063467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TJpBeuTG619R4ELbmnFYC85CzUpyPz22vrr2+7xqis=;
        b=TgAjE0ljQuUmKb6W302CvWRmMwz2BBuIjMSWlQMgtBIPxmC3f02Bm0ac9Zvx8xij7j
         JlGi7wh6ZIvnb/w0jZdXQ4yCgM6K6yg7ToX3+1QxDtzv2KOXxqOo8RTyvQBKrroBn+A2
         T8PlnKjiqxqh5NHuLtvGSmpSYWsjMGhK3vpg/5n9UeqjsEmYQrPtzTQXjWGBx7j3xErl
         4+x7r+77vbR+EhFIwU9lAsqSOQL4XXwvHs4y+XdQewbd30W+l/TS0AqVa1TF+DlkWzyU
         Kp5v4PxYAemqhopj5KWHXREtM1QVyYwESike5VCS4RKCA81gzrWxq+bvGIv8rOdpEq5t
         4yug==
X-Forwarded-Encrypted: i=1; AJvYcCUO5kBC8jRcBAxoLd3KsY75jSS2O3OSIlfBS3p1NbCwWaf25WmzJ5+MgbO7bR3Eaq2SW/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxESZjJUMqdwY95q9iVv2RZyeRe5QDi9gd2QYhLQteqylmoVHgE
	iCn+M6NP63E3v4Bg3uy3ZgZ/IXhv/A7nKSt0ZyjJBWD/O5JUS7iV0F1J+GOfNXoK
X-Gm-Gg: AZuq6aIr/Clvo1zHX3vNDJ9nUppLPEBsvIkdSmmoBzbwiW5OjFx2/mf4z0sIbpwY4ly
	mPzhk7sv0uZO6zAZOVchEOHt1Z7e5VlvdBGX9dUQg+Kd3mt7Uv93gf1aFGue6S3LMowqdSa0g+P
	7o3s2aC/WftmAbWROCvtUhD4Dlaw9OooryQveTIX/w87a45UHg/si489+ONVBWYvOzBJV/NAFOJ
	SAiAoEnxM5cBEp9odl93qljVLuRJixBruKPmviwBSiobGx6EXNyco68BReV8dGQTYzDOiw6hBmP
	xCAIrGJR1S8/LPzzOn5yJwGFZ35rZ6MbEN8TMJ4ofZi67+eWNzSg/V8sXw2BbAvHB2SkqTDkWQM
	YykwvSddIYcha3CjBQLbyEb3shS8/6DX0EqnWYNKy0vIlPrznHhmDmsytEjyv3t7jsqhPK7raol
	gWNtR1JqKu0tzJq+LAZakAR/STAsXOdSxy+MFegkfywrK20kxNmQiekYOa9Ad9ER7p506T
X-Received: by 2002:ad4:5dcc:0:b0:882:79dc:71a with SMTP id 6a1803df08f44-894b07815efmr79936266d6.46.1769458666794;
        Mon, 26 Jan 2026 12:17:46 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894a908d67csm68865826d6.20.2026.01.26.12.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 12:17:46 -0800 (PST)
Message-ID: <a5b456dc-2158-4f9a-addd-12fb9f408edf@gmail.com>
Date: Mon, 26 Jan 2026 15:17:45 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] builtin/backfill: fix flags passed to
 `odb_has_object()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
 <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260126-b4-pks-read-object-info-flags-v1-1-e682a003b17c@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/2026 7:17 AM, Patrick Steinhardt wrote:
> The function `fill_missing_blobs()` receives an array of object IDs and
> verifies for each of them whether the corresponding object exists. If it
> doesn't exist, we add it to a set of objects and then batch-fetch all of
> the objects at once.
> 
> The check for whether or not we already have the object is broken
> though: we pass `OBJECT_INFO_FOR_PREFETCH`, but `odb_has_object()`
> expects us to pass `HAS_OBJECT_*` flags. The flag expands to:
> 
>   - `OBJECT_INFO_QUICK`, which asks the object database to not reprepare
>     in case the object wasn't found. This makes sense, as we'd otherwise
>     reprepare the object database as many times as we have missing
>     objects.
> 
>   - `OBJECT_INFO_SKIP_FETCH_OBJECT`, which asks the object database to
>     not fetch the object in case it's missing. Again, this makes sense,
>     as we want to batch-fetch the objects.
> 
> This shows that we indeed want the equivalent of this flag, but of
> course represented as `HAS_OBJECT_*` flags.
> 
> Luckily, the code is already working correctly. The `OBJECT_INFO` flag
> expands to `(1 << 3) | (1 << 4)`, none of which are valid `HAS_OBJECT`
> flags. And if no flags are passed, `odb_has_object()` ends up calling
> `odb_read_object_info_extended()` with exactly the above two flags that
> we wanted to set in the first place.
> 
> Of course, this is pure luck, and this can break any moment. So let's
> fix this and correct the code to not pass any flags at all.

Absolutely the right fix for this case. Thanks!

-Stolee
