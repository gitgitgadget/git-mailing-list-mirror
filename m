Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320FAC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387146AbiDUTva (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiDUTv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:51:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F2E4D61B
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:48:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7B35C32044C4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:48:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Apr 2022 15:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1650570514; x=1650656914; bh=1MTLNMeavlbGYXG6ShN4RbqnAZGTlloUoks
        9tCrya9U=; b=W+nDAdPNlY1lBR7/ZbTjMH925QAnycrn9sbsCnKODqFu8ddVVDV
        nd70yNQL6Di58iNNh8eXWUXPja46EgLuD+ZUiydhfXKVoU5Ix2j792InbHtSRIy5
        rmnfK9NDqLrqr33dQ0joHdlmCtttxsTvuMt5LSHVNeSaxN9kJBnN9QfTyfNrA/n9
        n6D2DxBv/XWbnSypkDNAx26CW7HgKKgcJ+eh0dgDPWfkY/cRn/33rpG4/v06vTQq
        1fU03BD+yEn96iTTTuRwtOUlLmE0anSLcU++rsqd56QLX2sLkI6moqheM66jWnAb
        1mQ4pSncyXqvtopFZrrLh9VT6nKXHbM16fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650570514; x=1650656914; bh=1MTLNMeavlbGY
        XG6ShN4RbqnAZGTlloUoks9tCrya9U=; b=G9lfaOKTROLD8ESmdRd35otTLaQ+K
        Z5Azs8iXSDEEkUOhlERmSz0zTbtcVRKZ8tpZp1GDPYjs0dODOuM9MxUJbTXlCCei
        CHZ4kgQa9TiaUL5gjc6GKDgwki16iNxjt1zdNlNdKmgPaakd3ZIJQKmiMlSrWfZ1
        A8obRg6mJxFO8VKDtckQiGsKjt2NvutbNmpn9tnrSGFSiNffpwWQ9i66WwdP2oZD
        gzjgd6FIsrvK5CaGEkx9z9h7sBUDbsDR+CzRTd2Ynw3jFCrt7WfIfoHlkVQFS9RV
        WIDROnvjl9N5f0Z7ACOMLaKFhc0hFmn0av323HzsQjeK9i6ujxkxhUebQ==
X-ME-Sender: <xms:ErVhYmytx0AicxIBujnGvI-t5ndSHkxPSp_zneukoIEw1s17lef5Dw>
    <xme:ErVhYiT7WcraIauQ4f58JZ8v1_TeQO1RZw33qAJxJru0EaI9oYiC6eHkFLakz-TDi
    IaMNmsOS1bi1Mr7ng>
X-ME-Received: <xmr:ErVhYoWegrQjM0TNyxS4fM2Y4bHJXpGBQiJT3pGnyCyYcz_mDi8ZaPtdAmOngmMvMNLG4wQKERku9vjJW4lg60xLSoXjaxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddvgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheq
    necuggftrfgrthhtvghrnhepueeghfdvteeifeekhfekgfehkedvgfegudehtedttdelvd
    dvjeetffelffeigfdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepqhihlhhishhssegvvhgvrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:ErVhYshoiPOYMMvNQusuwmfg8KspUKY-sQrSbYhHjRG-ZclQdu7BuA>
    <xmx:ErVhYoAR3IPD_Int1QyNJqo23wBeS7KL6k4kl0qCfdMcmrnu9zK8hA>
    <xmx:ErVhYtIPU3__y5YPeP4hFK-KO1ZWKD8V7UXQvCzekojPkPkfaO_LNQ>
    <xmx:ErVhYn_ujBA43BkTmADh2G-KDx8lIWankkXCI8DwI7KFBfQLuQTkAA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 Apr 2022 15:48:34 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 991E12D6; Thu, 21 Apr 2022 19:48:32 +0000 (UTC)
Date:   Thu, 21 Apr 2022 19:48:32 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     git@vger.kernel.org
Subject: Should sendemail.confirm default to always?
Message-ID: <20220421194832.lshqkl3bogy2f2hy@eve>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5qzbac7exiffyexi"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5qzbac7exiffyexi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was recently having a conversation with some people used to the
GitHub-style Pull Request workflow, who told me that they feel scared of
using git send-email in case they make a mistake and e.g. get the
recipients wrong, since they can't correct it after sending.  They can
resend, but if they do that they'll feel like they're bothering some
very busy people by having sent them the same message twice (regardless
of whether those people are actually bothered by it, it's scary).

This made me remember feeling that same sense of fear when I used
git send-email the first few times.  At some point I discovered that I
could set sendemail.confirm to always, and then git would always prompt
me before sending a message, and I could review the recipients list,
edit the message if I wanted to, etc.  After that, I was happy, and
completely forgot that that wasn't the default behaviour until having
this conversation.

So I thought it was worth asking, might it be a good idea to change the
default, and have git always prompt before sending mail unless it's told
otherwise?  Expert users will be able to figure out how to change this
default if they don't like it, but novice users won't have bad first
experiences where they accidentally send out an email before they were
ready any more.

I don't think this change would cause too much hassle for people
expecting the current default, because the current default is for git to
prompt *sometimes*.  So anybody who doesn't like being prompted is
likely to have already disabled it.

These git users (who are probably in the majority!) are used to having
edit and delete buttons, so for them the idea of having to get things
right the first time is scary enough with a preview, let alone without
one.  I hope you can empathize.

Thanks!

Alyssa Ross

--5qzbac7exiffyexi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmJhtQcACgkQ+dvtSFmy
ccBBNQ/+IuCmX3CXz/g0NvEGY1OrDEMb6QZ1i0Bhtm0CVGTPEM789AVjA86qSNFD
tt88sgLE25Z8ydn/G9kwpyzE7DMtoxPoSpRRHew6f1Q06eMU3xZRWoi8iZ/Z4HrA
i2sXytyrBS/4h12xQ1aiFlrAIwrpyIC3ENDnal9R/+xx1EjlJwmb7tVtBTAZcIUa
2hh1VVYCXnIpH0U3gMaGld1yorgv0hkvOTXtrBOhERTx93Ujn7bJAY3+UIF7SoKA
oTYmAePI4ribGsJijhdf57y+d/TAQZ1hZscBCt5Eta3tTjrVOlHH8lNO7C/91rbF
idqkxS3Q444WbSw2LGgEd6bu8173cH98Xro3h3sv6QO3kirmOnc/aavWmnEjeUTG
hhGOQD7tPq+3nnkkRCaHMFFHDUofnepgSL4JfsKK2kS8/C71RxrFueqZ86D1eW3p
azVw68SUMiCUesOG9LNNl9/6DKIXxlcTmEy+5VpVTPzQHFJY+65ztRIPXsc57BVJ
GFBHrEQAL1iRmWRuitPhQcdtpnb8Eytz+1cAFFK9F13QQZaH8q5sp9ZOhbBKfrXg
pDbUnqWVn4Ri8UjMEeO4dScqjQ2YydAQtyxyxK6OlaJVxkLHK4/Xz3EFVEJBD+l6
s3ka71KU2WIQdGSNs4OXQzynOd5YYoOhcIKsdW0+RLz+vmBtv4g=
=XG5+
-----END PGP SIGNATURE-----

--5qzbac7exiffyexi--
