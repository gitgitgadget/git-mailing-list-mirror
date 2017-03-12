Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF07202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 17:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935095AbdCLRtl (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 13:49:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64633 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935007AbdCLRtj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 13:49:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C1C8855F3;
        Sun, 12 Mar 2017 13:49:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5ZFZWEgK+7dH
        dwZDc4QtSNCnoDw=; b=jy/OiyJ6m/Lk9Kj1Y+GVaQndvhozMwNi4/pO0ZGruz+5
        9gDxyiH5uZeyU8oOX/jZ+yWgFc0EF0DluXSKu4v4ay4WDfeKTZ+j+v0cLGoAhJBr
        vSOBE/HA7EPD7i2mTWS4nbFMomRCaT1DZNEfnKc85V0RGk2sDO+Gqpe03FFsYGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TL0xDR
        ijnhP3jAMKq+zz5sbD9dbqw2xi+E5RRN20mkdSpn/o8bW8Wslj5GXJCTR9MApeYI
        BiI/xEoQfJgWtnU54M1tGGtAlShgi505pfsCmsd4n/G/l+hhcB0IWjS/ufLCR0kW
        5w2bDJ10d9B+VcALgwSlUlAJPv/dJlOCIimNQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74A08855F2;
        Sun, 12 Mar 2017 13:49:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF2A3855F1;
        Sun, 12 Mar 2017 13:49:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4] ref-filter: Add --no-contains option to tag/branch/for-each-ref
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
        <20170311201858.27555-1-avarab@gmail.com>
        <xmqqwpbvumrk.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4v49zfyGVpcxGSKsxbMfVaUcGHtitpfaZMUtG82YzW-g@mail.gmail.com>
Date:   Sun, 12 Mar 2017 10:49:35 -0700
In-Reply-To: <CACBZZX4v49zfyGVpcxGSKsxbMfVaUcGHtitpfaZMUtG82YzW-g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 12 Mar
 2017 10:10:25
        +0100")
Message-ID: <xmqqk27uv100.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 424BB0C6-074C-11E7-97AA-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> And then later in the documentation:
>
>     -l <pattern>, --list <pattern>
>
> I.e. for git-branch this type of invocation wouldn't make sense and
> would just happen to work, but for git-tag the --list option is
> explicitly documented to immediately take a <pattern> argument.

But that (i.e. "to immediately take") is not how it actually works,
as you already know after looking at how 'l' is defined as OPT_CMDMODE.

The command line is more like "-l" chooses the "list mode", and the
pattern is _NOT_ an argument to the option at all.  The command line
is more like "-l <options to affect selection criteria>..." and the
<pattern> is one of these criteria.  The command line convention being
dashed-options first then other arguments, it makes sense to do

	-l --contains HEAD v\*

because "--contains HEAD" is a dashed-option (which takes an argument)
and "v\*" is a pattern (which is "other arguments").

> I'll change it.
>
>>     git tag -l --no-contains v2.10.1-3-gcf5c7253e0 'v[0-9]*' |
>>     sort | tail -n 10
>
> Although I'll add a \ to that so you can still paste it to a terminal.

Please don't.  The shell knows, when you end a line with pipe, that
you haven't finished your sentence and keeps listening to you.

>> Reviewers would appreciate you refrain from doing that in the same
>> patch.  Do a minimum patch so that the review can concentrate on
>> what got changed (i.e. contents), followed by a mechanical reflow as
>> a follow-up, or something like that, would be much nicer to handle.
>
> Okey, so two patches, one where I potentially produce very long lines
> & then re-flow them in a subsequent commit.

Or preferrably, the last "-" line in a hunk of your first patch may
be longer than the first "+" line that replaces it that may be
overly short (i.e. chopping the end of existing paragraph and
replacing the remainder).  And then reflow comes, e.g.

    -Okey, so two patches, one where I potentially produce very long line=
s
    +Okey, so two patches, one where I
    +cut an existing line short if it makes the patch churn smaller
     & then re-flow them in a subsequent commit.

> If I'd like to base on top of that to make things easier for you do
> you publish  jk/ref-filter-flags-cleanup sowhere? I.e. as a git ref
> rather than me also following that topic, applying it on top of
> master, and then applying my topic on top of that.

Do you mean a repository that holds broken-out topics?  If so:

	git://github.com/gitster/git/

is what you are looking for, perhaps?

>
>> and have both default to HEAD?  I know that would not make sense as
>> a set operation, but I am curious what our command line parser
>> (which is oblivious to what the command is doing) does.  I am guessing
>> that it would barf saying "--contains" needs a commit but "--no-contai=
ns"
>> is not a commit (which is very sensible)?
>
> It'll spew out "error: malformed object name --no-contains".
>
> You can do "--contains HEAD --no-contains HEAD" to get nothing.
>
> In an earlier thread I was discussing with Jeff whether it would be
> worthwhile to error out in that case, but his opinion was
> (paraphrasing) "Nah, GIGO", which I think makes sense in this case.

I agree with Peff (I said "that would not make sense as a set
operation", didn't I? ;-); I was only curious if the notation used
in the documentation, i.e. "--opt [<object>]" made sense.  It looks
as if it would accept "--contains --no-contains" (omitting arguments
from both options), but it is not so, and I was wondering if we need
to improve the documentation, or the readers are OK with the notation.

>>> -#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0=
)
>>> +#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, P=
ARSE_OPT_NONEG)
>>> +#define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v=
, h, PARSE_OPT_NONEG)
>>>  #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT=
_HIDDEN)
>>> +#define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PAR=
SE_OPT_HIDDEN)
>>
>> Hmph, perhaps WITH/WITHOUT also do not take "--no-" form hence need OP=
T_NONEG?
>
> I may be missing some subtlety here, but I think you've misread this
> (admittedly dense) chunk. the /WITH/ options don't supply NONEG, just
> HIDDEN.

Maybe I was unclear.  As --contains should not take --no-contains
and use "unset" (because new code wants to see "no-contains" and act
on it in the new code, I was wondering if we should forbid --no-with
and --no-without in a similar way by using OPT_NONEG in addition to
OPT_HIDDEN.
