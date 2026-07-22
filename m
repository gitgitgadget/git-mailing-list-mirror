Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D0B33FE33
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727582; cv=none; b=kW/aji2RDlr8nKfJ2h3GcaRuvOHOtMjRtfd6I9QauSdKMD/wMuUn/LMQQbb0xATjTWMo5Ubo2tyf18GUY0InXBGxkQXgPl8O8EUfUGnumnoZv/Vcy3da6JxhOprmsjU9vKl8vUHEMmBS+3EZFainmfvRfz9KO8dLkJSqaZ1GWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727582; c=relaxed/simple;
	bh=rPD1cefl4eyZenGhWBs9Nu8EtX9SWfUwKaMr7mkOLAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLO+nBCw+xJ+9bNk2n5BknJ7MCkN+zVSJGM/YOKK4np7IGy70I4ZqA//i+epWfEZq8maz73vMYwf1jw7mPtgIMe/v9Wt2ArtPxmmIupvlxijJ1LY3SrBUh6k6xxCw2884Bx07YcKXn4ddzGEhZx/wFpxX3dEVZht1lqLqXShKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oj8U5Tvb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oj8U5Tvb"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c167bda216fso1198837466b.2
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784727576; x=1785332376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JG63ityV2y7NsmGQE2TxVncYq8fjssAwtuXMrNIg0/Q=;
        b=Oj8U5TvbW/OSPFZJufqZwkbraL5vyNH/A0ZSQGZ8JWShfLq+/PhXCp+pB+bAIAOAAA
         8NOrdpJhuzm+esKpbG9ZjDM6SMHhQp8zJy1/E5zbN9a7rdjZA9nS1dlvGNXe6MPEcn/R
         DtyBv2EeRWLOwyKPgOncZXp7UUIwj6OyeP10Z8wCPzj2JjkbnXnSM4vNYaYse2lBI5Wo
         e5/uiSXlKdJUeCoLZnNN7PSkMrjK64QIJ0xaBUECDBmds1sIOzieESr2lyqrRdUmZmD1
         gjDR79+K+W9Fqt2dm0JgFuBycVWe4hLOGtaLoGEyBGXH48T+Yl1IpGLGMRgGQhSwZpCT
         nJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727576; x=1785332376;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JG63ityV2y7NsmGQE2TxVncYq8fjssAwtuXMrNIg0/Q=;
        b=LFQ+/sfzxNQY75w4NI2tj5qb57YC77Ykhbd090B18lEk1xKMTRBdSLr91FvCeG2sve
         stas1kBpXqgGbphL70TOd3jwUujieJ3qr9F9Xoy4rnbBfJ6uUCBOIHQxBJzAOqiNA3fn
         e46ovQiZWPQXCxVGlbuQF3Hu9DkUg4+mlRQUVfICQH+yFn2uva/+fyCXS5OjiMaXGuIF
         cnafUbSb+8xZEXW8UbEtQciwXnbYoU1FT4HDYdkpf/sI9PM2awViOCHvTcRj2B5yCyI7
         2CiVezs7c6O1CR2GwcQZEoYRKFN91XPTrggQ8NfPjsf6a7AHBQJ64AD5rLatODLvZqqh
         tbDQ==
X-Gm-Message-State: AOJu0Yxt574N4mSwr8f2PyRXozY20OV/G5pwxokV1Mi/FkluyRAyJAmW
	tNgrru6sclg4AOyN6Hmtl3CNgeC4238ZDM3vat1qPt9PFxTsLxCOnubfK1OoHg==
X-Gm-Gg: AR+sD13d1UdkSwBGZnYYNMc3zyljQaxTLewC62Si3USnF4AeZdAy71qWW8kf5UR4XV3
	xop3jQ1Owt3tECxxAEpWEVEsz4Umju62IFbOuy1UxTfXLHZ+ioEEYYwhPMeyzUXup8jsdDjmfly
	APtAGimhWDH+7f8GspDEuKeSs/t63GNHZq9N2VZtag4GWqnq6QIQiX3mUTD4PcHb1YJwUHj1a/7
	UuPDyi5R0ltcbLNU/nRuxeGtNdJtJZgkvgLWLvfsvqf/RcyimeX6tOxSpGzJZQsa4rpiNkAWSk/
	WI05zoQ6t+BqCAmIbZXRmDaLLIf971UsLkGooAZL4aLjD50x1lhk1Kue2+lvmAQRLOz7HYF0J1R
	Ff515Q7/6anPNQtDMGdMZN63p6jw+aH7dJVflNsAhbTI5kC//N4iKW6toeATUMEvis6a02SmAwC
	OAh/Z/oTBv53C3Uj4n5pb1965C7Qe+zLqJvVY++K41E82+qXnbDAp64now
X-Received: by 2002:a17:907:970e:b0:c15:de33:a018 with SMTP id a640c23a62f3a-c16b48c5ae0mr1026732966b.45.1784727576289;
        Wed, 22 Jul 2026 06:39:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32c8ea94sm107467566b.41.2026.07.22.06.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 06:39:35 -0700 (PDT)
Message-ID: <db7edc66-9b2a-47bc-98db-87d01885cef0@gmail.com>
Date: Wed, 22 Jul 2026 14:39:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/1] rebase: add --[no-]edit to --continue
To: Junio C Hamano <gitster@pobox.com>, Hugo Sales <hugo@hsal.es>
Cc: git@vger.kernel.org
References: <20260721140443.1809379-1-hugo@hsal.es>
 <xmqqldb4xlqa.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqldb4xlqa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2026 19:04, Junio C Hamano wrote:
> Hugo Sales <hugo@hsal.es> writes:
> 
>> When a rebase stops for conflicts and the user runs `git rebase --continue`, the
>> merge backend opens $EDITOR so the commit message can be revised. That is often
>> useful, but not always: sometimes the user only wants to keep the message that
>> is already there.
>>
>> This series adds:
>>
>> - `git rebase --continue --no-edit` to commit without opening an editor
> 
> Meh. "GIT_SEQUENCE_EDITOR=: git rebase --continue" is your friend ;-)

Do you mean "GIT_EDITOR=:"? The sequence editor is only relevant for 
editing the todo list. The last time this came up [1] I shared an alias 
that only suppresses the editor if HEAD has not changed since the user 
continued the rebase, but that does not stop the user suppressing the 
editor when continuing a "reword" command. I share the concerns you 
listed below about this patch in its current form.

Thanks

Phillip

[1] 
https://lore.kernel.org/git/fbf859ca-43f4-433e-b111-377aa60f1947@gmail.com

>> - `rebase.noEdit` to make that the default on continue
>> - `git rebase --continue --edit` to override `rebase.noEdit`
> 
> The new 'rebase.noEdit' configuration is especially concerning.  It
> encourages users to assume by default that their rebase sessions
> will not produce notable changes worth recording in the commit logs.
> 
> A few immediate edge cases come to mind:
> 
>   - What if 'rebase -i' stops to give control back to the user for
>     reasons other than a merge conflict?  If the user chose 'edit',
>     their original intent was to modify both the commit message and
>     the content.  With 'rebase.noEdit' enabled, would they now have
>     to remember to pass '--edit' when continuing?  Does the answer
>     depend on whether the 'edit' step resulted in a merge conflict?
> 
>   - What if the user chose 'reword', which is an explicit signal to
>     update the commit message, but 'rebase.noEdit' is enabled?  If
>     the rebase does not stop with a conflict, it might open the
>     editor regardless of the configuration.  But if a conflict does
>     occur and requires manual resolution, will the user still need to
>     remember to pass '--edit' when continuing?
> 
> The proposed tests only cover the code path where control returns to
> the user due to a conflict.  This is understandable since that
> scenario was your primary motivation.  However, they do not verify
> what happens when there are no conflicts but the user explicitly
> intended to edit the message from the start.  You may want to expand
> the test coverage to address these scenarios (and potentially
> others, as this is not an exhaustive list).
> 
> Thanks.
> 

