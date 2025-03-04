Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936320011B
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083814; cv=none; b=nqWALylR/LIN0H8DzFQorqviVwgV8kMjlnDDjzPbT45ptfZnEpmT5fDi31gSqOo0RbIPSFfWvJUmgA8gMgEGioNnlKG5aPqN2YtnU/sFoX3Y3iXct+xsUIB4xP7VZHhv3JrLudhhrZcSPs+gtEdW0ANNlGccZ+n/pXNLVziSz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083814; c=relaxed/simple;
	bh=4WFB9JVweHDa1wg2grrbhasPcZn6Qddq+3vFEc33e9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNAOu5lyJ34HJuU4m8chgQxcw65ZIPFHqpPgyDH9bMx5Kf1cyUSj27WZ05+10frHCJru2otWFwPcbgaulINDDspFyCbFHd8beuvlgcHetyFnn6xK4ij2HrKhNkJnupUVp5gIn1MAxwqL3wcP+mguUBUzD8jOWXlo95nI3de9X1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNcfw+f9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNcfw+f9"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso10198707a12.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 02:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741083810; x=1741688610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nQPy1CZWQSQ3HScMHeSMRb8LMPkEnRjn3ombSYtjAgw=;
        b=HNcfw+f9X486DKvg7Z6uYVnUfyZlvhtHxCYs92bfO02Zy34cleH43tJhcLV16tTnDp
         uESX2NCXSPlRQag481xUWqlVv6PIXiizNIHnW3+t5FMZr6AZ9AGttOXtoMPDpCoTuPRc
         Dfu+Psem+8iCcZ5sUr2I3jirS0NH2hPqJnQVxHWXy5oBV9hngf6Rga1PHz6zg+Kr2p1S
         PqubaKLAzjUBuxyvg340cDcYSxd8izRv0dP9WYx1ggwMLV7WXJQO7/mLmksP09g8k2Zb
         rS5f0G7bff49TgajSOPxJ7UCaTbXMmSDkVDAa8u2QqXrtOj8SaSfdK0OW6lanJDCVV1g
         a79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083810; x=1741688610;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQPy1CZWQSQ3HScMHeSMRb8LMPkEnRjn3ombSYtjAgw=;
        b=kBHCAjVVex9vhdsVXd0CsAWpn2sX3AkrCxWy/k9zXAuM1QFdQWZBlVxZgGFVfIk5Sy
         JUjoevHWBzPk0HYp5ldx0PMCRsyov2ink6FPoOoe1QK6/s7okqp1POH5gBP3kIUxryxv
         0OLaxieVHI8nauYpaBbpiTjiOWgUQnXTQw3Rn1T4rQ0eQh9BATUg0pqu3sqAbKjgPXfc
         fUREUwuWcTHNj26xQthf7ppCVamUfTHvtQympBFO0wAbO2DNIJdBbQnl7FnHkvAhkqrY
         68wQvGMMaQYmnLln1P+TDe1bab3tzRCe8Y+r7sgxkI80tRv9PtpJtgeYDJUx17owv8qB
         8pyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMJWPVbNviEI7jAFmeLHLmrhUx7iPlAM7/Qzpmhls/JcKwvoZmGM7CQakTmDPkS66Zu2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EiTEhV/IoYK5YZCfGoNHvKkEo8GYSkjJzQknOdpE+4dxjCLA
	ACJ6Pwn8WdOONvrLHytCU2adk7nEAdRD6bzwNNpAic1dy4VyfNuI
X-Gm-Gg: ASbGncsgNe/xKofD+UR+VQlgNjD5sxMhKLGJas0SIc4mq1MBQ3QZ1IzZbsWTDgzdtsS
	7D5WAef0IbC6k11sn/+LMT0Z8SG98WCB+r+vK//axrlySO6672EkBRHUrd7uyaWdVQYFQ4TOK5e
	1TkxcwtUxxXclZ2F7/MPReoUuG8I3J5yqQSRX5w53RPZTGA5PMNKvjUbq1ixalYxiCg8m8CQzap
	SexZjaFkpQ0P0SKaUoMUU/fYAztfF0OFhUe7KW8kQgfHBrrdoArlPTaQdB4sdo9rwzImSjahLOm
	MGwDC2jEqyAe4f37jxreA5Nsz9sZJX1oN41EE+TKiRPMlrczYnXVKswOhWeDjJy2W/bPV67Y5ME
	q6oZxZzlmAIaOa/wKWDkFIfI=
X-Google-Smtp-Source: AGHT+IHiI+0a9IDoC8FOGE9ZSFcrAUvwYF21LCV7REo5vL/Vc8OEzm2uiDx7QTro11E7n1rBH0O+pw==
X-Received: by 2002:a17:907:7247:b0:abf:78df:343b with SMTP id a640c23a62f3a-abf78df3db0mr626624066b.21.1741083810391;
        Tue, 04 Mar 2025 02:23:30 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf58804b49sm538340566b.26.2025.03.04.02.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:23:30 -0800 (PST)
Message-ID: <2583368f-c7ad-4088-b78d-f6d972c4ee47@gmail.com>
Date: Tue, 4 Mar 2025 10:23:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] docs: fix repository-layout when building with breaking
 changes
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1871.git.1741018310447.gitgitgadget@gmail.com>
 <xmqqbjuivuzm.fsf@gitster.g> <Z8afGexTdlqDnPV8@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <Z8afGexTdlqDnPV8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 04/03/2025 06:35, Patrick Steinhardt wrote:
> On Mon, Mar 03, 2025 at 10:18:05AM -0800, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>      I copied the name from the test prerequisite as I didn't want to have
>>>      different names for condition used in the tests and documentation. I do
>>>      have some reservations about the naming though as it means we end up
>>>      having to use ifdef::!without-breaking-changes[] or test_expect_success
>>>      !WITHOUT_BREAKING_CHANGES to document and test breaking changes which is
>>>      a double negative.
>>
>> It was exactly the first thing that came to my mind when I saw the
>> change to the Makefile in the patch.  Unless our breaking changes
>> are all removals, which is not likely to be the case in the longer
>> term, "without-breaking-changes" would be an invitation for
>> confusing double negatives.
> 
> I remember not quite being happy with the double-negation myself. I
> don't mind renaming the prerequisite we have in our test suite for
> consistency, as well, if you want to do that.

Yes, I can do that when I re-roll the patches at 
https://lore.kernel.org/git/pull.1863.git.1740149837.gitgitgadget@gmail.com/ 
to use WITH_BREAKING_CHANGES

Best Wishes

Phillip

> Patrick
> 

