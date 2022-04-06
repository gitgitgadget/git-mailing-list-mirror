Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EECC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiDFRzO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbiDFRzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:55:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21181107830
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 09:04:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DC2F12B6EF;
        Wed,  6 Apr 2022 12:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zd9sq71dPQLO
        4VLQVT/a/r6L2CjnQ/xB8hPjmWT5r1Q=; b=hmdkNpuvA3YcVZOp4YwNi8qakUD2
        VVESb7rY7WSEy7eCo8mSbyjHfwT0Rg1CmeSx8O4wqBhg+Yvw3Td8E/XhUpmBTFy2
        fNJp6njMLIsXnhaSuA4mYiw3XduEgLr76z2qlHnh2LN2x/J1d/TN5k9rdcJH6H3J
        ZMMPkhoF59J5TRo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7420B12B6EE;
        Wed,  6 Apr 2022 12:04:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3A8F12B6ED;
        Wed,  6 Apr 2022 12:04:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        rsbecker@nexbridge.com, 'Git Mailing List' <git@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com>
        <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com>
        <034701d84875$030bfb40$0923f1c0$@nexbridge.com>
        <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
        <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan>
        <035b01d84899$3cdc5b20$b6951160$@nexbridge.com>
        <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan>
        <Ykv5dCEv/gl7aHMq@camp.crustytoothpaste.net>
Date:   Wed, 06 Apr 2022 09:04:20 -0700
In-Reply-To: <Ykv5dCEv/gl7aHMq@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 5 Apr 2022 08:10:28 +0000")
Message-ID: <xmqqzgkyyz97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 38DC1F8C-B5C3-11EC-ACA7-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I didn't consider the case that we had NO_OPENSSL=3D1 because it seems =
a
> bit bizarre to say, "No, I don't want OpenSSL=E2=80=94oh, wait, I do wa=
nt
> OpenSSL!"

Indeed ;-).

> This patch also didn't seem necessary for me on Linux when I tested, bu=
t
> of course it might be necessary on some systems, so if it fixes things,
> I'm in favour.

I think I've seen the breakage myself when I tried to force
CSPRNG_METHOD =3D openssl in my build.  Let's take the patch as-is for
now.


