Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FBE299A8F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257436; cv=none; b=tFXaOc/r8pk6eADwHh2s8KQRs4aQNNYA0zV7xm0eJ0rhlFdpmUEDy5fWs81xIe6IdH0rylXTDYl+SCvDUyjMsaC696ec6AUPilelp0xGgGmY0bsFSMnqxLdMoiJQ3LcfRdpZWG+YsabllbqpgaaQv1XadHAOc5tkiivbfZHJKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257436; c=relaxed/simple;
	bh=FFmOjH78Qi8dt8dB49/m47fgCrogP4AYMc+TcQNymAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l/lufXHsW5qrKmiVhIqAuHllSJ1emrPRue/10f5+wKfJmn2YdyUlOzigwmnDFhSvAI0dk9vihhicoYQ6Fm5pk+iXoAEYxuZN/TvZmIVE0Jr4NbxtYfpq0ehTJS6ac69KUS+0YUUD0XZPzAUrsvz2FJNzR4Fru5MLdhNo625auVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo7a1vSL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo7a1vSL"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7c2788dso173837f8f.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773257433; x=1773862233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=37lcbSOFcq2B4/TK7B1nu+ONxcC/yL9cgASG9AZaWMo=;
        b=Jo7a1vSLFt+AjytBQJh3QQfKPcugiIDrO4WPTbUCJWlI+BEseDYL8XgKlpyO2Bx+XL
         mBs/SuqmiheQRVn1mX1CU+fE/BLptnzNEmHhC4hXVFm8Yg9id76ZwNm6vwVcWkw69EpE
         pcWZ+cV/xLflJS+tJEuDfxYkcfsFNSVVrNYog2N78eBNEW1YA+EY7ALIbHx/9BGSNvzw
         dYzXclr1X487BYEWvr8ae3sV8ec73N/1sTYfyEz0Z152XjWPbyECmhcnixALCST8hQ1H
         Qs1qlD0roWoUh/E8dMU6xXcILg3wXshIvpp3uafEK0hgoKCUDUpb/7vE+Vb+YfiLlxsf
         /qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257433; x=1773862233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37lcbSOFcq2B4/TK7B1nu+ONxcC/yL9cgASG9AZaWMo=;
        b=ZZb6cGunJabvhD9+1KTnfQTqM6MiDsTbo+qqiQ7MSpfa+EP2s2jAXC1p8+mnfYtglv
         v6pdDSWzT+zUKp2VLYv9CxmArGHvl5yB6pkm+oOsDMdO+Zi4sBBjGPzutKbSiN+JR5DC
         9nmtDP0ralwaoSxjyzlZ+2Y5SkSD4x+yhk1zagVxjdIyc0KO5EcUykS9Oef61OC8ZQQo
         /trmYhlG6in19+vj4GHgECsHXbYkCE6402fUWeIMMn/dEnzORYHjlf471/IyQOjPN7C+
         UCpkrX7ZxotSroL7nzMmIopxCn1lEx0y/FWuKe1ObQFNT6GpgxzCHDA0jEfggpAHHnkI
         gGfg==
X-Forwarded-Encrypted: i=1; AJvYcCXUq4y0mMkAhBrN7H5Yk63ZpCVsLc2aHdSDBmiMN9wkvs/L/fxFlCGky/5W1d4Pb9lXDVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoimQoVQcslQEnz8IDWHd1kAqx3VsDLEfxYt3QypBNoUzGAv+
	fGK94JzEsxTKFSw22SigAnqze0qhmL8Ox4avtwWwJVxYp48xu651MjcgJc7Y6w==
X-Gm-Gg: ATEYQzzAve8QLqQeKU5Hpk2iItlJMv38zUtgiwJGOkpP0o6bWVEkcLTOck3Hb7cA0UN
	vCvHSiSAhC0hIuuumbaaQ5XuyPqCh/O+YqMGLzhwndE1qwvQk2L5rO8aJy4EJxOr5Jlj/jegJVo
	lc7IC4D2jip8jjIe2/d+9RxDuWf4kMGoSEORMQIGMRh4C2XTlZ0BykVAXwQUAjuiKmKw9+JgXBs
	9JjfaZRiZ3gPIkaYciUHQS1k6+zhXaS1ZIMqn84ywusM+gtnavWK6mon/GSA+sDjN+C6gnCqlSD
	zp4kd/hQ393el5o2EN5jfz1+tFTnLzOtkCmx7av2PONQLWrSRDcazP3Dbot6rovAtmTWjx/Dz0t
	190adokaUfUDA/NSy2lNsGHBFvtD4m7vjcLex5CV++tsFOMURdlpZDj6jvCaCATcIvixU0+NU25
	Z2fK2OxKKdmjnTLe0EbkFZ3g+PNdkrcF23mVpqZut9Fb8xiyKTKDAM/w9CdoIx1Wiyenna4mzFu
	wY5P++wugUIURlY
X-Received: by 2002:a5d:64e7:0:b0:439:b265:6c61 with SMTP id ffacd0b85a97d-439f81bd6ddmr7162933f8f.12.1773257433342;
        Wed, 11 Mar 2026 12:30:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm1216115f8f.31.2026.03.11.12.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 12:30:33 -0700 (PDT)
Message-ID: <2d818389-6456-4b75-8a29-3167fc3c885f@gmail.com>
Date: Wed, 11 Mar 2026 19:30:31 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: cherry-pick: add --show-current-patch
To: Florian Best <best@univention.de>, git@vger.kernel.org
References: <43529695-5987-486a-bdff-46f573868c4c@univention.de>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <43529695-5987-486a-bdff-46f573868c4c@univention.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Florian

On 11/03/2026 18:30, Florian Best wrote:
> Hello,
> 
> When running `git cherry-pick` over a range of commits, the command may 
> stop due to conflicts. At that point Git reports the conflict but does 
> not provide an easy way to see which commit is currently being cherry- 
> picked or what patch is being applied.
> 
> `git rebase` provides a helpful option for this situation:
> 
> `git rebase --show-current-patch`
> 
> This prints the patch of the commit that is currently being applied. I 
> believe a similar feature would be useful for `git cherry-pick`.

That option exists for rebase because it originally applied a series of 
patches rather than performing a 3-way merge like cherry-pick and so 
there was no other way of seeing which commit was being processed. With 
cherry-pick you can use

	git show CHERRY_PICK_HEAD

which allows you to add any of the options that you'd use when showing a 
commit. That is more flexible than a "--show-current-patch" option 
because you can restrict the diff to the path that you are interested 
in, or show a word-diff etc. When reverting you can use REVERT_HEAD and 
when rebasing you can use REBASE_HEAD to see the commit being picked. I 
did wonder if the documentation could be improved but for cherry-pick it 
mentions CHERRY_PICK_HEAD in the description section at the top of the page.

Thanks

Phillip

> Currently, when a conflict occurs during a range cherry-pick (e.g. `git 
> cherry-pick A..B`), there is no straightforward command to show the 
> patch of the commit being applied. While it is possible to inspect 
> `.git/CHERRY_PICK_HEAD`and run something like:
> 
> `git show $(cat .git/CHERRY_PICK_HEAD)`
> 
> this is not very discoverable and requires manual steps.
> 
> 
> Proposed feature
> 
> Add a command:
> 
> `git cherry-pick --show-current-patch`
> 
> which would display the patch of the commit currently being applied 
> during an in-progress cherry-pick operation (similar to `git rebase -- 
> show-current-patch`).
> 
> Behavior could be:
> 
>   * If a cherry-pick is in progress, show the patch corresponding to 
> `CHERRY_PICK_HEAD`.
>   * If no cherry-pick is in progress, report an appropriate error.
> 
> 
> Motivation
> 
> This would help users:
> 
>   * understand which commit caused the conflict
>   * review the exact changes being applied
>   * debug large range cherry-picks more easily
> 
> It would also provide feature parity with `git rebase`.
> 
> Best regards
> Florian
> 

