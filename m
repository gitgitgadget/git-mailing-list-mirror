Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38428E7
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 01:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751853476; cv=none; b=qcvr1A6iBzmn1BazlBE6vEgf1sea/mM+nmaZJV5hj3a82GBcLD9J7A+jOXcijaGfj1VT/EDmghHnu980C9y96AMNnzvEzBJEKVNlkW4Mbl2IQbn5XM2Ejv907hGp4dS4RH1m/eHUTt7TWTYO8eaDMQpE9bUBMLB2RisMMBwlIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751853476; c=relaxed/simple;
	bh=2qUjUXkHVcyA/XWsRUTO81eOI9R6nB3X0omMp69SGPE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Q/Bl2r5Wzk9v1E1Si3s7niycDzTohh2pXt+B7LWKqTP7P/wEsZnaDaPXQ0Axmzujfg2pJj2YbZ8YehnQ45lFGn7h1wxwZB0sA6fn9KOENATVDXMYrcWHVkmdujxst8HpH9nF5meKci2ZHqe0tI/pV81VIbndrSiHZ4T06d7NfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDi1iwv5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDi1iwv5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23649faf69fso21479745ad.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751853473; x=1752458273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=heNbmBT3MudOY2pJS1sxw1axgqKF9APWZnLFgcy5Sro=;
        b=YDi1iwv5GyUW2E/ZNtrIEtMXP2x+F9EQAIfoFyHb90Vxs17L2WWDOFWEgpyCxXBiOC
         eZSfaNPlm06gaIkvFFoJPswNPRQ5rFXcyJAZuQgOT/c0EjYvnFeh9S8FtbjZf761G3R6
         AswLelti01JXHE+zOsj6xppH/4XQf1QAXrVosh3J9n0VgCtYj8DIKPNRHDv1qVxev+M6
         dSPGDL1l1w4sihTAjSZ2pQKvIalqdWgForOQzfaASuv3gcQo6PppWfZyLQd5eWnLhMDg
         ltOENXfVWcC/XJ3EWxwAtLGVm5Xure0hs4aFlia5lTRl3Y6wBG/d7wq5Ihj4tZm6rDo8
         Pspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751853473; x=1752458273;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heNbmBT3MudOY2pJS1sxw1axgqKF9APWZnLFgcy5Sro=;
        b=PNSwQpTTF8eWPjYfBTwoZRPtrh8LEMrCwke70NBdOzm9fqJU7q9x4kQAw/2gjbI1+s
         Ts5hRukiFL2KCfIvW5rXk4Is3R0jXXkyuy6NqKIKccub7DrVR1gCuBvGJXHz7uftN0pk
         AmT4GBcFWt7PU55SDW9WZbm7kNANtNQelKRHCrevDl6y+INqoYj7K41YnHrRfeQTh71l
         Fx6Y/Ibq2DVD4gVAA8U46+s3/kPcvFWThPLCa/2967Cy0hhvBQJLk95e96KDTwOeJQzA
         cAatx+rBlq7LlGMgWEZiSV5wEMyBf1E28iKvQWCZgkTdVUpRqKH2o7ZfnsiYJ0CLgkxn
         VMFw==
X-Gm-Message-State: AOJu0Yy8eYxbRX+ZXychh8xhz1eTsjetkMlo7FBvzLZFHVkS3xjukb84
	+jhL+bU9dmk8KFtpJPIxnY/2oAZCqwJeAavDFKVEvCkary+CWpHIBDoJ
X-Gm-Gg: ASbGncsFDy6k3D7cnB6A7WmzlXSmMh96WbckrGEm7Mlj0Cv6yqAXcxXqZ5nM0RdHgZY
	1Fjs11JF8Nj/VYl8hSLuuD7/qbJoPwPUg7HauFXEf4pqe/L4PCr66FGuPFeQxtMwR33nJPGltws
	i0dK+53GOFHTF3Tgey8XCIO6p8hqlFgbuhWBzRALc/b2hisTWULphxC/CSrU90HGljUryJeFkwS
	NY28AwqNHOfafOqHglps35E8gPLhv+YUFiigo15yjLF4ZHt/2Nac+/bBd7XcGl7wttE64E8FE21
	rP4WU8OaCeUeSd223Wn9RjNT9MBAGJHT0Bx0d5bS1poTJ+qP7+wh/PNTEJW/7gByM/u4
X-Google-Smtp-Source: AGHT+IE663MANUUAlt3yVp2UzQtfoDv2oKJt9i7UkRdmr66BomhrFmnWsk5U62Hqmt1fjtWu1e+8VQ==
X-Received: by 2002:a17:902:f644:b0:234:d399:f948 with SMTP id d9443c01a7336-23c875428a0mr137664725ad.33.1751853473288;
        Sun, 06 Jul 2025 18:57:53 -0700 (PDT)
Received: from ?IPv6:::1? ([2401:4900:1c96:b11f:687a:805f:890d:97f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457e9d6sm75104195ad.151.2025.07.06.18.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jul 2025 18:57:53 -0700 (PDT)
Date: Mon, 07 Jul 2025 07:27:48 +0530
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
CC: git@vger.kernel.org, Jeff King <peff@peff.net>, redoste <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqv7o4ajq1.fsf@gitster.g>
References: <20250706163009.335780-1-sandals@crustytoothpaste.net> <xmqqv7o4ajq1.fsf@gitster.g>
Message-ID: <2DBEA13C-5E74-4314-9A39-E045A0BC221E@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hi,

On 7 July 2025 06:41:02 GMT+05:30, Junio C Hamano <gitster@pobox=2Ecom> wr=
ote:
>"brian m=2E carlson" <sandals@crustytoothpaste=2Enet> writes:
>
>> Our submission guidelines require people to use their real name, but
>> this is not always suitable for various reasons=2E
>> =2E=2E=2E
>
>Another thing to consider, which may matter even more in the context
>of SubmittingPatches, is if it is necessary=2E  If there is a
>requirement, which may or may not be the "real name", that is
>essential to keep DCO enforceable, we will not be able to drop such
>an essential requirement, even if it is "not suitable" for some
>people=2E  We would have to rather ask these people refrain from
>contributing=2E
>
>But if a requirment we currently have, like "real name", is not
>necessary and if "known identity" is sufficient, then by all means,
>let's make sure we can loosen the wording to make it "suitable" to
>more people=2E
>
>> In addition, there are some developers who are so widely known
>> pseudonymously that they have a Wikipedia page with their handle and no
>> real name=2E  It would seem silly to reject patches from people who are
>> known and respected in their open-source community just because they
>> don't wish to share a real name=2E
>
>Yup=2E
>
>> Retain the prohibition on anonymous contributions that the Linux kernel
>> has to ensure that we have some line of provenance to a known (if
>> pseudonymous) author who might be able to respond to questions about it=
=2E
>
>Where is this reference to "Linux kernel" come from?  Shouldn't we
>name our own project and adopt this new language for our own rules?
>
>And yes, total anonymity goes directly against provenance traceability,
>so it is not a passive "unfortunately we cannot accept" with regret;
>it is a lot more active and positive "we must not accept an
>anonymous contributions=2E"
>

I want to know how we deal with anonymous contributions=2E Let's suppose s=
omeone creates an internet persona claiming that foo bar is their real name=
 or an alias=2E They make some contribution and then abandon this persona=
=2E So, isn't this effectively an anonymous contribution?

>> I don't claim that this is the best possible wording and I'm open to
>> changing it=2E   The term "known identity" comes from Linux, but if we
>> need to clarify using different language or otherwise change any part o=
f
>> this up, we can do so=2E
>
>Thanks for writing this=2E
>
>>  [[real-name]]
>> -Also notice that a real name is used in the `Signed-off-by` trailer=2E=
 Please
>> -don't hide your real name=2E
>> +Please use a known identity in the `Signed-off-by` trailer, since we
>> +unfortunately cannot accept anonymous contributions=2E It is common to=
 use some
>
>Drop "unfortunately"=2E  We will not accept anonymous contributions=2E
>It is not like we would wish to if we can but somebody else tells us
>not to=2E
>
>> +form of your real name=2E We realize that some contributors are not co=
mfortable
>> +doing so or prefer to contribute under a pseudonym or preferred name a=
nd we can
>> +accept your patch either way=2E
>
>Thanks=2E
>

Thanks=2E

Ayush
