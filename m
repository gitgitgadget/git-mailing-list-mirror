Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842D43BDB6
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244870; cv=none; b=qCNZGNCkbaKmQXWRAFr7oTTjq4deYemmdXI6rh89XSJBKRPGaP/rxv8ybfFXHtmynUtqrYnKYHt2GEaUWtzIW2nluF5J+i23cnPD6FjXfInq3Ydg/DJcCJ9mHiKfoyQ86oLCwG2N7XI+gBMghvTnAGN74RaZ2gaunH+GnKePhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244870; c=relaxed/simple;
	bh=SiIwx/RGTQEOWhod1PXXe7b/j0lo7VZlG/tz7eQW6dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cBfbrqVtp0QY3ZRtVrj3ZPfGWQ2oL5KV83a65UgkJ2sYKwtoG5mXO64RxkqtD2HH4EHHBA3LLP2KK3FYDzB0+t4076Gudc+I23EJFRNAkTM2prp+O2Z6D85E4SdToHWC4KKusf812WWTDA19Mt9cBVOwdiXYmUu4ic6VI7+tbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Piwckoyh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Piwckoyh"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so5802282a12.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2026 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785244867; x=1785849667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lZ41pduoFLBN2CLBK/cRB5Y9n4onXJ6BPErMIcF+g4M=;
        b=Piwckoyh5D76dP0ThzpzWI4TtHyL+q1MWVbw2llKTIgf/TKsz3DGV5YItkYQvL04Pz
         mKWtK7hOXwL4q6SNjbjyGhJR+4HDddA+pdkDGFrLZ5oIzTs77LLaaM9QWs3m83MuSH2M
         UmL73l1RkYqNICInPPP9h3eZv6r6/t5QXlpf2x1KpvJQP6ijnpQOMcqf13N1WTbzdqfH
         tBhbOXq1nOfoue+dvx45vVpJjFyPiEmdRtv/Ct78Sd+YG0oTf2lXSBO8zsjVc+Ojpu3Z
         utZl5/kQZr3xiXGv4S8TFh6+StyUEBeL0tvJ5RkIgOay9F4lqkHkl1su52Li4mqaLqCV
         4DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785244867; x=1785849667;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lZ41pduoFLBN2CLBK/cRB5Y9n4onXJ6BPErMIcF+g4M=;
        b=ZOaD6iRFUFFz+B9GRbRPZ3PMRZbe3WokflWsFZvHhS1ejqAVA4KEK+Cjsyr4ZMxwPL
         8XIbOdMom6MLrvj9XEoIL4bQgYbCQG5jW8sGr5II4hCQyTzO1KeAOz/Bda/EtOcefl1T
         6+vPL0DWCcLHFi6NtrYOVoH8dbioi5B/8ANsiJL/pk5t8FtUwi6F+c9Z/CTDsVkTJKNH
         lCFtI5Y0eq1djoEYq+DWOrY/2V0O5HLETL9niGpE+A3+nEKqseFXizQYKA9+weLcaEQW
         ru3/jTlEYTep4tiNLyjQm706S+iuZvg7Ke/SFqfIyzHzgUUeIeBOauOj3DqsKOFym6Kp
         Pjcw==
X-Forwarded-Encrypted: i=1; AHgh+RqS1EBXy3awlTqc2rcYA3wKZBpLeCPZl4stMoxV5RRTogExiHg7Xp4dmDicqVLV3zVTjOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiWafjR9MKJexMKLKufFREXHScKdQgTE6I0LFa7aruqU25Uzv
	ofsyADPuStw894VslQ9Ij66cQpozN1C8uFLyETpI9x9mZjm00E4F+I3Nf/K0Zg==
X-Gm-Gg: AR+sD13mb5TOlWYFN6Lvj3xhzp0dkKyL5ahZ8lsZuWTjQGTqZTVQ5gU1yIBM1tHc4NZ
	3P2PLcWGH7MO3sT3toWO43W45PKQsakbgVMl2oEOM+whLGVZr6dGPIJvNirVuSRi4pPfz8O/t8h
	qmHN02AqC6etvNV6tNdmq0NzVHxsSK4Jgy3T2d2AZwlH3rDAVohHb1LLdBzP1kR8B6uO1CVPGkX
	q2khr6AMgZ1ciq72ujcOOI2w44p6RitYmnImJg83NXLqXKq3xe0DOgbNwXJr1d2pxkNLEbRq/P5
	cJDmtimIvKoc8KbMl1VnD0azLHFaKrOZ4AAXrI4/YMO8eYOyn6yZve0v5rR3XUk6vwlmp9sb9Kn
	/y2NWMYYFTotJJ4JC3vjT8Z7Nk2EOeeEcCPmh7IFvGEZknL5S64dyPRbhMVBSE7kP3zgAKUjMCJ
	S2DdGV7EG+UhhLzlZjD7jMoRcLqreU7cHtZyl6ZC8v90kCHdJXm7M8M7EJ
X-Received: by 2002:a05:6402:240d:b0:698:ae9c:2ae with SMTP id 4fb4d7f45d1cf-6a0349de2c3mr1176504a12.17.1785244866824;
        Tue, 28 Jul 2026 06:21:06 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb5843580sm4051950a12.25.2026.07.28.06.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:21:06 -0700 (PDT)
Message-ID: <92a69a99-c56f-4ec5-968f-436bef64ee48@gmail.com>
Date: Tue, 28 Jul 2026 14:21:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: REBASE_HEAD still exists after success end rebase
To: Matt Hunter <m@lfurio.us>, Long 76 <long76.git@mail.ru>,
 git@vger.kernel.org
References: <edfc868b-6be6-4871-a539-e70791db216d@mail.ru>
 <DKA3RP12A8LU.2VD89MQ7G2KLL@lfurio.us>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <DKA3RP12A8LU.2VD89MQ7G2KLL@lfurio.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2026 10:39, Matt Hunter wrote:
> On Tue Jul 28, 2026 at 4:26 AM EDT, Long 76 wrote:
>>
>> In other words REBASE_HEAD exists if ogirinal commit in new branch
>> modified and need call git push --force to send it to server. Please fix
>> it, thanks!

The need for "--force" when pushing is due to you having rebased the 
branch, it is unrelated to the existence of REBASE_HEAD (other than the 
fact that it exists indicates you have rebased). Rebasing rewrites the 
history which means that the remote cannot fast-forward when you push. 
Rather than using "--force" I'd recommend "--force-with-lease 
--force-if-includes" instead (see the "git push" man page for more details).

> I ran into this not that long ago too, while working on a script.  It
> looked like this behavior depended on how the _last_ item in the rebase
> todo list was handled.  I found if the last action was a squash or edit
> (I don't think reword did this), then REBASE_HEAD was left behind.
> 
> Also, if rebase stops on a break command, then REBASE_HEAD will be
> missing, even though a rebase is still in-progress.
> 
> I made a very short-lived effort to look into why this "bug" was
> happening.  I say "bug" in quotes, because I'm not even sure if it is
> even problematic behavior.

I think leaving REBASE_HEAD behind after a rebase is a bug, albeit not a 
very serious one. Looking at the code we delete it before processing 
each command, but do not clean it up after the last command.

> I solved my need at the time (detecting a rebase in progress) by
> checking for the existence of either of the 'rebase-merge' or
> 'rebase-apply' directories in $GIT_DIR.

That's the best way to detect if a rebase is in progress - REBASE_HEAD 
only exists when there are conflicts, or the editor is opened for the 
user to reword a commit. It does not exist when the user is editing the 
todo list at the start of a rebase; when stopping for conflicts after a 
"merge parent" command without "-C"; when stopping for a break or failed 
exec command.

Thanks

Phillip
