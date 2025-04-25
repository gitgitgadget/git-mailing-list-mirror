Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1717AE1D
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576248; cv=none; b=lDhawIG6pe4fRICSSXQ4S+wO/q2YIfvt35JtvRml0DqNppOrt0gpA0ZQs6KXeczSpD4XRgObNbYtAv5/PxiPpnJZRul7Ze7kFwVM1mJvlg7cB0TdNxhywPcLhi9yAglKnE4JgIomXP+T4SZ2uzB4SgMc53JrxSGyYXJ83V5e9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576248; c=relaxed/simple;
	bh=fFqx4BPMwEt2UdbpXRITj9YBGcwSg2u/VZnh8WjX2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+miTtDVMxctzBXbwm8khiUW7qcrfW39ZnD/KsSux/Wb5RHJXWfJ4SGyHIyStps1xjYQjJvLP0FMiUxyKAbxbkSR25gmayqiot374zJRQDBsYIeowYsEUVEKGESPeluRSwUWYpDCx55Lw2S15I24Aw+/90l1meTKMcYmEa0e8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efhuNjE4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efhuNjE4"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaecf50578eso315152366b.2
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745576244; x=1746181044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xit7V3hGFQXukM/Glp/Lzh+n0JrbWvc1mkAEzqJrEgk=;
        b=efhuNjE497gdCxQgaHhn59BPoT9D4FyPIu2zdmE6rvlGW1es+mBwDp4BcHbVjQ0Zhq
         3Qdz5hG3pgTC22579dMi0w+O/gcUxkqHCZrJAde5mHd5dBwnlpNqTJRMyJG3SytMWggj
         jwsxOTYJJnirrGriY8rmsyjFvM44O6eNIqTsJfu58oA5ZWsaQetPU7vKWRZmQ4J8mkYM
         BtQX+y4osvnoEhq/gng0EPci2WaicNnZ9wS/lmvggL0Hr90knwyQMJPEaC5LC9CKsVpr
         RO6ud418ftVV6AB72MNMU3VG7wF2xru0a9n0GQYPF4EHPiAIdyBRYtAQURf2Fl18ookI
         MSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745576244; x=1746181044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xit7V3hGFQXukM/Glp/Lzh+n0JrbWvc1mkAEzqJrEgk=;
        b=M69xSGhA569EImePcNFGv3yf4j9hl9uQV04I/NGnleJ6EKeS1At5blSAzGL/Sy1M4O
         vxSM0MB0PZAmwsn5igaWw1StLDKivrbMMsdvyQsSIdFDWZSb9hl7dZ1ajANwH5K9iWqm
         tQ5kVC583DFyIYIAzl7IeOtjTUyrCS9zljOiOXV+MxpO83TkD1/znw8WFQnXDHeLCSMO
         c8Wz+kaw30CNhoMp/cifimhfHWXLmk5nxkukr1lY8OUFKPw+x96S9zUOQwREmbTaFe9+
         EWPyhfbHj8WBmgQwXhAmUfZY5TIAiWckA90Zu9i5inFBU/SJAqVBtMO0+MjxmSkA7asy
         J3UQ==
X-Gm-Message-State: AOJu0Yx337C08ml987cfhfJBvsoE9spXs16maBKW2u1pxvPKGgTJIFuY
	LozShpLkqOSHlHrHFrHKev3k/6wI1eydShSKdEZ8RcrwM24c7BIXoUCG
X-Gm-Gg: ASbGncso+gJ1BVG443m644aaxMf6AkFNqwrpyBa0zIwKJZEjlg0vC1SL4ncl5PfD+Xi
	J/sZxgxBJbLuh6knYXWomtLI6TCvE/kjtMOY0gve3Dgt469h4spKUUqCGA36gv+sgbMC39oezVQ
	2pEZJyHDhEulXXZN4K244AJ7uOstLcsScE1eAelaQyVoOhFXWMhMNIHLxlgpA/Kkxp+0eu30yny
	hSuQs3/zdzKYSBkmhqYP+F3Plu2T5PsR50yTZ9YiLYYnzKlQgj0eGHebdwG5x3EVumulVV3c8D/
	elHj58jaoQqVuNVJNtKQbHEiOsFNyK4FIBnsrfobBEWIs+MltMca7Bp/bwt7uOMI5rhmkxumzzs
	RI8Ug4GoRzIZTXR2RnDK5HaVTMmDmPolxi+Il6rz1b33tzTO+PciGjQuNSQ==
X-Google-Smtp-Source: AGHT+IHKXoXFNdVL3OSNLM5EINQD+aUj/21yGlVLSeyjWddNv/Et639EqYTtpIJhmzqBzPnsbny4vw==
X-Received: by 2002:a17:906:d54a:b0:ac8:179a:42f5 with SMTP id a640c23a62f3a-ace7108a276mr161763866b.14.1745576244194;
        Fri, 25 Apr 2025 03:17:24 -0700 (PDT)
Received: from ?IPV6:2a02:a46c:6903:0:cfff:fe6:73ac:966f? (2a02-a46c-6903-0-cfff-fe6-73ac-966f.fixed6.kpn.net. [2a02:a46c:6903:0:cfff:fe6:73ac:966f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c898sm112891666b.7.2025.04.25.03.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 03:17:23 -0700 (PDT)
Message-ID: <bb6192bc-4217-4e68-b6a7-c6aab395c3ec@gmail.com>
Date: Fri, 25 Apr 2025 12:17:22 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
To: Aditya Garg <gargaditya08@live.com>,
 Julian Swagemakers <julian@swagemakers.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com>
 <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <D9FI2S0NSC40.28VZMYOR6M8DO@swagemakers.org>
 <PN3PR01MB95973DC8D1505AC041263F0EB8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Erik Hulsmann <ehuels@gmail.com>
In-Reply-To: <PN3PR01MB95973DC8D1505AC041263F0EB8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Aditya, Julian,


On 25-04-2025 11:45, Aditya Garg wrote:
>> Aditya, do you want to create a pull request on perl-authen-sasl, or
>> should I?
> I've sent a PR here: https://github.com/gbarr/perl-authen-sasl/pull/19
Thanks for the contribution!

I've reviewed the PR and added some improvement suggestions as well as 
some questions. Good to see XOAUTH2 move forward!


Regards,


Erik.

