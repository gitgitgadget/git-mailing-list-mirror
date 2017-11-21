Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83BE62036D
	for <e@80x24.org>; Tue, 21 Nov 2017 20:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbdKUUrC (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 15:47:02 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43418 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdKUUrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 15:47:01 -0500
Received: by mail-wr0-f174.google.com with SMTP id u40so12498684wrf.10
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 12:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PW6hE4S0BMMbyUtTW6Nwu9iHgYFShWTA18qBPk+Gl0M=;
        b=LTZAiEoDsakvq+NmIZdXsWL/TAdwyA8IvsS5ItJ7jOko7rK06dDhzj15H0nu/HFg8m
         w0ofZw48CnE04hlie7tfq9a4xnoSDy9iwI8C4Cg0DHoIl/Da3VNtgQq29Mb8oep8QQkI
         1mpWydw6+VUvrHKL0fuQqbMkdrpT3XUpiiWus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PW6hE4S0BMMbyUtTW6Nwu9iHgYFShWTA18qBPk+Gl0M=;
        b=UuseXipPDT6iMJiucr4dvJ/8Y9D0erWZN60b2OLMSusaAKo5oDsG1t+dbf+k4pUhT0
         N3aqpj1AhTCj1jz+1+aaum+jj3AeOUSliKtPEdIsYEd1n1i1rehekWBPr869UBoJcx8s
         RxCcVMhfgui8QXT5JIrA1fMmSGUwSuMcpi6ULH4mmgN5R86C6u9edc9iqbqFkrosTzoc
         /zBhw4yjwCeHNgUP1/Y8dkutx0BDHC89hijRaX26NCzlydpBck+diJXTIfi1JofHxkwF
         dq9Kt7lsQMkYG7/oAInLRVnWH1fVRjyT73FxeOVmG+eVS7f05DpZfpakkqKxlEofjIN/
         RVVg==
X-Gm-Message-State: AJaThX7ilZHEBmi3ggyP5swVj1KOOg7RYzwVwxJdQwCK2+Jovpf2gb3K
        MW849eI6gh4v0GKIN3vRfok1Yw==
X-Google-Smtp-Source: AGs4zMY5nEsF2UieJNjaudB5rd9veONv5RFdG83EcOG5DbENkTw5PjT3V9N7pSO71PysFG+MZiPyhw==
X-Received: by 10.223.165.4 with SMTP id i4mr16568720wrb.158.1511297220452;
        Tue, 21 Nov 2017 12:47:00 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id w76sm29031091wrc.79.2017.11.21.12.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2017 12:46:59 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 10A643E0620;
        Tue, 21 Nov 2017 20:46:59 +0000 (GMT)
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
User-agent: mu4e 1.0-alpha2; emacs 26.0.90
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
In-reply-to: <CAPig+cTXq6jSN9f2_xyj=Jfv_cg2kUFUtA5uVkZDrRRSi2x7vg@mail.gmail.com>
Date:   Tue, 21 Nov 2017 20:46:59 +0000
Message-ID: <87wp2jwe9o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine <sunshine@sunshineco.com> writes:

> A few more comments/observations...
>
> On Thu, Nov 16, 2017 at 10:48 AM, Alex Benn=C3=A9e <alex.bennee@linaro.or=
g> wrote:
>> diff --git a/perl/Git.pm b/perl/Git.pm
>> @@ -936,6 +936,9 @@ sub parse_mailboxes {
>>                         $end_of_addr_seen =3D 0;
>>                 } elsif ($token =3D~ /^\(/) {
>>                         push @comment, $token;
>> +               } elsif ($token =3D~ /^\)/) {
>> +                       my $nested_comment =3D pop @comment;
>> +                       push @comment, "$nested_comment$token";
>
> Due to the way tokenization works, it looks like you will only ever
> see a ")" as a single character. That suggests that you should be
> using ($token eq ")"), as is done for "<" and ">", rather than ($token
> =3D~ /^\)/).
>
> What happens if there is text before the final closing ')'? For
> instance, "foo@bar (bibble (bobble) smoo)" or "...)smoo)". The result
> is that "smoo" ends up tacked onto the end of the email address
> ("foo@barsmoo") rather than incorporated into the comment, as
> intended.
>
> What happens if you encounter a ")" but haven't yet encountered an
> opening "(" (that is, @comment is empty)? For example, "foo@bar )". In
> that case, it unconditionally pops from the empty array, which seems
> iffy at best. It might be nice to see this case taken into
> consideration explicitly.

Yeah I was only really aiming for the current regression but I'm sure it
could be more solid. I do note that my @known_failure_list in test.pl
has a bunch of other cases that need fixing up.

> I also was wondering if it would make more sense to take advantage of
> Perl's ability to match nested expressions (??{$nested}), however,
> that feature apparently was added in 5.10, and Git.pm only requires
> 5.8, so perhaps not (unless we want to bump the requirement higher).

Hmm that might be a case of abusing regex to do something better suited
to a proper tokenizer.

>
> Aside from those observations, it looks like the tokenizer in this
> function is broken. For any input with the address enclosed in "<" and
> ">", the comment is lost entirely; it doesn't even end up in the
> @tokens array. Since you're already fixing bugs/regressions in this
> code, perhaps that's something you'd like to tackle as well in a
> separate patch? ("No" is an acceptable answer, of course.)
>
>>                 } elsif ($token eq "<") {
>>                         push @phrase, (splice @address), (splice @buffer=
);
>>                 } elsif ($token eq ">") {

I can have a go but my perl-fu has weakened somewhat since I stopped
having to maintain perl code for a living. It's almost as though my
brain was glad to dump the knowledge ;-)

I guess we could maintain a nesting count and a current token type and
use that to more intelligently direct the nested portions to the
appropriate bits. Maybe Matthieu or Remi (CC'ed) might want to chime in
on other options?

--
Alex Benn=C3=A9e
