Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB8C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E562151B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ux5/EGKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgLAT1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:27:53 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51690 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbgLAT1x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:27:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3957C114485;
        Tue,  1 Dec 2020 14:27:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ysU0D3vS12E/
        MOByKyB/Q0fwhGk=; b=ux5/EGKDPWWWov7Mhs/FisGqLKeHRdtObeF0e6XO42kv
        sJr8fGfRvkLjjpnC5FOtLgaxP4g5OCkyjFRECxI7cxsDwpagpV3zJmLsT6FYBBep
        5f4v2a3OUAsOjfzIL++bdmhwMjeJyRku5yGfDo6+hq15wWS+wi3wTeC4nnUuilc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=esnF3u
        A1MDPSsHvQoqoxuwhay0IIRtluaIb5Z5NM3kwf6ouepZWeBQU04d9hDn1D5pNAyw
        fAVXgNcxzr9pi76lv8SQU9wp5x/l+mv8m3qNVqGZUiaqk5rMiTzLZx6ahNzsCE4Q
        KIRjQiDuwIMdjNnJuInhy2Nfhr6Fq0vu727eQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32319114484;
        Tue,  1 Dec 2020 14:27:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72490114480;
        Tue,  1 Dec 2020 14:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Arnout Engelen <arnout@bzzt.net>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
References: <20201201095037.20715-1-arnout@bzzt.net>
        <20201201154115.GP748@pobox.com>
Date:   Tue, 01 Dec 2020 11:27:06 -0800
In-Reply-To: <20201201154115.GP748@pobox.com> (Todd Zullinger's message of
        "Tue, 1 Dec 2020 10:41:15 -0500")
Message-ID: <xmqqpn3tpbsl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33E49922-340B-11EB-B407-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Hi Arnout,
>
> [cc: brian, Martin, and peff, for their collective wisdom in
> the area of docs and involvement in the last discussion of
> docbook-xsl requirements.]
>
> Arnout Engelen wrote:
>> This makes sure the generated id's inside the html version of the
>> documentation use the same id's when the same version of the
>> manual is generated twice.
>>=20
>> Signed-off-by: Arnout Engelen <arnout@bzzt.net>
>> ---
>>  Documentation/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 80d1908a44..4d1fd5e31f 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -380,7 +380,7 @@ SubmittingPatches.txt: SubmittingPatches
>>  	$(QUIET_GEN) cp $< $@
>> =20
>>  XSLT =3D docbook.xsl
>> -XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css
>> +XSLTOPTS =3D --xinclude --stringparam html.stylesheet docbook-xsl.css=
 --stringparam generate.consistent.ids 1
>> =20
>>  user-manual.html: user-manual.xml $(XSLT)
>>  	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
>
> I think this would raise the minimum supported version of
> docbook-xsl to 1.77.1.  That might be fine, but we'd
> probably want to make sure it doesn't negatively impact
> OS/distributions which build the docs as a likely group who
> care about reproducible builds.  And we'd want to update the
> requirement in INSTALL, of course.
>
> The minimum docbook-xsl version was raised from 1.73 to
> 1.74, in 5a80d85bbe (INSTALL: drop support for docbook-xsl
> before 1.74, 2020-03-29).  That change was discussed in
> <cover.1585486103.git.martin.agren@gmail.com>=C2=B9.
>
> AFAICT, the generate.consistent.ids param was added in
> docbook-xsl-1.77.1 which was released in June 2012.  The
> commit which added it is 74735098e (New param to support
> replacing generate-id() with xsl:number for more consistent
> id values., 2011-10-24).
>
> In any case, a minimum of 1.77.1 is present in the supported
> releases of CentOS/RHEL and Debian/Ubuntu, at least (most
> have 1.79.x).  Those are certainly not the only systems Git
> cares about; they're simply the systems with which I am at
> least mildly familiar.
>
> =C2=B9 https://lore.kernel.org/git/cover.1585486103.git.martin.agren@gm=
ail.com/

I think it is in general a good thing to do (can we lose some lines
from doc-diff, I wonder?) and many of the result of your study shown
above should be in the log message in a summarised form.  Here is a
starter.

    Generated ID's in the HTML version of the documentation does not
    stay the same even when they are generated from the identical
    source.  Pass generate.consistent.ids=3D1 to the xsltproc tool to
    make them stable, which would help reproducible build product.

    We currently only support docbook-xsl version 1.74 or newer, but
    this option requires version at least 1.77.1 (released in June
    2012), which would be OK for supported releases of CentOS/RHEL
    and Debian/Ubuntu (most have 1.79.x).

We may probably want to talk about versions commonly distributed for
macOS and BSDs as well (I do not know if we want to list minor Linux
distros).  And we definitely need to update INSTALL as you pointed
out.

Thanks and thanks for CC'ing those who may know the area well.

