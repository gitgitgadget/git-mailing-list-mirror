Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF717555
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758460003; cv=none; b=DaXVD2DgEIftGJ+UXdaueIWF+cfB0cjk6q/sJXP9BKmz3TKvTIygkzc9qpVwYDb/pgI2DcgXgN4Od5INFQsXcxNHkJidi9AjD7NIzLK70C6byYF9UU+jsYyJpXrfy9fCm+JbdCKlaiLLe4oUDgUYVXmXfuF3ivBXgW+hhnmG+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758460003; c=relaxed/simple;
	bh=C9beZN8rjUx7J7b9hhWd4gcWJLtdI1315BIW8m5lbsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSaQcw4OWVOtdRN2BzVXjEm4ylE5QNXiZox0uHVdNI6sTuUp9LLobxUrwaDe4TdUTUbTduJzu4tUn0uxvx0h6k5QnZvdMm3cOq1lt9sgkV8RnmShB9K+umxDF/sv43XwYxBtRYrWYxjccVOZSh1PWQcJM/lu2qJ5ayKuidPs5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4vk62iy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4vk62iy"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1499737f8f.0
        for <git@vger.kernel.org>; Sun, 21 Sep 2025 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758460000; x=1759064800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3K5TmkOXkHpRuGLdWcNoWohIEEmgKIk8HkPvE7hQweU=;
        b=O4vk62iyc1VJblEmitqSbzkFX7Opx8mT61YYPmHDo9aH4228LX7kPuj5NvM3wjMvQo
         0ELEYzBnBXXNQb/19Dnm0i0fASN2GPe/S1LoacpkI9jamMn83zfat4TNa1Up7QCCK/7L
         5ssnXzAS+eTjSCWqOjKgUdnd8OykICFdROrdSUePmefwAlI3m0zFiWQkn7CZvle/P1HI
         I+0s7t+L1uX5c9MGWkqLL0uJSMa1LWz9QNdv47EZnEGG+DBOo3LZoLDuDbcitjeCkFNt
         FjhRTgaUX1A7gZvHjm3gxCBIg2nOmfFG6VsJ3biF14+pbdghZHjPpUmeQJtplihChTb7
         BkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758460000; x=1759064800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K5TmkOXkHpRuGLdWcNoWohIEEmgKIk8HkPvE7hQweU=;
        b=MXakRWJhsd32bKPlbwo21ngtJOowiEddiYbHB2+qQj1+ySLamVFdG+RMLl66fpiuKh
         2zTXFlOfDKLeQa5HcsVUeK2ETASaZqQ+IathDAxhpqmhjdV98QWXpeVc/tLc3mx3p7Y/
         g1xwimVN8wRWStEZmkaY7ZpPRJKJqWAgWnmu+xIArCMv8D4XyqMymYVbdJHwLk/sasr4
         pKBsguio0iRxRlmISSY+yyWzMkTD+d7ranLnO4i1AKBkwtiLuMUD5QQxt0BYgGvAjrwQ
         oUrQpfoWR0HVQGpkJBSYBYbKFGqVwhBADwbF70zXORecDNsBk4Ex3rWID4vQYZGtY5E9
         16EA==
X-Forwarded-Encrypted: i=1; AJvYcCWhl3QUD8Tg32nrVc+OvBliRRfKXeH/182KwOJOMidTl62ehrNzIcPHeuDfQ22LCWNcMFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeJyaSvRMAeTbwgbaiogFoD/g/Hsf4tkXZsZ8Iphia6wYLV8x
	vIAeF4LwKWhEORygcrMVHRPwOLRgbbYUHLy0Dfxxf/NG4hwhwn7Oyshh
X-Gm-Gg: ASbGncvngB2jW5H7Jc35IJyrQnbPeYl6nU2xTRvSAXGTdejTHsMXBe79jtukHtYLfZZ
	wJ9KieLyxwCtsaa/uZX94+IwspP9PyeE70++uQIKpx/m62uBJJyuohhV2gUtNz1bo48iGb+PvD5
	q4UI6f5qIAhy05BLF3vd44rxz33NMjXl03iQMBOEr1ixPyaCxtiJ+z9b/FSaDka99QP0Zam3grE
	La717dTZcOyx2P2SRqlg2UGLvD1HsrZRB15W5apcicJH7XY5a039AWxBePOY+VccAfhoE1HlxLL
	K5Frk2VL7SywMlZxxBD/LbiIByfeQBm98i6rqFvbsSxyMs6tkyI3v5cFCszcCel+LwQ6/m/7JBa
	HsKbl53LLM4fJqU+cVvPEdIcBeCN46UJwLF2FmYOWgHqCtrZXCCHmyV9yMP5QqFQQLFZ4n2G10N
	RncAVy
X-Google-Smtp-Source: AGHT+IFeL9Ima2/qpkUEB60aN81X4erusc3ulPEAh+693l5acD3rPFMz83dY4yvxVU3nSWli9MRyBA==
X-Received: by 2002:a05:6000:2003:b0:3f9:fd59:7a6c with SMTP id ffacd0b85a97d-3f9fd597b64mr1813655f8f.0.1758459999518;
        Sun, 21 Sep 2025 06:06:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:600d:1d53:febb:27a5? ([2a0a:ef40:62a:101:600d:1d53:febb:27a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a286edsm181550835e9.16.2025.09.21.06.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 06:06:39 -0700 (PDT)
Message-ID: <d22c61da-bd78-47cd-b3b6-adc0d3873fef@gmail.com>
Date: Sun, 21 Sep 2025 14:06:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] xdiff: delete fields ha, line, size in
 xdlclass_t in favor of an xrecord_t
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
 <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
 <e1e94107c9722b751d6111460b17e02a7ffd96d1.1758294992.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e1e94107c9722b751d6111460b17e02a7ffd96d1.1758294992.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiol

On 19/09/2025 16:16, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> The fields from xdlclass_t are aliases of xrecord_t:
> xdlclass_t.line -> xrecord_t.ptr
> xdlclass_t.size -> xrecord_t.size
> xdlclass_t.ha   -> xrecord_t.ha
> 
> Remove aliasing from xdlclass_t, to reduce future refactoring mistakes.

This is a rather nebulous reason. I assume this is about changing the 
types used in xrecord_t in which case it would be helpful to say 
something like

xdlclass_t carries a copy of the data in xrecord_t, but instead of 
embedding xrecord_t it duplicates the individual fields. A future commit 
will change the types used in xrecord_t so embed it in xdlclass_t first 
so we don't have to remember to change the types here as well.

As we're embedding the struct, instead of doing

> -		rcrec->line = line;
> -		rcrec->size = rec->size;
> -		rcrec->ha = rec->ha;
> +		rcrec->rec.ptr = rec->ptr;
> +		rcrec->rec.size = rec->size;
> +		rcrec->rec.ha = rec->ha;

it would be simpler do do

-		rcrec->line = line;
-		rcrec->size = rec->size;
-		rcrec->ha = rec->ha;
+		rcrec->rec = rec;

which would make it clear we're copying all the struct members.

Thanks

Phillip


