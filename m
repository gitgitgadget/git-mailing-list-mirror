Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBA2AD33
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696446; cv=none; b=hFiP9w9iJTu8nj2b6gt3oTgy0O8gqBJOYNsMzPipJJcQ/OVUdTx3ajjsT59yEgr5o8ZBp8vJjouN8KzlDuYnBfw05h+3Ebhya7LuWWeyVkL0TRIux6klyHWnSlW0MajJ46QDYzGyh29zXkg50iiY+SJCDsTOKsBoCTnmzesCD/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696446; c=relaxed/simple;
	bh=Mb6km49X/T7b5HRx3ZJ6TgXhNZ8riOj7FPgqocpFd5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N5IzNfAsqnX9c+fSriU6gh1OP+go8NziKLaTfIoLcphU4XCi4WZ09L94rU/MpsZRzDBOXVgYBc8UXmnN71Thq4AwkJLyCzPQOcH0FbqKvBK+UiADPUMRK31A7UzMiF0O1Zuc+y3mpl7BqTKmCuB0osboz+lpngpf2s6YCy2DtGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtbYUs0j; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtbYUs0j"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7024791a950so1638330b3a.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717696444; x=1718301244; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drKZiHJ8kQ5uUy/ZCwr8beK223T7Y2F9mIs22/xOTxA=;
        b=GtbYUs0jCwAQErHEchB3Wxj5IlWSaeASxbIjx5kdFF+bn6NITs0FuGTGdEjHjWmsOX
         KdoYfO101nZ2Y4xyhp3q9hb7hiCwpO2/G0KpY69jRv9t84qrz6SxkXlJC8k27eADfxZE
         Byr5oGhIrGvxhctlW3PfZymVACW1g7oLJAc6UbaUZ7C2deB1DRv2rKucGESI6SU2YvrE
         266N55vvYl4YX6Fr0/vombaKtGT3eD96/Le3QrLab87eCzxyqzlTA0++5AzUSLHIWwLa
         6atYmc2f5bRxp64Nf9XLkyHLZTsZclFm1KeEjTLz4rvGqckqU7UU0vSRA75oj8yU+I6n
         6+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717696444; x=1718301244;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=drKZiHJ8kQ5uUy/ZCwr8beK223T7Y2F9mIs22/xOTxA=;
        b=sx6Uxn3rCDTTveJLvOrCJtTSuu23Xad/laDiTYwjkD5hq2ceg/ImUyA+xr1eyc83xR
         Vdlhk8PcbpWOfnoye/+j057u7rJiSicIcI98o4wVmo6EFI38LPQD3I438+wNAr9vael/
         5g4VDVoGVpktZDhgLe38ZkoBKWSnf2RwTzwRZcYEAyDKyIXfPH4BxIL94kGsBf9CbuTj
         38VLmaJRtY8rPMq9rnox2h06rpuWlT8aeQ/NYGUwuEn1Oa/2G7qQ2/WS4MODFq6pSYrS
         EIKC7OoGsjoYXuDUYmeE/ZGCTvzy4RPixjPGOELrQVkctEBB34l7ToxDl88sJ9JuMKn9
         5uzg==
X-Gm-Message-State: AOJu0YxUW58W3K9jgcSlT9gu5Hl5793RdcFvAYHy+7geip2B57utZjEZ
	RH1OgcPWkZ0T8MtIdJVvz/xd2UpGFVI796C8sOEaexkgc86MaUEx
X-Google-Smtp-Source: AGHT+IHXI6/wdwuRPBRVkHw6wYGjiZ8lBMxQsmpkrKt2kO25WIsbiZ3yoDbjvlDwzv8TaBo6QLn/6A==
X-Received: by 2002:a05:6a20:244f:b0:1b2:cd79:f41b with SMTP id adf61e73a8af0-1b2e781a5b9mr550439637.25.1717696443823;
        Thu, 06 Jun 2024 10:54:03 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4dead8sm1350960b3a.151.2024.06.06.10.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:54:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 12/27] object-file: mark cached object buffers as const
In-Reply-To: <5cd014c22cb2fc7e34666aa6bd036d3cc4ce9039.1717667854.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 6 Jun 2024 12:28:41 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717667854.git.ps@pks.im>
	<5cd014c22cb2fc7e34666aa6bd036d3cc4ce9039.1717667854.git.ps@pks.im>
Date: Thu, 06 Jun 2024 10:54:01 -0700
Message-ID: <xmqqfrtqlzye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -1778,17 +1778,22 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
>  			struct object_id *oid)
>  {
>  	struct cached_object *co;
> +	char *co_buf;
> +
> +	co_buf = xmalloc(len);
> +	memcpy(co_buf, buf, len);

I do not see why we need to do this so early.  The copy is not used
or buf gets modified by the call to hash_object_file(), so ...

>  	hash_object_file(the_hash_algo, buf, len, type, oid);
>  	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
> -	    find_cached_object(oid))
> +	    find_cached_object(oid)) {
> +		free(co_buf);
>  		return 0;
> +	}
>  	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
>  	co = &cached_objects[cached_object_nr++];
>  	co->size = len;
>  	co->type = type;
> -	co->buf = xmalloc(len);
> -	memcpy(co->buf, buf, len);
> +	co->buf = co_buf;

... wouldn't this be a better place to do the "copy to the heap
memory pointed by a writable pointer and then point that piece of
memory with a read-only pointer" pattern?

>  	oidcpy(&co->oid, oid);
>  	return 0;
>  }
