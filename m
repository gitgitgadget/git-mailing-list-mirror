Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C656C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 22:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3767239D4
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 22:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usc-edu.20150623.gappssmtp.com header.i=@usc-edu.20150623.gappssmtp.com header.b="UjHDBLQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgI0W1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 18:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgI0W1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 18:27:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657AC0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 15:27:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mm21so2498346pjb.4
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usc-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=u4LwENqI4m+ciUNFCTPK++Cjb+ACySct3XW4QWkqvtI=;
        b=UjHDBLQd+j4AkaBNPNTw776VxLQNYGTIikXvILBYPMKPfp4mJ3zQdvNZUwriofCAg+
         vF+bquG57h8MFOuwyITsns45S45mvAACgzKI8KH3CLJV90qEoGLqBgjH4lY5OOmcINs/
         F4dCj9eZ7h2/HfWELbIG14veMRLp3dFSX8275mknnKxnjeruz8mZw1AtfIWeAnXNXI3h
         1yZ9t0sUK4Kpmwtzxn7wiTu0zNM9hK75nKx888S1uh+EvHduyLvC4cqLFGGMGHKlP8zA
         GIHaWVagsFfkvmkgnnPJ6alAOgr+YNLJvc66NCyDynLESkQ9NKGXfClDn8dWSIuMuWyM
         uU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u4LwENqI4m+ciUNFCTPK++Cjb+ACySct3XW4QWkqvtI=;
        b=SYrZ/L/yT9QXMgDiq5Lrq5BNT6iZIRlS8HRfcASuMHKtqT6lQkWgWqcOIsxZyYA3OT
         G3VRc1BdQrdUN2r4Viqken6hitsmNKgTXEiv/vW0y4rE9NlS5iLNI/iC2np43QJOUG0v
         xox3yvcORxwrKu0F9ftcoXb6MXpF6BoIhaZNxAsLXeukrpLjr0A26j/0AfCZ0wuKXu8z
         3wcAGMZICm1abwgKOaGgyiVb29saoaMrRzU7SU4BxG/wA49FgUDutmsdsBwJO7hcPgxu
         El95rwAkMKOw2kLoDmJoh2tiuwfpqQgSZk0ISckvHWREGsjjhEhG4Yu2G7JceCkanYLH
         mOTA==
X-Gm-Message-State: AOAM532/yTyIaupPbHYYwxmyg4Il7XwCQBJM4aD+0cL8MLzwadTw/tib
        HURDNLqV9GYroVBzcBpk9NiJ3McD11vXo2XfjI8cEw82/4jGvA==
X-Google-Smtp-Source: ABdhPJwRuk36PM2mdWMBRY+8yXYfnoWz2pabYlAnEoD/oq0rE+8fPiEqcTWaOjAqOBlJ8z96wVwuzA/nipp7xaX0OSs=
X-Received: by 2002:a17:90a:ec06:: with SMTP id l6mr6909720pjy.66.1601245627558;
 Sun, 27 Sep 2020 15:27:07 -0700 (PDT)
MIME-Version: 1.0
From:   Hampton Moore <hamptonm@usc.edu>
Date:   Sun, 27 Sep 2020 18:26:56 -0400
Message-ID: <CAOefx6Ro6ixiccDq_xH-UsjNWTcjKy=YQfCs7b0ZQkLjSb-0zQ@mail.gmail.com>
Subject: Git remote return custom error messages
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I have a custom ssh server that is handling validating users
permissions, is there a way for me to return custom text back to the
git client that's running push and pull? When I just send an error
like "NOT A DOMAIN" through STOUT the git client displays "fatal:
protocol error: bad line length character: NOT". I looked and could
not find any obvious documentation on how I could do this, or if it
would even be possible. Does anyone have any ideas?

Thank you,
Hampton Moore
