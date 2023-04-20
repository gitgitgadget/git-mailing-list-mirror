Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CBFC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 02:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjDTCr1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 22:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjDTCrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 22:47:19 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28AE7C
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 19:47:10 -0700 (PDT)
Date:   Thu, 20 Apr 2023 02:46:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1681958828; x=1682218028;
        bh=/ucYm+XCcEg8FheodlKkopIg6fafC3o1h0PPuQyVXIE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=fwX2s+24fLLCNtTdh1cPPo6Mdc4WC5xvlx24MSKoNKkK6rGqohQNv9Vfg3PNDGURa
         6tS6EkeiOGWjK5jdbeQyMkHwgif4nhH6pat/Z/RPfK4slqEX8ADn2Gg8HiQYYnoJP0
         S83X2ONAcchOI50iOZ4Pg0BqELIO/BpZ9KJQ2iAMOFB4Kd7fn4ST7IoWm5He9A0nwM
         /+nfWiiNS3VYBX2xTwBbcIEEHmd48+VBQFSGgykMx8M/OdSzHQlmekzih7a9K2MEil
         3tW43VlB2aPwBPLW6ttW9ytWlhMU5R5zqu33i+A6hG4o7ax2QD59DWzwdONMpy7MIN
         rqBqWGsEgiGBw==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v9 3/8] t2400: refactor "worktree add" opt exclusion tests
Message-ID: <dsbjgeppeusvddeqn466xwnaa6eif4uoofbcju4sdzhotp5ctq@hh6unkszo5k3>
In-Reply-To: <xmqqmt36jixr.fsf@gitster.g>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230417093255.31079-4-jacobabel@nullpo.dev> <xmqqmt36jixr.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/04/17 02:30PM, Junio C Hamano wrote:
> Jacob Abel <jacobabel@nullpo.dev> writes:
>
> [...]
>
> > [....]
>
> Again, I do not think this sends output to the standard output at
> the end of this test piece.
>
> > +=09=09test_must_fail git worktree add $opts 2>actual &&
> > +=09=09grep -E "fatal:( options)? .* cannot be used together" actual
> > +=09'
> > +}
>
> I do not think this patch is needed (I'd rather see people learn the
> trick of running with "-i" and rely on the fact that the trash
> directory is left intact to be inspected), but if you must, it may
> make more sense to add test_must_contain to make a failed 'grep
> "$@"' easier to see, similar to the way that test_must_be_empty
> helps a failing 'test !  -s "$1"', something along the lines of ...
>
> [...]
>
> Thanks.

Understood. As mentioned in the discussion for patch 2/8, these changes
(trying to `cat actual` on `test_cleanup`) will be reverted for the next
revision across all patches.

