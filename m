Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08629C433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 21:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996D12084C
	for <git@archiver.kernel.org>; Tue, 26 May 2020 21:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=chello.nl header.i=@chello.nl header.b="Je+rrPuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbgEZVVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 17:21:25 -0400
Received: from smtpq4.tb.mail.iss.as9143.net ([212.54.42.167]:40954 "EHLO
        smtpq4.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403878AbgEZVVZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 May 2020 17:21:25 -0400
Received: from [212.54.42.135] (helo=smtp11.tb.mail.iss.as9143.net)
        by smtpq4.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <eaw.janssen@chello.nl>)
        id 1jdh0l-0008Hb-GK
        for git@vger.kernel.org; Tue, 26 May 2020 23:21:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=chello.nl;
         s=202002corplgsmtpnl; h=Subject:To:From:Date;
        bh=VD0+Voq03Qq1NIRdQGwLrWcR9JmSc2h+LuN344yJc1o=; b=Je+rrPuPmdFfhMW2C5xCv+gglh
        LswqMF+I7eM8D7cz0DnU0L9nC2L5gHaGaLrZkaC8YB/JYpmOEWDyZGR3uES9sAAuNdMD6bQb5lvIx
        m8NZVP98QC9LPkeqhJxysptaYdU58N/wtoquk3pZLBNXoWN6+m6Q921gAnyNUuDYGP3qholA3tLqY
        YyUPQetdlVOEjznSBZcpmn1kyvi1zjPN4VOZ+EMMrocv5hrCO1RnB171uq+CfE85jxgoLrA97mILK
        +VabaZynS7G68CTGQzNDVM5TmjtEFy7skyAmirMYEvzeDDjp+i9UmNy2Nt4otm6ExshyNZ6F2wUIA
        PnBcOj3w==;
Received: from outbound-9.tb.mail.iss.as9143.net ([212.54.41.172] helo=oxbe9)
        by smtp11.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <eaw.janssen@chello.nl>)
        id 1jdh0l-0004rV-Cs
        for git@vger.kernel.org; Tue, 26 May 2020 23:21:23 +0200
Date:   Tue, 26 May 2020 23:21:23 +0200 (CEST)
From:   Erik Janssen <eaw.janssen@chello.nl>
To:     git@vger.kernel.org
Message-ID: <1098602171.79502.1590528083387@mail.ziggo.nl>
Subject: [Feature request] Add -u option to git rm to delete untracked files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev70
X-Originating-IP: 178.85.216.109
X-Originating-Client: open-xchange-appsuite
X-Authenticated-Sender: eaw.janssen@chello.nl (via webmail)
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=fqZHmGwf c=1 sm=1 tr=0 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19 a=ra8t5kwndXoA:10 a=IkcTkHD0fZMA:10 a=sTwFKg_x9MkA:10 a=O45WepMlw8oA:10 a=gjM3TpznBNQX8KNTlyAA:9 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello All,


Would it be feasible to add a -u option to git rm to specify that I also wa=
nt a file deleted if it is not tracked by git?
Currently, git rm -f can remove files in whatever state it seems, except wh=
en it is untracked.=C2=A0
By allowing a -u option (-u: also delete untracked files) I would be sure t=
hat the file is gone while it would also make sure that it doesn't break pa=
st behaviour where people perhaps rely on git rm to leave untracked files a=
lone.


Kind regards,


Erik Janssen.
