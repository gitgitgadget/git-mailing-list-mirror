Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B64631F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbeHPF0T (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:26:19 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:39141 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPF0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:26:18 -0400
Received: by mail-it0-f73.google.com with SMTP id w196-v6so2957980itb.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=01Hts676fu1Zj43oOwnQvLBX/29oiQbFCY8Co6oep5c=;
        b=ssZkQhmHTqkURkw9sp/xgJSPa00TV9yzzUSjSRt30lvbXdtiwmdqx8WMPeLV366Qrp
         E6ExsqifGj1b6X8GoUfiUNoEIXgva+V87Esn+mTYQ4e0FbY3Ten85T8eqVL8xTkiF1Sl
         92fJr8oRpdrYZmjodPaleVuVH94rIijaY4LVAHqOsbWmOBXhe+NwpnWewFOOzWacAh63
         PqYUuH3/oPD765wA4Z+q+MsIM8B9nRBFlMm9bNynUhU9yT6vJnxwVUW3OZA6JsLLFPoF
         lEzqfp5HuMOtzjUrFne0LEan1kef+rrjs69qV63MyrlNgZA8FRLo3Pq3itkP1lznHDtQ
         chHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=01Hts676fu1Zj43oOwnQvLBX/29oiQbFCY8Co6oep5c=;
        b=eJZvI6r4IDYEtDHdY7WZH8VbY9bWR5kvgHrf4mgkrGWrrNR81jecSqDdC5fhk6neng
         x8pjKLjn80Q2nMiFFPcli+0wjuiyAk44vBIvJ64OYFNbdbtHnRj5U3WBEV0biDsS6JBb
         K4A2E7KxLO3dkelN59NpFBNRpAaL75bX09LOEr5OvCkpL/veexcDV7rcWaz3fGcdXsIc
         y80PU07T53z3DeiK/gsylQYCNmHgkSrvHGCZkW79l3mUvLmUnrc9ze7Tta9iZimz4VIb
         LUH+8C7fureUTQgsH3AtQ41JC316WruaSE5eUmUfRYKaWEWaUPV8JA5BW8FQfc5q1q9/
         jCNA==
X-Gm-Message-State: AOUpUlE638fFBMgikvoapnPjirajmpddQ9hiIxagVykudteioLLCSRSE
        59E6wxTZJMI5sTftZXX7wffsj/wjWCgMXFj292w0FKApa2ly7fDqjLXccC/j1zM0vI1GaVJu06I
        iM7FoReOuBp8u73gCiqJzamFJhUyYsJkPn7EvZt5/bLpvlrjEl6iGbc5RHgfX
X-Google-Smtp-Source: AA+uWPxduqptW8VSvzGUOwRukHdMmOL8s5s4RxKXBF4+hn158/pSK7aQYXUDUKrxjIgCmUUeMnE2p383L3QJ
MIME-Version: 1.0
X-Received: by 2002:a24:74cd:: with SMTP id o196-v6mr11688916itc.46.1534386671190;
 Wed, 15 Aug 2018 19:31:11 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:30:53 -0700
Message-Id: <20180816023100.161626-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.265.g16de1b435c9.dirty
Subject: [RFC PATCH 0/7] Unset the submodule URL in the superproject when no
 longer needed
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, jrnieder@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is available as

  git fetch //github.com/stefanbeller/git unsetsubmoduleurl
  
and was hinted at in
https://public-inbox.org/git/CAGZ79kYfoK9hfXM2-VMAZLPpqBOFQYKtyYuYJb8twzz6Oz5ymQ@mail.gmail.com/

  Originally we have had the url in the config, (a) that we can change
  the URLs after the "git submodule init" and "git submodule update"
  step that actually clones the submodule if not present and much more
  importantly (b) to know which submodule "was initialized/active".
  
  Now that we have the submodule.active or even
  submodule.<name>.active flags, we do not need (b) any more.
  So the URL turns into a useless piece of cruft that just is unneeded
  and might confuse the user.

Opinions?

Thanks,
Stefan

Stefan Beller (7):
  t7410: update to new style
  builtin/submodule--helper: remove stray new line
  submodule: is_submodule_active to differentiate between new and old
    mode
  submodule sync: omit setting submodule URL in config if possible
  submodule--helper: factor out allocation of callback cookie
  submodule--helper, update_clone: store index to update_clone instead
    of ce
  builtin/submodule--helper: unset submodule url if possible

 builtin/submodule--helper.c      | 82 ++++++++++++++++++--------
 submodule.c                      |  5 +-
 submodule.h                      |  6 ++
 t/t5526-fetch-submodules.sh      |  2 +-
 t/t7406-submodule-update.sh      |  8 +++
 t/t7410-submodule-checkout-to.sh | 99 +++++++++++++++++++-------------
 6 files changed, 131 insertions(+), 71 deletions(-)

-- 
2.18.0.265.g16de1b435c9.dirty

