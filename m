Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBEF137C2A
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231655; cv=none; b=eTrTMZUnqKsmSvFCmloWL2nqifUgw4WTqrDyDLhZaIMbJ6sShhOac62/UTpGQkWXK9TOCmOPhhKaVEMn/qV7xQTRlC8jA/EGG2kB3Oegi91WdGyQpYj54usrGT11Us4nz2Jl6cnzuPZ85h28QVIY3hPi9V4Vzk6RBqOB+MBEJ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231655; c=relaxed/simple;
	bh=TxhwlaQeTab/06Ed/W/S8WB7Xb2fAveySyI2HXQY+08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6h5nLrwpifir3hJzdVf1Q3RnagkmtoGnpyCMdPwHe9A5ic7Se/WdMgeRQ9s8t2mhAmphzQiRL83FFHImgLV7tNzDHVlRGVOJlWqkMZEZKbn8ANBVai9UZOdrPquIrimCkhmjDSrl+5Z495H9LVhB1WIhOZkKzbrTKKqje7w3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSvrB7NY; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSvrB7NY"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25cb022c0e6so497873fac.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719231652; x=1719836452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0rbSn7nnG2CavXdDD4vHXJ0zslqa5BOSniaJ56xzII=;
        b=OSvrB7NYLhF5yDfqhoA4wNY1hqmIH33TYYwerFs8w8msx58lrg9684Ijv7QSo4gr+w
         qZPnVVdahf+d0h81PO8+4Czn4gL6QBnaGsE8Rm5lTyittuwh7O1F/QvIVZKaWBihF7Po
         ZJi8aChm6aS5CbPGDZs6DGzzq9hEg5ZyWztcizKYWzX2P6OpZeMDmfubRoSvXGsAQQ90
         iT9wgUX+HvByvwKY7vOrO1+HdXm/AUUjyRUZLl0SlnzC2TATrWp3Gh3/qFpgObnPxOex
         Pj9gkw1NxU6uPx0iuouAFNmEA5IAGqhiwwKfpN68ks2vP0XhPCfsHHQKqSccaordux3F
         /xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719231652; x=1719836452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0rbSn7nnG2CavXdDD4vHXJ0zslqa5BOSniaJ56xzII=;
        b=ZjzTgSgxnWbyX3v8wM6xWyajHgoCbLxalArFP41bOZ1TYWJgxcUeHXQBwv720Kqd/u
         cZSfW3CmDhCbvRxQogfxhp3FHsj0DzJNcbvsmhID1WZpvmVpkVM+cOKBbxlymlaABTHp
         MVb2T4AWiyMLSjBlaRsHmv7WPuTmOWwtqKlTbS1jIAIJoUL9NhXEIZFnOv4HMya1PjJZ
         qMozXLOinIX3KbzILctv7rakmWAPN6t50RnPEMxlCGUN0sgLdkPcwGRig7NP46xn/e1T
         CYqKPqO9Mej3d8TAvrfknQLXhOLXT3xTra1D4fWEyTpDDnqDFDt12uK1wGuhFiumo69Z
         rLUw==
X-Forwarded-Encrypted: i=1; AJvYcCXNVgWKvId40lwzJPOgupgMz/R3Y4Jdf9ORmIm5+QYbdQ4HAYFNq+yx2wDOb0gJNDv1ubKmO/hTSS23iJgHrXqI0p3y
X-Gm-Message-State: AOJu0YzfBju1wLiD0XLOARNIFnLEbzMokJLdQIEz1ELCdI3+apI/c1qi
	Q/w8jspTXprjh92Nba/jqqbeYywbRRY1PNqLScIXSg2n3lVgJvpi
X-Google-Smtp-Source: AGHT+IG4mub7t+gTqhY4NehZMD/oT2Txcs4CEvwfqR66W4MyXTMZv8ldBdIcmGv6AijDz/gXvExaqw==
X-Received: by 2002:a05:6358:9890:b0:1a2:59d:aa21 with SMTP id e5c5f4694b2df-1a233020c8cmr548947555d.1.1719231652412;
        Mon, 24 Jun 2024 05:20:52 -0700 (PDT)
Received: from ?IPV6:2409:40c2:1f:653a:6a8c:bfef:e5a0:901c? ([2409:40c2:1f:653a:6a8c:bfef:e5a0:901c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b4a7319bsm5458094a12.50.2024.06.24.05.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 05:20:52 -0700 (PDT)
Message-ID: <69662b07-e216-421b-b947-afa52e56d7ec@gmail.com>
Date: Mon, 24 Jun 2024 17:50:42 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
To: phillip.wood@dunelm.org.uk, Karthik Nayak <karthik.188@gmail.com>,
 git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
 <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/06/24 16:50, Phillip Wood wrote:

> This is a good description of the problem the patch fixes.

Thanks!

> As we're dealing with a repository that might be broken I suspect we'd 
> be better to run "git update-index --unmerged -q --refresh" as a 
> subprocess in the same way that we run "git diff-index" so that "git 
> describe --broken" does not die if the index cannot be refreshed.

I see, that makes sense.  I will change it to launch `update-index` in a 
sub-process
instead.

>> Also apart from that, we should add a test to capture the changes.
> That would be nice
Got it, I will add some tests as well.

Thanks

