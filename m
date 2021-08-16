Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AADC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 832A463266
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhHPM3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:29:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:49293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhHPM3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 08:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629116910;
        bh=QPM/V2VYEkHfkGfwfN9Ci+SLCApZ3MRFQy7+kwBMzQ8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Io/5hCHzbj7hRL6x/ej4XLSvQXJSL7bvt9DsLY9l4WuRRrS04OdhKWooUXicRBhOn
         UFA12veWwwJ+7Jl8Us4A8P6gl1BewuRwk+s/tADnedj1pOhfCrOfd5VG1JoRqWA2S3
         RWJEgo6DpfsT2ngTFLQVOrL5EU23wxPfetXtCfW4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1mnZ210omd-00dWdo; Mon, 16
 Aug 2021 14:28:30 +0200
Date:   Mon, 16 Aug 2021 14:28:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Azeem Bande-Ali via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, David Barr <b@rr-dav.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Azeem Bande-Ali <me@azeemba.com>,
        Azeem Bande-Ali <A.BandeAli@gmail.com>
Subject: Re: [PATCH v2] help.c: help.autocorrect=prompt waits for user
 action
In-Reply-To: <xmqqmtpjubuv.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2108161427270.55@tvgsbejvaqbjf.bet>
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>        <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com> <xmqqmtpjubuv.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:26a8blskm7D3/UBedQPVrkREyl3qjmZD8IoBwe1QI5Q0dVuA2CJ
 vlyMK+2uER5WWaaFBKnEE4zV2KJoWR+PUqkhD5tWuRRZmrtWDn4LiAGFJYQQbA5q44XnsQn
 SyHnnKU1w/qeM2ZaB5uLxpmzlubQ8H5xB7yF+5f9ec4+Wx1zVUgXTpu6hqA1/6fULTAxOYN
 I7zjEWmlwXhj77kPSV44g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SmaUOMa2wqY=:J3Q+ov0I697iSUzzlwU8k4
 n2fkdanxLvUXxg1DRQBfO1KaQDV7nqJs0ewEGbGNeiCFv8Bre56c0BXLyLdGUY52Fu2W9MN0+
 INuDcLS1+Y8NHCfmAgX+6wT0iZ1iPOvSn6KjPpCQ05JY6cc3NBJkcFy2IO6GQkLIaKa8cpEkj
 4UmHVcj/8bOubAwTPoK0GiHCIiplWXMsGUbzNcQ6SL+ZGIwc4KAxJWmnRmJxpcyJL5JOWQ/6p
 AeB94T6gmBz9Ie3MlTkJkJ2m9u+2TpPYxB5Lm5Bf58hJG2uJl6n4bTy8PxfM+t84mefahkfNp
 gTd52q48G1fJ1ZHMoq1RYaoaMsi7vvh9QQD4fBn4AErnjyv6oTdigcu/sfjf/tLiMnzk1N8ce
 n1QqeLG5jz6y1zpLmlyWbH5lKh7CEVWvstjpbH1d6zFzSaMuCIU24xA6UuASp36jh4MloVmsV
 /7EXAT5JDg0iD8X7CTL13r/vAwsaxbywowTgmD/JfAFHh33VWyKViYfXUHtz/94YCZBDu85sI
 rRVPlFBl0T/eo1KS07qm7rdhD56GRi6fpjzScKQ/0e8nmsQRGAkdR8kST9x8/x/8jcMqpMePi
 dX9b9AXJ34cs5ItpZrCRQrLXx1oYFk2wXA0ytm6qCVUJcFTZ3+zhWQnXcTPD1nJ/vu3sM6Lgh
 465E3ToETKyIOFG64kedPfBtYlHShRYAAqJq72kThORkVXyq1CxKOPizl59BHNRIOtDbcErEg
 hUs9d5U5CBHECKtxgXwqaeN2KQKbnXRCGI5IQvkPuQNLpn728W/f4PylZ4JH5W2TtPH3PttFG
 pX62Moo5tUGA4GcCVQPuO5oYHXDrf7TVwKEKd0SoVWHMA5AgjYjXBPhhJZybWd/oUUXdrpByT
 77tVUbU6e5y1j1EpoUSCyegWfYN+xdaDCUJZu80XWqrfJhGKIQ6wL+3rIm4CI+jjN29Kxe3F0
 gwaUIh2JUPPzEBYvdRMIW/j2ehChEPYaJn0o+jxQ0dJcR4a568oiS0A+CHBkwlWR+y/kpxT3N
 GKjg/J0ttGY+8TEdFTem7EIijM/Reu5hePtZPTLimFMxtm4PapprnQ8NudIpRUq9895N7H11o
 57eTE4V6Yp5+PDs86J4LP/vcQanII8+hQxhc8nU9uBW3Un5UI/d+tf/KA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 14 Aug 2021, Junio C Hamano wrote:

> "Azeem Bande-Ali via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > @@ -618,7 +628,17 @@ const char *help_unknown_cmd(const char *cmd)
> >  				   _("Continuing under the assumption that "
> >  				     "you meant '%s'."),
> >  				   assumed);
> > -		else {
> > +		else if (autocorrect =3D=3D AUTOCORRECT_PROMPT) {
> > +			char* answer;
>
> Some people seem to make an asterisk stick to types like this, but
> in our codebase written in C, an asterisk sticks to the identifier
> that it makes into a pointer, i.e.
>
> 			char *answer;
>
> This is because doing so differently would confuse novices with
> constructs like this:
>
> 			int* a, b;
>
> where only 'a' is a pointer, and 'b' is not.
>
> > +			struct strbuf msg =3D STRBUF_INIT;
> > +			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"),
> > +				    assumed);
>
> I think these should be kept on a single line for readability, i.e.
>
> 			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);

It might even make sense to use the `xstrfmt()` function instead:

			char *msg =3D xstrfmt(_("Run '%s' instead? (y/N)"), assumed);
			[...]
			free(msg);

Ciao,
Dscho
