Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBE48A2BC
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912669; cv=none; b=Xo/U5BFehd81b9wTAMSr7USYAUhPIogFJ0TTLJkziRc8pdoPjk90yQTod+Uz6mSbU6c5tqeZwIqm+y32jocj2sLJrR+Jy1A7EM1ZwcdCQs2tmrqeTcJZK3eZA5W/DH/DNpEzmI28s73Zik1YTEBbHmVpNpCORdZkiucdjd823oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912669; c=relaxed/simple;
	bh=mT+R6F5d6ZVMIBHlaxWftDsNCShJbcK85a+V9Cf3GPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBtXxkC5j9kx/0JnlzzPzT+bz1jRZrNiLRUD6zT7/MnPYx4d4lN7XV0YZnGOGxTScJ9bV26CSA6cOVSwBoOZmkJPFhDyocgvcqOrzbdA/Le1I2oAsdEvIcZkYXdVk3TPZdoXQOCVZhVjaBcKI2b3n+SQXRii5+NLbf9zzsBf4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1XR42rw; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1XR42rw"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so1191651a12.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782912667; x=1783517467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u3NRvtmo7u4qXRD9T1QccRmDEmMaTAILS0u65Z2pekw=;
        b=K1XR42rwWD0xNT03nsAeKuGNn8/vsm7gbmLHtVsBR8E1/1c2QiHD83MCCF65cUIWVs
         oVow2UPnUbHrY0xtGXcE3LzzFdnMYFBq30du4fXuaYQq7xEeYk5zeqaerkVvv+Fz0wvt
         gt8vckljD8F0GXMCbCzLjw2dAJ1xSoLzwftqkkLX1utOL0BETbnSa5tb0WLq8jWBaupc
         kZKDZW+UywlzJMUAmf2g4+OU1dTOuOedJfx4CP9c6sYHeAAy37kSDOkGj45dgy5DTCh9
         K0CPi+96+xun9R12T3g7SqtqlQiRphOF5jBt7ihoSHUxNnedwwPFl0tNIReUJelSWLaU
         uB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912667; x=1783517467;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3NRvtmo7u4qXRD9T1QccRmDEmMaTAILS0u65Z2pekw=;
        b=n4RFLASgm2c4A1jUfiBZHrKSDJPddH0w9DbiiL7gtfLHkKinr6dfMcsZVrW0fLoIqP
         2+fxviUXh2LdBZPrE51gVNra8cabYXAka6vrITeITrFv2Bcgrz7lDk40a6y4VCTZNzOW
         qM+xjiVE+ttUPwrnwCifrOgF7HOOvGQnKXpOIPaSYmDpVnqJ+U/XUo8mjBjwIPQQnKKI
         GVuZrA4q1nTikoSjjtf1BZb0HvMGCSLjqzv9bm+LcgHKyiVZBYeHWQHjcKloozkouqVj
         FtnKbHO5uFGT8AvtDo9Pxe/r+ywqKYHDLv8SJYWNq5NkIfLEqu/aEXVcVjuuX3d2cEIT
         HAVQ==
X-Gm-Message-State: AOJu0Yz5dbxUFnP3qwx6Sm+h+9gtVXY6D4EQYwl2OJusZnZuWisrmN3U
	16DYGD2mNa+BJ46k703FyQbp8Nsy6NSIsCMmnNRBDGMPerECSOof5WAT
X-Gm-Gg: AfdE7cl1R0gz1x+cL6cYhiEvqYI1gprivrp2mKWJ7hJDV6YAqotA3fGzvgmjqN/nms1
	AkcrhaiqGypP+9t2ryP1JFXe+L5IBU+tyOvzt0VR/GfjzUU1map0JA4jnKD/w6w3EDRcclyPleU
	XE7xnpSL77/B2zxCIk6bMjbWl3m9vS0cCWkvmf3VvlxztH0k3hmkPQ1rbJs7tupBtvaZ9eNUVBY
	I1R8oDdxVGBTG58GGzuAUNbbNLU+zX4HL/+ET67C+deISBJFWjl5tpMtSwrD7g5zuUtAfiMdHdv
	rYPkwNWH1UKYyTC8M7gS65eYg+JBhziwhtVFC5ba0LNipkKMMxTasUSrcDUNdIiRmdIWst/nwCQ
	0x+q6kERHil9NP+eagTZvpDNaQw0sxmKsmOg21oSK6hNSdlW8BI+0oCgXSu/7OhxApHMkAuctcX
	CSu20y4mdI13B0Lsw/jWf24FAibmApg372Qxp79V16o8pRTEQ+Pvm++bLRJeTiaHyxy94=
X-Received: by 2002:a05:6402:254a:b0:698:3ce6:767f with SMTP id 4fb4d7f45d1cf-6989f2f2699mr956542a12.12.1782912666259;
        Wed, 01 Jul 2026 06:31:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3a3f99sm2706900a12.3.2026.07.01.06.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 06:31:05 -0700 (PDT)
Message-ID: <dce74d17-eefd-40bb-82f3-f6b3179cc2b6@gmail.com>
Date: Wed, 1 Jul 2026 14:31:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/11] sequencer: do not record dropped commits as
 rewritten
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Konstantin Ryabitsev <mricon@kernel.org>
References: <67dbfb5c-5f07-49b8-aa32-a4635c585028@gmail.com>
 <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <xmqqpl17rec3.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqpl17rec3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio

On 30/06/2026 20:57, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> I have a bunch of typofixes queued on top of these 11 patches (made
> with "git commit --fixup reword:<sha1>"); please double check when
> you reroll after seeing more substantial reviews than mere typofixes,
> possibly from others.

Thanks, I'll squash those locally and wait before resending

Phillip

> Thanks.
> 
> 
> Here is the transcript of failed b4 am invocation.
> ---- >8 ----
> Looking up https://lore.kernel.org/all/cover.1782833268.git.phillip.wood@dunelm.org.uk/
> Grabbing thread from lore.kernel.org/all/cover.1782833268.git.phillip.wood@dunelm.org.uk/t.mbox.gz
> Analyzing 17 messages in the thread
> WARNING: duplicate messages found at index 1
>     Subject 1: sequencer: Skip copying notes for commits that disappear during rebase
>     Subject 2: t3400: restore coverage for note copying with apply backend
>    2 is not a reply... assume additional patch
> Looking for additional code-review trailers on lore.kernel.org
> Analyzing 0 code-review messages
> Checking attestation on all messages, may take a moment...
> ---
>    ✗ [PATCH] sequencer: Skip copying notes for commits that disappear during rebase
>      ✗ No key: openpgp/u.kleine-koenig@baylibre.com
>      ✗ BADSIG: DKIM/baylibre.com
>    ✓ [PATCH 1/11] t3400: restore coverage for note copying with apply backend
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 3/11] sequencer: be more careful with external merge
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 4/11] sequencer: never reschedule on failed commit
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 5/11] sequencer: remove unnecessary "or" in pick_one_commit()
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 6/11] sequencer: simplify handing of fixup with conflicts
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 7/11] sequencer: remove unnecessary condition in pick_one_commit()
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 8/11] sequencer: simplify pick_one_commit()
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 9/11] sequencer: return early from pick_one_commit() on success
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 10/11] sequencer: use an enum to represent result of picking a commit
>      ✓ Signed: DKIM/gmail.com
>    ✓ [PATCH 11/11] sequencer: do not record dropped commits as rewritten
>      ✓ Signed: DKIM/gmail.com
>    ERROR: missing [12/2]!
> ---
> Total patches: 11
> ---
> WARNING: Thread incomplete!
>   Link: https://patch.msgid.link/cover.1782833268.git.phillip.wood@dunelm.org.uk
> :
> 

