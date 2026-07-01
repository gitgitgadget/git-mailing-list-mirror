Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C5125AA
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913528; cv=none; b=S7xYk04FFtdF/1RlUWkw+5T2/0jUgtoo2O2MzYtmytw1BIjMzRv6GRdSCiE4Q8PwuJuICmCuvpnEv5gZQzbWdVVozM9ISJCC35T3JVudVY02eqiV+TYSHKNCEqZPi8zK1qNCMyQb5p6uxwVxYokvQdnAtX3ZpaqOM2q92vcD+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913528; c=relaxed/simple;
	bh=Ym06V2LgZ1ys5tE9a1X0UdKsH21fmE6XpCS8D7paZ8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgGidM4rNRPanR1CvscP1EqXwf58kB7gmEq4gHmhYYrPC/VlLsIghnmSyTqU74X5Rs0ASbm0Esnma7Di2ExJamOeFmBdKZCqs0Ofll5GVmJwv+I6JKO9v4UqSf/ttIms0FyFGeFN357KR5NXL23ZJEwX+MvM1grEAQd6VmhXGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPqVPNs0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPqVPNs0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-697ebe536b6so1270391a12.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782913526; x=1783518326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WkT8bfkv4FNLwn3fHP5W6DEjSdUYi+1KOKIRsdPDsPo=;
        b=NPqVPNs03fGhYGtCsLGt1zYL4W26y/B4OCgbFz8Yy+EeHCdOauzgfgsrylntuXVSgw
         kJei5OeuNBTkCQb05U1fCjZLkzTfaAAMOoYtvWHxwu94KFmhyH4uE0ttfyJbRljaRvms
         Sn86fmgqfb/EvEfXepie5vHpklK6ULJ3cgvGfQKw6rMp1FjxAzq2xGhFzd6xTZEfEzPa
         VfJjIadm4CuQk0c5Kg6Kgi8RV1fU9Ci3tIRZ9q6hvGrKPKvJ/x86br8TwJIVU+zBfkjA
         7agh/FhsK4b/Z14sYw+TtH9qzV5d4qnX9z5nwkwkxia3EcI1hRfivi++TDteb4wjbwAH
         6ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782913526; x=1783518326;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkT8bfkv4FNLwn3fHP5W6DEjSdUYi+1KOKIRsdPDsPo=;
        b=k5NHwyE7ZWeiPKOaS/DHpVOH1gAQ0uXzf6jGfkZxEcl/ua4U5Vr/3S6eLIcme5MM8v
         XtAj4bjoNsSYKRB8vSy6D+f77hPFmdQjXGdVXm52X5PmGRyh48GsLgW+3KTIYrMlcu7D
         KivIRVobrsTwcS89idGE21Yyd4+8zU+UFxRT8OibasGCcvnhel9ImHQsuAz5yvIs16Wd
         OB0dpLuwt0SbYVQ04JuY18hrJjkV7IljjXJxnZr5vpRoSm8KaMuxWkPWpo/0YOxmlBuP
         LHzMIk31+aCRXrbaXYtdQ1w0qbRscwVdyekJdUR/fGofHvl88RYIOvb7Ef6lVWNd6mLk
         i3Gg==
X-Forwarded-Encrypted: i=1; AHgh+RqdZoMn8HjLiWB2DnQshSg34QEa7All5a8KqyDSNfL7sh3hTAKCHwlStlsvA46RihTILTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvyReHWpEHjiEQlND9RSrm/nvfe/rvqdD8IAAdsj6flgJpX9eg
	amIkiKDQqk/7p9mcOLzVuV82tQIFTvBXnPfdxhfbZY/Dh/N5uBJ36Zx+
X-Gm-Gg: AfdE7ck6H3IZpt4tca5c1tG2Ved0MdYR2rmdwPsqSj5XLOxo8kp2DL+bS0kaF10MPVB
	7hGz0kzDg7ZsCyF+5IxL7VnqWQzGGDJz5eEPq2iLi/bIL+cQaBBgHoxeViw8vYuZvF2FG4r89MI
	KXreXvwqW709QEaxAa00VKbZvK1FfzPcQhMUNDszJYEnhnqA/qG5TgPj86YLjig0Ho+XuSvloYd
	Y9TTywHV/Z19JLXkDYaxaafMty85p1PAi4iGImEqHolPScYiOMbFzbcR5k9X4/PD5fo/OVfAL4c
	f18QHbqNWHLa+tvW+kYM9ZZrVesxMFo/1xoTDSqzxRA2seYmpeMCFboM794j3Otr6Rt7fnMsSUu
	DEbczIqMSA4dZO4PS5obRhzC/aQRv1nGmckjhS/N1d8x10gGHM3wrQ7HUxNfVu5wFUFBK3a/IY0
	soOsTXzx51f7aXs1yE+XGrDaw54K2aQxY6s5d5A6wFG+ik1DqHnHensoKj5yoAQRkZTqk=
X-Received: by 2002:a17:907:6c0f:b0:c12:1dd4:13ea with SMTP id a640c23a62f3a-c12aa142a5emr79119966b.30.1782913525687;
        Wed, 01 Jul 2026 06:45:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6a3e8sm276418566b.19.2026.07.01.06.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:45:25 -0700 (PDT)
Message-ID: <f3fe7ff2-3ce9-4e90-95e7-8c620de5628a@gmail.com>
Date: Wed, 1 Jul 2026 14:45:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com> <xmqqzf0dwalx.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqzf0dwalx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 29/06/2026 17:54, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> We should sanitize what the user passes though - we do not want to
>> accept arbitrary rev-list options. Off the top of my head "--left-only"
>> and "--right-only" would allow the use of "A...B" and allowing "--not"
>> seems reasonable.
> 
> I would not recommend guessing what these rev-list "expressions"
> would produce and blacklist some of the operations and notations.
> It would be a more robust approach to let the machinery do its thing
> to determine the set of commits, *and* inspect the shape of the
> history these commits represent.  Are they connected?  Do they have
> a single "bottom" that is just outside and below the range so that
> we can replace it with the result of squashing everything together?
> Do they have a single "top" whose children can be rewritten to have
> the resulting single commit as one of their parents?  Starting from
> the acceptable shape of the history we want to deal with, rather
> than trying to enumerate rev-list operations and notations that
> would prevent the resulting set of commits to fall outside the
> acceptable shape of the history (and I am reasonably sure anybody
> who attempts to do so would either end up with unusablly narrow
> subset of what we can reasonably handle, or miss some cases that we
> do not want to handle), would be a better approach.

I think we still want some sanity checks similar to "git replay" though 
to ensure the user has not overridden "--reverse", "--topo-order", and 
"--boundary". It will be easier to sanity check the list of commits if 
we can at least rely on those options being set as we know what order to 
expect them in and can detect merge parents that are outside the range 
by looking for BOUNDARY commits.

Thanks

Phillip
