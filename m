Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87812201A7
	for <e@80x24.org>; Wed, 17 May 2017 21:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbdEQVFN (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 17:05:13 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32992 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdEQVFM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 17:05:12 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so13138189pfh.0
        for <git@vger.kernel.org>; Wed, 17 May 2017 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GWgLyn5ObUhu1kB45QXHGFIuoqtoOJaUDKO8zHOHBnU=;
        b=f7IKeZP0mXXUGfmVaX2+/Gd75yh2szth2LDN5o9OBKRsXLDtpADg+HkPmgV5qXozIB
         jYH0d3pvmFqcPu2wlAyTz54wYn41JNqfur9t4sCv5nllGA5fOY5WtU1TXkOKunVqCbe6
         I+VMWRPcWJ/Rx8lmsmzk+ZJ2fagM2VUJyhGSzXMlmcpDJ6AFHBqN+X46r3vxFfsg4bt9
         a3Gqu+FzL2Qh+JXM86lP1QLaG4vW/rtIXZjm01FHy1mbDaCW6Ngw3lWS5k+YF/FDgLFG
         gm1cP9mHPMpZw2Ub3uFe1tQl4RmF8u6Wrp2hvj7D4CanrAtXlyx+uBjWLIPTF+R1KbwD
         21vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GWgLyn5ObUhu1kB45QXHGFIuoqtoOJaUDKO8zHOHBnU=;
        b=jznSiqBgxe3CpLiQrn1UhJP99w9XvTPZI1R5K4gFUdVrAMnNGzjgvlhdwaLbh1dvL8
         kfVcufBzKkmJqZTKqi9RojbNuuvLLcrmSdYfUcIfA8BBcDwp9PoXWedTSrIACKs+5OKn
         l7F15zYcT9H5TYOHOnzzGX2t7q+2gRg8UbMNqsh700Rgi1QNHCgqyMikPz/Hq/VcjREq
         RtoiLelQUvgXe3MWTgGIXbgfY6BrXWp46eD+rKDv0KDby/OR1d65ecaQ8kEQ0LvzqjSa
         6U9kp2PkaK4aEuwOjNz0HrFpONFZYmGyIqnrfhVWCYAfQhck7oEgBsMfscnTCrDpdz2i
         0ikQ==
X-Gm-Message-State: AODbwcDDruS8TEkqAgdlhsFLtr/aNVbLSAXvMUR29M31LQSt0PelalXu
        MrrHtsZ/L59t3wh5KM9lxusmOxskO/te
X-Received: by 10.84.241.132 with SMTP id b4mr811013pll.107.1495055111237;
 Wed, 17 May 2017 14:05:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 17 May 2017 14:05:10 -0700 (PDT)
In-Reply-To: <xmqq8tlwxdp3.fsf@gitster.mtv.corp.google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170517025857.32320-1-sbeller@google.com>
 <20170517025857.32320-13-sbeller@google.com> <xmqq8tlwxdp3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 17 May 2017 14:05:10 -0700
Message-ID: <CAGZ79kbCYiDRbf2+uXANqBiR9sG4ir4m6VK5+t1LS-kE7T1aQg@mail.gmail.com>
Subject: Re: [PATCHv2 12/20] submodule.c: convert show_submodule_summary to
 use emit_line_fmt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 10:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In a later patch, I want to propose an option to detect&color
>> moved lines in a diff, which cannot be done in a one-pass over
>> the diff. Instead we need to go over the whole diff twice,
>> because we cannot detect the first line of the two corresponding
>> lines (+ and -) that got moved.
>>
>> So to prepare the diff machinery for two pass algorithms
>> (i.e. buffer it all up and then operate on the result),
>> move all emissions to places, such that the only emitting
>> function is emit_line_0.
>>
>> This prepares the code for submodules to go through the
>> emit_line function.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  diff.c      | 20 +++++++---------
>>  diff.h      |  5 ++++
>>  submodule.c | 78 ++++++++++++++++++++++++++++++------------------------=
-------
>>  submodule.h |  9 +++----
>>  4 files changed, 56 insertions(+), 56 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 690794aeb8..7c8d6a5d12 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -516,8 +516,8 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile=
_t *mf2,
>>       ecbdata->blank_at_eof_in_postimage =3D (at - l2) + 1;
>>  }
>>
>> -static void emit_line(struct diff_options *o, const char *set, const ch=
ar *reset,
>> -                   int add_line_prefix, int sign, const char *line, int=
 len)
>> +void emit_line(struct diff_options *o, const char *set, const char *res=
et,
>> +            int add_line_prefix, int sign, const char *line, int len)
>>  {
>>       int has_trailing_newline, has_trailing_carriage_return;
>>       FILE *file =3D o->file;
>> @@ -547,10 +547,10 @@ static void emit_line(struct diff_options *o, cons=
t char *set, const char *reset
>>               fputc('\n', file);
>>  }
>>
>> -static void emit_line_fmt(struct diff_options *o,
>> -                       const char *set, const char *reset,
>> -                       int add_line_prefix,
>> -                       const char *fmt, ...)
>> +void emit_line_fmt(struct diff_options *o,
>> +                const char *set, const char *reset,
>> +                int add_line_prefix,
>> +                const char *fmt, ...)
>
> Interesting...
>
>> -static void show_submodule_header(FILE *f, const char *path,
>> -             const char *line_prefix,
>> +static void show_submodule_header(struct diff_options *o, const char *p=
ath,
>>               struct object_id *one, struct object_id *two,
>>               unsigned dirty_submodule, const char *meta,
>>               const char *reset,
>
> Is this ONLY called when the caller wants its output inserted to the
> "diff" (or "log -p") output?

Yes.

>  If so, I think it makes sense to pass
> 'o', but if the function is oblivious that it is driven to produce
> part of a "diff", it feels wrong to pass 'o'.  The original was
> taking a "FILE *" and line_prefix, so it is rather clear that the
> answer to the question is "yes, this is very closely tied to diff
> output".  Now you have access to 'o', so you do not need to pass
> them separately.  Good.

ok.

> Each line in its output, when incorporated in "diff" or "log -p"
> output, must be prefixed with the line-prefix to accomodate users of
> "log --graph", so I guess it cannot be helped.  Your calls to
> emit_line_fmt() below seems to ask the line-prefix to be added,
> which is good, too.
>
> How does capturing these lines help moved line detection, by the
> way?  These must never be matched with any other added or removed
> line in the real patch output.

Why?

Actually I think it has some value if it can match across
(submodule-)repository boundaries, e.g. think of =C3=86vars RFC to put
SHA1DC into a submodule. If reviewing that commit later on, a user
may be interested in "what is the difference between what we carried so
far in this repo compared to what we point at now in the submodule".
Most of the code should be the same, but anchored at a different
path/repo, so a move detection would be super helpful.

I do understand that you may not want to see a move crossing
a repo boundary, but I would prefer that to a later patch, once we
have a better understanding on the use cases of this new feature.

>>       if (is_null_oid(one))
>>               message =3D "(new submodule)";
>
> emit_line() and emit_line_fmt() are both inappropriate names for a
> global function.  These are very closely tied to diff generation, so
> we probably want to see some form of "diff" in their names.

Oh, uh. You're right.

I would think inside of diff.c we'd still want to keep the short name,
so maybe I'd expose a wrapper to the outside world.

Maybe

    diff_emit_strbuf(diff_options *, strbuf *)

would be fine for all use cases from outside.


> The fact that it is clear because its first parameter is "struct
> diff_options" is insufficient---"you cannot tell what context the
> function is meant to be used by only looking at its name" is
> certainly solved by its function signature, but the other issue with
> an overly generic name is that other codepaths in different contexts
> may want to use such a short and sweet name.
>
> Thanks.

I am bad at naming, so if you have a better idea for names,
feel free to mention them.

Thanks,
Stefan
