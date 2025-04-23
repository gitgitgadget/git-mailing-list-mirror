Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289C7253921
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441440; cv=none; b=t6mzYp8NkCREBCyzA6MbH6oj8x1/CK0et4CjeWBNQF+YIBqJLXSFkXHvFNM5cAlo3zGDP1Ch1CWnTTcI3BMpcPDfhatesAN+hLLJxdiGTx0gpiOhoTMYe8vRfBAiNoBM1uNyOwB/kQe/vrVgWIkMwZjEQ8ewyrWLu3K8JjwwQMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441440; c=relaxed/simple;
	bh=BtM1ivSbUq+VQ7xSSlRrJf7lwB5a5tEF1ZOz8cIE2Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unIti7KLvNtlSgAHUP+n34jbKAMXPPybRZTNHLfYEdxWsGLjGsyPMTE/dghZv5+BXifDvVQDO9O6zESF/dciFu292f0gYXIdLZeMrvv3yFfoolBwgOCMhK+OiAl81zIcbH6mH1680OfUj9h/5cnNZ/tMbLUkWHbGlzQ/7zfyQDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6U/J68a; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6U/J68a"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-acb94bf784aso4438066b.0
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745441437; x=1746046237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fAknDHBcIMuMtsZSszkibKVNCa30JlDWYzchC9xCzCE=;
        b=N6U/J68a6hXpo2rjO61bQ1PKYroSEQIIQ3C/aJM25HJJeXZiSRdBRBM+A+Wgx4v0PG
         v5eiXGEwlH67rEOKHvSAyqLcWcJG/Fld65xNNYH6sM/k92iSjIhJY9TFPBCm8Yg0Nw8G
         iUipYT5q7RC5v9A6CqWmeYd1w+iuYeKREpgc2uc2QxBnj4euCvawiafU/xiK7OzMD8tx
         TfUtDW8pVMKUXUKRd3ASsv0VTOVDvVTELXio+JzMbLo+DMy9D5fkB3JXE82iuXzbcOGp
         d7uRo4e+qQyK2Dfnyjgf8oaBgAA+2iAuPcaG63EY5yCjrJtMCHhuOTjbLVQq36bDvY3Y
         TOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441437; x=1746046237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAknDHBcIMuMtsZSszkibKVNCa30JlDWYzchC9xCzCE=;
        b=ETgWENj6AKROffs3GZ4utiDcer1qMlrkHjhSv5PhC8486tkqZy+k4Z9aO7IZbyPFE2
         1erkubIT2Uc5VaZw//c+SUyxU5mpMHj1IizW7wzX5P8f1c7826evODWbGdyvipJk4nq7
         q9i6VTUBIKKWP74n7Pmkzl7cEwwVEYNyLQ5GQ/dL/3nrjXfmzprjMcla+LfxJjeJdpsj
         ypUt82e8jpmMxDtes4k7T2Fj0mMBLesU7uLCRhJUJmY16XFLll5n04WPkUGfoI4hlP2m
         B+dEGxl3ft+f47+V6eHOa5oAv/MORek3v0lSwFfeO7IdaVnHQF8BUYm26J7vP83sUUh+
         BC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdok26iy3YQSh5DaBHXR6w9IvG7SR4w8sOemocx46tbAgFdP/YKIQEi3GuPKyjDlANkEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHtVvQirStQkQBA0oUFJfZcJGW0CLAkkzmVZrMSPYMOWAW+gE
	wia+AxziGNvunpMHvb64vIte5248Yd3C2e4gKKFj+yKgzRmfsqp5/uLKB4yynhGT25ha6BJNb8u
	Oi6S9nWgQA/HA5eMoPw1Lrur6ohg=
X-Gm-Gg: ASbGncvGPHVXbkFH3zssJ0bc/eH14Bu9S0rvFCgZ6/1/+thSi0MY30WQPJYcRzfCfhV
	4EvtqDPDWDXx0dOLuEmLguzqlKG3rO4dDawiO+A3ci7KBFoCZnH9boD2p8WdvVlFlBTmOhuBfm4
	J+Tz0vIw2E5u6d1AQK1jFFrQbDmcv3Hst+4ABwdU0kPGFeUAf1/WUZyZthzGojPg==
X-Google-Smtp-Source: AGHT+IGKJLZizp5BNf9jRS69uodD85dRlla6Ekfgl/4NlODa+L/srnCED7Je1qGMcrWd3NUn6NXRJ/3rr/Zmk+dAQVA=
X-Received: by 2002:a17:907:7fa5:b0:ac2:6bf9:e386 with SMTP id
 a640c23a62f3a-ace5728b964mr7138766b.8.1745441437070; Wed, 23 Apr 2025
 13:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
From: M Hickford <mirth.hickford@gmail.com>
Date: Wed, 23 Apr 2025 21:50:00 +0100
X-Gm-Features: ATxdqUFYJsPXSytMgDJIruAhP5d4hh2k6SHC8pOsf5pu-0c_BfUMTSvHb9o1icI
Message-ID: <CAGJzqsmgPfju6NLU9j9qSnJzdnKerGN4cks-e8JzNBx44A0vOw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] send-email: add oauth2 support and fix outlook
 breaking threads
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>, 
	sandals@crustytoothpaste.net, Shengyu Qu <wiagn233@outlook.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 13:29, Aditya Garg <gargaditya08@live.com> wrote:
> This patch series includes three changes:
>
> 1. It adds support for Oauth2 authentication, which is now compulsory by Microsoft.
>    This patch has been rebased to the latest version from the original version
>    at https://lore.kernel.org/git/20250125190131.48717-1-julian@swagemakers.org/

Fantastic!

> BTW, I am sending this series using the patched send-email by these patches from
> Outlook!

Nice. I notice that patch v4 is a separate thread from patch v3. Any idea why?

Ideally all updates would belong to the same thread, as at
https://lore.kernel.org/git/20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com/#related
