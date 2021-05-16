Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C0DC433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9907610F7
	for <git@archiver.kernel.org>; Sun, 16 May 2021 12:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhEPMtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 08:49:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53319 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229888AbhEPMtX (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 May 2021 08:49:23 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 572375C0235;
        Sun, 16 May 2021 08:48:08 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute7.internal (MEProxy); Sun, 16 May 2021 08:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hockersten.se;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type:content-transfer-encoding; s=fm3; bh=Lhfd9
        2kqowt4SmBqEkXmv+HL1XULzR8VQ+GhxLY+bhk=; b=Y4WyxX0m4q4/SkHiq0sPU
        /xgP1FS5pAimYVsMG6pVBA80OGlhq+8urU303v7jU96odN+8wojkPiSVR+NlM7L3
        iwlZMe9hT34Kj47y+39HcXqmQqDLyIY3PLo23t7eAf/659n/2v3D94OeYrF70hoz
        HFFtXA9WQ3Rj+YzaywjnEcV1hSawJVLfjcwsZwihJXcPCiQcKASoy/fV67F4KxlM
        plfWxxVOXxG+UKJylufB81N77IU42pulR5Wu99JonlWlLwbdhRJec9SPwylKh9pD
        WeqxklQsfHbTMFNdfEdYPLMp7dNRrsqVXw7ISVbbxtUxCYi6FVdIOG1gGaNcRNU4
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Lhfd92kqowt4SmBqEkXmv+HL1XULzR8VQ+GhxLY+b
        hk=; b=QAYFUjHDPTZI+pN4KXSroBegho+kh8Q0/yd2P8akzEyAQazKIZ2XeupUQ
        Lo+IleL/+6FTfWy9s4Ij6ckznW6V5jVoNXbZJWsZ28Zf+uCRHhSFs5i+ixgg98dH
        eP1ygpHtVbJ1f79LuJqIW9+X5PiJqaUn4MDnztWcAHmHiRJBEFkrqKGiw2v0ai/w
        HBeOrT8WIGk1gpQ3sn48oGslVQzj0bcIuru3oGLlidszBqNFCX/+DzWBu8fdKBMW
        8ex7xlrVvgSnA6XmxmV5QoPEp1Meufx9ARr86z28Mz/8sHS1dTXd24hrtsrsrlsW
        ydhsRhSqRChLmDuWHkFpwwiovKNVg==
X-ME-Sender: <xms:hxShYAAvUlhZK4CDeB1wCgqWbxtndD9iAk0488RbvbHhdIK0vDpeVA>
    <xme:hxShYCgfLg2G7nnRBZmqEqXeebNFdoagOLh-MJTbxgt3s7H1ltv3Wm3fBILHYQXrA
    D4kqLwEU5hvqTlkDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeifedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpeetnhgu
    vghrshgpjfpntghkvghrshhtvghnuceorghnuggvrhhssehhohgtkhgvrhhsthgvnhdrsh
    gvqeenucggtffrrghtthgvrhhnpeevvdetgffhudejgeejiedvuddvkeetfefggeehteeg
    uddugefhffetiedttddtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhguvghrsheshhhotghkvghrshhtvghnrdhsvg
X-ME-Proxy: <xmx:hxShYDmM4WxYt3Xs9uEUir-R5zEa4giH3DfysR4utl2efXWQ25-rdg>
    <xmx:hxShYGxWc_fxp_-WGIUrxovMScVj5WInuagjRIs0zNTLr2i7K-RPeQ>
    <xmx:hxShYFSYlIu1z0x-TxNZlII8myoBC0unZJIAeLKWRsraPLgzoX8CVQ>
    <xmx:iBShYG6XtPIMrpCqoSxcvOxrTX37_RXwBLJ6EOlKdNnzc1oXXly4hA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD76015A005F; Sun, 16 May 2021 08:48:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <8cad4c4b-a923-43f2-9bb7-6ce418cfb0fc@www.fastmail.com>
In-Reply-To: <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com>
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
 <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com>
Date:   Sun, 16 May 2021 14:47:49 +0200
From:   =?UTF-8?Q?Anders_H=C3=B6ckersten?= <anders@hockersten.se>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        =?UTF-8?Q?Anders_H=C3=B6ckersten_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Sun, May 16, 2021, at 14:00, Bagas Sanjaya wrote:
> On 16/05/21 14.32, Anders H=C3=B6ckersten via GitGitGadget wrote:
>   >   --abbrev=3D<n>::
> > -	Instead of using the default 7 hexadecimal digits as the
> > -	abbreviated object name, use <n> digits, or as many digits
> > -	as needed to form a unique object name.  An <n> of 0
> > -	will suppress long format, only showing the closest tag.
> > +	Instead of using the default number of hexadecimal digits (which
> > +	will vary according to the size of the repository with a default o=
f
> > +	7) of the abbreviated object name, use <n> digits, or as many digi=
ts
> > +	as needed to form a unique object name.  An <n> of 0 will suppress=

> > +	long format, only showing the closest tag.
> >  =20
>=20
> I think the more correct is the abbreviated hash length is determined
> by number of objects.

I agree. I will modify this to:  "(which will vary according to the numb=
er of objects in the repository with a default of 7)" unless you have a =
different suggestion.

> >   --candidates=3D<n>::
> >   	Instead of considering only the 10 most recent tags as
> > @@ -139,8 +140,11 @@ at the end.
> >  =20
> >   The number of additional commits is the number
> >   of commits which would be displayed by "git log v1.0.4..parent".
> > -The hash suffix is "-g" + unambiguous abbreviation for the tip comm=
it
> > -of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
> > +The hash suffix is "-g" + an unambigous abbreviation for the tip co=
mmit
> > +of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). T=
he
> > +length of the abbreviation scales as the repository grows, using th=
e
> > +approximate number of objects in the repository and a bit of math
> > +around the birthday paradox, and defaults to a minimum of 7.
>=20
> What is the birthday paradox then?
>=20
> Also, better say "... and by default the minimum length is 7.".

The explanation was mostly copied from the 2.11.0 release notes, but men=
tioning the birtday paradox is unnecessary. I suggest changing this sent=
ence to:
"The length of the abbreviation scales as the repository grows using the=
 approximate number of objects in the repository, and by default the min=
imum length is 7."

Best regards,
Anders
