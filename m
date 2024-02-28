Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B3149E0B
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131545; cv=none; b=gkWrxAk+JaCZAX6hNuBBWVW3yUaacDxXKPMKAmESkobqO8FxYWymQlfLlWBA5Odf9UYxuwRW3lsCQ1aAobKHN0y2tq+JViIAQRp9MejbN9FLI+YM3APk4wOVf83mgJ06DkHawPAV99QqSZm+4GJesYNs8RElftIKfnXHtskxBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131545; c=relaxed/simple;
	bh=cxvI7dAqHLx6sLsvlXC3FzX7oH2r26TlAX/pqVv/PBw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UZaZsR9cgB1fFX6x1PFkIUk/ulHWsjQHAjJxZa7a4PhNk8/a6qJoQHU+QRIbPJagnsNhUH5y1DwFY9YNZFE4Gx4WHwP+zHuYlbzwyIUPdikpGOaVHJ8E9QhGbVgruE9HuTcL798fqeyM3rOilnKFSZIUrKI3myVCA7ecHDtYacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nm0TUXYP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm0TUXYP"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513173e8191so1755125e87.1
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 06:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709131542; x=1709736342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zJBzHbVbgmcoHCyYjQR2zrRXZpANI93wEBsALmzJ9Mo=;
        b=Nm0TUXYPM9ey3qj6NHOwfKN+FuTUwCEZhYnLQIY5JEORcClquX4d3UGDucGwztFD7l
         Sk3g5IeJRiiU48Xxb4OUzUX4F8lk+QHiRO3dPibOkH2Hia0JsNmqemPM9PZ7wYBgLRCg
         uEtOvIHjl/9JYRic+Dwqze28EMmqsKsP0VH4F8CIukySFLdfHsTBGObMI0fDvX8m2UbB
         BanHJ/V0HHDGvY/NQDBZdYptSFES9ZaDs5hYaCMEH7Uy6+dkHVCZ4z4mxELHgQGPYDWm
         891HONP8MAA0rsKlGtX0REyiNguTKI2R+7616SvQlhxkQ4DLT/ox+hWb8ywncHJ3AWoO
         PjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131542; x=1709736342;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJBzHbVbgmcoHCyYjQR2zrRXZpANI93wEBsALmzJ9Mo=;
        b=OQuR4qpbpBPOAzBJWoRSLA/Z7QAZEE0u94bQpDc93lVgMH4E8gdljaHDSfjtuj1MXK
         AX9h/dDdUJ3PuLqIaO1V2MLpZqWTNFtuT6bxeP6CXY2t4W4j/jtD6tAweeiOWJ82lFhN
         JqqIcgxT8MY5owSfWIXveiYODTQADt0mcx/4qmry5+hWj6D3YTbZLVF9lDIRVHPyihJp
         TRJ5+la2MYOhr4/VjoQAL+54xhKIsCzgtHFgHZMPD4gGNM0f9mkrNxQrVeR/12bR4dU6
         3m2eA8+HMPKL6MXMn8ZOGcAglLKxpj9pnSR8EV9PzBk8bnTLY2j1RqgraSXxZjprmQ9/
         7l5A==
X-Gm-Message-State: AOJu0YwZuBsy8a0YzoFpo5aUW4eLPzS720McTLYqzpcVfjZVssvhxwl3
	7zBg2ScjHWNDG7BcP9ukKW8dd4oZR4ISjZcQLcg6CXvgXnKTrilP
X-Google-Smtp-Source: AGHT+IGBOuo858XBWhs1rIMjYuXtpesd6L31amW6So+F39+T2iXZCarn8pbCv6HLW9c0iqO66k+rNg==
X-Received: by 2002:ac2:5182:0:b0:513:19e0:8c9a with SMTP id u2-20020ac25182000000b0051319e08c9amr1460031lfi.22.1709131541641;
        Wed, 28 Feb 2024 06:45:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id iw1-20020a05600c54c100b00412b0e51ef9sm2315819wmb.31.2024.02.28.06.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:45:41 -0800 (PST)
Message-ID: <a11e3e0a-23a7-422f-9f3b-ab673860f1f8@gmail.com>
Date: Wed, 28 Feb 2024 14:45:36 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: stop setting GIT_CHERRY_PICK_HELP
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1678.git.1709042783847.gitgitgadget@gmail.com>
 <xmqqil29sqfp.fsf@gitster.g>
In-Reply-To: <xmqqil29sqfp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/02/2024 18:38, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Note that we retain the changes in e4301f73fff (sequencer: unset
>> GIT_CHERRY_PICK_HELP for 'exec' commands, 2024-02-02) just in case
>> GIT_CHERRY_PICK_HELP is set in the environment when "git rebase" is
>> run.
> 
> Is this comment about this part of the code?

No, it is about

         strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");

in do_exec() which clears GIT_CHERRY_PICK_HELP in the child environment 
when running an exec command so that "exec git cherry-pick ..." retains 
the correct author information.

>> +	const char *msg;
>> +
>> +	if (is_rebase_i(opts))
>> +		msg = rebase_resolvemsg;
>> +	else
>> +		msg = getenv("GIT_CHERRY_PICK_HELP");
> 
> Testing is_rebase_i() first means we ignore the environment
> unconditionally and use our own message always in "rebase -i", no?

Yes, this matches the existing behavior in builtin/rebase.c where we call

	setenv("GIT_CHERRY_PICK_HELP", resolvemsg, 1);

to set GIT_CHERRY_PICK_HELP even if it is already set in the environment.

> Not that I think we should honor the environment variable and let it
> override our message.  I just found the description a bit confusing.

I should have been clearer what that it was talking about - i.e. it is 
still worth clearing GIT_CHERRY_PICK_HELP in the environment when 
running exec commands.

Best Wishes

Phillip


>> diff --git a/sequencer.h b/sequencer.h
>> index dcef7bb99c0..437eabd38af 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -14,6 +14,8 @@ const char *rebase_path_todo(void);
>>   const char *rebase_path_todo_backup(void);
>>   const char *rebase_path_dropped(void);
>>   
>> +extern const char *rebase_resolvemsg;
> 
> This is more library-ish part of the system than a random file in
> the builtin/ directory.  This place as the final location for the
> string makes sense to me.
> 
> Thanks.
