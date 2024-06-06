Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC93197A8A
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 16:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691929; cv=none; b=bAtJCFoeHPusNnlNAWrCfQAqG5E0WxO/6TGYQQBJ0bZy3onOTkmtSZAd3PE3ux/jPgXuaYYy/u0nPyvDO1IFpg4XK5lXnG8UUvsccoZIlmMZgFk5CCBQB5pTBAVr/OU5g2fYLX+yBgiUzpnXVDLGW8uRhzC6s4NDfA79ceeZXFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691929; c=relaxed/simple;
	bh=SIUzLBq4twD6T/OmBl15yN7rhJAe8M+Xg+TdTlpzgJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kNTsOPpgdNSS8dp6BFKpq6CtCiDPzoRidOYkGF/G5kpnktQH+zyw6/g5PEnkfSMMxABRpQJwjvdtqMqqteMtDxED1AUn2nx1LO/Uibngs9gUPvqq2dhVLwwtAq9kVHa0VzQ49jRhWAUFkbzF8thTdEPjITKVuD/JDh5Y6KODEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKdR45UO; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKdR45UO"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-704090c11easo218702b3a.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 09:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717691927; x=1718296727; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfUQNDwVZXBLPWOS6RPEGu0sqdgFm2wm1uXMOc4EDKU=;
        b=JKdR45UOFeNuqwLVNq+W8pJGdLOOdianvu5U1dIOsDe51eGpyR8uywdfLPpHgbECJ4
         Km3BbrSwQOMhTIlunznyHZiFt/dRr6bzIJmGykJvFPrkHcTx29QTCi+XAZle6Yvj3Qew
         UgF8vR0ZoD2H7Y5qzu/kZkZFcUSjdobfIN3f3mCiQTtbexYuEuQVW0dQVNgEHvowbIKZ
         72fODhfqxY8ZUDs3/vsFInbIJdHaauQHWJKiGB+cAU5aHyk8eq6GdjKAhHzhCudFaKLe
         udX75zMT3lI/xJHcY0Esn3rLst3luMb5w1+35qQvf9l+2bs7vn+aDOo4TV3+s5aV3Yu1
         C8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717691927; x=1718296727;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jfUQNDwVZXBLPWOS6RPEGu0sqdgFm2wm1uXMOc4EDKU=;
        b=vkafwoemCi1amBAXbyWKsOcdl42kEK7vz0v82a6WTUZN55vounNA4YzpAHqkHleoKj
         +fWB7wNIJvHa9Uw8Prh1w9EFE6mtvuGceBAURN2TqBCedbnVG6SUPz9kLFvQrvdIjZjF
         9Mg6+dgl7yegf4EC6/pE2+K4PiX1cVXbW2rzTb6JftaGaJ+FTTGBRINqkyI+d0MJoHar
         oqFNmE1XPyIE1N1+t8by2cwA4C66WbxP0lPymyYwpL2BN1uouxtVt6agWEmWTgzu+0oX
         Kkv8tcOv4r8peGiJ4sXeZXGWY2dbGa+YuVnnJAodvHwsm6ZcybQ73JbmYnxocDPrY1ZR
         TkiQ==
X-Gm-Message-State: AOJu0Yzyh8UbPNh7eTEQQMtutnxVoWDHjbVGUmiflFHjZhiDTGhePxIs
	BzUcHTieUSRnCMwltNtPmIY+Zn3V+si29CjVGUXJCxbw1freeDUc
X-Google-Smtp-Source: AGHT+IGuCyR2fdLiGL7vuNuxBmVcxyE3pP8qPxVyMS1PKIsK5Q+WuTGTQhEDylhBdEDBOmaxxfxTPA==
X-Received: by 2002:a05:6a21:6da1:b0:1b1:d519:6cce with SMTP id adf61e73a8af0-1b2f9df70cemr57645637.57.1717691926565;
        Thu, 06 Jun 2024 09:38:46 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd530d25sm1284487b3a.213.2024.06.06.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 09:38:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  =?utf-8?Q?Rub=C3=A9?=
 =?utf-8?Q?n?= Justo
 <rjusto@gmail.com>
Subject: Re: [PATCH 1/2] am: add explicit "--retry" option
In-Reply-To: <20240606082114.GA1167215@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Jun 2024 04:21:14 -0400")
References: <20240606081724.GA1166769@coredump.intra.peff.net>
	<20240606082114.GA1167215@coredump.intra.peff.net>
Date: Thu, 06 Jun 2024 09:38:45 -0700
Message-ID: <xmqqzfrym3fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think even without the test-terminal cleanup, this is a good thing.
> Any time there is a heuristic like isatty(), we should have a way for
> the user to be more explicit about what they want().

I very often do "git am --no-3" to countermand a failed "git am -3"
(or vice versa), so I'll be hit very hard with a need to retrain my
fingers.  But I'll live ;-)

"--retry" is a horrible word, in that it makes it sound like it will
keep trying to apply the same patch over and over until it applies
cleanly or something.  Can't we use "--continue" like everybody else
(like "git rebase --continue", etc.), or would that be even more
confusing?
