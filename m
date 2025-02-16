Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C79450
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739714014; cv=none; b=plnn2L1NDtPc7QmDKQYw0Ea4pPm8FRx4i3/wsk52QjT6E69DggROMyljzbNN9s6lfgoBf8QkiOljCq8bw43s0EWUn22ePRbF1oM0etBv/bNDXbBryIRRMITFuRecdPI4IhTGLk2oVYdi73i2bJu+Bf2/YtkVFa4vzT/b9KgZAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739714014; c=relaxed/simple;
	bh=cq1yo9CXMo7SHrPEDwUtZ8oKlViMufF6H41kcISCDJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIGneb1yV34cDtl9jNDJDvGRECIOKOP1Fu8lUww8J0JBXe/HHzbtLgyCJteNqD3ensrtaAJXliuCSrtGQquGj5jt0tDdaFPq0nnWfcOROnpLA6rC9eTuONstdYsBZyozAuFtuAzXIn/q1hs/8QME4PyX5fu/Nx0MoY7rlQbl6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFPJ2P81; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFPJ2P81"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2210d92292eso23198545ad.1
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 05:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739714011; x=1740318811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtDGnxAhvZTagoULHZkAp9S1PFTd29skCF3sGmrLWwI=;
        b=eFPJ2P815jUUzDWMRkHKy0tT8DSQt/hvAs17tUpZ/b60FhxHTkNr5CHDetu+Ijg2yX
         HmNQv4AkhmRr4n196MF+R/+ZDTplJ/JDhtRUWrYyN68yCGya0ZWh9yK98a5HQXQAnOIY
         AjINsPq48g588WNcimQduUbfSWZaD+QYtSdb1xg8J5qAjNlH8Zq0JaHKa2xmB8x+0bCa
         CQoyQuwmeyGUl9M6zi1MxIUMFC417ANKCVVtfaz4JvzrdowNj/24VVRPjkWvOjvHck80
         Ffr7Kl/BVP/N4V31ZCVhWHWQokWqDpPw9puR+0iik7yIa4RXGom1/bDV2DPoXkm1Q5lM
         IYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739714011; x=1740318811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtDGnxAhvZTagoULHZkAp9S1PFTd29skCF3sGmrLWwI=;
        b=L1510ruD/EGsYB2yBzIu9MdYqxet07JBVhoAlAMFfYkPkmSBRotg4n7nyaNtebv9CY
         mlnH3iV25mR4HhoKpMcsl6ztr5FjQFTDe7lTg296FqfnZB8tYqS3nr0T/O06JY/XxDBC
         7bsNtR6Ujsc0nNUpk04Asdfm5aUQFjX0L/EoldZ/lF0ckreeZCuaYMLuajC0aJTzPW2i
         HM5FM5x2vEUUriA8du4Q5z3xH/X3e/zHnYdortIE8zGCwuxS45EMK+KsRnZPRrtcIaLE
         sWYfG0W0PQ7eUrqoxgxpX6ebAFIWBO+U1/NXnDYV5ATqcVICmpFJcC8eyGOwGjsJ9sdc
         vqdA==
X-Forwarded-Encrypted: i=1; AJvYcCWFikMQXwziVNyi33QvoNLVQb5L7edv+0iWI6mr2+w4F3GGCtGSl5bYONQUNVtYxLGlyR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMu7JxWeXbFzZg7TRgsgL9ED3fFdvPtbwHNiqROsgwHmlskMIk
	38XzHvXQTcVv8ato1stScLWkkO4br3XVHeINLGfpxUmpdzgLtIaw
X-Gm-Gg: ASbGncuND5JCImjzfCoZ0sba8Oz6KIA3zcovqhSMpypms/u0L43oA5qLvt9FSzZGdI6
	3227i2lVYLDyXSxrrXVBr2xUZfYLAJMmM/oG1EFqWiVAEGoBBpGbWBJoQy7i/iZBdkB2IplR9dy
	pIbPOiJACOEp48Pu4H8XnSibxuEGkWUVuM53YaZeKe3R37kkDIyE/57dn/HaTK+nLSGI0YZ0tft
	O6TgluV319bCc88plYEKHT5ohceNOF8ZHqjLNbGSh9EgmB1K/A/v4E5Xhkh5DHYBjG066J/9MFl
	8uenNJJaA11kYRYW8Twt3Rdy
X-Google-Smtp-Source: AGHT+IExdG9Uxnjj/BiT9EkySPfuH++CqrJLz226XgtbXE92nJsGiu/5UAAzoiUGSVjQqO7mnmgLmw==
X-Received: by 2002:a17:902:f711:b0:20c:9936:f0ab with SMTP id d9443c01a7336-221040d6a6dmr93979925ad.47.1739714010942;
        Sun, 16 Feb 2025 05:53:30 -0800 (PST)
Received: from [192.168.0.7] ([106.51.25.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220ddbadcbesm53274135ad.165.2025.02.16.05.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 05:53:30 -0800 (PST)
Message-ID: <59004310-f270-468d-a248-c83c97de4a1f@gmail.com>
Date: Sun, 16 Feb 2025 19:23:02 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git in GSoC 2025
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Jialuo She <shejialuo@gmail.com>,
 Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com> <Z6Xmrfut7jdsVAfg@pks.im>
 <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com>
 <D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ghanshyam,

On 16/02/25 18:26, Ghanshyam Thakkar wrote:
> 
> I can co-mentor this summer. The 'Machine-Readable Repository Information
> Query Tool' project seems interesting to me, although I'm up for co-mentoring
> in other projects as well. Let me know if you need any help with
> anything else.
>

That's great to hear! Thank you for volunteering. I've added you as
a potential co-mentor for the project that you've mentioned. We
could discuss about the allocation to other projects based on the
applications that we receive. Feel free to let me know if there are
specific projects you wish to co-mentor in.

Also, feel free to share if you have any other ideas that we could have
for this GSoC.

--
Sivaraam

