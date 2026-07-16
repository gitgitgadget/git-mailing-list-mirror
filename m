Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8B395AF1
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194650; cv=none; b=psGzbX+xL0NSgk1bNvN+f7BltEn/lf2xDLU8IyviX2tHq6jmJylcCJeSaRkQRb8qCMAnzQ4vDKbgUWylphQQqkKDuWEXsppvpk43rS63YwlttpfFi8P50Rl8qxwmdj/AVH74ZXhkLpqztEW4rlmAwTWRL5/xPm3yv27At80iX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194650; c=relaxed/simple;
	bh=FC9aCbJ8RLHj0YkQ4R0RsfOVa/FPvnE+SiU5RoDO9M8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oi+uudtph5rbjIk6kDM/GFmED6J2z0dsUBckVgP7UREn/35FnnGb0id/olgfHpZ2bFqGnY4+u02d+niV6JuqUBGNDWYK9FEwcFMlw5WCPyUD5aYFdOz5BonzSiqNsm+CXyzw5MJeM3PVZJpc/UpHGrlCNxgOQ2DXwPWaou9aBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tJ0X5QOL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJ0X5QOL"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso5095988a12.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784194647; x=1784799447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1M1kpQCbD5KoKlVdeK6PJoYP3csRT9jd7uQ/8Aj8tW4=;
        b=tJ0X5QOLzj3HdHQZCQ7rQB4IPNdbOqleIWChWi5Dx6+Ix6cPb4LL6qcQjVMCPbkyos
         kSg9uLvn9JMjwOE2qJOuWxo++qT85sf/btylNERjyZGcEwsCXY4cC37OFz9S2w0HLLpc
         wDdkHuPeU7aRNyblghzYObn7dnQCLUtQKJEy31Z1CaZuf2scHQHnGPEPt5r43UMhxhaB
         Z3k9e74dvMu45B8qnXwcBdpycxzpRNnhrVJYvr3KXHNYEH9sO6yXkovB4OglwWhnpfzy
         8hDrL98PiwVXPS03/Hdb8uvJvuWxTQq67bhs+L5jsOTRAyOpyUwIWsCvH44FJqH8GxlL
         W7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194647; x=1784799447;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1M1kpQCbD5KoKlVdeK6PJoYP3csRT9jd7uQ/8Aj8tW4=;
        b=BlDAWzHloPUG0zwjkom26Z9Z3GhJLD/qoZRzapLkDEXANrcNy2/cZhsreifVo60ADg
         N9HGELPAov7wx6sPprRJdZlLMVPVv5Z+MFCIuuzM98+3bOaXmpfKJt+ULNLgL7cj/Ihm
         PPV+lyuuqQpeZu1fzYAd+uXBuhrbaalKPgX/+SdSw+p7674sXhPSoiJ0yu83mggomfez
         8EHwIOUGEKOFcKx7JQYU3FV28lzTefFJVFyAmoBLMRTGsDm/MRZdiJ/AXXbX0Hk9Z27N
         9uZciu/EwkH4C2GcTmYqA3ts3grUS8fS8gxtexgStlSB9PNjEPenSeO7w28qWudSdJZR
         qcrQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4UZBjhEuCtDkZFR8yA2jdYqh3e+jrYeHtDPVZPtQpEfqlPE0e8QwAtv43NYmJyGI1hbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnb42xH9uGdF7IYCJNwQ3GXXKIxAMMobjLqxvX+NVHrNuXjP7
	WHcrnVdnHA3J2vRiEj5q92PKp4AUCIsNtTCUr18TpGyMLWwPMopWSmg6
X-Gm-Gg: AfdE7cnLWp2EkJzUeaBwUTS1kS6xD17jb6hkIu2XwiRXo7LrTt73f+bmRmgVHfli6Bx
	a5VAxEkvIHeBjhNEoLBcaAL+FMLF4g1lumQ7Bl2oAO3/gXACIHLrWVgvP3qObRhOTVw+z6GWWAr
	rqhXHMaRXTOK78h7B/q4uBNA89g+8xZ7D8RXh9cS4dz7p3r5bpdGsSgblD28Uha1a1RbbTQnMHJ
	Mvy/6g5BQqJzB6B287sWj5yhLvzyL4lz69m1Fe7IgXObPDUdrUpzU1OzMWzf5wDa2ZYKgpcYbUK
	gyuyV3rjE8uX9l5OOLcYbulsSpYNT09jEHdfqxyy31Uau9ZEPwNtT/Q/hfPrdj+tZAw3w3JWKW9
	FcGWOnX1mIfAiAPR+gHlQhmD9gZ+jeLr/by1qIn+E+Wk/+fNpyCA6ecFj25cqzXbKuK5sKGCXOL
	tkCETam9hE+Nor1O03kHFPJSWw+QYdWiRQMFVl9pCqC6nGlUnfBAYdFIas
X-Received: by 2002:a05:6402:21c7:b0:69e:2821:73c7 with SMTP id 4fb4d7f45d1cf-69e28217515mr2506776a12.34.1784194646721;
        Thu, 16 Jul 2026 02:37:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e12ccd067sm2411353a12.21.2026.07.16.02.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:37:26 -0700 (PDT)
Message-ID: <4d150f21-46ea-4bf7-b516-c1763c152b34@gmail.com>
Date: Thu, 16 Jul 2026 10:37:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Harald Nordgren <haraldnordgren@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
 <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> <xmqqpl1q2xw5.fsf@gitster.g>
 <bd7dc183-6597-4fd0-ae64-682d46480cd4@gmail.com> <xmqqo6h9z7e6.fsf@gitster.g>
 <CAHwyqnV8je6gCTExr=CFCdYskN1dVaEDVSKDLUo5A4Ukv=qhiA@mail.gmail.com>
 <xmqqa4srnwfa.fsf@gitster.g>
 <CAHwyqnVy=4oHBTmtDJ6jX38Kh1aLYYXHR-_12DdiiUxpXZ5kNg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnVy=4oHBTmtDJ6jX38Kh1aLYYXHR-_12DdiiUxpXZ5kNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 16/07/2026 07:02, Harald Nordgren wrote:
> I'll revive this discussion because the 'git rebase --keep-base -x'
> case still bothers me.
> 
> When getting stuck in the middle of an operation, it just makes sense
> to offer a way forward and a way back, why be more obtuse than we need
> to?

I'm still not clear why you'd want to abort after a failed exec. In the 
example you gave earlier in the thread where the exec command was trying 
to run a command that did not exist isn't the solution to edit the todo 
list to fix that, or if just this exec command is wrong, continue the 
rebase?

In the latter case it would  be useful is to teach "git rebase --skip" 
to skip a failed exec command that has been rescheduled by 
"--reschedule-failed-exec" and provide a hint to the user that they can 
skip the rescheduled command. We could potentially add a hint to suggest 
that if the failure was due to a bad command then the user should edit 
the todo list.

To me aborting a rebase because an exec command failed is almost never a 
sensible route forward and we should not be encouraging users to abort 
after a failed test - surely the sensible thing to do in that case is 
fix the problem with "git commit --amend" and continue the rebase.

Thanks

Phillip

