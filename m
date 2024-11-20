Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1416DEB5
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108411; cv=none; b=HVj9T6gzW79wLvdp08L12np70gLvkua8E48FIXzWJ8K0+a+5/WgSh5KXXnje8JBkk6XOsYsH4CbCelG7TGUIFw1GF7nz5tH1s7SKmn/hXxShyHVAeOpFhraF25Z7ZCqBpT5F3y7aLpYMtKtYBh5wdqx1Tv9p6Q+JAFIs8a7RymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108411; c=relaxed/simple;
	bh=2z9fHUR3bhQj4k+H1BUkW3KtqycpyYAn1YPuEyWyTaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJy+JLRdH07J87A94WUevQe6HgtZ6GDOKG3UzC9AhxtMHjtLTJMCGXTlyviv9iog/7QO7aUSAK3f8+FdUkAeB7TufmpjcIAY4xh9/1Vx9/xs3aVle5iT0ZAzTLIaFS61ZQlqVw73ukPTu2KFt6hwANySzN1QEcsRz89cPNzZz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnZnycQ9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnZnycQ9"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so5052625a12.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 05:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732108409; x=1732713209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H9j9QyBOFIhIayDWKDPQ42e8piaDjQHb7LR7N9jOr8k=;
        b=NnZnycQ9XJrz/qlO/zS8mHOKhYlWvgTeQVbjCToteKyMTFnQabrnH1WVNnRXlonc1Z
         ej+WQ2MYykiUqiMXBBMWIN0tKyNXW750sX72ehuO0UMdhjxkbRqXAxJU1ju3qyy6/04x
         OjdwPaGyEogKV4NV+yl7QsmsXI+7k5K28RrzWMnqo7pmsa7JSXuMi2xuHcdl8nYQVZPY
         P4j9v9G3Q8ngm77h8JeOV2usDK4Y/5qfiIkUZpmlEXJLUHzDYCysDZjz9irRbYyUZdZ4
         4NLDKIMEynyRwmu8cG0QHFHq+j4+m6XVAtkJxGkVDF3+zcR2ZrVpO2lmuNCedASfzTet
         SEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732108409; x=1732713209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9j9QyBOFIhIayDWKDPQ42e8piaDjQHb7LR7N9jOr8k=;
        b=rrRCpxMB0NM6X1evsbdLXzTWArb8y4z+W+fdGAP4vzZcw5L5QixUwUgjH8f8eP/lEA
         cTzYZPhbwNNDrxobP5mkjFYLEM94keKXWGkkI4Jp37HSrcPne3Vo+MTQFp4ZUCh+65XS
         epNmDnr3I+cuc9qXtNOby5uaQ3MKumDkPVPqy5BqYIgINo0TTPtHg7RBtdBJJnyz0a/h
         Go5V3S+939q7BrN35SECKoYTphgHfU99I5HaaviGLWflO9xKUWw2QSp29us0kicRgy9g
         ytwBN83bkrW0M+VeZP0UUAateYD3Y9TlHrJ5rTIOgd4JxTgDSxhNH65CkS8D4hTYqFJE
         13DA==
X-Gm-Message-State: AOJu0YxQz9iBZ8wze/p3MnUnq7cMYerGJNjK8mvwTNO9Ist7veWjZLL2
	pgjiJjkg7bBrTLnRWwJyyM3yJqcR68iEV0yBR2dnOTjPFf9pLvlYN1aiqQ==
X-Google-Smtp-Source: AGHT+IEkSsgDBzi5bwEjnAsHeULoquO1rPI7zP2M+QcScLnNIuLSumHGXaX8zXo+k1IJnKLEx0HyxA==
X-Received: by 2002:a05:6a21:99aa:b0:1d9:d04:586d with SMTP id adf61e73a8af0-1ddb0625117mr3888788637.38.1732108408957;
        Wed, 20 Nov 2024 05:13:28 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befac984sm1552465b3a.158.2024.11.20.05.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 05:13:28 -0800 (PST)
Date: Wed, 20 Nov 2024 21:13:38 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 10/10] midx: inline the `MIDX_MIN_SIZE` definition
Message-ID: <Zz3gguyjTKJ8RY-z@ArchLinux>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-10-e2f607174efc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-10-e2f607174efc@gmail.com>

On Tue, Nov 19, 2024 at 04:36:49PM +0100, Karthik Nayak wrote:
> The `MIDX_MIN_SIZE` definition is used to check the midx_size in
> `local_multi_pack_index_one`. This definitions relies on the

Nit: s/definitions/definition

> `the_hash_algo` global variable. Inline this and remove the global
> variable usage.
> 
> With this, remove `USE_THE_REPOSITORY_VARIABLE` usage from `midx.c`.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
