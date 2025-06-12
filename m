Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B572D322C
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757192; cv=none; b=BfrnXsyY+kfvyubJaSWNb1H9R23snoIVzQJdsUJ4YdZwvCGJOd3YdWrP1qQQlbwWdkaw50YzT4XG25IySXxWQXyVGS440SwuNj0r0S7ryZdTY45itbpd9aQDfWMrtjcRyX5AMJdvKMX8Nt3EMchT3CoMX3H9T69yzZhlWQ3JkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757192; c=relaxed/simple;
	bh=rQsBZuAhaA9FcbRYm27I0ZUPb54ktT+EbvEyz1N7dZM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dCx56hhP4Bs+w8M92enZe1wLevxQrtwfUr6kXpyFqztR5t9GDzGUKiRvlq6AaDKN+I6DE0XAZo7VUIeA1KAEP/UtFkky3Y3CAsgkyabIHNybvKOJlOOdDAOsjf1ivuLQiOXrQ1oHwJpjVXdkd9MY3A2IKZmSJ3TgbtY19kamdg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvRebycP; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvRebycP"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-747fba9f962so1238637b3a.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749757190; x=1750361990; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ER2WQOZGtLeCL8ocUEWLwJVfYk8iuKHCVeM/w1/JRI=;
        b=HvRebycPtTLmKDvhhft70Rg6rkbKtGiBZ8IM1YTCTOQSrlNOV6YDo7NfytcXboP6IM
         M0veOlD+q3Og95An9G4Ni/EaqUOPL5Z/PQjgBLs9C5ZyVdIikd/2kBHZGD3t887oxm9a
         24x9cFHfL+jCPwjTOaw+E1mClXMq3q3D/45zVShxqN4vjyB72uaL+IognEpxpszxcYEN
         G7f7ZJyksZCK57+TZc/YKK2Ae+LF/05+ppn+5Dt+2zMUaoVK4gU475H5Xi/1SqV/s1v4
         rUmGPvDAxz1CYO9NIg4txGWUOoTcMg9fk1WRxDIdwTzS1fqwjGEi71NViVTJ/EjFBJwV
         NoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757190; x=1750361990;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ER2WQOZGtLeCL8ocUEWLwJVfYk8iuKHCVeM/w1/JRI=;
        b=SJf986pm4ne6MeLIo9CSVHRHouOrEv0N1wj88ghVLkheeR9LaJHDW2kKjnX29wdqRn
         7Ab0OTF/QAJuQyy+Ra/L5lDdYEFrTWDawnY40/j2k3nQwEt2rEuTbOqfE1/aWFI7CIeq
         GD3EGCBQpUh3eoyjxcn85y7z6Wwp8QXa2U2BMLSDXJFTAbn05tAXamQEU07UTY6C6/0g
         elG1O3/vnANIJ3IbRlcESYyH0KI1DFmmQtYv3H+zULXU2PijSn5vwcmgCuqZStxawEuf
         toS80SFncbWEhvuXiqn2XU4cxz7Jx5blcPgESmJc5LYZpRlju5sUA6JG6EMuYoxgOOIZ
         +G9A==
X-Gm-Message-State: AOJu0Yy571vtvVNUVN/30zlX/YZlT9Vn393mkLjJeClckkEmBq3ogCZM
	jr22wLBq5k1SkSXw5+uqFbR7hC07rzFhMCud2V/EFIZo8moYyThtKrx5X2XYnA==
X-Gm-Gg: ASbGncsRdc5H9MTPXDYXWDph5+4eR5EzzkzIChIBNNIH99W/GAGhR2tX0pk1rrQVVxO
	GdFBsJ1SstU5WJzc9NHGpjP76YbOXiqMF+ijpCmh2A9Ua5XMotzTLWEnHWD7FA4q+PYtANUa94u
	1sP4zLVg8z5At0LG6kCC+vz/LdieuHrxquyvPw2zlOEtve53HZd3HZotF41b1Us/O9TnwFhGO6M
	I+4A8rz7op3fry1+SVdUTIgGGaKbM0mGRi/17MkrR04IZgUc4hhTUbFyjVx9lIns2rKctl0c5YB
	xL3wc47J4e7IkYEbAKqMGggIrM5CBKTWUVrkXyLb33m33i+4g0qREm4psDnBa9v9dmRgoBX9IVN
	gKmloic43olH+GG3kCow07Y8poA==
X-Google-Smtp-Source: AGHT+IGksZcfniM1dbzOlsfE6kYhGH4ZmTOLXMngU2q1rtBJEDz8TPxQudLkAyo14GvlpcpwqB7gtQ==
X-Received: by 2002:a05:6a00:6182:b0:742:b31e:e9c1 with SMTP id d2e1a72fcca58-7487cf17775mr4078523b3a.11.1749757189976;
        Thu, 12 Jun 2025 12:39:49 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b0bfasm99709b3a.122.2025.06.12.12.39.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2025 12:39:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH 4/5] repo-info: add field layout.bare
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAOLa=ZTvC7Hq5Fz6N1ESzf1s=7kkyZG5iYTA6pzxnKm2p4oMNw@mail.gmail.com>
Date: Thu, 12 Jun 2025 16:39:36 -0300
Cc: git@vger.kernel.org,
 ps@pks.im
Content-Transfer-Encoding: 7bit
Message-Id: <CF0AD6B1-80D8-417D-9DFD-32338D9EC92A@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250610152117.14826-5-lucasseikioshiro@gmail.com>
 <CAOLa=ZTvC7Hq5Fz6N1ESzf1s=7kkyZG5iYTA6pzxnKm2p4oMNw@mail.gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


>> +#define USE_THE_REPOSITORY_VARIABLE
>> 
> Ah! Seems like `is_bare_repository()` is responsible for this, it would
> be nice to not introduce global dependency in a new command, but this
> isn't part of your project, so it's okay here.

Yeah, to be honest I was reluctant to use this, and I tried to find if
I could easily drop this dependency. But this is `is_bare_repository`:

int is_bare_repository(void)
{
	/* if core.bare is not 'false', let's see if there is a work tree */
	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
}

But I couldn't find out what is the dependency of is_bare_repository_cfg
on the_repository yet, but I decided to keep for this RFC.

