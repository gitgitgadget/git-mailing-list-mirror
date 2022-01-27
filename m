Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F939C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 08:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbiA0IVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 03:21:14 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58265 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237689AbiA0IVL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Jan 2022 03:21:11 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C091D32023C4;
        Thu, 27 Jan 2022 03:21:10 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Thu, 27 Jan 2022 03:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=Cz2jYVNrOaKhL/
        RpQ3L9dCiNHZa7n66HYxcMee7dI0c=; b=oS9RS4uCRrfA1ZK4YJ+x4B0ybr+MoR
        5QGhZ/wenb5aE86Q9NUlM4tfhgVpNgL9CSK8TMOjgebo8ONSqp+c6iY/BHkkHmTj
        L1Y+/CXQe3ittMEDqzXkJCSluxg/Fi7tXKlektUWW0oVwgBHygrlQ99joNBkcGua
        KHsEYHGaYCl6Ibci5RzwDX8Dxp0VHovUrYKE1wfcyNcNvBDIEL1D5E4XFphnLt4L
        g0vUB9hK4psSqz4Dk9qX3HyAsK3iQzHiHstiyJao0MZm00t61THRGy78CowBlCbd
        7J543xvESEYSHGohHat2254AzKy2h16QJk18ofvz2NMdD3UlILXUZwGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Cz2jYVNrOaKhL/RpQ3L9dCiNHZa7n66HYxcMee7dI
        0c=; b=h7+/ozKSH56Kxu8iSvXksxOm4CM5MU4oUKHurVoW6mdhCPOFYaoEOajye
        Dj6WkUODGCHSUvRYTCT7dnOemH6jE8yIXknpVBiuZqB1S2xCoI11oiNoqnYTxiYL
        Zx2Cd5c7Tm6UecsZl5ktsj+GhJLFAd7AC3QMr3xn2DrJVkIlLrTn3NVdb3XI5t5w
        KRhE2PNXHondydnxETupO090isdGjZCV/VFgnxCOepSCclulzIup89AYwBuedM9m
        3elX1z5VmsXqxROI7C6TJ4NWTLPcHMXkJ1c3bGvuPyw+aNkJ3T57RtMhaWDYz8n7
        cPVwej6PggD8OdYk2ez+UF3lhSWNA==
X-ME-Sender: <xms:9VXyYUeOGIrwxt40EoDMcFaAp8uBuVc5aq2IuwfphBXGOOoZLuwgAA>
    <xme:9VXyYWN6st9wvXZ31vGn3uQQ8W7KtRs3XwwqTuEJbPnOX1vUvxksa-MaTl0ab7Rti
    FRH1A_-27vTmc7EDJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrfedvgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfirhgvghcujfhurhhrvghllhdfuceoghhrvghgsehh
    uhhrrhgvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeelhffftefhteeffeektdeiff
    eghefguedujeffffefveelveekueefvddvffdtheenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:9lXyYVhmlz3G2tvubyNGjORvCJOPMAFyeP9cDmuiTiS5_Y-d1Z6E6Q>
    <xmx:9lXyYZ8PbS162CY8WzMVGSImngSwCbn2WvG18N5K4OAAS9NeaXHJ8g>
    <xmx:9lXyYQtFUNhyfucQ0HzEL5h-uy_9jJFRbAt1LR7LxomPWdxeKMdCrA>
    <xmx:9lXyYW32GZRtz3mr3t2rdcwbaPtXKTWEQpoXS8D6Rk9DQg6kUwvpVw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EAF351EE007D; Thu, 27 Jan 2022 03:21:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4585-ga9d9773056-fm-20220113.001-ga9d97730
Mime-Version: 1.0
Message-Id: <4216fdca-cf73-4bf6-b911-90c6c7ba0e2d@beta.fastmail.com>
In-Reply-To: <xmqq5yq56hbu.fsf@gitster.g>
References: <220125.861r0vhh8r.gmgdl@evledraar.gmail.com>
 <20220126121426.53799-1-greg@hurrell.net>
 <20220126121426.53799-2-greg@hurrell.net> <xmqq5yq56hbu.fsf@gitster.g>
Date:   Thu, 27 Jan 2022 09:20:40 +0100
From:   "Greg Hurrell" <greg@hurrell.net>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git Mailing List" <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/config/pgp.txt: replace stray <TAB> character
 with <SPC>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022, at 3:30 AM, Junio C Hamano wrote:
> Greg Hurrell <greg@hurrell.net> writes:
>=20
> > Specifically, replace the tab between "the" and "first" with a space.
>=20
> Good eyes.  Does it have ANY practical downside to leave it unfixed?
>=20
> In other words, how did you spot it (e.g. "asciidoctor passes tab as-is
> and screwed up an alignment of the text, which was how I noticed it")?

The nearby fix (the apostrophe) in the other commit was what had me
looking at this file in the first place. But my editor (Neovim)
made the mid-line tab visually obvious, so I figured may as well clean
it up along the way; on my screen it looked something like this:

    =E2=96=B7=E2=94=85=E2=94=85=E2=94=85signature is requested. On succe=
ssful exit a valid ssh public key is
    =E2=96=B7=E2=94=85=E2=94=85=E2=94=85expected in the=E2=96=B7=E2=94=85=
=E2=94=85=E2=94=85first line of its output. To automatically use the fir=
st
    =E2=96=B7=E2=94=85=E2=94=85=E2=94=85available key from your ssh-agen=
t set this to "ssh-add -L".

Vim's "listchars" setting is responsible for making tabs visible like th=
at:

    :set listchars=3Dextends:=C2=BB,nbsp:=E2=A6=B8,precedes:=C2=AB,tab:=E2=
=96=B7=E2=8B=AF,trail:=E2=80=A2

Greg
