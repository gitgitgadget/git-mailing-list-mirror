Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C8F9D6
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030624; cv=none; b=MjSWRw6NO6RkfjQR3FThPO7EzAyDb/uANda9ZR+fc9Ff9inBapGJPWXpODt7Dz1NkJQSCbNg08sjPmmN4md1uV7T3XihyMvDaBLhVedjp+203L1HIXJrCb5gBQG5FDwWL5dRftArMKUvldQa6ug+93qpauy0a6VhVfr3llIHqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030624; c=relaxed/simple;
	bh=Bif75FR+m4hhkwU0es7dMgXKDvYMD+mEvUPQ0MmFjEI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dMFj5CS/K0T4LnYFAlsDtNTrsS/Hni2/MWJVD33HSqw4eFvt5sH7oUDwA/O81eFL6mwTuymQsfq3LJycYtQNuxNYSLZXhrGwNhxK/3kL5saCWslBwuLg1/r+i5mgoF4U4QAHVC5m00NvAiv7NLOWCBnmC8vr9OXhAUQY5hSyc7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnMaTOfb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnMaTOfb"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so2906503f8f.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709030621; x=1709635421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p+dm7DZdwidgBGW5ExMhoWSKofNtmyM4GNX+El7vLkg=;
        b=OnMaTOfb9480PQOfg0qlMF04hPCl8LYzVvzdGYWZcPhDL59DOvQ+5aMtfKlbtIF3mo
         grUIFyJbvAeOOzFsGIvXlO+uub+Oh1P+tslJEI7yxL+KXbot7bgoma0T/fuvBQUcIFN4
         UrdvCPVeWv21mVNkVpuaMI2Zf/gQCpD/ecaSd3dp0vNga/0Lwuv4ISBJGY6mcoAN3nlU
         wSYhkjvP8M2q91rjH2hCrOkbt4UUwfgnglUJafkKq7qYVRrGlT607jPB/+IqHG8xYHKl
         fmiLsbxz9vpAMOpJ+HH71GZkE0mU2Nos/11h/p5FjaXr1dw5fdN1MhnnsNcnkWMu5MmM
         9oPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030621; x=1709635421;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+dm7DZdwidgBGW5ExMhoWSKofNtmyM4GNX+El7vLkg=;
        b=ke8xv7Sq0crGWApfScgFE3CkTT/4ZNq7ncM9/NXPFvq2hMDnrMZpx8+kIhgerl3l+s
         hofBhpOp7Ym09VTd3SQRpgCVgK2PJKrZaiq1nWS17IDGqXlIwG0Pd51hAquKgkXtU6gM
         DLRAq14xmHO7143MOy7QJyWZM0OFH1RErUiU8peh6x59dayUfbSjDccnARdpJQ7gwNkV
         gekS+JSKPq0uSgIAT9fIsPnmtajBeORZNox8dG0jYjZOZWK02FK01swZ0ksD8nZ2KEKP
         EUjfSv4P1SPvD+MdPjwmmIV0IVxKsRoIQkfs9pWFO5MDaH8sTY0lNIkyuHTAbU/Ya2sR
         mHng==
X-Forwarded-Encrypted: i=1; AJvYcCVgOfA8oKzv3pDdxZwdVruVpY6fzcBVzkH+XaRdblN8gepgwKoDM/kRie2OJ2mz3znanCHIc/b61/sx5eZUQ/OwykxK
X-Gm-Message-State: AOJu0YzFO4j3UoNukBcAMgP7ZlCh+IuIrWrUHIq7k5A9Y4ZaY3+zmr7m
	m+6mvXqPAwIOuP8klVB+0TWITRZfmg7WikiamYmpz2Z15uBbuAP4
X-Google-Smtp-Source: AGHT+IHGbGVbUsJmjN9H7jWddXkVeqa+iHKqnpkUN1br8Tho2OP3d+sdvb8r47900T2sv0POr9bKgQ==
X-Received: by 2002:a05:6000:11cc:b0:33d:6ede:249a with SMTP id i12-20020a05600011cc00b0033d6ede249amr5659110wrx.69.1709030621078;
        Tue, 27 Feb 2024 02:43:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id u9-20020a056000038900b0033cffd1a302sm7717629wrf.57.2024.02.27.02.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:43:40 -0800 (PST)
Message-ID: <ded76144-91e4-4b24-bcb9-8eec5f589c4a@gmail.com>
Date: Tue, 27 Feb 2024 10:43:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] 2.44.0 t7704.9 Fails on NonStop ia64
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: rsbecker@nexbridge.com, =?UTF-8?Q?=27Torsten_B=C3=B6gershausen=27?=
 <tboegi@web.de>, git@vger.kernel.org
References: <01bd01da681a$b8d70a70$2a851f50$@nexbridge.com>
 <01be01da681e$0c349090$249db1b0$@nexbridge.com>
 <20240225191954.GA28646@tb-raspi4>
 <01ca01da682a$5f6a7b60$1e3f7220$@nexbridge.com>
 <5e807c1c-20a0-407b-9fc2-acd38521ba45@gmail.com> <Zd2hMmIzHKQ7JE45@tanuki>
In-Reply-To: <Zd2hMmIzHKQ7JE45@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/02/2024 08:45, Patrick Steinhardt wrote:
> On Mon, Feb 26, 2024 at 03:32:14PM +0000, Phillip Wood wrote:
>>>>> reftable/writer.c:              int n = w->write(w->write_arg, zeroed,
>>>>> w->pending_padding);
>>>>> reftable/writer.c:      n = w->write(w->write_arg, data, len);
>>
>> Neither of these appear to check for short writes and reftable_fd_write() is
>> a thin wrapper around write(). Maybe reftable_fd_write() should be using
>> write_in_full()?
> 
> It already does starting with 85a8c899ce (reftable: handle interrupted
> writes, 2023-12-11):
> 
> ```
> static ssize_t reftable_fd_write(void *arg, const void *data, size_t sz)
> {
> 	int *fdp = (int *)arg;
> 	return write_in_full(*fdp, data, sz);
> }
> ```

Oh, the branch I had checkout out was older than I realized, sorry for 
the confusion.

Best Wishes

Phillip
