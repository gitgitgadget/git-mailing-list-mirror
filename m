Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F01E534
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236921; cv=none; b=obM4tVJh15MJ58U/38TbJdqISiMYtiPedk6CqiagSYcuDmmw4QTm5m86b0aIESanvnpjzwm7DpU9ZZdU94ksCxNJJFmhXl1zY8CBNDTSYaML/nDX6FN7qv7BuxJsmr3ojVjsS3MBGvbofuJYapLi9JdRYJB0d7SulSABtvBvqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236921; c=relaxed/simple;
	bh=RW/QdHm8F0NsYfAwgFQ7c25FrL3COy+GoIgWknP0Bu8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OnA/oN6n1Sv+VfA32819PS0XAEREd7h1OYtuxyexEY5I5syljiKJLavraUQzYuFQxhJPzJoq3ZhPDYhNtCoRCnEi0aeQk2R1gc6a5oFZepCAvQk+CFdt8h176ped5dRIPEDYnIueGi/3ZP9mlJRrv/1krcPUlE115iBgiepqdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8cb9+pa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8cb9+pa"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70685423a06so44018b3a.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2024 06:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719236920; x=1719841720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RW/QdHm8F0NsYfAwgFQ7c25FrL3COy+GoIgWknP0Bu8=;
        b=T8cb9+pacn6ngr8kxrXe09B3kCs+adWctsRhZPXwbuIstCOeGil87CqVexE9uwgSCm
         ePgml8IMfI7xN0MVlx1VluVkTJIMJjZKlkqMfNJaOXpGD9NF/qsrJr07tNV/c2LV3ZmP
         4QTlsg1/xiwx+mclQM9YSEahmCQ9KpI277gkmKVPW7IdnSOkbWNr5EjUSjnQmnynWW6W
         5DGKiXFhIX/+iiKy0xMBHEmuDmlVI221qD7J+jvSMhcGAuCdXh4P2H1j/g6dZjOzXKm9
         dyk6OeNyl6x6FRvsb0pbiQRi/qz/7BqfTOEVxHtTufIGQLAJzJJRBW6+cqZj4Tzz/5v1
         pvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236920; x=1719841720;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RW/QdHm8F0NsYfAwgFQ7c25FrL3COy+GoIgWknP0Bu8=;
        b=FU4VtPl+0XjGIHwqh8kRB+r7mjgGQMxlcQV9no4S1/Y8hrb/YYl3zWNuLoSqFHxFUY
         PDRHa2Zip4fd+vCxFbRAUuqUaC4i3fejNLniAyxaQEZWsFEuSgwcYCWqYCD0QA9VzHiG
         4ujL3ogRAJaqynfHDSPD0ABmSGG2+j556Trskz/oPSpEhE/w9Bv8QlQPpZc3WhAcpGs/
         p+ppJn3r6T1+qCVSF+5C613J1whTO+Q4vmHlOK3oIixe/Y1HerZ1NNMogw+R9lCIZvSy
         XzgJLgYRJED5FmTrQM2D8E6yCxa2zx8Fqo2QqhAA8H7dW00k+C2SAer2tk3gE4maiyhg
         sRzA==
X-Forwarded-Encrypted: i=1; AJvYcCX50/sJK5zwQn9SeFjDABTLlPahejdIH3GA6Y+xx5geUyqEaqmybLIgcyVJb8oNC0ah9X1PH/uvmELwVzMlrwjo2hEu
X-Gm-Message-State: AOJu0Yyh/p6Do+tqD7trF93a31nVvZ176prmFis0Mk/OeLZCTQVdxZdO
	eguXFa7f0c1+NXLYOfttl5x8je5icxyvOgjjfSIpj+HNVGzcTc6v
X-Google-Smtp-Source: AGHT+IG5yNTKvst/v5PonXUnSGq0TftH1kX5flEnWtFdxqek5PHREBlOQDN0SFwA1uUVyGYEvpn7oQ==
X-Received: by 2002:a05:6a00:8c0d:b0:704:21c2:ae92 with SMTP id d2e1a72fcca58-706649a6b01mr6547879b3a.2.1719236919584;
        Mon, 24 Jun 2024 06:48:39 -0700 (PDT)
Received: from ?IPV6:2409:40c2:1f:653a:6a8c:bfef:e5a0:901c? ([2409:40c2:1f:653a:6a8c:bfef:e5a0:901c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70674f9abe1sm3044467b3a.59.2024.06.24.06.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 06:48:39 -0700 (PDT)
Message-ID: <735b4a95-fe8e-4bff-9dd3-10ddd4bdb5b5@gmail.com>
Date: Mon, 24 Jun 2024 19:18:33 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] describe: refresh the index when 'broken' flag is used
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: phillip.wood@dunelm.org.uk, Karthik Nayak <karthik.188@gmail.com>,
 git@vger.kernel.org
Cc: Paul Millar <paul.millar@desy.de>, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>
References: <20240623214301.143796-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRGramQ3MdzzXzZ19yeUB_rQZPbZ3u=eA=T2SfV3nhYOA@mail.gmail.com>
 <054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com>
 <69662b07-e216-421b-b947-afa52e56d7ec@gmail.com>
Content-Language: en-US
In-Reply-To: <69662b07-e216-421b-b947-afa52e56d7ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have a question:

I would like to change the owner of a file
in the test case I am writing -- an operation
that requires super-user privileges.  I am not
sure if it is okay to do that in tests.  Since
that would require running tests with `sudo`.

What would be the correct way to do this?


