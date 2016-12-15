Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48801FF76
	for <e@80x24.org>; Thu, 15 Dec 2016 09:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757856AbcLOJ4T (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 04:56:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36055 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757800AbcLOJ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 04:56:14 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so5327090wma.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 01:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MiUGYlJRWWecV3NkXFPll5Smous8jAmpo0XZHT1fY/c=;
        b=A/vnrOMqEK3rvgKeJcSFOhR7IgcUtw/VVz0QjUJSCsocvagEBpi04YXF78D4Y+oHIR
         kOhDlJo6hhB5mGGUBaQJJYfJ3xZSykCwfOHAohGAr/hZpfGGt1DyBZygqETv0351O08z
         Nb34S6d4AO7Fm/E2ROdpJV1I01RuDMqqNnpmiZXS4jKR+U0BgwR8GCgqUp/taOjRRaCS
         T2FikHdbBJHktsYAuV5RN7mxauDyvoZ98HvHmBsuzTvHI2KalhNIG8FVBtFhaqSubE7C
         8rZEFkyzgAGMOfPspVGNC6g98EIImHK/UlnWoZJJDRYQq90Mdc5R2kW9JZDlt7xRN7EI
         xwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MiUGYlJRWWecV3NkXFPll5Smous8jAmpo0XZHT1fY/c=;
        b=K9jBiZ4nmSKcg/Fu3qOITRdEDwvbBfl1OPn4r4/WXNIgNlibyIXV9HOOxRt/ijGfHN
         TX6lTpQ/v2OKFOcSPxwUmFJOyjoLRe9bI2Q5+4HAWvnWbYlDh+kVXF/DKf87ln+bdY82
         uTvrrrhhZHPOqZ9+JsQZPytgPSXukfmKjT1TOsuwKBLWIOdcF0erB0oRl9fSb186Xyze
         eKhH2e4qnHcmiuVzCtxEH667o0uJSEuXzDp7kvn3wy26aHLAZ+IytiExgfmQExwyzRxh
         3PagaBfVFQMJ7P26Z03JgE1s1BBSfEXeuTgWFnSKCpXjgFjyRvh0QTWmL7UIr457CI83
         XQEQ==
X-Gm-Message-State: AKaTC00vlAHBh3OJoJXCz3NY3ZAyoW4yNLP2XpLRpkK1rFkBcswgAvyrU7B7C6mT7Em6uoBcx2zAL5VvivRXSg==
X-Received: by 10.25.170.198 with SMTP id t189mr156630lfe.129.1481795773095;
 Thu, 15 Dec 2016 01:56:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Thu, 15 Dec 2016 01:56:12 -0800 (PST)
In-Reply-To: <xmqqshpr1tox.fsf@gitster.mtv.corp.google.com>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
 <xmqqy400bno3.fsf@gitster.mtv.corp.google.com> <CAP8UFD1=-xKWaDnGKrtm2mzVxpH7N-Q3iqnOJeOM5QrtNpitrA@mail.gmail.com>
 <xmqqshpr1tox.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 15 Dec 2016 10:56:12 +0100
Message-ID: <CAP8UFD3ytxuQ8wF2AawvbyzThCF0f5qQcmrpNy0pmzyorZiEGA@mail.gmail.com>
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 9:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> In general I think that having a lot of refs is really a big problem
>> right now in Git as many big organizations using Git are facing this
>> problem in one form or another.
>> So I think that support for a big number of refs is a separate and
>> important problem that should and hopefully will be solved.
>
> But you do not have to make it worse.
>
> Is "refs" a good match for the problem you are solving?  Or is it
> merely an expedient thing to use?  I think it is the latter, judging
> by your mentioning RefTree.  Whatever mechanism we choose, that will
> be carved into stone in users' repositories and you'd end up having
> to support it, and devise the migration path out of it if the initial
> selection is too problematic.
>
> That is why people (not just me) pointed out upfront that using refs
> for this purose would not scale.

What I should perhaps have clarified in my previous answer, and also
in the documentation of the patch series, is that in what I have done
and what I propose, the external odb helper is responsible for using
and creating the refs in refs/odbs/<odbname>/.

So this helper is free to just create one ref, as it is also free to
create many refs. Git is just transmitting the refs that have been
created by this helper.

Right now people are already free to use whatever external script or
software to create whatever refs/stuff/* they want, pointing to
whatever objects they want, and have Git transmit that. And indeed I
know that it is already a problem out there, as then people often get
into trouble related to having many refs. But it is a different
problem that is not going to be solved anyway in this patch series.

So if some people want to use a specific external odb, it's their
responsibility to use an helper that will not create too many refs.
If they know that they just need their external odb to handle around
10 big files, why wouldn't they use a simple helper that creates one
odb ref per big file/blob?

On the contrary if they know that they will need to handle thousands
of big files, then, yeah, they should find or implement a helper that
will, as I suggested in my previous email, just create one ref
in refs/odbs/<odbname>/ that points to a blob that contains a list
(maybe a json list with information attached to each item) of the
blobs stored in the external odb.

For testing purposes in what I have done in the patch series, I use
only simple helpers that create one odb ref per big file/blob. So yes,
it gives a bad example, because, if people just copy this design while
they need the e-odb to handle a big number of files, then they will be
in trouble. But this does not by itself carve anything into stone.

One thing that could help is perhaps to put big warnings into the
simple helpers saying "Be careful!!! This will not scale if you want
to handle more than a small number of large files!!! You'd better use
an helper that does <this and that> if you want to handle many large
files!!! You have been warned!!!".

So I am reluctant at this point to write a complex helper just for the
purpose of showing a good example to people who want to use e-odb to
store a big number of files, as these people anyway would probably
need something like Lars' "filter process protocol" too.
