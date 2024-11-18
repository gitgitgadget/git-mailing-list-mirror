Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636EB1C1F14
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 22:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968405; cv=none; b=WAJSP56xJA7mnYS3h+JrYxYSkxDMaA7okM1HrO1iwsUe1x29gj/54uucJjva7ch2IwnEWd2sgiZN4RO4Rk+syG4+HFh7xwIDOWEFqyEM18NYvbTZXDev7vLL28Rn04oK6gURjWJQWT7xWcCNW0HL/LqByGyQZr62+O8MouZ+Xdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968405; c=relaxed/simple;
	bh=QfZPo9JtMQMiDTV35tx2jFS7fr1uqPl5L0/BgvN8xvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIJmtZYfWYEbuiv59xh3e7h8wIB2HrewGsqNAFdsU+25s5dwjK+ZwVWcQt9f5JAVAk2swsubPwaohFIJ1uUf5Rr2bC3Lk5o0oWS5mBlfLqmf5gJwTCTYITVwmzDHII6kr62rXkuf6UYWsuvKZkCsPd//Q3mlFggjs091YAtg86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb+Dz1uX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb+Dz1uX"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431688d5127so1878615e9.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 14:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731968402; x=1732573202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iaai5FypHfB36E1sDZzSUeriQAAsrxOwVkNaLVoTwLM=;
        b=nb+Dz1uXDG1zUA/f2pD/6g0wRNs6gmumqMU5MEStV5b1BpbglXJeelpmvhCFJxIv/o
         KpIvXxPEn15Ljz43LZPgTGAmhj5lXId6M7dgDwguxqBYCyKb4527xaxa/LPvkrNxOZ1u
         SEi6dPtIJFR9t6NxeNs83KAyzi7pGnvDDqAF3vEQTF8Yfb1Q+ZcSZQu3hAGmnSqDTQjA
         Ygvokfthq81rgXkWZFpJLreWFMYCEMU/DviPF2HCUlcIFNqtV8/zPnyzFswLVCbuo/0/
         Oqh9Iv0b76AO/8xBMitSZAr2fQThyyLa6jEACJxHuuQt/FsV78KayHPt/e17oRNWMgKb
         BAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968402; x=1732573202;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iaai5FypHfB36E1sDZzSUeriQAAsrxOwVkNaLVoTwLM=;
        b=TSsfs/oWQuFLhRwXGYbOJ8UXlWi1Xtr4x81PDQ/N+ugCkP8y4fm442hiCJcy4H9qkU
         z4chL1EWAW3KmDj7i3mTb6ijfVKfK/kPokqmjX2zOQTGh9BLUAGjBJNYlwE5UC9FhKJg
         V4FxFOmZ03DCdCv5aJ5WNh6gBUEiEsWyFAgKpUcgdxQkST7VHfdOSQkWb1KzY7VTp9z5
         PNeD2L+D5utW2MgJa4MhwCGBHSqttNePdkizr5JUofw8P6CJa5LOIGZnReFk5rSBVRkP
         CkuCwybmaypwsuQFP0FZZ5uIWqF1kJVvXI8zZO50ZLt1wKOrBwrdncQCOCdQvckZw34J
         Ia2A==
X-Forwarded-Encrypted: i=1; AJvYcCWBATCnOiI0IdNpo21A4fwTUR0hDc0TlX1U6fFrMr5vtQ8DTGT7L8eKkrNKvvtizg4mMVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqW6oiRTaK+sWpjVcDh9SIL36mVUHM0+0NcaVptyi2W/nGw2Q
	Owl5Vg+Im9VO0MudBtppyaneBYilJdzOgZ0HH7J6HwCN3v0cimnlst9vrA==
X-Google-Smtp-Source: AGHT+IGHD3Ef2CEurjMPnrCE5JXN4dqGwHtwdUHmXiET8eTCgb8RuMSPTuZ2dTVAZ4vuyk66AwPuuQ==
X-Received: by 2002:a05:600c:b8f:b0:431:561b:b32a with SMTP id 5b1f17b1804b1-432df74cd6fmr119797715e9.19.1731968401485;
        Mon, 18 Nov 2024 14:20:01 -0800 (PST)
Received: from gmail.com (169.red-88-14-50.dynamicip.rima-tde.net. [88.14.50.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm176787315e9.24.2024.11.18.14.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 14:20:01 -0800 (PST)
Message-ID: <5d9d45d4-b1ff-4349-aaac-e7461609363c@gmail.com>
Date: Mon, 18 Nov 2024 23:20:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Nov 2024, #06; Thu, 14)
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy11kys9z.fsf@gitster.g> <ZziAy187d_VU55QM@pks.im>
 <e540c259-df6f-4b65-9066-606beb462f5b@gmail.com> <Zzrh6xlxfOo9q9gn@pks.im>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <Zzrh6xlxfOo9q9gn@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 18, 2024 at 07:42:58AM +0100, Patrick Steinhardt wrote:

> > > Rubén's review went through all of the patches and his findings have
> > > been addressed.
> > 
> > Yes, this iteration looks good to me.
> > 
> > Two thoughts about the merge:
> > 
> > First, I'm concerned that we may not have sufficiently documented how
> > contributors should proceed to prevent new leaks when submitting
> > patches, and perhaps avoid some unnecessary noise on the list.  I
> > reviewed Documentation/SubmittingPatches and didn't see any mention
> > about it.  Perhaps it would be helpful to add a note about
> > SANITIZE=leak.  I'm unsure if we want to be explicit about this,
> > though.
> 
> Nothing really changes with this series -- we already required code to
> be leak free beforehand, just not in all of our tests. But in any case,
> providing pointers for how to check for leaks somewhere could be helpful
> indeed.
> 
> I think that can happen outside of this series though, also because I'm
> not quite sure where to slot this in.

Re-reading Documentation/SubmittingPatches, I think the recommendation
we already have might be sufficient:

    Pushing to a fork of https://github.com/git/git will use their CI
    integration to test your changes on Linux, Mac and Windows. See
    the <<GHCI,GitHub CI>> section for details.

Anyway, of course it can happen outside this series.  For me, the
series is ready to be merged.
