Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473A6E613
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717570347; cv=none; b=Ucjr6IrmoCCSXYoRiS2NAsQK3+TnbX2VX9mALXorJbRm7CtbvuFm5qC/O4AbjaDmVqoqbV82OAVachNy986qy+5jvhYP9InJED9YzVKKHFtICzEtNt8jJ1vHevKRsbVl2bDeQKMxWx097YZAkkvIKGhiKx/TfdZk2AowFShHceo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717570347; c=relaxed/simple;
	bh=FMgPZfkv+TvAtmXmEehBeWz43JbTmXFrHv4vAi+GMnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUBqMB7hXH8TFAHdgNjCEng7D6eNApxfh+vbRvTDcxNEo06mWZZeew+BTwsq3hbCKTiXTdev8lkWd5SvbrRSjS33QOnwQbhZIVZH1MKj3JYsaUF3rZh0UZ/WGb02KXmcg5T3VW4cq3N8ox7SBDZOpUiyVtnhhs8+7LLgUUHBZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etxG2Ifn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etxG2Ifn"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70245b22365so3912265b3a.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717570346; x=1718175146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMgPZfkv+TvAtmXmEehBeWz43JbTmXFrHv4vAi+GMnU=;
        b=etxG2Ifn6cxVhCx227jxHpEpsklaMJnxw1B5uNewj78h5oe62iK1MrPI4gvS99aEeE
         Bw94rVRE4cr692x1UTiFeqAq/aicyhfkTJs3+ejyrJ8xd9NERCVu5XtdwnTzFUI5DpAu
         wIVvFSiBpfTC7aARC9ITouExvM/LVJXte9wzCDIqGGsbnas5EYLTa4+F9wArmL9wl5Sz
         tFXUfJdbGxujY5R/SojZYnEDk7wDPRIrSwx7uIArUptpUutHT8H5fPyprjl5oAJMdKUT
         fVDvq7Z7TzerFobXr88NUB30ybvSLAC34cDA33VeMXJugpNn1bU0mCJc1uTA1gSiE6Ik
         jpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717570346; x=1718175146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMgPZfkv+TvAtmXmEehBeWz43JbTmXFrHv4vAi+GMnU=;
        b=g5+tVm2+r7YbMUJBiJ9vCSTZwySAxE1nnH720fAmt6j8iGkwAQ/TzSgc7e78DUvBXs
         I9Rb4TRK8sv5G9ta/yEIQnZDS5C14u1NsBIB2Fb1xIIzTIBU8KE6p4mKHcYGJXDSkgtY
         Yxe1UoDFLGG9LwqZKB2YZ/afKHCmhfgXEITI5wQBgqRgI7t9vOTfO4LQpFCUSTiP8r0n
         Gv/sFLHIK0GGxrzlZTvFJo7aCQY6mwuKci3fzzMrhWe7/QJF2FzTJKFqiunUHMKLiqaB
         LL2XFpTfAdq6doF6N6YiWg0tPXJC7O//uyjSVDs9oj0irQuW4Xto7J6yNctdxsX8eKzD
         Pk3A==
X-Forwarded-Encrypted: i=1; AJvYcCXrbvrzWNUXT38+po5p7FZLY4ag0U4GZl0CT/K0dPlVUerd1l63H5wPjn92CjQnMRCrdpcBiVgRa63aCcmfQs2JEFfO
X-Gm-Message-State: AOJu0YzlhmCSq1puntLQj49hwhLp5MC44rKmUG9YJ1ZcCRcNSCGWrDMm
	GXJ8sZ1e4KAjn4mDyWxu5IXA+KfjKxHHBkONJArUkVYK4j8UciJ0
X-Google-Smtp-Source: AGHT+IH40VWqKWFGOC/9WH4aP3QYSZMc/XuUUfu7NGJyLMN2p2CX4vaCVdKa2aKTNaTZ2WJ6atqS+w==
X-Received: by 2002:a05:6a00:179f:b0:702:3a47:2b13 with SMTP id d2e1a72fcca58-703e5a7b1fcmr2095411b3a.22.1717570345637;
        Tue, 04 Jun 2024 23:52:25 -0700 (PDT)
Received: from [10.0.0.8] ([101.182.100.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b055dcsm8290019b3a.172.2024.06.04.23.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 23:52:25 -0700 (PDT)
Message-ID: <c525e112-b4da-4871-88fd-6e62b3ff1ba1@gmail.com>
Date: Wed, 5 Jun 2024 16:52:21 +1000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] date: detect underflow when parsing dates with
 positive timezone offset
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
 darcy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
References: <pull.1726.git.git.1716801427015.gitgitgadget@gmail.com>
 <pull.1726.v2.git.git.1717369608923.gitgitgadget@gmail.com>
 <xmqqwmn66zzc.fsf@gitster.g> <2d771a72-3021-46db-ac32-e008a7ace34c@gmail.com>
 <67c23773-21a4-4ad5-9b98-5e44578166dd@gmail.com>
 <4574e410-ca1a-495f-9835-14ee3fa454a1@gmail.com>
 <20240604093345.GA1279521@coredump.intra.peff.net>
Content-Language: en-US
From: darcy <acednes@gmail.com>
In-Reply-To: <20240604093345.GA1279521@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/24 19:33, Jeff King wrote:

> I think the 2099 limitation is there because 2100 is not a leap year,
> and the code has over-simplified computation there (it counts every 4th
> year as a leap year, which is not generally true for century boundaries,
> except for 2000 because it is divisible by 400).

Ah, that makes sense, thanks.

> If you're interested in picking up the negative timestamp work, I'd be
> happy to discuss it. It's been on my todo list for a long time, but I
> never quite get around to it.

I may look at this in the future, but this looks a little out of my depth
at the moment, as I am still unfamiliar with the codebase.

For the moment, I will just add the check at year 2099, and possibly will
revisit this when I have more time on my hands.

