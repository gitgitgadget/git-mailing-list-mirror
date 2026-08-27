Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554F747013F
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836381; cv=none; b=KhFlWYtreVytwGDWl7ZaAXqEYucxyAPPfZqmKrb07Rwvf6SE1xOoZNRtuuFqnf0kN/dryI0R2cqXwNVQPEzK3uVBC9YZweS8EJz245nUd2EcXH1sFjdw3LuYEj/1B+VKh7djnoEFehO7dDmNvjhkpy53XWLEPhXWpc49Zm94doU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836381; c=relaxed/simple;
	bh=hXdGnZtd1YfWxpPu6dKgmpdFkE1b6TTtnswUy9eIIH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U0V84lyoBBFc+QYZKDTaPLFuUyCoV9kkRawkZ8H0migsBwVPlH20AYihDDfSWGAC60DzLMhgAhgaZKyTWLt+wJp23KOo24q5w7qYQKmGH+AnzL044HDNDv56e+k9xU9atOo2jQ55E/DqjV60CBJRGYwAXkVpWpQ9C8f+FW+7daU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0x2DzG1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0x2DzG1"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2531f453eeso92416566b.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2026 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787836367; x=1788441167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MNbTTlwC/eGrigJ4LlaR+jT8z02WneQub34LW9G5s3M=;
        b=o0x2DzG13pQ9VLQYJ8QmAacKjQ7wrOl3cbdOdFCeMlEe0vcCQYlDB/icMXsDsjdqdS
         URhyzTn8srbRL9BUEKaOAjqej4lN+pBeyp8KIkKrjelL9ZZThcHuIoaqQxmY8hUQCSqW
         OigYEija7/JykN0JvBPLxfFVn4/H2m4DUGVfd2bl+BdmW/VF0OJ8umLfIcvOGRKWx1Tl
         H/nBDFyVVNk+Xfp5FeFA9NsJAgwzA2CnM5r0pLJYBFspEh7hJVXR+jK3d4asdP0exV9Q
         1FaSntXnsqX3evC2/h3Ph8tPlQmSoLKIEGVywJy4p3xnKDvGXwxFObfZyecBYfAl4+ab
         G6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787836367; x=1788441167;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MNbTTlwC/eGrigJ4LlaR+jT8z02WneQub34LW9G5s3M=;
        b=hkxQYZQb8/9wcWw3I9Mt5OTj1ShiUANGISRND/0LRQ0ObgK0Hau+NMT4jVjypfDlDu
         5M/bCHcNBO1AuyxohHyIa28kRqORFbsNUg09X58T5g9KP1u0rdFByQXd4QUTnATajjX9
         Y2gK6NrUfksiRIPQweDT5bC22TX09Kl7laJ0S6BCwH3r/KOHGROSUDKNUx+hWEvQ+4PP
         aKtJZY+CYHwJpzJ6onCPGPy8ZFXWbXloy57/T1SJeQITwgzdkJODRglh3msJc2DPY3Ai
         I32dsQfSqwIUvidcdM3m3UycTIw7suKR0Wgj3Ocj3w3ni65gjBZbBGUt5oU22kY09jsD
         t4yA==
X-Gm-Message-State: AFuF++lq0zRKkm6ULVdu8WImiNYX5g6Mp6KgO5sEpYBcS7p9YSlUBw3x
	b067zdR3NN74Bux3RDqGov6V3BppLhmkRGc2V3SFCWmUI9Yb++oXrkEn
X-Gm-Gg: AR+sD10NwRX6LePV5u+PTOLJTOhwRZ0S9O+r50r2or+LA3gdTPwY7VxVQxDN5Kw5z4O
	zSEbVuruEu6kugH5d2HVA9GeOMWzRuOSJPive8XlzLu71d3nmXqA/tq5aaDA6QdSFavOjJHW735
	cZ/pELGPEUtCE/NM3RG0bF/xKipJ4U/7ChAt055V3oLuxRsB5poOoEkMdK7RdcaZMMCya3MRW7x
	SpxXOeN9egRvUlGYw+aaD2L8spxNo+9auR6H9IPcLP1X0RGjlRB7g64wVq9kpJJMEuyQTKdJeSA
	YV15uQLqyKlc8sHMGJ6P8l1JmqcIBsERR7RCnY8z7DVKSWrqVVj2VUCnJtpzkj6JVcITo+VVop9
	kIJ+FmlwjdeNAKcn6V6xM2G2Y15IdpHrrbdJFWgRvq2FL9IKarEsErQKU/CSWb+Olj+lNtKEP6P
	RDm1esd6h2SHOYIjuUr5aq6gnnXSih4731KgcL/BqSuhb3sKIi70m0I1zVrHetJrKoGGTpULWGG
	ALff1HczNqDibFa1oR5hEmZz0NDVQ6lcvE584iFoVA=
X-Received: by 2002:a17:907:c807:b0:c25:4e5:fe33 with SMTP id a640c23a62f3a-c250c352a4amr1473759266b.24.1787836366874;
        Thu, 27 Aug 2026 06:12:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d69a7sm1087087566b.8.2026.08.27.06.12.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:12:46 -0700 (PDT)
Message-ID: <9f73c4b4-0336-46be-b39e-6c648f6a69bb@gmail.com>
Date: Thu, 27 Aug 2026 14:12:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] checkout -m: refine autostash fallback
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <xmqqld9sg0di.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqld9sg0di.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/08/2026 20:14, Junio C Hamano wrote:
>
> This topic unfortunately has seen no interests from others on the
> list.  Asking Phillip for help, as the leftoverbits comment cited in
> the cover letter is from him.

That'll teach me to make suggestions for further work when I'm reviewing 
patches! Thanks for following up on those comments Harald. I've left 
some comments, in short I think the changes to the error message are a 
good idea, but I'm not sure sure about the other change in patch 2 though.

Thanks

Phillip
