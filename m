Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B773A2E3F
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119397; cv=none; b=qWv5olxkRdPH5X4PjvJvfNL35HSN2D7tG+kttOD9DPyhK5ugLUGFOKGhfeGr2KPNxDXoiHUk6vei4LTK3Kgxa05N+fUJd9hPkyTyB79IVN5ExFA/mrxCBvSjwGvSRvr6HkzW0Opu1SBo7Jxf0Nt2SPbJAjN5LcTFoDfJgT8qFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119397; c=relaxed/simple;
	bh=nnqXlTnIRKLAsmSqIJlYlFwL4j1qfb7sbf1KTSV2C6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcP/AmQhrxe1vCJxGHKtSHhnMqJfejsaut6U81nAMa7REfoYD4/mvsiqXd1oaPr7KD+d8QRi5HqAis7Ld6vTYDTR/2yCqRnkYsc6XYIKq9jqnePAq6qZczNQTjJYGtM8+G3ucYvQqpVQ6gcu+RZ9XEFdBs4AXvm9L9HOoiMcGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daMCSrFf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daMCSrFf"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso4411249a12.2
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 02:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782119394; x=1782724194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auLg5kzSacQIWc+Co0/1+7Go/kKtaOplu4DCdkoWe7A=;
        b=daMCSrFfzVjf/81iEOJ0IilWh5bMTkcWRbRg+jY1/2HOGQ6+alWy8DwAdUqd6uG5GK
         YnrpnE6kdBIKq786YV+iD8x+07qVB1oT3pHiHFqk8v7Q2SoXQ/tVl7/TGyDIf5hwDib9
         nu0xCXknBS1EUZe8s2wonDuzMg636OPv3QwACSu8OvASceYqI1Rv1Fwrqa3kqqMvO6Ny
         tGC2zxT3jN+iHdSDd+C/vMeNncmpSuchz4nAHavl+Sh7DMAM6Yu6TAaQzHl6/X9sPBde
         CNgtaJvuQ1leWabcAPotSxv4KE04qesFbvpqegHfjaJk8tZHVNd3ReWBUiNh6lVTBiGP
         rB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782119394; x=1782724194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auLg5kzSacQIWc+Co0/1+7Go/kKtaOplu4DCdkoWe7A=;
        b=NGMngNaZE18Q2H44tSGVJXsqZBV/WYjhmeL0o5g0KONfsr1go9ge1+DQIMYs1TKnrM
         +vut56KuOO0v+/9ZdWYRcvtNEiTMNTWMN3UwN7fPgXAUqoJcLnlrX9Q2/rdyqPhV6nOy
         1DPnMHaSjPqhjzd5WOIDCbAeOJs8hMKOm6YlapMLyr9rl6IiZr1sD41wklgyy5D74W7B
         Jpu26G3a8SIpKjfGUI5l1FgrfvLral80syyCp7HrJIn+cknqdR3ZWUkbiaRV33EyoZH2
         ZZxBpZn+3peIR2TG4kB+BS4UZ1fXtXK8TrXcOqZP9KACi0hOspZVSn1KEU4f8JIMySRd
         zKiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EHS2RP3luEbHFuKOBaxSjI/foOmv9lapZjqya52R4FufGycqPaPJUdhN6vBgbP0UvNDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMJdTNGFc2RDcN/1Yg8WIbV8Y+X3uTPa7uyg1C23oNM6/SNJry
	aHp1s5cLy3h2HCNqlRkbtT+DodrmTyE4vlIV1Io6qNOrLD88uPU/KCVr
X-Gm-Gg: AfdE7cnvjzCsm1yOBcKSWO/Nwf1WKX71sLvMl2un7iWc2FBdlywkFHWiwRa6vb1uRmU
	miJC3zXD+38qKuGMWg/fKDhsT7cQjCm+TfQebiizVbFyuTZHTScWqlZMrVVqIVGkJIPusOOMF0G
	yCYsDD0KMABwkQai7Mcx9mQmNYrtpYPjra3fQ04xFlveWn98mHlT6Jx/E1Cy8h1ktXN0moYO1Jr
	AbOVAJZW2qx4oqWtzpbXotT86kKCWq4kwUjepcrbrsgBbRGbqiy9XSfrmh66UyGv5p463x2YPK6
	2qv8+mQXwbHbROoqk0hmOlm5YuYjwu8MTAl9Lh3mR605GckLYpuwr8G957xJMIpVlWDo/Utsspx
	LEriDXbNxbQ2gjbH4D2n15tWJ+ZKQqLfJghgsC+ZFaiTSLSlYpi99Jfe6XFFC6gn7etzJLcj2OB
	lf6EnnyjDIomCZD9iwE9Hc5gSIpraCoJrumXuCoPqpI2lGKq7BSbw31V8KKVw3eFWBnNItovD7h
	qRXZAhS
X-Received: by 2002:a05:6402:400f:b0:697:be39:606f with SMTP id 4fb4d7f45d1cf-697be3960f5mr736971a12.11.1782119394083;
        Mon, 22 Jun 2026 02:09:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:33f4:2760:38a0:c4f? ([2a0a:ef40:69a:b801:33f4:2760:38a0:c4f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be4b9f6sm2643769a12.22.2026.06.22.02.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 02:09:52 -0700 (PDT)
Message-ID: <31172867-5577-4c1e-b8b6-425ef9fe44e1@gmail.com>
Date: Mon, 22 Jun 2026 10:09:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
 <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g>
 <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
 <CAHwyqnVce7NKft9AEyCUnR=S_y1ygiXjhf-qmJqmi-tuUXcw=g@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnVce7NKft9AEyCUnR=S_y1ygiXjhf-qmJqmi-tuUXcw=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 21/06/2026 19:46, Harald Nordgren wrote:
> Looking into this more and attempting to implement the logic for
> re-assigning the upstream, it becomes quite a lot of code.
> 
> Maybe an easier way forward now is to avoid deleting these cases. We
> can always add the re-assigning logic later on without breaking
> backward compatibility.

Not deleting the branch is certainly safest and should be fairly easy to 
implement. Adding an option to reassign the upstream later sounds fine 
to me.

Thanks

Phillip

