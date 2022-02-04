Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F4BC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 18:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377392AbiBDSJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 13:09:57 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58833 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377397AbiBDSJ4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Feb 2022 13:09:56 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9F46C5C0199;
        Fri,  4 Feb 2022 13:09:55 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Fri, 04 Feb 2022 13:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=p1ioNMfD+ewri4
        Zecs8npBAp9TIhKc0DVYlvOu8xFaQ=; b=j/cqao7Oi/sxKDrcpGbnEK5A7S4KEE
        FGvrOCTcg46KdtClt5KKV6dZyiNt0SvpOCA0lqHL0uEhd0Jk5Xn9cv0mAZje6Ios
        uhMmpfOFmvy+pqs6oKP1fihXXPXlfmmNjEZAE4UxnGV5exYTSxtHirTKbSylLwO4
        CB3U9SznG4YoVQoVr6eFqUUtc3RoYiVJN9vcdMcK9l+Fq1FnJpcZ5GqpBPkj3uKX
        ykDsZWkzrlSppc2yP2LYfD5WE17yRa5Gar4ybOseGXiK/Ydr1oKjtppOdShdANpz
        3bR6FhaUp4i12G0r+WFW6MRZMH1YHFEPPZaL8tchWDptjKDmE0aCV37A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=p1ioNMfD+ewri4Zecs8npBAp9TIhKc0DVYlvOu8xF
        aQ=; b=DE8ybd9Xv2z2FPWPSvp+69gQxSPAXpPj6kH8Pn6qgrUZuL+4LQUCN55yz
        BuVPDwB+vGSVtetNxU675lmDlDd3cFjpxPrkQ9/Uf+qZEajiHbhzQkCk8ehMs9Ks
        gzS0P9qPKIrIXD7VOYVgoEATdvDRcbrA72vUcITpmU+WvQ7OHoU6jOcVbHEmP6Ij
        KkWme7eJuYTyI/IHi4KvqZiPC25SsafkhCqpJHBp+KCpQX21OGtaY6s5QaHJaXPL
        iyNtzqtNUgeP5IL/3nVJy2BI+Kw7o5xZ3kjXE32CnDaTJOBLDwVWmiQePBKDAzQt
        G5MEvXiWwgAGI91wxvAnL8LOT1Nrg==
X-ME-Sender: <xms:82v9YfS1dcGL6luNjQazfgsn0v4a3aGwJr8JLW3pjdyAXkoFFijslg>
    <xme:82v9YQzNfb0t_9qWQ0J0Rx1AGTwohSrIYQx2eLdOTTtFfL_pZ-rMMPDiGgJCWy_rS
    2IebiWix_bW-PKs9p0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeelgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftfgr
    mhhkuhhmrghrucftrghmrggthhgrnhgurhgrfdcuoehrsegrrhhtrghgnhhonhdrtghomh
    eqnecuggftrfgrthhtvghrnhepkeevueekieduleekgfelteduheffkeegveffheeljeeg
    keevteeiteekvedvvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprhesrghrthgrghhnohhnrdgtohhm
X-ME-Proxy: <xmx:82v9YU1uORtI-Q1HmxQwT9aM7qr8RC-E-BhDrDsSKnJN56Ks3szNGw>
    <xmx:82v9YfCQbOryFZLQ4t-Npn4osN9aYdlexk9Tbk_iMFQJNvIv4k5s8g>
    <xmx:82v9YYga9VOtMc9prLZGWPCja14uYbzlZlEEkNkOatkK3ad3OqqA7g>
    <xmx:82v9YbvwhRiOdarWp7Vos-i5AnQMA8y1Le4kCeOo4l7Ty9vBlCiaEQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5FAA31EE007B; Fri,  4 Feb 2022 13:09:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4586-g104bd556f9-fm-20220203.002-g104bd556
Mime-Version: 1.0
Message-Id: <e04aa856-07e2-474f-88ec-af5d47d9f640@www.fastmail.com>
In-Reply-To: <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de>
Date:   Fri, 04 Feb 2022 19:09:35 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Git List" <git@vger.kernel.org>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] bisect--helper: double-check run command on exit code 126
 and 127
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> The workaround used by this patch is to run the command on a known-good
> revision and abort if we still get the same error code.  This adds one
> step to runs with scripts that use exit codes 126 and 127, but keeps
> them supported, with one exception: It won't work with commands that
> cannot recognize the (manually marked) known-good revision as such.
>
> Run commands that use low exit codes are unaffected.  Typos are report=
ed
> after executing the missing command twice and three checkouts (the fir=
st
> step, the known good revision and back to the revision of the first
> step).

I'm happy with the description of this patch. It doesn't add an extra st=
ep for an overwhelming majority of users, while not breaking backward co=
mpatibility.
=20
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -1089,6 +1089,44 @@ static int bisect_visualize(struct bisect_terms=
 *terms, const char **argv, int a
> +static int get_first_good(const char *refname, const struct object_id=
 *oid,
> +   int flag, void *cb_data)
> +{
> + oidcpy(cb_data, oid);
> + return 1;

I assume you return 1 here to stop the for_each_glob_ref() iteration, af=
ter copying the oid.

> @@ -1113,6 +1152,30 @@ static int bisect_run(struct bisect_terms *term=
s, const char **argv, int argc)
> + int rc =3D verify_good(terms, run_args.v);
> + is_first_run =3D 0;
> + if (rc < 0) {
> + error(_("unable to verify '%s' on good"
> + " revision"), command.buf);

Perhaps in a subsequent patch, we can consider sha1_abbrev() to print ni=
cer messages everywhere in bisect.

> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index fc18796517..5382e5d216 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -290,7 +290,7 @@ test_expect_success 'bisect run accepts exit code =
126 as bad' '
> -test_expect_failure POSIXPERM 'bisect run fails with non-executable t=
est script' '
> +test_expect_success POSIXPERM 'bisect run fails with non-executable t=
est script' '

> -test_expect_failure 'bisect run fails with missing test script' '
> +test_expect_success 'bisect run fails with missing test script' '

Yes, these are precisely the two problems I had.

Thanks.

Warm regards,
Ram
