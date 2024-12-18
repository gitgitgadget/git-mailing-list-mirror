Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1F7F477
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531827; cv=none; b=qgzEDy3LKo/ejMEc3e7yKHOVz9L/0kXWfrsuGnFvy0gNtgc0xl7MVUuxubrHfBhP1NJdAXh8Il1HorwOu7u1Hharm0TOQU4wKjuf1uR9CasMyFxfBn/MOdKnoD5fTG4OpvVcLIdFDQOcU9kQH5vzSn8TGD+HhMC8ti7qZ/XVEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531827; c=relaxed/simple;
	bh=qSeUjIqHbMWV0P7zqpaDmhFLCRE43ZkVOHodoV9sN28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idfd7IAx2pS1zJ4j72xo6go1KSK5xiH8yxlp39Mz9vuBMyI5g8sHuTUZ+stc9HVef75gLjvmRfCCtHsxDEIOFn6dlz+Wt77JwkiT4Qg0nCV6Cxy7F7hIQ5v278kOkbaMJODwDOKZ8P4X+oJou3ZvpRZuRS4Wd0n8PSl2JymeimE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieT//8h7; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieT//8h7"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eff5ad69a1so53658047b3.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734531825; x=1735136625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Mjvr6mpRt8X+mxaVm3MeADgfXzGxdOcpgTgY2H+EkM=;
        b=ieT//8h73Pk3JPM7x99pnz4zhh8c5v0urPDM6wGjm8eVQj0w+NbmlyNY8ATGHM32ya
         TD/oNpP167Gjri+EDkkgPl3CDl7X/u8BEta5hjCbRWXQHgZVhiPeZ+oLL0FCH8AUoZC4
         b5gz4F5s+d+vMk2lfSVFgWzfpOp2ad9L7i//rp4wMOwdDwCYb9HKp3u48fSc48scbPex
         9H98ACbOep4TnqsFjB1cMfhyABU4kvxo7qpAboAJANBMbconOE4ElkXxtUiI300KMnLO
         uZtD0FKKZ89aZjyDEq/fb9Q+Cw6f+wzXcsCcLzRQvMHQ3+17EWPpzNm/t4BvWOAnAz2u
         l92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734531825; x=1735136625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mjvr6mpRt8X+mxaVm3MeADgfXzGxdOcpgTgY2H+EkM=;
        b=jNLaAtkNbY7uG/NGv0NscCzrYODZFI1qX5fBekanqiRutrZ5i2O5N4Qkpu4nbll0dc
         HZBwdqFPeuiRri4/UlHEjJ4wRko6g5r/6G5hnPdKFx3ASLlosUemRrIG98q48ZORlN58
         XNDFP48x1tAQ9tyGpa5RXRxuNy+nx+9CWgbw1js0D0ut8spvFWmPV3zy6KE8FMeumvrq
         k7CoH09oEjK86xOiOX42i2dGTjEu+U3pDID2kyfI52ntXvy/xnJbaXpblF9frSuexkYr
         SpxvqLOxlzDxJDrS7JRi0BKaI9KvLlMLA3+j43GiicxWtKZy8GD28HhCQDbcZF4/f2jy
         1rtQ==
X-Gm-Message-State: AOJu0Yx2OyLW+6T6VnK+hEMNvnDcQrD55E3mV1tfr1ESGEdiw+Ov0DlK
	4Md6fMtPLcgix8M5NFZRCRjACIo0NFY5Xk9m1qDV3wUHnDSzvh27
X-Gm-Gg: ASbGnctW7NSrKBbTNLjbBrHvUqEOp2qtnjCuGCf1csg8SW8jdBb67OIIhqabSYU73eT
	CP3Tyub5sDDgOwkXRXQ7LL4c7fAw3WB6OiZGFWedOQx/K/f1LV7Agv+DShuwTWF1r7dkAqUZSUv
	QISTl1QgLmb/jAqBXUPTw4j6kjdV2v7Wzs6c8JdzBlyXn397XUo4KPyiHR6yxS6TOjsdrWF1B1u
	KIx9mXAYOUL4vkby3cpTKnvgWZFdbaZP4H1V67yC04YLgPe41OJuU67q7iFw8kFmZW+gZ0b06r8
	8mO5xgliVGUGVMvjWCjfgslyxATAdDO9y6w4PKTMUReU
X-Google-Smtp-Source: AGHT+IG1RR+01IVlmCxgKcKXaG0A9nB1y8X/T3ae20mvUPdM7Sqk+vEjP4/Xg7DOIigz60FUv8SaTw==
X-Received: by 2002:a05:690c:6c85:b0:6ef:70fb:4594 with SMTP id 00721157ae682-6f3ccc3f268mr25424187b3.13.1734531825193;
        Wed, 18 Dec 2024 06:23:45 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:79bd:fdfb:4e92:f26c? ([2600:1700:60ba:9810:79bd:fdfb:4e92:f26c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f289218cbdsm23192377b3.132.2024.12.18.06.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 06:23:44 -0800 (PST)
Message-ID: <b1ae2658-d576-433c-9180-8adb57479022@gmail.com>
Date: Wed, 18 Dec 2024 09:23:43 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] path-walk: visit tags and cached objects
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com,
 christian.couder@gmail.com, kristofferhaugsbakk@fastmail.com,
 jonathantanmy@google.com, karthik nayak <karthik.188@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
 <a41f53f7ced7a403547ce1c239c5fbb5382cfb0f.1733514359.git.gitgitgadget@gmail.com>
 <Z1whdAJ4RgQlLNl_@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Z1whdAJ4RgQlLNl_@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 6:58 AM, Patrick Steinhardt wrote:
> On Fri, Dec 06, 2024 at 07:45:56PM +0000, Derrick Stolee via GitGitGadget wrote:
>> @@ -194,6 +201,134 @@ static void clear_strmap(struct strmap *map)

>> +		/* Navigate annotated tag object chains. */
>> +		while (obj->type == OBJ_TAG) {
>> +			struct tag *tag = lookup_tag(info->revs->repo, &obj->oid);
>> +			if (!tag)
>> +				break;
> 
> Same here as previous comments, is this an error that we should rather
> report?

Can do.

> [snip]
>> +	if (tagged_blobs) {
>> +		if (tagged_blobs->oids.nr) {
>> +			const char *tagged_blob_path = "/tagged-blobs";
>> +			tagged_blobs->type = OBJ_BLOB;
>> +			push_to_stack(ctx, tagged_blob_path);
>> +			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
>> +		} else {
>> +			oid_array_clear(&tagged_blobs->oids);
>> +			free(tagged_blobs);
>> +		}
>> +	}
>> +	if (tags) {
>> +		if (tags->oids.nr) {
>> +			const char *tag_path = "/tags";
>> +			tags->type = OBJ_TAG;
>> +			push_to_stack(ctx, tag_path);
>> +			strmap_put(&ctx->paths_to_lists, tag_path, tags);
>> +		} else {
>> +			oid_array_clear(&tags->oids);
>> +			free(tags);
>> +		}
>> +	}
>> +}
> 
> So this is kind of curious. Does that mean that a file named
> "tagged-blobs" would be thrown into the same bag as a tagged blob? Or
> are these special due to the leading "/"?

Indeed, the leading "/" differentiates these categories from other paths
that are stored in the process.

Thanks,
-Stolee


