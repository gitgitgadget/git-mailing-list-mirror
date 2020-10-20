Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1802C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 07:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37242224B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 07:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="g4GvITBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405042AbgJTHYw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 03:24:52 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:11593 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405036AbgJTHYv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 03:24:51 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 3FA5B2001ABC
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 07:24:49 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="g4GvITBb"
Date:   Tue, 20 Oct 2020 07:24:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1603178685;
        bh=pUwseMo2WYVdFt4PjYSO9+0YUsveLPrImaY3M1xfIR0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=g4GvITBbTzVX16gcEeSHBZxXGfCzozRg6QjP6FXM0zjYss4TmY+2CjpP3h1Sx4mFI
         9EBod5Q1nr+ywW2zPzfwck668ulmtGnxrza9gDzTEHdtvBo+eMnzCj0H7JkyuhuKM4
         V5/q0uDFJxL2O2hJjkdl8ce9H/IIaOZ20jvKGa44=
To:     "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>,
        "me@ttaylorr.com" <me@ttaylorr.com>,
        "emilyshaffer@google.com" <emilyshaffer@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
From:   Joey S <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Joey S <jgsal@protonmail.com>
Subject: Re: [OUTREACHY][PATCH v1] t7006: Use test_path_is_* functions in test script
Message-ID: <O2ACwMmJ8_oj_OrMPF4bGf-9nctJiXbFxJ6yzlWWCob0Zr25aSCOfcCc8pGNukbReQQJi_6igxiEyQT1hWp3ccbY1pJr62Y4eNk097tInP8=@protonmail.com>
In-Reply-To: <xmqqpn5dd5dv.fsf@gitster.c.googlers.com>
References: <ERmIkC3rLZ3BAyv2Nq_GK0CjWvEQw6ejl8V-HVvwCsyIv0guQV67nO8KMLi7eA9qO5mo_ZJ8XB360uP_LtP-LY1xsaRBXHsc0F1uSID-KPE=@protonmail.com> <20201020001103.GB2774782@google.com> <xmqqpn5dd5dv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

Thank you very much for the input and feedback, it's much appreciated.

> All this text above is useful context for reviewers but appears as part
> of the commit message which is not what you want. If you add notes after
> the `---` line below then they will not end up in the commit message.
>
Understood, thank you.

> > Modernized the test by replacing 'test -e' instances with
> > test_path_is_file helper functions.
>
> s/Modernized/Modernize/
Will do in the amended commit next.

> > -   ! test_path_is_file paginated.out
>
> It would be better to replace`! test -e` this with
> `test_path_is_missing` as the modified test will pass if paginated.out
> exists but is not a file. `test_path_is_missing` will print an
> appropriate diagnostic message as well.

Thank you for the explanation : )

After replacing `! test -e` with `! test_path_is_missing paginated.out` how=
ever, the changed test cases are failing;
```
$ cd t/ && prove t7006-pager.sht7006-pager.sh .. Dubious, test returned 1 (=
wstat 256, 0x100)
Failed 3/101 subtests

Test Summary Report
-------------------
t7006-pager.sh (Wstat: 256 Tests: 101 Failed: 3)
  Failed tests:  7-9
  Non-zero exit status: 1
Files=3D1, Tests=3D101,  5 wallclock secs ( 0.03 usr  0.00 sys +  3.49 cusr=
  0.65 csys =3D  4.17 CPU)
Result: FAIL
```
Is this the behavior I should be expecting?


> ...Alternatively, this would fit just fine in a cover letter. Usually
> cover letters are not necessary for single patches (where the patch
> message itself conveys the full message, or a little bit of additional
> context below the triple-dash line is all that's necessary to clarify
> the intent). But, if you want to introduce yourself, a 0/1 cover letter
> is fine, too.

Will keep this in mind, thank you Taylor.

> > One thing missed by other commenters: the Developer's Certificate of
> > Origin line - which is what this indicates - should have your "full
> > name".
>
> ... and it must match the authorship.

Changed, thank you both for catching that.

Thank you all,
Joey

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Monday, October 19, 2020 7:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:

> Emily Shaffer emilyshaffer@google.com writes:
>
> > On Mon, Oct 19, 2020 at 04:26:07AM +0000, Joey S wrote:
> >
> > > Hi everyone,
> > > Hi Joey and welcome.
> >
> > > Signed-off-by: JoeyS jgsal@yahoo.com
> >
> > One thing missed by other commenters: the Developer's Certificate of
> > Origin line - which is what this indicates - should have your "full
> > name".
>
> ... and it must match the authorship.
>
> > So in my case, I sign my patches 'Emily Shaffer
> > emilyshaffer@google.com'. If I'm wrong that's fine, but JoeyS sounds
> > like a name and initial rather than a full name.
>
> Thanks for pointing it out.
>
> If somebody from the "mentoring" group is taking a tally, it might
> not be a bad idea to identify which style and procedure rules are
> often failed to be followed by new contributors so that we can
> figure out ways to make them stand out in our documentation set
> (e.g. Documentation/SubmittingPatches but maybe a separate cheat
> sheet might be worth having).
>
> Thanks.


