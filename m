Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEB41F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbcHISJk (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:09:40 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:33140 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbcHISJf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:09:35 -0400
Received: by mail-it0-f41.google.com with SMTP id f6so2946063ith.0
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 11:09:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V98yTB7JO1T9hl98uJfLrXGSBMAx7byNiWJumvbMZtw=;
        b=YwCzgLa3LbmcXHfMDM1Fqq0AB4RS6EUle75PATm1OMZc2rsTPy5puhNxZvkiwNLeUl
         lZiz9Pw8PwUljqH+CLirEsvjbpmVsqkehJ9hE6vrC14g500q1DmBjfQUIc3dQ/kzpWER
         6/4hWb+u7bsQ5i7rKYaShhOrLx954zVxVd7HQJJUhEfLCbkBfly9YPHuR3N/afSqp0J8
         VfPwluxoW2P1vzE3ZkgSVqHzyNp3dYeQ4KJhUUBRJ5pujwDBC/XtP0lz3TEYDRRlZUqu
         efadEwbgmu/TJAi0b4UyqDb2nrubBFBA9Blu4GoNjMxJyRFAFi7WQarJtw2RWDPNx5bP
         jZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V98yTB7JO1T9hl98uJfLrXGSBMAx7byNiWJumvbMZtw=;
        b=PlE0aFsVJWKml3U+hgvulP9kV9rgyCIxzACIw+naOfH7qeCNDB7gW8rvG+INYEZPTZ
         szTnF5EUo1YfnxYAkNItUdEMMu/PtXpvI/SlJRryj702RBftWmfBamkOS+5674wjQ2+J
         TXkCs/T56xQzyJF5Tny/iBrkv7b1uQkvAooojtsVetndgTQiasnni16qZQZKYkq0Y5M4
         Y5W1WuW91sJ7QpBX69maY/ahfZiZQ76t1WEk8PWAHBdU9H1N6Snm4AKJsu/GMafxne8S
         pMJIg1dixPxtH3q6Hn5tmf9at3WfuvwzJxulNUPzUDMUqaMmno3vXG0cn2NJSe0QG+Sf
         vfQw==
X-Gm-Message-State: AEkoout7QIepupVgi+MPyV75mQ7CWdQNulfw9fe2jZdFs2HZAMWrxpIRBIFcrd6aK6QOtdyeW+hWAo+/A9jD/v9b
X-Received: by 10.36.227.13 with SMTP id d13mr376682ith.97.1470766174771; Tue,
 09 Aug 2016 11:09:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 9 Aug 2016 11:09:34 -0700 (PDT)
In-Reply-To: <xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com> <xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 9 Aug 2016 11:09:34 -0700
Message-ID: <CAGZ79kY8EiGaugsh4FxKYp1FxqYr10JfGqsrfsnhULB+OBnFXw@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 10:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> "you did ask me to use alternates once and for all when setting up the
>> superproject: now for this added submodule I don't find the alternate;
>> That is strange?"
>
> Absolutely.  I do not think you should expect a user to remember if
> s/he used alternates when getting a copy of the superproject long
> time ago.  Giving "info: using from ..." is good; giving "warning:
> not using from ..." is probably irritating, I would think.
>
> Stepping back a bit, when the user says --reference-if-able, does it
> warrant any warning either way?

Stepping another step back, let's discuss the expectations of the
new option "--reference-if-able".

The way I understood and implemented it is

    here is a path, try to use it as an alternate; if that is not
    an alternate, it's fine too; maybe warn about it, but carry
    on with the operation.

With such a semantics you can just add the --reference-if-able
to the submodules that try to borrow from the other superprojects
submodule.

    I expected the "--reference-if-able" not necessarily be
    used by the end user. It is a convenient way for our scripted
    use, as the -if-able is just a check if the path exists and nothing
    else.

    We could check if the git dir exists inthe helper for the
    submodule command, such that we only pass --reference
    as we are certain the alternate exists; we could have a switch
    in the helper --on-missing-submodule-alternate=[die,info,silent]

The way you write this response I think you have a slightly
different understanding of what the -if-able ought to do?

    When --reference is given, only the superproject should
    borrow and the -if-able, may allow submodules to also borrow?

> I.e. "we made it borrow from there,
> so be careful not to trash that one" may be just as warning-worthy
> (if not even more) as "you said we can borrow from there if there is
> anything to borrow, but it turns out there isn't any, so the result
> is complete stand-alone."  It feels as if we can go without any
> warning at least from "git clone --reference-if-able", unless "-v"
> option is given.

But when git clone is not issueing a warning/info, who is responsible for
that? As you noted the superproject may be setup some time ago and
the user forgot they used references and want to use references for this
new submodule. So the helper would need to do that?

>
> I have a very strong opinion what should happen when the end-user
> facing command is "git submodule", but if I have to choose, I would
> prefer to see "git submodule update" tell what it did with "info:"
> either case, i.e. "info: borrowing from ... because the superproject
> borrows from there", and "info: not borrowing from ... even though
> the superproject borrows from there".

I see. This way the user is most informed. The current implementation
of "submodule update --init" for start from scratch yields for example:

Submodule 'foo' (<url>) registered for path 'foo'
Submodule 'hooks' (<url>) registered for path 'hooks'
Cloning into '/home/sbeller/super/foo'...
Cloning into '/home/sbeller/super/hooks'...
warning: Not using proposed alternate
/home/sbeller/super-reference/.git/modules/hooks/
Submodule path 'foo': checked out '7b41f3a413b46140b050ae5324cbbcdd467d2b3a'
Submodule path 'hooks': checked out '3acc14d10d26678eae6489038fe0d4dad644a9b4'

so before this series we had 3 lines per submodule, and with this series
we get a 4th line for the unusual case.

You would prefer to see always 4 lines per submodule?
Is one extra line (25% more output) a reasonable tradeoff for the
reference feature?

I dunno; I guess we could argue either way.
