Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F2C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 15:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiAMPRC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:17:02 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39731 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236041AbiAMPRB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 10:17:01 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F24A5C017F;
        Thu, 13 Jan 2022 10:17:01 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Thu, 13 Jan 2022 10:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=YfeFX
        YlEXVabwJZX1anz28wto0+nfbew/iepyHeP5kI=; b=BL12TnjODfwzU0sr7ZLm0
        0Dwb7QlnOj+cMcUd567l4mFtyBhH/RmwjXyPen78Mw84BoyVjAKDX4q9mWSUxlbi
        ETco7jblu4Xl9SdQJn/Om/hNjhRpHNlrVellhmqVWpFzTpmIyeBkWx0E1bVhA08K
        A5Gu+2qC2fdds+GSFTGGNU3aFepY8lQMTTUP5tGAjFSUxe8UxhMiyBsViZ1WFZt5
        6jdSD6dmM9SAUXllV/agQ4/mnJ0mFJ77zzjIkRLIhDXfcddg2Y7z9Q55vBW5D4wG
        2KaUG1JMe2c8vzK6E7uWRzsQ4Rz6jqRkjyq2VWT0B7U/tNPxVOSwywtLg3qBBeGL
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=YfeFXYlEXVabwJZX1anz28wto0+nfbew/iepyHeP5
        kI=; b=FypPY5htt0wCyxhOsZydaSwHoRsDloMMiQECkmBjLnM+hxtynarsia80r
        sAJGtFTGx+4MuOjHT1hH45JuauhbdN1cQe9/UfnwGybnYhCEY3VGUSxxZvpAtB2a
        OHQZSSEJ/MVfI9deWA/EIsIlmC1DuOkOMQa+GydN8G5GIV8VDjynm79LoeYt4tzy
        slXjFve85CWWiK9wgpuYluAFEZTISy8q+dtHy/Xm/Cjvuif5NdodsehzbIflN8n6
        DhChN+wB7616N/OFwEkMS3S1eM4FuOBQaX+IcBHmCjttho9R6t3cvx5JPw0803wH
        CEtmrve8LevMy1+GKvh40tlZJppPg==
X-ME-Sender: <xms:bULgYZGkVJsV3lN8iZ-z-JSqQT-y4zrBiqDed2hJek4i53C8jsNNqQ>
    <xme:bULgYeVzhuraZhIdWk-EG2w-zE25cMDsAU23YptcDDzPdY7DbUcxmyGAhdtmQE2FP
    ecnkxAFtjlijqnWVkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdefgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdftrghm
    khhumhgrrhcutfgrmhgrtghhrghnughrrgdfuceorhesrghrthgrghhnohhnrdgtohhmqe
    enucggtffrrghtthgvrhhnpeekveeukeeiudelkefgleetudehffekgeevffehleejgeek
    veetieetkeevvddvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:bULgYbJu2wtz5IvR0bb6MlY8oR7J-S6fiU3_Or7d7M9UvhkFmq3thA>
    <xmx:bULgYfF53d7S2zUSlwr6O0DFGn4R0Kbg0UuusTvUsPvhb13tq6tU_w>
    <xmx:bULgYfU1S4R58mWp-Jp04xf5ORgY2vR8E-np2MAdydddoMCRrA7vvw>
    <xmx:bULgYcgsaXjXniNWcloUC4gYOvj86StKJD6D-T3ZLC_6LexnrRZpgg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EDD421EE007D; Thu, 13 Jan 2022 10:17:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <925ef53d-c8b2-4ef4-acee-490900e8a3b7@www.fastmail.com>
In-Reply-To: <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
 <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
 <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
 <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
 <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
 <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
Date:   Thu, 13 Jan 2022 16:16:40 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Christian Couder" <christian.couder@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Git List" <git@vger.kernel.org>, "Miriam R." <mirucam@gmail.com>
Subject: Re: git bisect bad @
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> Am 13.01.22 um 13:28 schrieb Christian Couder:
> > I don't think it's a good idea at this point to reserve the 126 and
> > 127 error codes as there might be existing scripts relying on them
> > to mean "bad".
>=20
> Certainly possible -- people get the weirdest ideas.

My gut reaction is that this is an overly conservative point of view. Th=
ere are two factors to consider: first, bisect scripts are usually short=
 one-time throwaway scripts tailored to one project for one problem. Sec=
ond, how likely is it that these people that have a complex script with =
126/127 as the exit code, which they have been using for years to run bi=
sect on the same project for the same problem, update their version of g=
it frequently?

Again, I might be wrong, because I don't know how people use bisect. Wor=
st case, we can display a warning about this backward incompatibility in=
 the next few versions.

> The implementation language of git bisect is not immediately relevant
> here, but that the shell is used to call the user-supplied bisect run
> script is.  If we'd run it directly (without RUN_USING_SHELL) we could
> distinguish error code 126/127 from execution errors.  I assume the
> option is used to stay compatible with the old shell version of bisect.

Sorry, my misunderstanding. I thought the external command was being cal=
led from git-bisect.sh. I don't think I understand the purpose of RUN_US=
ING_SHELL (it just seems to put an "sh -c" in the beginning):

	static const char **prepare_shell_cmd(struct strvec *out, const char **=
argv)
	{
        ...
			strvec_push(out, "sh");
			strvec_push(out, "-c");

			if (!argv[1])
				strvec_push(out, argv[0]);
			else
				strvec_pushf(out, "%s \"$@\"", argv[0]);
       ...
	}

Warm regards,
Ram
