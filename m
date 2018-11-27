Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B9E1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 20:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeK1HFA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 02:05:00 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:33097 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeK1HE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 02:04:59 -0500
Received: by mail-wr1-f45.google.com with SMTP id c14so18373945wrr.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 12:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kTx5u/tJJT8o1VCZeYrkPTX9Emikbuu6/bxR6dd3T8I=;
        b=SiTRBVhvfD7+jVjCcthZgNx0UOTFGjYUe1E+Xuyd+CgR31h4eBGmfuhgWvEkAU23q0
         kmTBeKU2F+RmZp6d3dAUO0VltGoEQXuuV+w3DtHbkV3TZAF83+7bnkemQUYxDeTT31No
         waCYn8JnSVAvjin8XqkKKzXAaHGoiCWZ6Xwb5CPHSdvy7CDYd/0/7EQtI/CwHO6TMBqe
         d3XFO9S1Bl86ABVhppzjD3ECVoPPc8CcgLbsfzy+jQnbowiSDQt0BCD3P7+BxFjaxm/q
         XfxzgArR/xaLZWUJfRMV6feo23xXFrj+l0L8LrITqSKMJhaC6jivChW9K06cgNr24u6z
         Q+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kTx5u/tJJT8o1VCZeYrkPTX9Emikbuu6/bxR6dd3T8I=;
        b=pG7rV0b/RGwxgkIes+kZeiJDfuDgkhqkT3ZLX7GGbYyB2gVm87AVQffF3jrHzAL4A1
         wFMRfs9foR3cZZDdGhzWVnV2jU6i/2mHSybsjtIaYKFhBKFKULGRViKKk9e6KzA47z30
         RNzxHRhDbWO/ipomqV4w24Lc9kf/VH66iUFGouYmFaVzSM6PFFD4t9T8qbmWzXwbbWNQ
         ciTnGlr08w5sM2vKO62Vt9wE6Aqy0h1rlNCv0vGVLgd4eWM4XFZgTlbyjh2uK7w5Le83
         23h1NNsViDwThiw61G2FkzUJEd0dbjb0Gs2Q07++TVuR17pDdcF3xOaPwqYHknxltyEy
         oJkw==
X-Gm-Message-State: AA+aEWbSKeX+Lxm1YGga+ld2GX2YV/RJusH2Ru+Tdfadkh2B+ShrDYmn
        DSc0EoX2PmhZKAAOlnU=
X-Google-Smtp-Source: AFSGD/XEIymajO7pZK9VFZSFvPonSaWudr8pt89WAOfEkgCUel9ia8wcGQKChIO3ETblE4CPVIftmQ==
X-Received: by 2002:adf:d4c9:: with SMTP id w9mr6988631wrk.119.1543349156624;
        Tue, 27 Nov 2018 12:05:56 -0800 (PST)
Received: from [192.168.25.100] (ip-178-203-18-66.hsi10.unitymediagroup.de. [178.203.18.66])
        by smtp.googlemail.com with ESMTPSA id a11sm211709wmh.26.2018.11.27.12.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:05:55 -0800 (PST)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
 <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
 <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
 <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
 <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <b69f9626-7a6f-521a-1b4e-8b21dc214d93@googlemail.com>
Date:   Tue, 27 Nov 2018 21:06:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 27.11.18 um 00:31 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 26.11.18 um 04:04 schrieb Junio C Hamano:
>>> That does not sound right.  I would understand it if both lines
>>> showed ^M at the end, and only the one on the postimage line had it
>>> highlighted as a trailing-whitespace.
>> I agree that this is a (small?) weakness. But...
>>
>>> When we are producing a colored output, we know we are *not* writing
>>> for machines, so one way to do it would be to turn CR at the end of
>>> the line into two letter "^" "M" sequence on our end, without relying
>>> on the terminal and/or the pager.  I dunno.
>> ... this goes too far, IMO. It is the pager's task to decode control
>> characters.
> It was tongue-in-cheek suggestion to split a CR into caret-em on our
> end, but we'd get essentially the same visual effect if we added a
> rule:
>
> 	When producing a colored output (not limited to whitespace
> 	error coloring of diff output), insert <RESET> before a CR
> 	that comes immediately before a LF.
>
> Then, what Frank saw in the troublesome output would become
>
> 	<RED> -something <RESET> CR <RESET> LF
> 	<GREEN> +something_new <RESET> <BG_RED> CR <RESET> LF
>
> and we'll let the existing pager+terminal magic turn that trailing
> CR on the preimage line into caret-em, just like the trailing CR on
> the postimage line is already shown as caret-em with the current
> output.
>
> And a good thing is that I do not think that new rule is doing any
> decode of control chars on our end.  We are just producing colored
> output normally.

Hmm... I think I now understand what caused the confusion here.
It was my mistake: I didn't consider that EOL characters are whitespace
characters, too. :/

Nevertheless, I still think that eol (CR, LF) and "normal" whitespace
(space, tab) should be distinguished and marked/displayed differently,
because they are playing different roles.
Your suggestion seems to be a good solution for that.

Regards,
Frank



