Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B25381F453
	for <e@80x24.org>; Fri,  5 Oct 2018 06:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJENLc (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 09:11:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53038 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJENLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 09:11:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id 189-v6so684981wmw.2
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 23:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=IE436Yl8fmc5iIju/ByWDiwSOouccf3OdC3eNHvb8eg=;
        b=OhcArRpsc5b+eLQEwV11XVGbcBqTqNfPSNZRtj3IiPKYMYdPaajsE15dyRBmrXTDEn
         yz83Wo5onwmK1tm4Y5jnUoRAF/ioxKd4OKnXgvynWXzRDP4UKZvahpO2YEwQLkdjTt2B
         k3Nxxrl0G1/RTXHkP2fSjSprNpihTwjCuO+t3J1BlWZ+ml7Zn9cdeCVV01Q1WxLcIt/Z
         MVyMJ9sURfCT7kfjM3ZufsgJsog7g8+mZU/FZDFqM9EDHzrSo4GPD6eSvPWI/M7yiqLZ
         dOwUgMpLcSzCiyiby5sIaa6xe/T7iv3KiMuo1j0mhl5JzvXmgNpVm6pPwHVtSsppmwHU
         qgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=IE436Yl8fmc5iIju/ByWDiwSOouccf3OdC3eNHvb8eg=;
        b=Ue7SQnsWU2o9nSek/4lqjXRkv69FNwQVJbYPQulEnWDfdPL5ZRdP4QICXB38CMCXU1
         oJzsmQ21Acta+Xf/IX7sSUKixe97CVRI+aOF2c8J7ptBHzVxJ/h+WtUwpwHYE9GXZNPB
         IlEt9v67NAquIL6hJEX4MJbza5ILbSLIrJG4GRM3eSt5bXsKhMz+UOhUQCL+K+ox1l1K
         6Nb+zalao7aO5MNShzZZUVLSdsjo3MhHk5HLW9eOmImOUlSG6krL5m5OgHID2RyH+QLY
         EXg8m+8QNn1Jwfe2IRr7Nr4udMeeVorB23/RgF1G2lITkHi0Pu+b0fagNw391u3cohis
         Ouig==
X-Gm-Message-State: ABuFfoha8rJ28Ld6IY5CyYZrJqHKENU/S9OQz8+zFs2HsC/79Qj3BuvI
        59rmk7rB1ECEBcgZMQ+LLpqpaiIt6ic=
X-Google-Smtp-Source: ACcGV611mfd9ija7gecyYtO4Cl7K3+TIYjcr4bYREBJEIT6AYSK+Ir6h3O0XpxjfiOXM5+kV9QTIyg==
X-Received: by 2002:a1c:7816:: with SMTP id t22-v6mr6972635wmc.46.1538720057311;
        Thu, 04 Oct 2018 23:14:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a105-v6sm14418002wrc.23.2018.10.04.23.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 23:14:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] gpg-interface.c: detect and reject multiple signatures on commits
References: <20180817073441.5247-1-mgorny@gentoo.org>
        <1538555376.1042.3.camel@gentoo.org>
Date:   Thu, 04 Oct 2018 23:14:15 -0700
Message-ID: <xmqqin2g3op4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny <mgorny@gentoo.org> writes:

> On Fri, 2018-08-17 at 09:34 +0200, Michał Górny wrote:
>> GnuPG supports creating signatures consisting of multiple signature
>> packets.  If such a signature is verified, it outputs all the status
>> messages for each signature separately.  However, git currently does not
>> account for such scenario and gets terribly confused over getting
>> multiple *SIG statuses.
>> 
>> For example, if a malicious party alters a signed commit and appends
>> a new untrusted signature, git is going to ignore the original bad
>> signature and report untrusted commit instead.  However, %GK and %GS
>> format strings may still expand to the data corresponding
>> to the original signature, potentially tricking the scripts into
>> trusting the malicious commit.
>> 
>> Given that the use of multiple signatures is quite rare, git does not
>> support creating them without jumping through a few hoops, and finally
>> supporting them properly would require extensive API improvement, it
>> seems reasonable to just reject them at the moment.
>> 
>
> Gentle ping.

I think among the three issues raised in the review of v1 [*1*], one
of them remain unaddressed.  Other than that the addition relative
to v2 looks reasonable (but I only skimmed the patch).

[Reference] *1* https://public-inbox.org/git/xmqq1saxc5gu.fsf@gitster-ct.c.googlers.com/ 

Relevant part reproduced here.

>>>  	/* Iterate over all search strings */
>>>  	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>>> @@ -50,6 +52,10 @@ static void parse_gpg_output(struct signature_check *sigc)
>>>  				continue;
>>>  			found += strlen(sigcheck_gpg_status[i].check);
>>> ...
>>> +	if (had_status > 1) {
>>> +		sigc->result = 'E';
>>> +		/* Clear partial data to avoid confusion */
>>> +		if (sigc->signer)
>>> +			FREE_AND_NULL(sigc->signer);
>>> +		if (sigc->key)
>>> +			FREE_AND_NULL(sigc->key);
>>> +	}
>>
>> Makes sense to me.
>
> I was wondering if we have to revamp the loop altogether.  The
> current code runs through the list of all the possible "status"
> lines, and find the first occurrence for each type in the buffer
> that has GPG output.  Second and subsequent occurrence of the same
> type, if existed, will not be noticed by the original loop
> structure, and this patch does not change it, even though the topic
> of the patch is about rejecting the signature block with elements
> taken from multiple signatures.

Which still smells to me that it points out a grave (made grave by
what the patch claims to address) issue in the implementation of v1;
did v2 get substantially updated to address the concern?

> One way to fix it may be to keep
> the current loop structure to go over the sigcheck_gpg_status[],
> but make the logic inside the loop into an inner loop that finds all
> occurrences of the same type, instead of stopping after finding the
> first instance.  But once we go to that length, I suspect that it
> may be cleaner to iterate over the lines in the buffer, checking
> each line if it matches one of the recognized "[GNUPG:] FOOSIG"
> lines and acting on it (while ignoring unrecognized lines).


P.S. I'd be either offline or otherwise occupied until the next
week, so there is no need to hastily prepare an updated patch
series.

Thanks.

