Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606F84A35
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943441; cv=none; b=Hhr71UxtEL04F6qTRMPSzHugI3XU6HVQKzrTSWded4j4ZbXd/egqgS0127lshYcbcbW6swXeikbtmR35jF5pIIGAcHnhco56WeltRxOXy/1BrtwemCz+nXWL2bFee5du0llaaA25IGgHbmHX+SWdWPe7sIDSVOT3GZ5lzkzENMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943441; c=relaxed/simple;
	bh=c4qDCsWsKDKxuHUXKqXdpNujlvkkKZbsOk8tRGjd3ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iijjAKPP8mJ920zxc/3ifmHPsUdHgjp7rPKJ0pH3cS6zVTNr7hrVJ/oXbcERpIanq2z1XbhI+lRACM0n0fpTfMwkY1qHACv7fzEg7m3n63VQPr0irkEDtYPLlUr2DRNLbwGmwViMA/PUUZOEOyqTArB3dCmpqc8FnZgNrHNDRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyxaLfKd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyxaLfKd"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343f1957ffcso708170f8f.0
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712943438; x=1713548238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnxKdnnZRfMp36/+V20VqmRf+yO0Rh14KUlcaByeuOE=;
        b=VyxaLfKdyxci8ScnIGgBNa3NrkHLMG9Ftd8E5mJmnGCqCyjVLZz1qN4ixVawFkKQAS
         Siljj9FEMgNXFVGcSdqIwb7xcZCpERGo8nFZCPQUOsYPphNGLFCDUr2GzNkYnuq0rFsR
         PzJ19OdwoO10FAd7ciyZcxnzLdhzeVWaH+SvEohXt6BW2ohzydzBOz0vPMlRq9XwmREz
         6+LD3HcNFGcZl5TenfgM4wbpWGfptPVUk8JWKbFJiewJK96zB2t0/BNGfdlAlRMlIqTK
         vbEh3QyOxkllqxM6G1weJeFfSc9kTa/vEC26DcWWet+EYGRnIp3uUBO4OXH24aO+A8tA
         HIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943438; x=1713548238;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnxKdnnZRfMp36/+V20VqmRf+yO0Rh14KUlcaByeuOE=;
        b=caw3Drl9mAjyj+P2xcwRctDQTXp75z9j04vTYAksbAdHWYzrWxhDcHVhuzoR7y3bn8
         GXux3bnYZ/CPIkNflnB+V82wWhycsCdwdRMQrdpoMnrroyZ0Wka60+baV6CFQfcbEA34
         Ccwcd4XR207+HVLnKG2br8tkzahsWwlWyQGJpJBgQEH0hlyGwA5NLsG9GcxddjdF+R0k
         PD4oEJ/dXZCA8F5bZvp+dVg4m+GIw19SZLFaf9tWnL8F2bjNAjF8DCduiRj/bR5gwr2c
         2nMb1kLhrfVqQTV/5PRQSQvbhfOtvQebpDZI2UflnbYlEls00LZbDkFWmOSaucswLK5I
         Y7Og==
X-Forwarded-Encrypted: i=1; AJvYcCUyL+EkPtKzC2kQDrdziyf23n42XfDJw62OEk/fTYTdr647xEvMMhGNvmS0ujGBUKllVshu8xjm6eEaHXlvoCnjwQDm
X-Gm-Message-State: AOJu0YxbIEzpjogQacfxSUO3kESKYTwTlYcy0j0m0gvhE5vv4s4RElIV
	SUeEl0o2rlGDDrX9AZrCHO8Q1uR0mgA94cyLmmFn2T+PsapWLFhf
X-Google-Smtp-Source: AGHT+IHt8pK1eOYnLh2ZtU7y++1YqP/JD5cAbiOS2XZKXU+6sHwOpkQH630+uML9A/N6NFgEzGeWng==
X-Received: by 2002:adf:e28a:0:b0:346:e2f:a21f with SMTP id v10-20020adfe28a000000b003460e2fa21fmr2659263wri.8.1712943438242;
        Fri, 12 Apr 2024 10:37:18 -0700 (PDT)
Received: from gmail.com (188.red-88-14-41.dynamicip.rima-tde.net. [88.14.41.188])
        by smtp.gmail.com with ESMTPSA id q4-20020adff504000000b0034635bd6ba5sm4689017wro.92.2024.04.12.10.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:37:17 -0700 (PDT)
Message-ID: <f473894d-caf9-4a50-962e-dc884f29e174@gmail.com>
Date: Fri, 12 Apr 2024 19:37:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] launch_editor: waiting for editor message
Content-Language: en-US
To: rsbecker@nexbridge.com, 'Git List' <git@vger.kernel.org>,
 'Junio C Hamano' <gitster@pobox.com>
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
 <96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
 <0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
 <ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
 <83b34572-498b-438c-8437-dfbb837e60ba@gmail.com>
 <02b701da8cfe$59be3370$0d3a9a50$@nexbridge.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <02b701da8cfe$59be3370$0d3a9a50$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Apr 12, 2024 at 01:24:55PM -0400, rsbecker@nexbridge.com wrote:
> On Friday, April 12, 2024 1:15 PM, Rubén Justo wrote:
> >Subject: [PATCH v3 1/2] launch_editor: waiting for editor message
> >
> >We have a hint shown when we are waiting for user's editor since
> >abfb04d0c7 (launch_editor(): indicate that Git waits for user input, 2017-12-07).
> >
> >After showing the hint, we call start_command() which can return with an error.
> >Then we'll show "unable to start editor...", after having said "Waiting for your
> >editor...", which may be confusing.
> >
> >Move the code to show the hint below the start_command().
> 
> My thought on this move is for esoteric (but commonly used) terminal
> emulators. If one is on a t6530, tn3270, or w3270/9 emulator, for
> example, the emulator switches modes from text on the POSIX side to
> block/full screen mode when the editor is launched. Printing a message
> after the editor has launched has the potential to dump the message
> into the terminal emulation buffer and get caught in the commit text
> comment. This is not desirable. This change could have seriously
> undesirable side-effects.

That's a good point.  Thanks for bringing it up.

Of course, in such a situation the user has the opportunity to disable
the hint.

However, can you think of a way in which we could do this, not showing
the "Waiting..." before the "unable to start", better?

Thanks.
