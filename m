Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F26C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3357206E2
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 03:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="s48JeCTb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZYnfflI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387712AbgCLDz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 23:55:27 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42953 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387453AbgCLDz1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Mar 2020 23:55:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 393A8221B6
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:55:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 11 Mar 2020 23:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=mesmtp; bh=DiTkng0umJXOrnl0mYRAiNH
        HIINEbFNus2Ze1Bk7/uQ=; b=s48JeCTbexvFZe6Kzdl4edIEC210wGcUST0EKZK
        h/Egw6Ivr+CJA4WYFttL8iHq7kCx8TWzN8CDq4xlAGSYE4h2EMIGSIoeGtyiqNqk
        M5CkOILq6w8WxIETY075fTuJ2FyIgsfRwxot4QIZn5/80yh9x3sJdA8w/dMkYLHA
        K+dI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DiTkng
        0umJXOrnl0mYRAiNHHIINEbFNus2Ze1Bk7/uQ=; b=VZYnfflILLJnJuwD7Lnz2E
        /K9OWqZKaPrRngm7SwwWgsO1iD8WjiNWM29sjWav1mcSyucp8rXPjobyqJzQxFDd
        6LQ6CGlgvkx1Vw6rhN1ef4HxDvSQueiHA7IGd+po1DcJXWdZtTHDQCtHHRMTK44c
        0nboR+9ZV85rf66jE3YwA5QEm4etY/GIpwMQob0VeYg3VvEbhFgN8mKe3NuzRpJ3
        R7BsJx2ZTYeZlbndXrlEqKHTte443+VkOHPUpdVOXAeNPq+KwHS1mPVIeQLTwHXD
        x0KN8Fw4gBOHoDoBbxcXASj6J6BLxMBAosNizBcw0euL9K7jsVn8rC1gdBVhZEhw
        ==
X-ME-Sender: <xms:rbJpXmtHh6gL0WVi8zRbeed4Cutsl_8wdmXICdubvk6d3SDnF3aNWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhephffvufffoffkgggtgfesthhqmhdtredtjeenucfhrhhomhepfdflrghmvghs
    ucftrghmshgrhidfuceojhgrmhgvshesjhhrrghmshgrhidrtghomhdrrghuqeenucffoh
    hmrghinhepghhoohhglhgvrdgtohhmnecukfhppeduvddurddvtddtrdeirdduuddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvsh
    esjhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:rbJpXjqb2a6Ah9rUcvzwwcST9Jz4lYBdT8r5tNQl-3O7j6xfmxFayA>
    <xmx:rbJpXtX1D-MXHGdpMeDUWbhy5CSyDk7Ny1K81Uqe6AaVwoBp8U248g>
    <xmx:rbJpXr2Pfb0hSpbizHlRMrR-Sl-FfDztraY9YXBqXdYG0jq9z5AbWQ>
    <xmx:rrJpXiGHiaxEIp-er6mdhDCYGraD9OvBKPoTqe2tEgG34uEBXJWweA>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43EF0328005E
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 23:55:24 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: Notes from Git Contributor Summit, Los Angeles (April 5, 2020)
Date:   Thu, 12 Mar 2020 14:55:21 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was great to see everyone at the Contributor Summit last week, in =

person and virtually.

Particular thanks go to Peff for facilitating, and to GitHub for =

organizing the logistics of the meeting place and food. Thank you!

On the day, the topics below were discussed:

1. Ref table (8 votes)
2. Hooks in the future (7 votes)
3. Obliterate (6 votes)
4. Sparse checkout (5 votes)
5. Partial Clone (6 votes)
6. GC strategies (6 votes)
7. Background operations/maintenance (4 votes)
8. Push performance (4 votes)
9. Obsolescence markers and evolve (4 votes)
10. Expel =E2=80=98git shell=E2=80=99? (3 votes)
11. GPL enforcement (3 votes)
12. Test harness improvements (3 votes)
13. Cross implementation test suite (3 votes)
14. Aspects of merge-ort: cool, or crimes against humanity? (2 votes)
15. Reachability checks (2 votes)
16. =E2=80=9CI want a reviewer=E2=80=9D (2 votes)
17. Security (2 votes)

Notes were taken in the linked Google Doc, but for those who=E2=80=99d ra=
ther =

read the notes here, I=E2=80=99ll also send the notes as replies to this =

message.

https://docs.google.com/document/d/15a_MPnKaEPbC92a4jhprlHvkyirDh2CtTtgOx=
NbnIbA/edit#heading=3Dh.vvhyp0oa4hhz

Regards,
James
