Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DB79938
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706248; cv=none; b=Rl6NLwJdJpWQeycftAlDokFTnd0O1QycR3fmfp7Zs+9xdBKjRcbpgD3ea1V75V2aHNbFttpmjNvA+oFu7F/0ySWICqWGuAQEsRWErdTX13Ht7BVR0OLjQqg1Cy+wZoBvFZDaxgQ1iv/lD1EfASmRyFvKBmSBd77dY30ieiRrj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706248; c=relaxed/simple;
	bh=Wl9t2gozxij3Inbfr0+glzNcW4+PAFApa7/L0ALq3JY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=J1gTx9fcB8wfbISxjJEwasWgGvUBpBgJ0bh9ZrLsdTmvPqXT8Vsw4ySmT6LLMBAGoDNTyxiNsR5rOYaFV7o1FAv4orrOdKw2j4AIb3Qrb7IAsSeykFbcqP2RLTGHkORlK/gzbOZs0QW4uQpd2NYJCMbry5Hd0Z4wEr6kUhhomIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzSiQS0g; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzSiQS0g"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d066b532f0so9719461fa.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 05:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706706244; x=1707311044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=72CZjZ48pmn5Ku4fNbegdD1cfsi1nAdkBdpjaOLYkxk=;
        b=PzSiQS0gfaXrmH+7ewFYcwGlZrinteV3hHRiQoAaMLrhDRdBK+uzGFOBznxOKI4pp+
         uzfCQbupoZlPskvB3c3VWC5yHE7xyzQM8RTtJ9txNwKzdreZrW+RA1CyBLuv8Y/hGsxt
         ibE4Kd6Hae3p0v5ciZYXM83IxPFbOxjNTcIa38I4vSLXgrr4AeufOWjiubTu04zcj7po
         bA++jmZz2hLiEW9Wbw8d4tLYsyp1+pmg06tYBFZpbduHPq5cc/W4j7WBB2nvMiSC3Afp
         64EQZiq9YBi5zqOx1yd9qV4YcRs5PXz9u/mgW/YU+NvRlgkkJxAvbJIb3Rvq6KqAENjb
         bSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706244; x=1707311044;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72CZjZ48pmn5Ku4fNbegdD1cfsi1nAdkBdpjaOLYkxk=;
        b=joF3WUJVE7WOf3X7iTsgeK4A6hTys5XcTDs7mus/k5JfI5cIlBSn0pn2maHc1OPEEd
         ktFdfhIxUTmwr8i4WitRJuylVsDZdy2holzWZUKKNsz7vlTBvONid/ccdlCMmFG6Vw8B
         jvmWGMONzcGeL7sIpWqh8jTHFoO+gB0tSgkrSBPhcBarAKjj3zdAO3vdi6PlIGJZkYhq
         s8diy4XuNgqnM6z/grkyDIsFIxZqn8JlrNVOIBHWZzNvRKOjcXaKlC/iIPSy8wahRMzQ
         o/EiEblTByyektVQDrSpdbKV0gtnVMsLaEVeRgTuRa+7YG9xJstCgOkIEfPEKpsc2M2r
         H/3g==
X-Gm-Message-State: AOJu0YwFviEe3XnGRd3oClNYiEKj//oihhA9pafuNtrCrReRh+9Cf78G
	foXCV/WRQcY1QVXWIzHtMhIWAab1LnJO29J0oOBlbw5n4VmIX4Vg6Dw4GrLBP6k=
X-Google-Smtp-Source: AGHT+IGbwn/xr/bmm2eZkEDp9R1cDtDmXSyO8kG9D8GUGyWnuIfXXwh5ClZ+DVeUo0XGmlOEdU7uxg==
X-Received: by 2002:a2e:3516:0:b0:2cf:3037:2a35 with SMTP id z22-20020a2e3516000000b002cf30372a35mr1114278ljz.48.1706706244222;
        Wed, 31 Jan 2024 05:04:04 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s24-20020a2e9c18000000b002d04d287251sm1063054lji.73.2024.01.31.05.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:04:03 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	<87a5ow9jb4.fsf@osv.gnss.ru> <xmqqsf2nnbkj.fsf@gitster.g>
	<87plxr3zsr.fsf@osv.gnss.ru> <xmqqa5ouhckj.fsf@gitster.g>
	<87il3h72ym.fsf@osv.gnss.ru> <xmqq1qa5xq4n.fsf@gitster.g>
	<87ede56tva.fsf@osv.gnss.ru> <87a5ot6tos.fsf@osv.gnss.ru>
	<xmqqzfwspmh0.fsf@gitster.g> <87ede4fg8s.fsf@osv.gnss.ru>
	<xmqqzfwrjdul.fsf@gitster.g> <87il3enc1i.fsf@osv.gnss.ru>
Date: Wed, 31 Jan 2024 16:04:03 +0300
In-Reply-To: <87il3enc1i.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
	27 Jan 2024 16:25:29 +0300")
Message-ID: <87plxhiri4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> I'm still arguing in favor of fixing "-n", and I believe a fix is needed
>>> independently from decision about "-f -f".
>>
>> Even though I do not personally like it, I do not think "which
>> between do-it (f) and do-not-do-it (n) do you want to use?" is
>> broken.
>
> Well, you are right, but "-n" is not documented as "do-not-do-it" in the
> sense you use it here. 
>
>> It sometimes irritates me to find "git clean" (without "-f"
>> or "-n", and with clean.requireForce not disabled) complain, and I
>> personally think "git clean" when clean.requireForce is in effect
>> and no "-n" or "-f" were given should pretend as if "-n" were given.
>> I wish if it were "without -n or -f, we pretend as if -n were given,
>> possibly with a warning that says 'you need -f if you actually want
>> to carry out these operations'".
>
> Yep, then we'd not need "-n" that much, only if to cancel explicit "-f"
> (provided "-f -f" feature is removed.)
>
>>
>> But that is a separate usability issue.
>
> Yep, and that'd be very different design. 
>
>>
>> What I find broken is that giving one 'f' and one 'n' in different
>> order, i.e. "-f -n" and "-n -f", does not do what I expect.  If you
>> are choosing between do-it (f) and do-not-do-it (n), you ought to be
>> able to rely on the usual last-one-wins rule.  That I find broken.
>
> I fail to see where this expectation comes from, provided "-n" is not
> documented as anything opposed to "-f":
>
>        -n, --dry-run
>            Don’t actually remove anything, just show what would be done.
>
> This is typical convenient description of "dry run", and current "-n"
> implementation is rather close to the description, that I'd still
> rewrite to emphasize the primary goal of the --dry-run:
>
>
> With these descriptions, the last thing that I'd expect is "-n -f"
> removing my files.
>
> Overall, as I see it, we have buggy implementation of suitably
> documented "--dry-run" option, and the best course is to fix the
> bug, with no semantic changes to the option itself.

OTOH, to preserve current actual behavior as much as possible, we can
probably first fix documentation like this:

        -n, --dry-run
            Show what would be done, and don’t actually remove anything.
            This sets 'clean.requireForce' to 'false' for the duration
            of this command execution.

that to me looks like a match for current observable behavior.

Then we can fix '-n' implementation exactly according to this updated
specification, making '-n' really independent from '-f', yet keeping
pure "git clean -n" as well as "git clean -f -n", and "git clean -n -f"
backward compatible.

As a bonus, the above solution will also free our hands in [re]defining
'-f -f' later, if needed.

WDYT?

Thanks,
-- Sergey Organov
