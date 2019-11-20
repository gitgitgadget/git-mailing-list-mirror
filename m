Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC25C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDA42240D
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 03:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiprknbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfKTDtd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:49:33 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:36049 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfKTDtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 22:49:33 -0500
Received: by mail-vk1-f173.google.com with SMTP id d10so5684741vke.3
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 19:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+dYXT/qDD3EAcEeBmj7MDZ+sjQhrqHbGFmklxorXAII=;
        b=oiprknbErBMV8cJa0OIvzp4usGxn4naJMPVtmj7o52isKDvSkce00HbrJCgunWcL16
         C63uWU/Gblx+SrJRisn3XIsEJUhawG+OrEqLrTfcuLOz7vsMHqJD1EYGmMWkulzYyYMB
         VjJnQSLlBc7MwOR+XU4guDf9u3T6NjHShZxcQlDhKrErzrr9wMRxcDY0cYLn7B7sKh5l
         XKbGEqDpeAe3KlVToPREAl/I+UwMzynffmG0xonOj6rjdvlzTO/K+OKKiorRBy4ZoyNR
         gIERaPC/+TlmXX1Aq9560LbnG2Aw1Ss/0BpkZOtIT3GNhAi2N4WJEdl7tZYKRf+T9X3i
         Oksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=+dYXT/qDD3EAcEeBmj7MDZ+sjQhrqHbGFmklxorXAII=;
        b=AjqQhO/5KtL0P4/RTx+8yzy/xUKpg5xjg9AoBS99y7GXpLsv47tfUUMLJtu9CUBjJ7
         ylMoYxOKl+vI9DGBlpBWCCDrakQx/AVqaf3sV7DOgy/Kny+8j/8C8ipkAzRILTjwwxWe
         Rv7Godp4YNJRocv9fL0YFvEd+xA7WsGk6cSbL/Ipel71ofifcULJ2E9C7lrpUOX4HGrR
         +zJ5qkSFNzaew2bE9vIYxiOajnoaWAR3aswzJAf3u469eOHLt6FKxRpKvSLRDRGWvpds
         9mTyTgBSD0sOsppZ3Mg0Uu52u9wrn2GUSTHYc/DjzInBqUtMhmJo2zHRljAUk+21+bqZ
         GSGA==
X-Gm-Message-State: APjAAAXzUm+bannMk8LCnjwh8KQTwq5IhRMk5JxtPwwDb+62JnheRFpS
        3X3bdSCh7Rp3FKREi3FxqZe2odBSDfAYpaMDjyzYbUWtIfs=
X-Google-Smtp-Source: APXvYqw/uiAK3brzfQGp16hpgnc1EhFycWwtLVYeipb9EJtLWI3V/5guxjB0/kgoKY82HXcnDH1+rWsxfOmoWhz1ZEE=
X-Received: by 2002:a1f:a20e:: with SMTP id l14mr237890vke.14.1574221769974;
 Tue, 19 Nov 2019 19:49:29 -0800 (PST)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 19 Nov 2019 19:49:17 -0800
Message-ID: <CAFQ2z_OMr4J-gF1HXXkSQFheiDkf+7WBbn-oLYeDydmuLSfN1w@mail.gmail.com>
Subject: 
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey folks,

I spent the last few weeks cobbling together an implementation of the
reftable format in C and in Go. I thought this would be cool to add to
git-core, but I doubt whether I will have enough time to see such an
effort through. Maybe some of you would want to try integrating it
into the Git-core code base?  Example code is here:

  https://github.com/google/reftable/blob/master/c/api.h#L153

cheers!
--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
