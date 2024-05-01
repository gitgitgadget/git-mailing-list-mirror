Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB80D52F
	for <git@vger.kernel.org>; Wed,  1 May 2024 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714597992; cv=none; b=hfcs7IXmCa2W4BjmZPHCYUO4UZJS51WZqHMnjKlBzcJGFEBdG/AUZSnmtHRdBcFab64Q91KNkmerAh7nYW5n5RyXdmGkr+r3OwxL2bkfUtivfV0oTNWL9ttqukABDPhC56HnyF5VpIFdtGiV8UDjiPZnnoSZARbpmIQ2wiJ1HD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714597992; c=relaxed/simple;
	bh=rDBFPltKadk+zdeuB8G7PHbZLlHXHGFi83A2/RiQD2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLIfTFhhRe1YiXjKkbao6HFK70Wh5BwUGV1i5Jlju8zryl6gAgbk6k3kozpVC38xIbODHaYT9fLi8YZEhVo0IrkFDfGIzrbSDeWl8iRp88YkjbwlfJ00VLHkmMkcrAM76awI3tKd55UqSuDBfIEo9ZXqz5CMS3knlUCznidHFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJnhsB3h; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJnhsB3h"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so1545549f8f.3
        for <git@vger.kernel.org>; Wed, 01 May 2024 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714597989; x=1715202789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6/PMHyrgEDPTUfoLuaDamwEsllTpggbSHvYt4D1bT8=;
        b=ZJnhsB3hQNqMzTQ/ZUlBCaleX9cDjf3XZekRc1kyA0Tc9OOxF6UIr7hcd7a3t66glR
         bixhEwJJ9cUdIv77lY/Irr8dOr+2u1769p/cTIEfKvrSb9R1N1vOThR5rICmdReYeYGV
         AdJTXjSxMo9uaPHL7QVmgHZ96j3xXWpuFvM5erz+4xvQOa/fTU/9/weLyZE5eQAEPEGs
         bLnXBWByRQ99Hpl/5avLoQdxbqqM/XUuE+qmFVKOsQKL9stFBug61he+2lk8jZHguuf4
         Z3DcSz5OteN0UJDh8ybfsxbHh1XGRQNY8kejAF9Lx7/jWw+LspI/VoDWNlvA37BSv9jX
         PG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714597989; x=1715202789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6/PMHyrgEDPTUfoLuaDamwEsllTpggbSHvYt4D1bT8=;
        b=hmmbiwlf+kPny+40TiKRjhrsdyXLBhlkx48QwIV+PHA0MSsf6EGCWEAt7qU2u0l3uS
         IWGjVbL7yyYabzZ3V1Mn3335B8M+VVjQ1RobN+ACjR1xUXJv/eXhBRbaN17v9aLRxJBR
         HqNObuVWoRp/ZGpGq5ndRu4BTWVtDxEizr/wdIVtEh6mH70KXfNuTIWDUIYo6AaCqGt2
         wCxvc3cQQin8qzLyUXxAUrx6gcse9RaXv266pr2eFQ8uVolM9RYMaSQ9w5biFbCIbRDT
         wwhZfBrGeGd6YM61hiA7jyYUtScCC2nq1wfBikUJ2yYRP2hkfRJ+Bh9crn8tMB7Xqijb
         doQg==
X-Forwarded-Encrypted: i=1; AJvYcCVDeTgG7lmmDDl5AM6A21I5IHeIp2JpKwcfRKi1YzLV2c6/wtadPPwWZ1tyTsmZhyBIkZOCbGaVJEmC9jmRUoJZHami
X-Gm-Message-State: AOJu0YwobhyuhPIUQca9+++1rNrbz3J0ro6pk59OVgw7DR7DVqRNwCLQ
	kwT8mTlTk1BXMb1S6VndfYyH3GMAHczqcCj2qBfqXWtjfrmu9+VE
X-Google-Smtp-Source: AGHT+IHxUPpQG10cjujQD1aR97SwyE+skwBtR48yQZrzBWmPFMQqwhJOoDAK34tX+he+f4RYlChQ3A==
X-Received: by 2002:a5d:4992:0:b0:34d:8fac:9540 with SMTP id r18-20020a5d4992000000b0034d8fac9540mr2591428wrq.59.1714597988527;
        Wed, 01 May 2024 14:13:08 -0700 (PDT)
Received: from gmail.com (51.red-88-14-204.dynamicip.rima-tde.net. [88.14.204.51])
        by smtp.gmail.com with ESMTPSA id dj9-20020a0560000b0900b0034ded946587sm1579291wrb.91.2024.05.01.14.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 14:13:08 -0700 (PDT)
Message-ID: <0dc1f9f9-02ec-4394-9c25-7a7fee6147ee@gmail.com>
Date: Wed, 1 May 2024 23:13:03 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
 <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
 <27fbb12a-f2d2-459c-a27b-519f69242105@gmail.com>
 <ce11355e-25f3-4d76-91ae-bd561143dd49@gmail.com>
 <7a3fcf9c-a70f-47e8-9624-40b407f90242@gmail.com> <xmqq5xvx5x1u.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <xmqq5xvx5x1u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, May 01, 2024 at 09:14:37AM -0700, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
> >>>> -		fprintf(stderr, _("No changes.\n"));
> >>>> +		err(&s, _("No changes."));
> >>>>    	else if (binary_count == s.file_diff_nr)
> >>>> -		fprintf(stderr, _("Only binary files changed.\n"));
> >>>> +		err(&s, _("Only binary files changed."));
> >>>
> >>> These two mean we'll now color these messages which we didn't do before. I
> > ...
> > I think so
> > ...
> >> -		err(&s, _("Only binary files changed."));
> >> +		error(_("only binary files changed"));
> >>     	add_p_state_clear(&s);
> >>   	return 0;
> >> Or, simply leave them untouched in this series.
> >
> > Either option sounds good to me
> 
> We are returning "success" to the caller, so using error() here is a
> bit strong.  Judging from how other messages emitted with err() in
> this program is meant to help the end user, they are all to tell the
> user why their input caused no actual change, and showing these two
> messages the same way as these other messages would be the best for
> consistency.
> 
> So I'm inclined to say that what was posted is good.  If it paints
> these two messages in the same color as others, that is even getter.

Having:

    $ printf "\0" >binary
    $ git add -N binary

Displaying the message in RED does not seem as a bad change:

    $ git add -i
               staged     unstaged path
      1:        +0/-0       binary binary
    
    *** Commands ***
      1: status       2: update       3: revert       4: add untracked
      5: patch        6: diff         7: quit         8: help
    What now> p
    <RED>Only binary files changed.<RED>

However, here could be disturbing:

    $ git add -p
    <RED>Only binary files changed.<RED>

And the "No changes." message is going to have even more audience, I
think.

Perhaps this seems sensible:

Range-diff against v5:
2:  b0f042f4ff ! 1:  94c3f80041 add-patch: do not show UI messages on stderr
    @@ add-patch.c: int run_add_p(struct repository *r, enum add_p_mode mode,

        if (s.file_diff_nr == 0)
     -          fprintf(stderr, _("No changes.\n"));
    -+          err(&s, _("No changes."));
    ++          fprintf(stdout, _("No changes.\n"));
        else if (binary_count == s.file_diff_nr)
     -          fprintf(stderr, _("Only binary files changed.\n"));
    -+          err(&s, _("Only binary files changed."));
    ++          fprintf(stdout, _("Only binary files changed.\n"));

        add_p_state_clear(&s);
        return 0;
1:  4a0eb1337f = 2:  abaf904e8c add-patch: response to unknown command

But I'm not sure and I do not want to send a new iteration unless it is
necessary.  I was already happy with previous versions ;-).
