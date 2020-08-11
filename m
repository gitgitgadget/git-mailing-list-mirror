Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C87C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826B1206B2
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m3+/mkBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgHKSyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:54:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60665 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKSyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:54:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 390EF8E790;
        Tue, 11 Aug 2020 14:54:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tAVoB/vGas8E
        LvuAr8XsONFEgR8=; b=m3+/mkBRVhfAF8/zLIA2Ud3Bc7cD4aje5c0vI/6Pf+er
        67DN+v4mJNnSdnyLzDrGRl3KSK6V5tTk8zPnygnJfLRERXYXrYuQIdLlHLoLYReQ
        EzvBzK98ySSdeOFnPlTL+g/CWmwFMbaVI4mAq49lntdbWoV4+Wy9QX4+DGdW63c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dyGyPC
        55/b9OahjYtGkbUOz+x3Ydzox88lV3/ZsMjHEz8yOq4jbKqIFwZjbuQ56V0uJ/sD
        0jqj3M1SzC52jVt5I2dvczurz+w8AHksgdPYtjDDZROS0s9Ehd/s6Uf3g7mAcv6q
        QYBJ5gJqlgmjbsuJW4Ye3bGU71SpaVV6N3oh0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3140E8E78F;
        Tue, 11 Aug 2020 14:54:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C8598E78D;
        Tue, 11 Aug 2020 14:54:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] revision: differentiate if --no-abbrev asked explicitly
References: <cover.1596887883.git.congdanhqx@gmail.com>
        <cover.1597146478.git.congdanhqx@gmail.com>
        <9daef7445c09d355d4801f64e427c27dd6c44afb.1597146478.git.congdanhqx@gmail.com>
Date:   Tue, 11 Aug 2020 11:54:01 -0700
In-Reply-To: <9daef7445c09d355d4801f64e427c27dd6c44afb.1597146478.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Tue, 11 Aug
 2020 18:49:56 +0700")
Message-ID: <xmqqwo259fp2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 05E7A9E2-DC04-11EA-B362-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> When we see `--no-abbrev' in command's arguments, we reset `abbrev' of
> `diff_options` to 0, thus, on a later stage, the object id won't
> be shortened (by not set object_id[abbrev] to '\0').

s/by not set/&ting/ probably? =20

Please do not write pseudo-code that does not exist anywhere in the
codebase that pretends to be a quote from some real code.  It wasts
reviewer's time looking for non-existing code to see what really is
going on.

I think you meant this line in diff_abbrev_oid():

	if (abbrev)
		hex[abbrev] =3D '\0';

so you can say that more explicitly, perhaps:

  ... we reset the 'abbrev' field in diff-options to 0 and this
  value is looked at diff_abbrev_oid() to decide not to truncate
  the object name.

or somesuch.

> While not doing anything is very effective way to show full object id,
> we couldn't differentiate if --no-abbrev or not.

You mean you want to tell if --no-abbrev and/or --full-index was
given from the command line and act differently?  You need to
justify why you need to be able to do so (which you attempted in the
remainder of the proposed log message), and also you need to justify
why changing revs->abbrev's meaning is the best way to do so (which
you did not).  In fill_metainfo(), which you are going to touch in
[2/2], you can peek o->flags.full_index to see if --full-index was
given, and the fact that revs->abbrev is not DEFAULT_ABBREV (which
is how the field is initialized in repo_init_revisions()) but is 0
tells us that "--no-abbrev" was given.  --abbrev=3D0 would have busted
minimum abbrev and set the field to MINIMUM_ABBREV, --abbrev=3D99 would
have busted hash size and set the field to hexsz.  So 0 is the sign
that --no-abbrev was given.  No?

> In a later change, we want to extend --abbrev support to diff-patch
> format.

And it is unclear why this planned change requires it.

> Let's ask for full object id if we see --no-abbrev instead.

Hence, this "let's ask" is not justified very well.

> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>  revision.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 3dcf689341..24027b1af3 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2430,7 +2430,7 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--always")) {
>  		revs->always_show_header =3D 1;
>  	} else if (!strcmp(arg, "--no-abbrev")) {
> -		revs->abbrev =3D 0;
> +		revs->abbrev =3D hexsz;
>  	} else if (!strcmp(arg, "--abbrev")) {
>  		revs->abbrev =3D DEFAULT_ABBREV;
>  	} else if (skip_prefix(arg, "--abbrev=3D", &optarg)) {
