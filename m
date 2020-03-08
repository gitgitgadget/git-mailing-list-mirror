Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E588AC10F28
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 15:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B273020866
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 15:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8iebFO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgCHPxH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:53:07 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:34734 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgCHPxH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 11:53:07 -0400
Received: by mail-lf1-f44.google.com with SMTP id w27so5636746lfc.1
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 08:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=X48Sh6YzldZx7csV3HAXFqJTgt/tQgKm7cTUEbDbsuI=;
        b=P8iebFO3Nz6wPhuNv2J2tjMiCkwMT4MIKzzRa4fkENRNwHL0dvgOel0e+OMzGarR7S
         qgk6urC1ryO/540xZx4x6e6aFRxFGTK4F7KE6r1ZuG5q7sNOQ5VNNXZkzHTSaIAYxV92
         +YqoK0qZBfmQO4F1ZG9+peTzDVMUWAoq9Myf4W2kdN2gXGcA+Talf+dBCyBgNeYdJokU
         qJFqJf2W9WO9DXqGoTib7Lnhr6cJFV+idiBJsAZnHhw0v6wSc+iTbmIjKYewz0cxbU8T
         hj1qrCpQsgL9NqHP6ykITRyE1TXUW77KmUILlVYihRHGtw+iJSg+PkWnXMByt2GDNurq
         8U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X48Sh6YzldZx7csV3HAXFqJTgt/tQgKm7cTUEbDbsuI=;
        b=XKSowhbAaGjLAAXXMO29P38LiMRVS4ghF6wREg9i34uQ234rYZX4Y55fJhdeK1Rrw7
         +gD5sfzDlkWbyxVyYFBrbgkG3D07RJxCmN8Q2qhkrv9YPcNZA1wK5PAGSSOxEgvwJfQL
         wwdNP95UuaYrwnlrpdO+q71tBnA+nQAMzK2DerREc4oTXJH00mF+yH335RDdTkpLAQ7c
         Y4g1R3OE2sI1IHJySldbjgzke4bwmEuUY5FETy88xJsKxGCtgV0GNiuQCcTmcIal0hsr
         Q/yTK6+F3ngR6wPDffW8kC2ObDlJfBIZ5aladwr9aTWLmVQykS4j5WvD/yBikJAxTeXC
         hvOQ==
X-Gm-Message-State: ANhLgQ1zx70orf48/m0qT8k7FjNLgWAfRnALgWpQ/cUC5f2HUAgAb55O
        so0AM+tQqRxLxgSSNHFH5V73CV5QblfvJeHt4SoJU+g+psg=
X-Google-Smtp-Source: ADFU+vt+kjS/4zRBW49E8SiJLTgbJASIjv7FbBaAXxXKxw4SgQZJbQKnelxSvCkqQSOT3k7GKy4cecZPQSH5ErWm9vY=
X-Received: by 2002:ac2:5b47:: with SMTP id i7mr7118715lfp.181.1583682783843;
 Sun, 08 Mar 2020 08:53:03 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Sun, 8 Mar 2020 16:52:53 +0100
Message-ID: <CAGr--=L9nEfX1c6DnaqQHqNMh9Ci=q=dMZLE_gpgyoneBcJ_Kw@mail.gmail.com>
Subject: gui: error "missing close bracket" when doing a reset
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The last couple of times I've done a reset in git-gui
(Branch->Reset...->Yes), the repo is reset but I get an error message.
The message header says "Error: missing close-bracket". Error message
is as follows:

missing close-bracket
missing close-bracket
    while executing
"set status_bar_operation ["
    invoked from within
"if {[ask_popup $op_question] eq {yes}} {
        set fd [git_read --stderr read-tree --reset -u -v HEAD]
        fconfigure $fd -blocking 0 -translation binary
        ..."
    (procedure "merge::reset_hard" line 28)
    invoked from within
"merge::reset_hard"
    invoked from within
".#mbar.#mbar#branch invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .#mbar.#mbar#branch 1"
    (command bound to event)

(end of error message)

Does anyone else experience the same issue?

Best regards,
Birger
