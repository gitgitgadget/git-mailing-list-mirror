Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F7175D2E
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726702736; cv=none; b=RTuSF7btPwRQhdxeylbIruTLiV95PNf4IIKTwnUm14Pav3O76f4ftD1IbqSagdoL0RZbsJQE1tO6cdX6rN5n5Z32wkBREUAL6ASpYoQwsAZq+vdgKL/rCtAX88eQH+u/iucuTCBH6IfDNuMjnBO4Q465CUlN8GBF05YzjE/q8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726702736; c=relaxed/simple;
	bh=GBpnFxoxLhZwxCRihlFa2+k27rOlyeksRHZo45lwLOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n1lTW4Q6A3XzU3jReIVCZEyy/3KExtyVJjXODFNb2baVOxWhtz4df2bDQyqSne39Z4vFQ+eAqUYwMYcwE7YF+5St6mQDvOMjWjpkxTa+wLohNy+OKZMZ3DRU/pC4dyZ32KUDCA9OHBYOdaTwNWM1eAZscPk6aAXQm2DRBcKSeFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNgPu8DW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNgPu8DW"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so141961a12.2
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726702734; x=1727307534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTe5nLVhcgOqovJZQ0x/B/NKdPUC8IHJ80LpT24idi0=;
        b=iNgPu8DW4+f9Aty0rvJeQheNewpRpvYuzX9BplRaHNYdeC73x6uk3ptDam/+SxAfez
         RSJYC0BvZdWwVJO0IkAn6rbwOoEuvCuwDzmv3ZJ8y171gVZO67/TAPM3aljUMq4WTvea
         GQv13CwL2UINnk/wAFsRX1zvZAbpJniIXciTTwBnl8PP6yauzI3O9sbFEmaSBb73ISPo
         NOPMqUdMUM3A/XJN8qWA2vkBHn1n3izZhj0akiiWboY2PuzsN9OTsVW3BAwsleNHHktk
         K7gYYe83CWJgteX1P8+kt3PwL7/TcnTbuBp3objoUBhIpstcD8ugzn0Ew+60uNeu0bde
         vaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726702734; x=1727307534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTe5nLVhcgOqovJZQ0x/B/NKdPUC8IHJ80LpT24idi0=;
        b=nXZTBalRMP+ln9WzIeUj+5PWSOSU74x2KOMV/d/ATy2LbE/ST51u0KJEvrG2RipXPV
         Tzn1K4ggPZM0w2iB1AwXAbyYwxjPV8z9vS0hPR8uOlgcGlYaNvw848Lw+tYmWddg9ceO
         ZMGkMlfMihM7/SMFHcNQ5CBl3Z7IqyJVg369W5K00kbIijDDZcs8R1EthN0tZY9DDltz
         IBrxbsMLIvxDuam0tyKlkxNJQh1h9wTDzh092qvrKasggtqfyuK7QetidCVo/oangWgZ
         w+6xFralqeEG9xNQqG2JPm2edW+faWqiSnxD9tjBaSJqvgz39z73qDmArfrCV/Q1Tnmc
         dPWA==
X-Forwarded-Encrypted: i=1; AJvYcCVaFbQHsK0OTqjLxE7OLkSSAnlXAO/lqxZZCnvDP516hE6AOOwmT0/zQTceoWXrtl2MMI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaphZnYBJSAA4xIHXj8Iwgbe1k108UvdJg1swbBOGe6giPa6sO
	67o7V26LXWXF49OUnTJrxNwV2/iRrk2dLdHxH7odeoa0PvenC2qv1Mvsdw==
X-Google-Smtp-Source: AGHT+IEoGxWQ9p0Wz3AL/IL896WqtnunC+ODlAo9fSDmgfooDaM1J3D7Na7lgplJTBCEyBCw5ZZp8g==
X-Received: by 2002:a05:6a21:8cc8:b0:1d2:f146:1814 with SMTP id adf61e73a8af0-1d2f14619b7mr7357534637.4.1726702733666;
        Wed, 18 Sep 2024 16:38:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:8559:eaef:b03f:6f5f? ([2600:1700:60ba:9810:8559:eaef:b03f:6f5f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db499a1c6csm7882695a12.91.2024.09.18.16.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 16:38:53 -0700 (PDT)
Message-ID: <beb10633-78d7-4fe3-a71b-73d5a4bbb5ac@gmail.com>
Date: Wed, 18 Sep 2024 19:38:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] deprecating core.preferSymlinkRefs
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240918232825.2627999-1-gitster@pobox.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20240918232825.2627999-1-gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/24 7:28 PM, Junio C Hamano wrote:
> Removal of support for core.preferSymlinkRefs at Git 3.0 boundary,
> so that we only write textual symrefs for things like HEAD and
> refs/remotes/origin/HEAD, and still understand symbolic links used
> as symrefs in existing repositories, is a serious proposal this
> patch series makes.

I missed a lot of this discussion about 3.0, but I'm fascinated by
the prospect.

> What I want people to think about is how to ensure quality of the
> Git 3.0 phase.  We can iterate and polish the proposal phase with as
> much time as we want to spend, just like any new feature.  But Git
> 3.0 phase is with a solid deadline, and before that time, we cannot
> remove the feature for real.  Would we cook such steps in 'next'
> forever until the actual Git 3.0?  To those users who are running
> 'next' based Git, it would mean that some of the changes the
> breaking changes document listed would come a lot earlier to them.
> On the other hand, unless we somehow have a way to expose willing
> volunteers an early access to these "big changes", there is no way
> for them to be as stable and tested.  We should not plan to scramble
> and be able to perfect these changes between Git v3.0-rc0 and Git
> v3.0 final.
> 
> Or perhaps use the "experimental.*" configuration stored in the
> user's ~/.gitconfig to let users opt into Git 3.0 features (one of
> which may be that textual symrefs are always used regardless of the
> core.preferSymlinkRefs setting)?  That way, we can merge these big
> changes early without worrying about accidentally affecting the
> end-user population.
I do like the idea of having someone set 'feature.git3=true' in
their global config and having that mean that they are ready to
accept the Git 3.0 breaking changes as they are available in
a Git 2.x release. As much early testing as we can get would be
beneficial.

This would be a way to get your patches 2 & 3 into 'master' and
released, but I'm not sure exactly how to keep patch 4 queued
for a potential future release. The best I could think of is to
have a long-running 'master-v3' branch that takes these cleanup
patches and then merges ongoing 'master' changes into them. It
would be a gross history to manage, but it could potentially
work. It does lead to concerns as to how to communicate that a
change to 'master' has broken the 'master-v3' CI or how an
incoming change could create conflicts with 'master-v3'.

Sorry I don't have full solutions for you. Only more problems.

Thanks,
-Stolee

