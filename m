Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF789C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 07:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A506F2064E
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 07:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIPHZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 03:25:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47221 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPHZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 03:25:38 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlNYj-1klgUL44Rp-00loLx; Wed, 16 Sep 2020 09:25:24 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 1C3121E01E7;
        Wed, 16 Sep 2020 07:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZfoYbq0PAuTJ; Wed, 16 Sep 2020 09:25:23 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id C236B1E01E6;
        Wed, 16 Sep 2020 09:25:23 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 5CA5F8051F; Wed, 16 Sep 2020 09:25:23 +0200 (CEST)
Date:   Wed, 16 Sep 2020 09:25:23 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Pass --ipv4 and --ipv6 options to sub-fetches when
 fetching multiple remotes and submodules
Message-ID: <20200916072523.GA15595@pflmari>
References: <20200915115407.GA31786@pflmari>
 <xmqqeen2zqk0.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeen2zqk0.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:1UmsFi9WhEL+hgjjNrb6AtdfGEi2UDjCJ0cEox9MRkMMJ2CTtyh
 wWrQkIATNYDuTOJw+OH0cL5i1jODM/HPsb5zjkcWWxmrwkFb8xKN9H9hlTR8/fHmGNGmGEU
 GxjFWEkAbxLyjbmR2ojhjhl3PDhbGin5uMO8UZiQUNnw6S64HHXRM5W7Z+ib6jmwT72g8oF
 aNrRrFX8sNdi7YlG6kydA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f/fIUFXclWU=:13cfceTSe86rV3JynMMKp+
 zG3jOOGdccBL2SBGjJuKMhVUqQVyDzf1T3PExxXRbjU2v0z3lbghJHK0/ur6bUiwD3GoPArxo
 BOXCIKc69I5UtKP4KWq1lUfaQyCERuVd1SgIir0GkWrBRHpgY/2xfZIP3VU7tsxgf47YLE0Of
 Sn4KcTF38BVwe6m2JVoSBNbBmhYWyLE8tDpM1mLiTSaoMzZHeuVc8CCWertjnU0BhZhqdlKIE
 Wdbdb/GNNkWtYLs1WAtetlBJI1/a42jDX5+R2KB/xn5GGt8YDh+s3ZY9IAmZm/6wFghTbBdTP
 hAPsf3BN5QvBVdlF1XLu766YQEBHRTCmG6W7LmgO5b9nwQwqxfmIIMDrI6Vn35WhzITSNsiQ4
 CBXWezVvhqr/OQ4wdDYZ0p9xVGqzqG6YS5RMKymjOfTFRzWZK9QGEra1o/MSXM7imabTv7Oq/
 xcVl7ykqB1Ruu1xW82SDqSJyK9eNoSFWrjJfCKjxBSRzhz/XZh4u8Th+WVMWc2dulDqnPo8hB
 KBNcfsWGbHAf+jAqAA5PT7v7caRfaCBq21Nnv5FcRozoUIVr11yVklO3Shm3OEjQ0xNkf5Pvd
 qlz2Stt7Jf1fxSb9sMEOzZUMenfoDzLKidQ/VtRF+jJXXgc4AZQGTI82hJR3bbivMSQpLhFsD
 cwZakxhq2dwY6jgjtBABWxijCk7mcQFG0bIbExw9JVjF0roR90OMhFM+Sjp8kVPmQ+koAzadW
 UZ6QL9ylahK+DbLSfmZOkYej9jrTPA5CBngvVt5coow240L5Lm9JHfW5LZMkB92mLUHjjnfnJ
 t7ryfJ1w6ZmG8gn512VDHbhkLE7dArUO1X/5XmUH8yqgqW9sdDFYt1Hl44Ol7tIr7XEZo4k/q
 XNpO70m37v7/Ye+4y28A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Tue, Sep 15, 2020 23:19:11 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > The options indicate user intent for the whole fetch operation, and
> > ignoring them in sub-fetches is quite unexpected when, for instance,
> > it is intended to limit all of the communication to a specific transport
> > protocol for some reason.
> >
> 
> To avoid an overlong title and conform to project convention (aka
> "easier to read 'git shortlog --no-merges' output), I shortened the
> title and tweaked the text a bit to compensate for the change.

Thanks :)

