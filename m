Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B93FFADC
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556630; cv=none; b=MeO+pbomt7rIBjGgnnuZ4kmrOWqG0trd958PMxcdKqiJd3g5GiKJy/aryuG/+wAgwzgyECgJ5wT3tbQWGAkg9/fqQluZ5GGKZphp01Yv3UmBDUKwFAoH0xODZRbrpMXUZT9UnbzQYWEazyoXuS0IJt0gA1v4PnxO1WQTVIV415c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556630; c=relaxed/simple;
	bh=oeQOF+3p/LONfQrEAI++CD9J89+6GNNJWaWqL68qyyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zd0Mtll7Vk5XsK8fZcsTqocTI+tLxdhzfXj8WURY+BTeKMNC8TsGQhFkR5YEM6aPMUOHdG3zCaJ9VGIBxF1UDDCRosVXsUIG0R9rfQwRopMREijxP9Pc0lyCd41vJj3LlSGD7n8qipUxK5kV3jYg2T5IS1Vtiiey5Z0loby3uUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOZGuEL0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOZGuEL0"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-441209fb77eso587009f8f.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777556627; x=1778161427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LPeectdBHijERkhhUwvF8MDILyiq4TwaTk5xdSxrZGE=;
        b=sOZGuEL0cG2Y0Yy1JnaZbAjgbTOt1go86akIT6/jISV1mZ6++gXsrPjGmerpDb5dny
         0p8UE/L9zz/gK4/LmB59kD7coE+6QM6R8dx1FtLp36IlGWcEnqpRbremCeDOB4fwSHyl
         g2eO70WFB4BfmDtSt2FjlHFDSurFg+MfEpwT5N7D38klEcf5yAKlpHl2cM/7MSQ8gbVB
         Tdx5I4oW0bVKl+pFmSgUMZza26lMB/39HFw1wI34/PPf4MH1OSSbDcu65ynB+4mfXfDq
         uPiw4NnJYzTkstfmMBhnBMBtmFTbYE04AeOpBySBLlSLCKuIOckaqC/g8ex2y7kPPVHJ
         S+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777556627; x=1778161427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPeectdBHijERkhhUwvF8MDILyiq4TwaTk5xdSxrZGE=;
        b=RZrferBxxc15lyVgCHP9dtUWoCJFxm2LhnxgTRajO4wWQVe/M1AIuh/6T1y6/5gjkf
         nDgfnlJukpn9P4fOwYjHHJk6fRUDvV36yfUUHnOUCPc7RgVbl87FhsT1Ny+GSzzn4rTy
         tdIsS+YgKHYZIwbG3TI6KABW7H0I6OolpZujOoTmiC8Y2v8h/N+JFT41pUQt+NNbbSp/
         w9T9yeNDiLszUvIpJZ/PtoBtwgrvdPnd7rEcLyu1zq8RQitImZwH6MWeJepeLtGpLL2K
         S+RLZ7tSCBBdRQUfQ/rXfIEGEz4gw/Cze+KBjlkq0pRA/m5D2kxecAtXtCJONSSZASlv
         /wvg==
X-Forwarded-Encrypted: i=1; AFNElJ9sxj+jRR3kFlv5VHRdol49bQqX6oAD7W8wP3kvP5peZq0MAlyUS3Cfk+pFgUhLxKUCSEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDbzMQQ7blipY1DvZGmtzZacWoTLc7QvSSsBWktrH9C42u5bv
	OxsLP8BQwcxPpCr2PRoCevT30pS47JSk8kNiD6JVmlLJqwF65ApOgK1P
X-Gm-Gg: AeBDieuALwuOp1tK9a1LbEhCyl/+tS/y3uEUc8isgcD80u0hb8I8bJceH1C16INxcjW
	SFxxIQIc0Vc0QTWI9QpJ+3Xre8fSDjWpxjzupIF2EvrKIYIB3RsEuflYg15y5RhC6v5JUp5pz+a
	GPA1PSUgR7567mleD7w9E0lk/p6OxQWSDXXCSxyJ/bnDe9VzELIK8JyCPdib0+AdHRTM9c81T0b
	jr74JbmAo2L5l61cBTRW5zuqDVU4MGP7HwBBONnzKTBK68gea0dfDp0YSMO1nh6P2a2sU+5yoYZ
	wQaSx6KVtOWsA0jm2Unt4FWgMOMypDeEC88Bjg3ZlDwUCY6HOsUs59BsPG701HGydAfPdXWCm5i
	ONLihE50njceaGPq+cgyDq6M5w4dVDI0n/hBZX7oPNdxmgeYBVA1mW5BTSO8Hm1KFWPGphj3+79
	dFudYeXafsJ+lhZDT5P9Po5Q+smlXoZhw/N+OtuTspguLkDEUEvH/lC4mzXwhMKM4pPbMLDsyGM
	I/E9d8iY7zwaQ==
X-Received: by 2002:a05:6000:2381:b0:43f:e9f0:87bd with SMTP id ffacd0b85a97d-4494e8d7bc5mr4751694f8f.10.1777556627072;
        Thu, 30 Apr 2026 06:43:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216ed6sm14396022f8f.16.2026.04.30.06.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 06:43:46 -0700 (PDT)
Message-ID: <986ca9b2-2ad1-4b2e-a61f-3407fe5d5251@gmail.com>
Date: Thu, 30 Apr 2026 14:43:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git interactive rebase does not allow editing commits at once
 anymore
To: David Jordanes <davidjordanes@outlook.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <DB7PR03MB3881199B8D12CC7A981ADF0CA8352@DB7PR03MB3881.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <DB7PR03MB3881199B8D12CC7A981ADF0CA8352@DB7PR03MB3881.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David

On 30/04/2026 08:46, David Jordanes wrote:
> Git version: git version 2.53.0.windows.2
> OS: Windows 11
> 
> Steps to reproduce:
> 1. Create a dummy repo
> 2. Create a couple of commits
> 2. Run git rebase -i HEAD~2
> 
> Observed:
> Lines in todo appear as:
> pick <hash> # commit 1
> pick <hash> # commit 2
> 
> After editing:
> reword <hash> commit A
> reword <hash> commit B
> 
> Then git loops each commit to edit.

If you mean git opens the editor for you to edit the first commit 
message and then when you close the editor it opens the second message, 
it is working as it always has done. There is an external program called 
"git-revise" which I believe lets you edit multiple commit message at 
once though I've not used it myself.

Processing the commits one at a time lets you inspect the changes for 
the commit you're editing the message for and if you have 
"commit.verbose" enabled then git will show you the diff for the commit 
below the commit message in the editor.

Thanks

Phillip


> Expected:
> After editing, all changes should be applied at once (no loop).
> 
> Question:
> Is this intended behavior? By whom and why this flow was decided? What problem it solves? If I have to rebase interactively 10 or 15 commits I have to go through all those commits one by one???

