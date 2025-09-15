Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA682C027C
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945461; cv=none; b=KtQcww7b8K60rEU7ooFIHUqm8LJiwMPvPwEVvMED3kryrOp0QDXKB6zB512f/c1VRcRWtZd1W84/PKlYsUYb77zFHzSidkoW4e3Ra2jqIcztsZ3iEuprB/x0aHsfJ1EgLaoJWSsXBDHPqHFrf18AFand6+9H3gT+Rg25gS+GJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945461; c=relaxed/simple;
	bh=bumXb2/LljvHicXlJaz5OXL7GMgq3AV66bA8zDLEh94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+Pr3oDshaMfDFaQXg0KNKPtAzZ2lHHFxeiQlQ7kz9O0+rOq5KYN+MNz3SX6D5GMvbkOp2rj9txisQZdn3hiM7XluDXRZtrATELmc1fzQcRRp6gxbFaYp/DD4OTatNZkuRQ1NjuO1XPl24JV+UPmD1CHpfB/fQu+mSjtCoVgFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1K+qQ7j; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1K+qQ7j"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3dae49b1293so2406526f8f.1
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757945458; x=1758550258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow5kL4JClbBU9+gM1HTIedmpalFm5MrwSu0jCxyjx6A=;
        b=C1K+qQ7j0WItMvKtIKZrLThQ+kTtGFxQfrm+ENoxlDi6Xc8h9qSaUIt5KEheI6xKiR
         IuKS40ZTIeTVogRKcKUiQQmMviplsH8g1rHAn+OLJ7wmEsKfhPqS4SiaFeqx+Ep/xBij
         AUFDErfPdE+oIcLgKzcMzbnOmD+4FQo2pDqyVHVk8xpE3qqCmm0V1/71qVXD6TkJmj8x
         90WDZq6ImeV9NuOkeezsKEOaEngV4Nk7gjgUz8tlO8u7becYTi+8/5Oby3R+0DDp8s2D
         LnSIza7lOpWOFYQEth/dmgU0UzFTzdaPKww0s3KW7I7bKXrDnO20GzjskEq223DpDCOH
         EqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945458; x=1758550258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ow5kL4JClbBU9+gM1HTIedmpalFm5MrwSu0jCxyjx6A=;
        b=OCq3sc91cZk+d9HKAJT4oyribTVQlP3LVvmb5aQtGxvsvtAPE7QQ6HCdqncWCqKQK2
         iL30hEDyIE0DlDJdJRbhiEO6/ba5Qz0iHKKyWYIRU7tsSAyfuZz44860I6JqnQkP0r04
         ZAzXRj2SlTHMQNCTVNzFaatEfyzYHSKVGL9gof06OObiE7yuDCmfVoCAg8NRrcbUta6f
         mRq6zT+9yeqrdJCuu88cjNMwH6HJXjg3MDtvyr1CzLvwn5kzHFNRCPOITR01PFEDTFrO
         fvIHac/TSn93t9aJjCxoBMRn7bAz3HtdE3xn/0dWedfaEn8sPusPS+Sii2bGZvI/Pf+0
         AGmg==
X-Gm-Message-State: AOJu0Yz9EaDLu/iPRQRUMZCc80FRphg/OXJhnZ+8ZrzS+NRWM3gWaoNj
	SArCWTBJwdFGs/kBh8hYnH3lQbZ+Gl6KC8+CEPPPg7NETQ5qW+oHhrWrOFOhEw==
X-Gm-Gg: ASbGncthGUWc9i5fL+MmiMuvEvGkhGlBCRqiomJXUxn+ifk0rzm1R2y+lA5Muc3/G3/
	S6iQpt4adyefleDUF2ipmQLLeebxmVf5Y0z+FThWiWnHuZ+UmgwX08pBvuFc2n7/MSSCv23YHn1
	tU4u0ftH5me3LsowDNp6kezK8XPPHUlEi4DM+wzcQW5HikJR9QycXfq3RDNgh6lRF7IhvLIhEfy
	t5X+l3YKN38mIwWaWdMMmxTNUEu7vBNsKJqlfTIokyDcQREQD/7sJfi9HHsJqjyFJdGh1w4Ip1c
	iTmC8FKigJMoOltPTB/889+74zIxDeIQBGLdKu5HYLSexerEo9KBMq1LIymL06Ho55bPunK1dSN
	HBtxD54WNIDTmWte3ya/nBe1Py8vUsR1Ye4iReVi52bxcNRzlwFJCgR63i8IqujdWbGN1ZEXd+B
	98nBQBoW/mdhfMObzkG8dy
X-Google-Smtp-Source: AGHT+IF9DEJpz/sDRHlzNImPNZiIPfa/Sr4CEUTGKMz1UImPoVnRJBaFN/mOB0NkMA42SdI5kxEqsQ==
X-Received: by 2002:a05:6000:2010:b0:3e7:27b9:40f3 with SMTP id ffacd0b85a97d-3e7658baf5fmr11106913f8f.15.1757945457846;
        Mon, 15 Sep 2025 07:10:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760775880sm18106524f8f.2.2025.09.15.07.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:10:57 -0700 (PDT)
Message-ID: <fe671dbf-5177-4e66-a89a-8f99b379ac75@gmail.com>
Date: Mon, 15 Sep 2025 15:10:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RFC v3 18/18] builtin/history: implement "reword"
 subcommand
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
 <20250904-b4-pks-history-builtin-v3-18-509053514755@pks.im>
 <10696a16-3f2b-4844-9f9c-9815976b3e1e@gmail.com> <aMfdMe72WB3DR4gW@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aMfdMe72WB3DR4gW@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/09/2025 10:32, Patrick Steinhardt wrote:
> On Wed, Sep 10, 2025 at 03:05:04PM +0100, Phillip Wood wrote:
>> On 04/09/2025 15:27, Patrick Steinhardt wrote:
>>> Implement a new "reword" subcommand for git-history(1). This subcommand
>>> is essentially the same as if a user performed an interactive rebase
>>> with a single commit changed to use the "reword" verb.
>>
>> The sequencer already knows how to reword a commit, it would be much simpler
>> to reuse that code.
> 
> I'll drop the second half of this patch series for now to reduce the
> scope of this series a bit. But once I send the second half I'll have a
> look at whether this can be simplified.

If we passed a todo-list rather than just a list of commits to the 
sequencer then it would be as simple as writing "reword $oid"[*] in the 
todo-list.

Thanks

Phillip

[*] I'm probably simplifying slightly as we might want to tweak the 
hooks that the sequencer runs for "git-history" but it should be fairly 
easy.
