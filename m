Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BAFC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EC82067C
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sebres.de header.i=@sebres.de header.b="gC0X5EUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgJOTSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgJOTSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:18:15 -0400
Received: from sebres.de (sebres.de [IPv6:2a03:4000:3f:185::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20114C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sebres.de;
         s=dkim; h=Message-ID:References:In-Reply-To:Cc:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CkRVBjxuJ6b/V0i61wMDG+LYvPfBsfWUFFHxPJ747N8=; b=gC0X5EUADhOMBf3olGEDC6cpqR
        2FfWJm9XbMFyxAXAUejTOl0WvM1UPsFvvz1VUgIpcpqc9KeKZ+/ZlRv1v+cw/fRBiOX1SdBVrR3qe
        6QUDw1ABQcln+6JVLVMc0lRT5nlaVDnsWvvnrZfeJve4eWMdmNFwuVCuoBfuJigaNFuwElt4qbRZV
        qMCK10N5Egp0ip3dv8hbx2BadAkr4skgnCzOrAiQDY4NVb83TbgFST3iDEkz6tu1/M+aM5rpSTJrw
        jA3y/4GHcUb8RkVyfWSM66KrTzTPmCxqMEe3Gu3Us/USUFPATzrXMWtHbRhj7I49PH2/gjGuHzN61
        9JY3ULgg==;
To:     Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: fix over-allocation of marks storage
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Oct 2020 21:17:58 +0200
From:   "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
In-Reply-To: <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
 <20201015153849.GA551964@coredump.intra.peff.net>
 <xmqqzh4nfldw.fsf@gitster.c.googlers.com>
 <xmqqv9fbfl68.fsf@gitster.c.googlers.com>
 <f3e4f7ccc36dc214201c1838acce4aff@sebres.de>
 <xmqqo8l3fibz.fsf@gitster.c.googlers.com>
Message-ID: <65f46be7283239e86bb345e94bc5dbda@sebres.de>
X-Sender: serg.brester@sebres.de
User-Agent: Webmail/1.0.3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Well, a bug-tracker had some clear benefits:

1. it has controlling and statistic mechanisms like a road-map, 
milestones etc;

2. the issues get a priority (so one is able to select bugs with high 
precedence);

3. they can be labeled or even characterized with other metrics to 
signal seriousness of the issue or
to emphasize them in order to be flashy in the road-map.

4. the issues are bound to the participating contributors (reporter, 
devs, tester, etc), so for example there are reports like "open issues
belonging to me", which could also help to organize work a bit 
("remember" them).

5. Transparency of the representation of issue or some lists is not to 
compare with a thread in a mailing list at all.

I could continue yet, but unsure the arguments will be heard or welcome 
(I know it is your work, and everyone
organizes his/her workplace how one need or want). I was just wondering 
how it could work, even for years.
In my opinion all pros of a bug-tracker are obvious for everyone once 
using them.

And an automatic export/import from/to tracker into mailing lists (to 
retain it for conservative part of
old school participants) is mostly trivial.

Thanks,
Serg.

15.10.2020 20:35, Junio C Hamano wrote:

> "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de> writes:
> 
>> May be this is a sign to introduce real issue tracker finally? :) No 
>> offence, but I was always wondering how a team is able to hold all the 
>> issue related stuff in form of a mailing list, without to experience 
>> such an "embarrassments". Especially on such large projects and 
>> communities.
> 
> I do not know if an issue-tracker would have helped, though.
