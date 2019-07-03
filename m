Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1B41F461
	for <e@80x24.org>; Wed,  3 Jul 2019 10:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGCKIU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 06:08:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:46277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfGCKIT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 06:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562148485;
        bh=ry2u8+ojfoObENDn2MXf+B0YfaoIYPnJepOPddo3pYk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QBpD0dzl2MXtAFqLdK5ZqbmlB0gS7T2CK5LxCIU2LUrCypPvMyycYzX/NUivK2/vh
         B6618aoIIIOxso/wPS+KSeG+KomwQV6FI2wFR7YoT9ng2oiMRp1DdATL8SqlIte8O4
         3zYR97sgMYYlJLx0R0dqqRSwOsI+/W9W3V+T0KvI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M39zL-1iZCR01F2N-00suwl; Wed, 03
 Jul 2019 12:08:05 +0200
Date:   Wed, 3 Jul 2019 12:08:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
In-Reply-To: <xmqqo92c2oru.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907031205110.44@tvgsbejvaqbjf.bet>
References: <20190627233912.7117-1-avarab@gmail.com> <20190701212100.27850-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet> <xmqqo92c2oru.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VieAB19o/Y8ciPLgz8ydep8a7CwCkUHk/oqcz4AbrnIQpA+t1HT
 eAwbPtipzwRLhyOoIeLE+F2eHH7UmekpjohhFxKBS9iiWLI77lIsas4nK7znlhJV5JVzpAk
 RjL0itRCoTCxtbts1Te24p/C14VqsGQXwkasBWEqzfQZzNXRdO2IpjxaVjXXlbMrfF1jwKJ
 iqKVjc9BNvqz69wcmwAbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qfWm8Gjw6ms=:R9qZDNu8Y24f8FeJj2oqvo
 ASFK1vfaFnd8667aKmOL8i4J6kPE9q7J/37R2wDj9lDOCovMMyHjSpyqT5IQk5RTk1+bWaBGH
 a7+yKcMod/lNaLn373Dfxu6jldwnUR98HKes+d9gB38MzaUeKWcoVx8Fto4fG6dXAfNSn1ul0
 OWE2RimNBNZf/SajIG+NnG5ZSXbAKyHgA80SHmjCO+1zZDBLSN3lvwZvk0WyHMomsG97n+8fJ
 POAanULQ1pKNr+appiufxNbxbfomM9SEbu9rXr2kFmmiO+/VuxhwPoO84BOn/FuAdKbnJ2fAO
 pTWVaB+1TuXPE0ct3OQ4QFkPCHfr6SaOdbfo/0/Y0X9pNfZnpAISfuF/leyaMTRbLh3eqTWOG
 BeTMjGP2VGP+/ZU+zPHGUPyR5bXElfhi5inIUtaAS/wQ3CjZMrz0kw7lhcrwNk92iv7SWgx6L
 n2pAs2D6Emm5k8ucZnKGUTT0kzxlPFE28SLkPgxzbegFenu5yzjPqlc0gSeLGWLqa0pRNBuyY
 6tNjr8+HvHfbov+fxXrZiod4dKlh6GzKD79NF1mcCI69pLeig+JuazCaHOus7jABG5ydJjyGf
 QwzXxtkjJ05IEef39ptwqW6juMVj5z+wu8TzSZZraPhKiVQAo+PXtHQlE8gJp8HSqL/E/hHjt
 4O+N7uyG6H+hjDMimq8+ezMqZ90JmWQNto1Z0GIDsCUMrXLkL2lWDTni3XMhTdLG1WBJxitp2
 YY8XBVu3+d38gKfEp8j9uE8oc/WZqUYdTV3UJIRNWHpmUls/LJHRtWQg/ddquDAWXdnn1RRBY
 JlMSnqZlUI4C9uSCnlNebOFVpIucAowmM1HHwgGpEmhMlmcStK90CEIAfVffgFAB32HH6GA9T
 ZXjDvra70xck2j3BRrpXGI4MbDwoogmfCS8OTkOY9fJTs4Pze06qUo4/bqz4r6O+isMRX6EWQ
 ZbayBLLTfx3jzArGXFWQ7asGk5u3mBqFVE4O/6Lf5iu8XV1dPOtNeR7vzt8IMuBMp0mL4XuIA
 Pou39MmAgsibEu5pXUqYdjt2a2rcwv2juetIe3we7pMmA81Q8xEJ0UuU0jUuToVJJLr68d/Iu
 SI3opFfygTt83M4uJiPCPR26Azw9YSq5O3d
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 2 Jul 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Please note that the problem is _not_ MinGW! The problem is that the
> > non-JIT'ted code path is a lot more stringent than the JIT'ted one. So
> > what you'd need is a prerequisite that tests whether the PCREv2 in use
> > supports JIT'ted code or not, and skip the test case in the latter one=
.
>
> Hmph, so additional prereq !MINGW may happen to match "do we use
> pcre sans jit?" but not a right thing to use here?

That's right, the `!MINGW` prereq works by happenstance only, and as soon
as I find some time to rebuild PCREv2 with JIT support, it will stop doing
the right thing.

Which might happen very soon.

Quite honestly, I'd rather introduce a prerequisite here that specifically
tests whether the output of a `git grep -P` suggests that it has been fed
incorrect UTF-8, and skip the test case under that circumstance.

Ciao,
Dscho
