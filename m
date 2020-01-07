Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC2C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3C3208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OoNzqKcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgAGRxI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:53:08 -0500
Received: from mail4.protonmail.ch ([185.70.40.27]:39646 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGRxH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 12:53:07 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 12:53:06 EST
Date:   Tue, 07 Jan 2020 17:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578419091;
        bh=28wYTs3gSEyDKbI3cPX8mnJDJ7tbccB2n26D2Aw7hd4=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=OoNzqKcdmbnnQhYDsJLrrHRJYfcg4AAeXUCL4fz85zMojs1FB4AzkkXA2OGyVowPl
         bae7OioEGjAdUetSTT68TA7ByLj36ADdBb4y8YnjffRyjPsPh7HaB8XOdibPQzAZir
         gnoXrVYdD/+Upqhy5zsT8VFLoMvdnd2wcRi2cHms=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Andre Loconte <andre.loconte@protonmail.com>
Reply-To: Andre Loconte <andre.loconte@protonmail.com>
Subject: Git bundle create produces inconsistent bundle
Message-ID: <QBxpUR_NauPk0G8X2KKsqzlrfyxNuA4OoNR3Dm1KpHMNEELiSUxKr_IDM_qghObDt4aVv-bjg1ZQtCYRgxArdGsK52wCuO1LbsqzlHBto-k=@protonmail.com>
Feedback-ID: ZsGzMiUXru0GkiKDCvY1IgcSYEKmivChv-eqew0uRa_PeoNRSpe0OxK1bEBvV3oiRtt2JivVVESHjNfXNDr1Qg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am running into an issue where "git bundle create" doesn't always produce=
 the same bundle, provided the exact same arguments and the exact same repo=
.

Where it gets tricky is that:

- I cannot reproduce the issue with random repos from Github (tried with ~1=
0 repos and 30 bundles per repo);
- I cannot reproduce the issue with the same OS and git version on differen=
t hardware ;
- I can reproduce the issue on colleagues' workstation (environment is iden=
tical down to the hardware, see below).

Environment:

- GNU/Linux 5.3.0-24-generic Ubuntu 19.10 x86_64 ;
- git version 2.20.1 ;
- Intel Xeon Silver 4114 CPU @ 2.20GHz =C3=97 20 ;
- 4 =C3=97 Hynix HMA81GR7CJR8N-VK 8GB DDR4-2666 ECC.

I have put together a bash PoC [1]. And there are some example output in th=
e comments (consistent [2], inconsistent [3]).

[1] https://gist.github.com/alct/05cc9a2b4657d51669c96cb22cd5c4a6
[2] https://gist.github.com/alct/05cc9a2b4657d51669c96cb22cd5c4a6#gistcomme=
nt-3130206
[3] https://gist.github.com/alct/05cc9a2b4657d51669c96cb22cd5c4a6#gistcomme=
nt-3130213

I cannot share the affected repos but I can run any diagnostic tool against=
 them.

Would you have any clue on what could produce such behavior?

Best,

A.L.




