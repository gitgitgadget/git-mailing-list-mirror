Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3B0C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 21:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiD0VMZ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 27 Apr 2022 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiD0VMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 17:12:23 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325CF94
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 14:09:11 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23RL99vH058164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 27 Apr 2022 17:09:09 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Phillip Wood'" <phillip.wood123@gmail.com>,
        <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        <philipoakley@iee.email>, <me@ttaylorr.com>, <guy.j@maurel.de>,
        <szeder.dev@gmail.com>, <johannes.Schindelin@gmx.de>,
        <derrickstolee@github.com>
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com> <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <fcd26e80-daee-2d66-cbdc-b004c478357d@gmail.com> <CAPUEspiHWTTAvNyqqLzcC854UccH=bkPLPBzPaPfzFKn_yt4aA@mail.gmail.com> <b0a80f47-f441-fc6e-3695-58ea83dea2b8@gmail.com> <xmqqzgk6l5ly.fsf@gitster.g> <CAPUEsph9tUkm+JsvU6z0Wt7mtRcTCH1vbvYTEdWjNyXzdoU=vw@mail.gmail.com>
In-Reply-To: <CAPUEsph9tUkm+JsvU6z0Wt7mtRcTCH1vbvYTEdWjNyXzdoU=vw@mail.gmail.com>
Subject: RE: [PATCH] git-compat-util: avoid failing dir ownership checks if running privileged
Date:   Wed, 27 Apr 2022 17:09:05 -0400
Organization: Nexbridge Inc.
Message-ID: <00d301d85a7b$0af698c0$20e3ca40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKW87AjxA2cdMBJpUJ6sUXK7KFdYwFanWTqAZPhW0MB3pyBzQLn7ooMAS1FncEAxRXxKAKaUsKwqyT/RLA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 27, 2022 5:00 PM, Carlo Arenas wrote:
>On Wed, Apr 27, 2022 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> The "sudo sh to get a shell, chdir to /var/tmp/foo to do something"
>> use case does care---it needs to make sure that whereever it goes is
>> not part of a hostile repository.  So "if SUDO_UID is there, anything
>> goes" is not a good protection for such a use case.
>
>FWIW that was never part of the proposal, indeed making git aware of SUDO_ID
>when it is running as only as root was part of the design to avoid other users
>probably allowing repositories they don't control by having an evil SUDO_ID.
>
>as per the root user, I was expecting that he could be trusted more and that
>wouldn't accidentally get an evil SUDO_ID on their session because it is something
>that gets generated from their original account and they should be aware of it and
>even might need to tweak it
>(ex: by un setting it if it gets in the way).
<snip>

For perspective, the root user is specifically only trusted so far my community. Mucking about with repositories is frowned upon except for special system configuration repositories (ones for /etc, ssl certs, for example, and they have to sign those). Commit signing is being deployed to detect and as much practical prevent root (or any other user, elevated or not) from inappropriate repo history operations.

Just sharing a different POV.
--Randall

