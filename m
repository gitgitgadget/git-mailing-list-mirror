Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 048F41F462
	for <e@80x24.org>; Thu, 30 May 2019 20:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE3Uqu (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 16:46:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:41821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfE3Uqt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 16:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559249178;
        bh=Siw79cWtpdqIra+7UI1LABoYjxdEdi93K6MRgVDAeYw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kk49fXom6K9TFP41RDk9hKx3Q7eCs7TBgwsQ8gMe0RMD4wW+1BOJE3qlkkWfxShN/
         PBHM2JAdrIfCqef6w0IleAEYTRnsisRnFP/praZbOATwrHFtP+y7Efyq0PkcAHD3li
         NBxMMHgsT0V722NMbnHeX6/OHB+YuWIyN63PbYDI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1hQRfM0UNW-00Baed; Thu, 30
 May 2019 22:46:18 +0200
Date:   Thu, 30 May 2019 22:46:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 04/16] promisor-remote: implement
 promisor_remote_get_direct()
In-Reply-To: <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905302235000.44@tvgsbejvaqbjf.bet>
References: <20190409161116.30256-1-chriscool@tuxfamily.org> <20190409161116.30256-5-chriscool@tuxfamily.org> <b4d69d2b-dc0d-fffb-2909-c54060fe9cd1@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iCQv0HwCezUG69xGQrVE5iQX/WHiVFDpF+Qqb/tW8aoahzoracv
 lPa7EN/j7lsOgfw0ThU2VsSwkbyPRi9d5wxBFWLj/NnaTRtegBL///YUIao4co3XCKdY+sy
 DAWwpjOTBd7t01ZMORekRu+0Y1mzOTUdGgqSfYVQG0+If7EBJlX+8EXyjwKosWW/oXh6Z51
 mI/8ZTZoN56mqv7LSNbtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PsSYe32T94k=:xSBATqYzblfCCWG+M9pbAT
 fTpkgkB3ozo4IFaRgB/VERT1gDvS4YDHq6wZse2QpsVk2g88GmEdcgdWYtrqB9yvUCCzjGacL
 jacekpTG+4bUA/5LbsxPoNdqp5PHJqdoihEUOdPJtJJVRPfOA/+QpJXzrRsLb7ZzSouzJuWv3
 5QEW4Duuzo7g31l4a5CgEN5dLozRZQjeTfRzBshY0jt1jhgnlSWuHnfEeTpMcScjSXb+uZPnj
 eVZKTpd/2XBo9JoX/7vnGaGJNhMMZ09gWjzLLOhiURhhe8903Blcj5fOr4/OvhWkccZSHjgPu
 l8rygDUlkmqh9vURdgNVnH2c2V9QrArOMhBAL4HXESzEdI02IPdly8ow8sdcjufulhChmrxio
 kVlvT/hOMjLqVgWkZAy0ZYcbAXimh4a025GO6+jUx9Y9H5kzBgyg/B2bRw/hBuH/G10FT0aQx
 OryY0fjzEYmU5KbCVoZVB6Lope8Grt7kePFy2tPd49X30wCwex0XUPUWtMdJKocD97P2oK68p
 ci5SC1Fr6vkWJyCAJPuqiHYaQshzowaPfX+F7Z74ptWJ6Ofpw+aY9N91lnDFJBjzHD0djetU1
 5exOdKNrmVkqYq5P400Z7uJ5cWGPmntM/lcQuZvL/N4el5zZjrNe6c9D09kmx1VNM30NMfOWt
 vGiUFwEfbJ5Xgd9i0M/P806Ca7meksm8BkJvQ9sUoijM8YMKIg0pkMT1SYSRKLA/kE2R4tlmf
 t3KuMOxRccgVVTNDOGms2NR7tPawEOAcwwwDdhRrxCi8Jk3iyW0jqgCBR8CWfshSxSOIOxmE/
 F7HW4MSMDEm+AyuizEa4xycwHzzHHhRi+XFnzM0h5Ho5sMYjJCM8q/VDZG4vHSRvBmXp+QQdr
 VEIatngxCKnrHf0SvnNy4cTzJEAt7SkGXNDPCPRNXwJxAMLmj3KQs07KlKq8zd+/0RKhrgyeQ
 LbUHf0MEElLkj2JLabu5bmSaWfT/2KP0UbrcxmH0rjoJit8ed42Y9
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 30 May 2019, Derrick Stolee wrote:

> On 4/9/2019 12:11 PM, Christian Couder wrote:
> > From: Christian Couder <christian.couder@gmail.com>
> >
> > +{
> > +	int i, missing_nr =3D 0;
> > +	int *missing =3D xcalloc(oid_nr, sizeof(*missing));
> > +	struct object_id *old_oids =3D *oids;
> > +	struct object_id *new_oids;
> > +	int old_fetch_if_missing =3D fetch_if_missing;
> > +
> > +	fetch_if_missing =3D 0;
>
> This global 'fetch_if_missing' swap seems very fragile. I'm guessing you
> are using it to prevent a loop when calling oid_object_info_extended()
> below. Can you instead pass a flag to the method that disables the
> fetch_if_missing behavior?

FWIW I mentioned the very same concern here:
https://public-inbox.org/git/nycvar.QRO.7.76.6.1903272300020.41@tvgsbejvaq=
bjf.bet/

The situation is *pretty* bad by now. I see `fetch_if_missing` mentioned
25 times in `master`, and all but one are in .c files or in cache.h.

The flag is actually used only in `oid_object_info_extended()`, and that
function accepts an `unsigned flags`, so one might think that it could be
extended to accept also a `OBJECT_INFO_LOOKUP_FETCH_IF_MISSING`. But then,
there are many callers of that function, some of them also pretty low in
the food chain. For example, `oid_object_info()` (does not accept `flags`)
or `read_object()` (does not accept flags either).

So it looks as if the idea to pass this flag down the call chain entailed
a pretty serious avalanche effect.

An alternative that strikes me as inelegant, still, but nevertheless
better would be to move `fetch_if_missing` into `struct repository`.

Ciao,
Dscho
