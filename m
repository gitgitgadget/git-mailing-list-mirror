Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872E2505AB
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692914; cv=none; b=qYJdmnnl0zQQuOdpY6UPDGyO76OhKrK0jUAmICQSGo3UYN+g2wOfb8jdbs3OTKwdhHN7TImCC5a3U4niMeJtQ0gf8eEy21G03Ze6+i9oZRdgetOgUYJ5hCyPpEzcNyGi9ctzK/hdRb3OF2p3mYjp4Grkmt8/0m67wK/HdsoOrVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692914; c=relaxed/simple;
	bh=uvpraONENtdHC6n0Vd3RmYu4xS91aDACAKawAR0p3GY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uj3vmbSuX8E/CiHruYTf/bcC0XR/IJ+SfGch/VUeWPE1qSthM6cbkMy3XMMY+P3HU58LMa3BW2juOGsjsipo/nGjx7llMBSYRX2GLTy/A00f/sdDrRBooSn8jx9WVm+otr8fN89nsfmVGVL5NAGmtHtkIC/lF2f1Nsr/+2Tk4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9Dk0pvn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9Dk0pvn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso10330055e9.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 08:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743692911; x=1744297711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSzG9yAC8u5Hp7ZRpDHBlqJB9OD264dcAJqC7RWrOSo=;
        b=E9Dk0pvn1bowhLv8N23J0EEXysplmRjcgdA5SmpqoAdU87nGQ4bP4REEPGXjRFcKB6
         HKjjBhKxw0lcXWWI+SgvaxjUFdkZURRJDTIOuo7Dsn+Ezhln0kJcJAqszJ15IZ9iyTW1
         SYGdDLmYCkUgdPkvsMKlsyOWta4OC310FpByuAEAmqXMdrFqSiiRHbxShkXVuLoi9Yoc
         Go8Zp7muh9gJc4KrqnJnX4uGxKeWw0AiTphx697cw+KCsCGJzn+i7qZ37hEnOeRkz/xS
         4C4Xy/9YiH7v3zYiHghfJ7MFBtVvEuJ4feWsiWgqFqjcLIPY2p6LfSppLKhPKAlbYrY/
         Svug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743692911; x=1744297711;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSzG9yAC8u5Hp7ZRpDHBlqJB9OD264dcAJqC7RWrOSo=;
        b=cYr4nad/XvEi7Rv1HvWQVs61lotZ10MMqzRJ1jZs1GwTiypnp2wAf6AUR0IVN5mni8
         qLanHJ/bufRgEN0XM2aKJ8EQRn+TEQLY6uGsk6ukO1adO+JX+Ax0Ove1JqXUZhh9K0Z/
         MVvduQpEckAuqAv7L264Vcs1YUHditmJWcg00NtvaflV0OI53PZYKFe9KN3f9QGPGsM3
         CK0QxwCCAxEY0D1MdaONztzND5TxTMEQB9U56BTNgkJRrkZjDwzWRXfsO03NrBcvyYAk
         eDep+oD9+TOxuk6BpgVuHKNSpBpffNPYxQ+Ntpd299e2XKcBM/cLkaCe9a2rQJ3AMZZV
         ZFvg==
X-Forwarded-Encrypted: i=1; AJvYcCV5GagLdaetlVMyGQyGTMtuJzNaf7Mc42wYMrO1dtEgF8SXdAGFKwoWtlyI5bXQdSp+Ki0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ99XVxd2quENo23dYMCd2vIBz4Oed+Q7SPwqtTh2iD8QPPPI7
	GdokAU6mr61Y1JPxbbT08geeJpoXN76Hs1Ua4q6T35wALH8E6/I4
X-Gm-Gg: ASbGncsW2WjD/MrbAxKXndi502z0BKaWaFQdpZmRRCngfPPTO29rZOCs0XE6M+Wv+fB
	eT79qLgVl/fWOjJGdBBPHQGRsANaZlsdX8xbea/A3yF+8S/Hr8V0dXwryxwkcVH+NbUjx0YCrl3
	P8sAtNDUkLDFbn6NI+AIdCQACpELWqdRMisRI2C4xGBql6K7874Xu9dXWHTpY906Hp7/t5NaXII
	hhzYfWIjKhEdszJ3kiVFrauSEPOmGukVy+XVvdWvWo0BMbF7D1LOX7E7zARPqwL0yTT2P8j167o
	R+DpBbjjDm6mhFmXldDxfsqhQeAi/lpoqbvAsF+dZu/5a/Y5VbPOCFyvrouQnfF4QErsMTyi79I
	Lz697seig9SfgAaHcB4xv
X-Google-Smtp-Source: AGHT+IHpWhFgvIBigUZzcat/oq7d7a2+irzxEKpUWAO6UEErYuOJpwL+3F4P5xGoOKl9isuGi0krMw==
X-Received: by 2002:a05:600c:1382:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-43db61dc79bmr206785955e9.3.1743692910326;
        Thu, 03 Apr 2025 08:08:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b1352sm23905755e9.37.2025.04.03.08.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 08:08:29 -0700 (PDT)
Message-ID: <08837a1a-b46d-4456-beba-5c889fe9e674@gmail.com>
Date: Thu, 3 Apr 2025 16:08:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to
 conclude 'merge' instruction
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
 <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
 <0bd7e0c1-fe73-9e16-0737-d6b175a60dd3@gmx.de>
 <a81dbb21-b50b-4358-b2d4-7f804b66bcbc@gmail.com>
 <15222e69-9452-fd61-6ffc-8c8de0c68d8a@gmx.de>
Content-Language: en-US
In-Reply-To: <15222e69-9452-fd61-6ffc-8c8de0c68d8a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes

On 03/04/2025 13:17, Johannes Schindelin wrote:
> Hi Phillip,
> On Wed, 2 Apr 2025, phillip.wood123@gmail.com wrote:
>> On 01/04/2025 17:22, Johannes Schindelin wrote:
>>
>>> It is unfortunate that we cannot fix this, as `git commit` with an
>>> interrupted `pick` _would_ retain authorship, right?
>>
>> Unfortunately not. Running "git commit" rather than "git rebase
>> --continue" to commit a conflict resolution when rebasing always loses
>> the authorship.
>>
>>> (Why is that so? Can we really not use the same trick with `merge`s?)
> 
> Authorship is retained when a `git cherry-pick` (what an unwieldy command
> name for _such_ a common operation!) failed with merge conflicts and those
> conflicts were resolved and the user then calls `git commit`, though.
> 
> Why can this technique not be used in interrupted `pick`/`merge` commands
> of `git rebase`?`git cherry-pick` retains authorship by writing CHERRY_PICK_HEAD which 
`git commit` uses to look up the commit message and authorship. When 
we're rebasing the sequencer removes CHERRY_PICK_HEAD and instead writes 
the commit message to MERGE_MSG and the authorship to 
.git/rebase-merge/author-script. I think the reason for the different 
behavior is to avoid confusing things like `git status`. 
CHERRY_PICK_HEAD has been removed when rebasing since it was introduced 
in d7e5c0cbfb0 (Introduce CHERRY_PICK_HEAD, 2011-02-19). These days 
rebase supports --reset-author-date which means it cannot use the same 
mechanism as cherry-pick. Personally I'd much rather we tell people to 
use "git rebase --continue" to commit their conflict resolutions as 
using "git commit" has never worked if one wanted to preserve authorship 
and I think making it work would be a pain and probably fragile as I'm 
not sure how we'd ensure "git commit" knew it was committing a conflict 
resolution created by "git rebase" rather than one created by some other 
commit run while the rebase was stopped or by an exec command.

Best Wishes

Phillip

