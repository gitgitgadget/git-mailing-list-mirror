Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E934C9A3
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651151; cv=none; b=KuKkEq5Ks8HoiMoLch5seIvxhRC8DNWr/wDIt/y3mC9e+i8q+u+4PeNBbua9PI4NPcJlDvX9HkXjkus1HLTrCl9Y4w7niXI6pTwepvx4zFlNUYwXmoDuYlFF/TRVt8x+ZBZbWQDWi+FWB36laRsaWSLVG9PfN08Un2GEnjY3gxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651151; c=relaxed/simple;
	bh=EW9TmYd73JYZ2LIysoDQbtlnLkTvM4UxxTw2AhaMzuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCK3WtOSsm/t1qgIZZU8wvALbQTcMSHO2mue67keYBevlTDM2UPBpxusmtkNx8JDGrQc/uxnC5MSBueKcSCP3DzV/0ZVjmby9ozuRQb8j71e2hbTpxKSP3iTEsxfVR3w2hgEl9x7yPmWDYCCFaNe4ZUSyICd/SIC/GXzXGflogc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr5Cuf3j; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr5Cuf3j"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c7869704so859803f8f.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763651145; x=1764255945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=++PNzTR6LZiC0xTfdlp9Vx8rEJ+dywNWV6ujEQ5PXlI=;
        b=Fr5Cuf3jV75Bhps6tbnguyr/TmN57rgIw2RuBG786cAUfWnyQnuLG4LAMZH0uPcplA
         psGRpkxnHR2orbClxa8AmX9+2vJaRXUnQk0Wils9f+tSquy/tbMzdTmcosMnY2aWxMiR
         9LNLTtBk/luFlcs/aBc3QrxRgwEHw2VfN4vRn0mj1nkkrKyyuNqGb3lRPa5gQZD9MPA7
         Yr0c/rD1xMBjPX+idZgScPakptUijzKrP5oFnpvTzli9ZWsiuI2FIJ0oLxNIf4RdUvkA
         HqMBtB3uyec7nxpm8trZ1vfNEHl80M7PVhmLavwYM46HM/WwbbttkW/iZVhMTh0uKafX
         Ds/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651145; x=1764255945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++PNzTR6LZiC0xTfdlp9Vx8rEJ+dywNWV6ujEQ5PXlI=;
        b=uvZrxhxvK4qo9ClO/Fo7SU+Jq18pRxZgc+wH+/yQ3+S3kQ/2G4om4kXPqJBCKgIK9l
         yA3N+d6hY/ROZYCNY9dk5+NN8QXT6t1dJTTTh91Uhv+X70oOUIDa08ZKdUgrV5qG/5Mp
         IfjX+Ilgg0N+CFwEUkX9PuboDrhTZ10kHG/3xTx5ayhuXR3C5p0rMlw0cCx7PteDKpdV
         TUtPRDtwKz9c9PmAdNzGCEYgteUjjCAWbUNqayChMeXFiDrS/4L4dM2OomDcMnlkUJpn
         yuiGff0rIs9MFWnc5Jq1gHwvjpsIpxx8c8fW288YFjbm/RoHlJZW3S/A2UzAlbeCQlJT
         81tA==
X-Gm-Message-State: AOJu0YzC45+VmhrUe1rRPpADIVWDcsywDb3n5I1vtNF8ITVc6lW9a3Vp
	1ZLtsyDR1XdFlAXO2iuuxg2Weq+DG9FrrrNcOSTqYS7Hy20SIV5ktUwf
X-Gm-Gg: ASbGncusAu61vOIWYiE56FKCw2edTcCCY8tZ1ycOSV0yxYv5uR+iBnIU3cG92ZyELyK
	a2ngiMw4jw+XgKDWJs0K1z3NX6EnRMApzJmtGiDdqVOuRl3BRxlzZsyrl2aII41xwKIULOaHLtr
	Szl+Xvtpc8B1Sq8yGpBvISqQTnyMnYdiGh80cNpTRJ4QFVUfw99z6ZMiFy/1SikxnA3WTNMhjcp
	2ackc5wH65VRkpWawtpnGSYIwMnEd2m4eqQ6MLWpXfYrBydMXUIFsLxp87SK2IvQIM0OWVP8jtU
	YHtJ2EuNX5CL3L9GuTeKTBuUcW2tacgMQPBYMu23USuq9jxTnMQE5YSUZo0DGr2BDXey/S4cWoy
	8kewXVl4rDEBJydcZT1huzc1NVgQogq5Nik/Q3/1CRdvUquWdGp6mPnNlrUzzcCKssCajl/XC1I
	m6AZDtKxegPAPGM+FIaN7sjmT+s3ygUyHOpnBUG3ISRzIKFM8/gfQWjvNTKnb02tQ=
X-Google-Smtp-Source: AGHT+IHWYKl42pqE8wv5/b+zE5KJo0JgIKf0CG2TWIX9zHgaU29htExVI+7dn5KJClgDy1kfoxf+vQ==
X-Received: by 2002:a5d:5d82:0:b0:42b:47ef:1d53 with SMTP id ffacd0b85a97d-42cb99f554dmr2774135f8f.16.1763651144868;
        Thu, 20 Nov 2025 07:05:44 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm5993860f8f.26.2025.11.20.07.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:05:44 -0800 (PST)
Message-ID: <40695513-d16b-4fe5-b98a-c6f789e3a44c@gmail.com>
Date: Thu, 20 Nov 2025 15:05:43 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 09/11] add-patch: add support for in-memory index
 patching
To: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-9-407dd3f57ad3@pks.im>
 <CABPp-BGRnx7+qvFcDeWCZEZm1aRn=kRezZ2KZA0E=8hji9Vjiw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BGRnx7+qvFcDeWCZEZm1aRn=kRezZ2KZA0E=8hji9Vjiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/11/2025 07:04, Elijah Newren wrote:
> On Mon, Oct 27, 2025 at 4:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> I'm totally unfamiliar with add-patch.[ch] beyond what I've been
> reviewing in this series, so this may be a dumb/naive question, but
> why add a sibling run_add_p_index() to run_add_p() via
> copy+paste+modify?  (Or is it not copy+paste+modify in some
> interesting way?)  I'm worried the two will drift, and I'm curious
> whether run_add_p() should just be calling run_add_p_index() and just
> passing r->index for the index field.  Is there a reason that doesn't
> work?

That's a very good question. I also wondered if there is a way to 
prevent any future changes from accidentally using "s->r->index" instead 
of the "s->index" but I don't think there is.

Thanks

Phillip

