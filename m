Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE64AA1DE
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788375954; cv=none; b=E3EteZXCWbo40OUiYBrtYFxli7cZdCVNWCS9QSHE/XsibIaEo19frqvCt1P1Pb7OA+s1DJg5TE6B5+jOab8598zgVBAi/Huj9lCYgeSvdrGHYE1bDXZIemjCmCUIVUUmdFSJydy42Pvz46eHmymks2Cm9YmwJaRlMaIKTIfLT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788375954; c=relaxed/simple;
	bh=D7tTYG7SwIg0JW5dYX/17I9P2rNcO35gfhVZQvP3AnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFtPo5vk2nAhjWlez6YngHbYjVL79xB7Q4qRUkqrv3sIvjw3MY6zm44egkGBO5KRm6vRYHHi6+0EXbYW0f1SQz7FrtGYEQT7VYTBPUZtATlSClthJiMs9yoewVU6x2hKVKjEsT1pUnLFP+QI81D9Q03DV4knvVFiMezVaUzQ2I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrt/r46Y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrt/r46Y"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-517dc520840so16329351cf.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788375952; x=1788980752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35p7e6ZMq6IrASR9Z+811Xzx6KKPMB47tjav8WKfxtM=;
        b=rrt/r46YxHZyu0iGgW60m1hTNree+KQCj/oIIU/BDVhEYmzmo1llXXwmZXKSj+80xg
         DT9djNDRPpkrglcmrfQ1B1KRpJ71T194FkQjALJOWInvT9RaHQYDhEvUNobCO5zJs3vM
         gkxsblXUOW7zbPPe9Aa3/HoRxiusUP9zBSOjqp1bcWOAnBTiTe4eIWyQ9G5TBrpltHqc
         7znhohrD5nPQIO+bebhx4EDc2SRczNhHy2Ui4NtwFqZOuAIe/R6sQO6uWGI3+93oyJtX
         jBd6Y8ZiGNbfcEmzecnGwcL+S3Fk4M3tR3Yh28q0s9jM0WPeRxyd95STyWpDXAID4CwK
         iQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788375952; x=1788980752;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35p7e6ZMq6IrASR9Z+811Xzx6KKPMB47tjav8WKfxtM=;
        b=kc09/Bl0kVi3UUGXaz8sC+rNXlzI6A/YKZDC/GGOOGTO9o/D+W368/wLXrUCehMpIb
         5aFQkNBPGYAbB/iamPdbQysBC1HpRrLB+c+fkLPBII0EJ8kvRs47WaJuRDMCqz2MsLcj
         mu0YMNFkxIK61A0YDoLWVQKHTFDjwnfJX9ce9CXfWWRx9sj6P6lM8mBznbmVDLletzu8
         yq6R+Nf7SDFI0zg3xfkpSPUUIaNsHERhxo7g0GHRPZ6RTuuRMAqdzSpPtuQSZ4TdklSA
         wMooAef7yo67q/J4upR0141odH5OVMeSf4WYrkzd/nx6d29ctvjTrZNeBpj3OcXbCWDT
         Vnyw==
X-Forwarded-Encrypted: i=1; AKwUvBx4Q5/wagVs7V4qgAltjUmkZCsWUidx0op4jczsN+96mMWaJ4cIDJ1O3JPpu1+9tQLqhvo=@vger.kernel.org
X-Gm-Message-State: AFuF++kH1g9uY2YmwrTdfZ/AoB/94DqQYtUOC/LIJxU0O1KqUrFRZvhu
	V3Dkou2he6QHTkV8yj7yIonbtKb/g/UBrjVwnMZNxpH/AT1OrKO98tc0
X-Gm-Gg: AYBFou05g9g+iG7WiuQABgx0CdImCjaZ33TiLeyVuoux9IPwEtwib+2s5gnwkCK3ifL
	Wzx7SQWyVQrfh1saGyg2Cd9dr9/CQ3oyAObIEZJQ0AVjtNhlAQmxe8tls47oPwu6N5LRw2fzIH4
	kNw6Bn009YtnoWaGBQEeZZgzapGRSUT34wURVOMBQtEW2yElaRQGL3Ol2GRXOdKTp1PnGnqQcpi
	dUSFssNRxxXnAFK2bieH7cR5itJjBP9A9P98GnJFTyntzs3CjTMmHZj/8WdQA/Tp+B7ESGhH6iu
	Ax+vKeT6wZE1kAsOusKA3SiKig2cxtoGNrW3dV6oqrzy0OZBtdGL9n3rEtd7n+7GYTTLaKbcL6M
	Sk4cySklvZK4kX4hQpVpmDOWwKSUZ0oPOl8htEAZLipduEGOLz/ZEQ1sAJEc3zRbV+xnFyVuUGr
	MAKr/WOTUF0dOYvvYcMdH+VOy/JdrBpAB3OZfN2jmTxpJNE7JC33v9KDr4Lu2XTpK6U4Ungzn0z
	jfpk4cX/qJLwQX7sCQ2LWLVW5E5lWt8pjfdBNvooeJcus7CydixWslSCX7QeOKx5d0QVHvt76DL
	x6LEzicoa1ifCOQ3hWjkNgYlst2nXON691D1iqxoTjqNSjUs57sCQPV6zh67cS3I0JuG0mRlHNH
	yvuMPLSggdNuB8KtILfbUclvK
X-Received: by 2002:ac8:7f93:0:b0:530:178a:9de8 with SMTP id d75a77b69052e-53036cc63a6mr83313421cf.22.1788375951913;
        Wed, 02 Sep 2026 12:05:51 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530331dc455sm25108151cf.15.2026.09.02.12.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 12:05:51 -0700 (PDT)
Message-ID: <1d6a4047-fa41-45cc-8097-88680e8ea67d@gmail.com>
Date: Wed, 2 Sep 2026 15:05:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-pack: avoid sending the whole tree when pushing from
 a shallow clone
To: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
 <aohP7GMx9oX3ZCsQ@pks.im>
 <CABPp-BHJj-b=ieva3-=zaCAyvn5UtNQqNT0Q76YCpqZAjO-8VQ@mail.gmail.com>
 <aovW5bxu1F8jYKYl@pks.im>
 <CABPp-BHwa7QM=XDuO=9xqm-OL8dn8uGf1=rv+sgBRQ9hHKMFuQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHwa7QM=XDuO=9xqm-OL8dn8uGf1=rv+sgBRQ9hHKMFuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry that I missed this portion of the discussion talking about
push.negotiate. Coming back to correct that.

On 8/25/2026 1:00 AM, Elijah Newren wrote:
> On Sun, Aug 23, 2026 at 10:30 PM Patrick Steinhardt <ps@pks.im> wrote:
>>
> [...]
>> TIL, thanks. I don't think I was even aware of "push.negotiate", and I
>> mostly went by the folklore of "just clone with --depth=2" that I saw
>> repeated on many sites.
>>
>> But this and all of your other answers make me lean strongly into the
>> direction that the fix is at the wrong level, and the proper fix really
>> is to enable "push.negotiate" by default.
> 
> I don't think that fixes the problem, though:

You are right that the following cases are somewhat common.

>   a) Users can do a shallow clone of a specific branch for a specific
> pull-request/merge-request.  Then the pull-request/merge-request is
> rebased, and sensitive data removed due to a leaked secret.  The
> shallow graft is no longer common.  Pushing from the shallow clone
> should fail, but it shouldn't have to send several gigabytes of data
> in order to get the failure message.
>   b) (Very similar to a) Users can do a shallow clone of one repo (a
> local repository cache?) and then push to another; the shallow graft
> thus may not be common.  An error is expected, but sending gigabytes
> of data to get the error isn't.

For this case (b) I can think of it as doing a shallow clone of a
base repo (https://github.com/git/git) and then needing to push to
a user-owned fork (https://github.com/derrickstolee/git) and the
fork not advertising reachability to the shallow commit.

I think the difficulties here is that your approach is assuming
something about how "non-advertised" objects may exist due to either

 a) delayed garbage collection, or
 b) shared object databases across a fork network.

I don't think these are reasonable assumptions to have by default,
so we need to be really clear about the reason to use this setting.

As your test demonstrates, some amount of "our assumption was wrong"
is built in, so we should have a way for users to respond quickly
or automatically (retry without the setting?).

The multi-push case that I brought up is tricky, though. It may
be very narrow, and HTTP servers would be protected, but we should
avoid allowing corruption over file:// protocol.

Thanks,
-Stolee

