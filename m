Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A634B1E56
	for <git@vger.kernel.org>; Wed,  7 May 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624647; cv=none; b=OYlj4OIuaO1vz1GnxVFs5dhKujOT/O8pheHjwizkRVrW50GWqJpo3l78zloDh6HgVGjF6lVqMY2nxGyd7I90gHaMldycg5s6fu7XFKgCWv//7ljoymykyho6hQ+j82g/iRKzebFIzDYBOqLThPLZOrosRWoechJfRboet6EBpLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624647; c=relaxed/simple;
	bh=syPM1XqSThC0TmVXsPJQfWOlDd1/4ISAo7WoxKB6bIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9JzVanz+nTCjJUUvq/+eZHgzNADZnue0f8odmdB8YNOVYq6+EMwtXFe1cEuSVcUn/PPt+22GMzWMWYszyHQ3tiPFeo5a27ie0qK13sXA85sc9K4cXP3NMEixBU8qjQbYVvzpJat0g9HCXpPTAzx90LTZ0+hZ7pyiXhLdR9Xfvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzUOoVIo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzUOoVIo"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so8047604f8f.3
        for <git@vger.kernel.org>; Wed, 07 May 2025 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746624644; x=1747229444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t2nN7ZbeaM8U1+aROdg+mUjX6N2JhPBQB7ZfCWEU5H8=;
        b=EzUOoVIoev1y9e1P7CfvDARpJYETb7VV9XHFWJSnl6VAHedo3Z8v3/tmaq6kxFsPQF
         I2Lz8W4zcjNay2cTaxl8AXeupwKgAWtME8dlx+oLd33qSmawDsSsgQ+GCpHxgWKx4yEr
         c/Bgw32uZzFDj6O6E4Hy/ull/yS/FqAk1x9CE7Oo0Oo07WvCIottDf3nAYbgggQjRpKV
         kQBn0m8aqC9IrMBM4qAZVIbT4XiKU35U0gjvtaRoXxA/g6oMX0WQte4wvzz0aDuJ0syC
         YwkD2x1fl6fWs2US1ezw4sevWHPOJlBHocs1vlfH9Edm6n6WNFypcosR14RVlAtoyZyf
         pB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624644; x=1747229444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2nN7ZbeaM8U1+aROdg+mUjX6N2JhPBQB7ZfCWEU5H8=;
        b=U8YmccmPrwIdR/bOUwHcx6DBHzQRqvAICeqwL6tpCnJYiuE9NCU1a2QJW6jKM1tZzw
         rKA0W3B4ROFj3b1IsKiJillU4qYxj5OqGuUotjae6MI5DgDH4BSGAEyOZH+myko04uQ6
         tIcgBxRsNpCkLmVLXG0bb/4V+5igkEQ7rAXfwMdADQYwvbMVrbMTgQ/ANTmmw1aZQ1sK
         IMWHMIreCWbY8Ca2j4E0cVu7k/d9/dn+y0EurBsAlSKZhlQVwKYenRC3U1xmsoHNuATO
         hyNIh9vSqgxd+6KbpFL3MmgjOD8NeueUWQ49noVqQIOtZtnp0MDUOnPFPmiZGkLDXpGG
         77dA==
X-Forwarded-Encrypted: i=1; AJvYcCWxbTxBqOiba3hZNuW0TIGRdnE62D/8kC27LFWZpHEXoXcZyEaGqL/uy7+bRLTotxxYAro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3k8h5cwE2lFr+DoI3F/DC7bzq5UBpNTvRXajwbCExrIeMW47
	R55XXHfOz6aqoyKEwBvD1y1LJhSh87I1NXlDwUkmHa5kqYGm+gqE
X-Gm-Gg: ASbGncuKKqiYXpCJAkQBMuswTCWPTyWfWwEVuApxXn0Km/Rh0WPQTu9DXF2XhHgoQwI
	OMhMIvg/Ip1bkbDV6Gps1mop/2NABvGqUWyDwVLc+udyP+tNkSZvaDbpJDVANLPI2eMfOYTO0Y4
	WzWysWYdxOuB8FcJT/y1qcEbct1pZoo2bv98BJuFuYVGP6gmCEdaWkwxlZuarp6MaQpAhIzjyG9
	KV9nUB+h/zUDoatNTjoo4H32+ZdAbHN1i2msjZsj9JcqaTzMfSP4R7SD//J83S8fkA4gm6c6kZi
	UWXUrqZiu3qDeHhs1itaDp9uJLGdoSxP0d4T09Y7sqVfq8yKPcb4aGg+is8dFDqTopZCZN1hsWA
	SxPlEIjM8Dm7tpZ6M
X-Google-Smtp-Source: AGHT+IGUUEA+szOirAR+uduUo9sWofkp7JRyF/JYS/0b7yOiXQkrTmr6/bA9C5sSJMqEOxMztLvbpQ==
X-Received: by 2002:a5d:64c3:0:b0:39c:1f02:5409 with SMTP id ffacd0b85a97d-3a0b499c1e5mr2834387f8f.9.1746624644172;
        Wed, 07 May 2025 06:30:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b3331cb0sm3653340f8f.65.2025.05.07.06.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 06:30:43 -0700 (PDT)
Message-ID: <a290bc6f-9198-4a00-8273-2970cfbd4a29@gmail.com>
Date: Wed, 7 May 2025 14:30:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] add-interactive: add new "context" subcommand
To: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <b4b7854f330af7588b12e3361bed40723febddad.1746436719.git.gitgitgadget@gmail.com>
 <CAPig+cQmnAiHo8su6UBaKnZ=UZwgwMbDFA6ewMAfvCRR0RFzbw@mail.gmail.com>
 <xmqqldr9lmpg.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqldr9lmpg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/05/2025 17:37, Junio C Hamano wrote:
> 
> An alternative that may work better is to allow subcommand specific
> parameters in the answer to the "What now>" prompt, e.g.
> 
> 	What now> r -U7
> 
> to choose an equivalent to "git revert -p -U7".

I think the best solution would be to allow users to re-display the 
current hunk with more context inside "add -p" rather than changing "add 
-i". That way a user who needs more context to make a decision on the 
current hunk can get it without restarting the whole process of 
selecting hunks [1]. If the user knows up front that they want a certain 
amount of context they can use "git add -p -U <context>" or "git add -i 
-U <context>" which was added in the preceding patch.

Best Wishes

Phillip

[1] With "git add -p" they can quit and carry on from where they left 
off but "git stash -p" doesn't let you amend an existing stash and git 
refuses to pop a stash if the working tree is dirty. This means if a 
stash is split in two because the user exited to change the context they 
cannot pop both stashes on top of each other.
