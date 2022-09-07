Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730D1C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 04:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiIGEav (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 00:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIGEat (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 00:30:49 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8067A832DC
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 21:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662525041;
        bh=CkEw3iyQXOi6lcnFcWS7ctZ27E4uPy1hbvTk2MsL9zM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Efvz7yOLx4sUaieuzsWiUXtlt6lW+bBdgbzDIY3RXryN5FZBE46b/6oIYKzThnSFY
         8zJGLPyuZNceTn1/cgll2+tYQPWkqdbe9OV3OE59OApu2FXzNBBCick+DlL//lGvk/
         Y/nMLOwzI/rXY/9h1NuDSp9Z9V/VvDLbFAPBt+tY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1pXXbK15ip-011Ja0; Wed, 07
 Sep 2022 06:30:41 +0200
Date:   Wed, 7 Sep 2022 06:30:40 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alexander.s.m@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 1/2] diff.c: When appropriate, use utf8_strwidth(),
 part1
Message-ID: <20220907043040.idqqivi3jt35jyst@tb-raspi4>
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220903053931.15611-1-tboegi@web.de>
 <xmqqv8q1zgzi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqv8q1zgzi.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:CVxQs9KJu4N14mtB/OMxw8GT1MAdoXvV/lqoLZtUuWzfouDqNyw
 RBErOJ/CIXbEl0Nx5vSR9mxR40b3tphk9ZcLbzfmRaOERzRn4x6a0biImmbbibsC0Ba4SY5
 eVjON4yKcA1LnGXieV67T9pu0vtTgMz5XZrgDdc4cn+GMhH9sIiN12bYQIJ/x1SFiqqSCsN
 abkplf51EIetv9tazIkYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iYLhgPcWC/s=:ErXgqrTSC8UGElN3fEPCpk
 3mAkw3jsyW+1f9Zt5fRPyVqmayybie4DQnv5FBy+HafS/5KCZblvI3iXQmppoksMSYumQ9+8G
 +FERgQnqST0ckTGv5272YrX0ttrlCOwlHGanFUd2I+bNKFbvevb/gGN/AlrFe1K059zjRziAS
 F1hOCOO9UwSwovufQgGwkyDg10yTypDF8aZYqE/T9cghwPcduMBQVf/i6DvBNSt0Dkitu3PDa
 Is7W7g/oQmWWzCYES6g6R/vOSS2hLrTG+jhrhGe71aQ8qNYUY7o/E77SXDr9N+iGiLWQ7AuCr
 H9H57Z+jwfGt6BhFnstfxoyQtQYHxQ/uWG10EMmtrk1OQCGTKxmKDFYzYh+GmjU3UHEiJHqEx
 Y1CaOyc+DACORLv275auRbzgKjj2bVydwl7woTpxCcDJAfq3ZZ5WS8Cw+0SudWkRsgtCq/XjG
 2UiiY1iQK2tckHxiZHi+T8xDjElMs6mzHynyj4+c1uzn9yISWfvaSTc2W5OcR8SW6NvRHmZAM
 PbJ21A/tMQlTxQQ/ah6mPL7fsiT6IV3tWVLQkY0sR4+kdyBCqSTGPrmZ5xnYrZCYl3P4cF+G9
 Sm8ZOxFFlSv/4QMWweqRhiapamqsohh+tcNocqwwxgaZtK59HCPtT9nJdi2/et3nMkF2IwnbO
 1/Y8cDpd66auX5YXrRA3mPoSEvMVF112eEK1S3aQH2oTIohhsZZB83PICwarmJw1ZAaecN4kr
 16Sc/1fNut5mZEzZf4hmX2iFmTPNuRLDv13yo/D+UKz6N302CS19rHzc3mMpP5WhIccILpVIr
 9a5sF4voWwzag6z+fU5z9g1Y7dt/FYDklr0DWHk5YLANbtcGEvscF0qv5aqEsaONAc/rusCx0
 qfx45P0iH2S+TMk/jX7i8pNv0cD99yAO8O1ltmlCZWigGL/Q93P7B9u0GkfOYZpo4HzJqHrzG
 u6PGsxV4IEJ7MUUJIbm3d1CnT1VL8V6sGOBiRWZDZ2dCmxvjG4OVY9px3D4EvqroHN+RZPrhm
 aLGJPTHyqiyKbEwQJXcQMPjaDpG1VifaAGNhHY2BLPG76LtIASyJBkvdRK8/4rVDjxoAd8JNw
 ecT6XDJZQCZzCiFpCnFnxhfoD+hc9iZQSCrPtoaapMXjpvQez/5I2QOpwdUYTc1wUQjgJsZva
 yBLs0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2022 at 01:46:57PM -0700, Junio C Hamano wrote:
> tboegi@web.de writes:
>
> > From: Torsten B=F6gershausen <tboegi@web.de>
> > Subject: Re: [PATCH v4 1/2] diff.c: When appropriate, use utf8_strwidt=
h(), part1
>
> Given 2/2 does not share a similar title, "part1" sounds somewhat
> strange.  In any case, 'when appropriate,' is probalby best unsaid,
> as it is almost a given.  We won't deliberately use something that
> is not appropriate on purpose anyway.  Even if we =3Dwere to keep that
> word, downcase "When".

Yes, agreed. In short: I will make a new patch the next weeks,
in one commit (again). (That can take some days or weeks)

Thanks to Dscho for his patience with the strbuf() improvements.
I think that I tried a "%*s" version, but couldn't get that to work.

> > Side note 2:
> > Junio C Hamano suspects that there is probably more work to be done,
> > in a separate commit:
> > Code in diff.c::pprint_rename() that "abbreviates" overly long pathnam=
es
> > and "transforms" renames lines like
> > "a/b/c -> a/B/c" into the shorter
> > "a/{b->B}/c" form, and IIRC this is all byte based.
>
> I already said that I suspect {b->B} conversion is OK, so the side
> note is probably more noise than being useful.

OK - the comment can be removed.

I didn't know how to read this comment:
>...but the former may chomp a single multi-byte letter in the middle,
> which would need to be corrected as a part of this change.

After diffing into the code some more times, I think that we don't
chomp a single byte out of an UTF-8 sequence.
