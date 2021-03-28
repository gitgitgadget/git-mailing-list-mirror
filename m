Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404BC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD876191A
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhC1G2g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:28:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58895 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1G23 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:28:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80CDF123BAD;
        Sun, 28 Mar 2021 02:28:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2O+m57X+7Kwp
        7p16668t7SYepCU=; b=UD+I78YOTMmNcCGXWweEe4e5wsIGlOPc9oKIyx71cTn0
        kAfwmKoa9xYIsHbO4Nd3I9VYD+qmPEgKukOns7KfYEDK84Xj2Mp1U7MoOH/uTnC3
        TEw7kTE3Ea5LXnxqtUsTQbSp8DZSY6kyIeoc9WNpPaVgbC5CwXSa5nzGUSxidxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TkvJYi
        0D1zUQLVKaKlPZ+TxDpdHuHBXSCk0FpMrlqOK4hUe+U7W5fwtH0i5z6pjRwRhSrQ
        TTjb/ugOGRVhdaRCecTWbByxD0VsT+Z47kBr9UV3NZrtRe3EXeaIG9TqTBVVx8rR
        CIz1aMKMMSOEH8AZPMElCHhdnikIM3W/MU3Dc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 79951123BAB;
        Sun, 28 Mar 2021 02:28:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BF1BD123BAA;
        Sun, 28 Mar 2021 02:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] doc lint: Perl "strict" and "warnings" in
 lint-gitlink.perl
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-3.6-12573d90289-20210326T103454Z-avarab@gmail.com>
Date:   Sat, 27 Mar 2021 23:28:25 -0700
In-Reply-To: <patch-3.6-12573d90289-20210326T103454Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 26 Mar
 2021 11:36:48 +0100")
Message-ID: <xmqq35wfokqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CDEDA6BA-8F8E-11EB-B86B-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Amend this script added in ab81411ced (ci: validate "linkgit:" in
> documentation, 2016-05-04) to pass under "use strict", and add a "use
> warnings" for good measure.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/lint-gitlink.perl | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitli=
nk.perl
> index 476cc30b837..35230875c24 100755
> --- a/Documentation/lint-gitlink.perl
> +++ b/Documentation/lint-gitlink.perl
> @@ -1,5 +1,7 @@
>  #!/usr/bin/perl
> =20
> +use strict;
> +use warnings;

Yes!  Thanks.

>  use File::Find;
>  use Getopt::Long;
> =20
> @@ -45,7 +47,7 @@ sub lint {
>  				report($where, $target, "no such source");
>  				next;
>  			}
> -			$real_section =3D grab_section($page);
> +			my $real_section =3D grab_section($page);
>  			if ($real_section !=3D $section) {
>  				report($where, $target,
>  					"wrong section (should be $real_section)");
