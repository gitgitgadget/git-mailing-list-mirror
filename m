Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7581C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 06:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBMGiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 01:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMGiW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 01:38:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CFCEB7B
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 22:38:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id bt8so5633215edb.12
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 22:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urElr+e4c2kE45YYEv6ot6OvL/o4S9tTGVYBljx+MRY=;
        b=H3c9nLVRz/FH6P3mr33FH1+o+rBpIYHjHoesN/vW96IPgYNR+8LN5WGMhvNtWNYTzP
         /m4oK5W9aUvqCxHXgM/8ZG2GmcOAK7U5h568NMLcp4qbxQS2J1QtU7kQ8OR0LdrpALcl
         JKmHM6qp2pPJqaqIh9ZN5QRZLcgxSTUa4ckVRsHZvUHxxJwm/CwlnkMCRinUZjlsS6qk
         DRcn9nuRsci7yFAMCYdKULeQMDwNN9oJsvrOT+0yXEaRM0ilLUJblVdf87U6wvUNn93J
         wAiIFSASNBvjvOuWgmtfgpCsbbJs8NBgMJgs6TPjofMoFE0FkXsUGCAE6M0XWf5LVDTi
         9Ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urElr+e4c2kE45YYEv6ot6OvL/o4S9tTGVYBljx+MRY=;
        b=7cQQmdLrfuwxy2/DZw9TMiAcCBmZpL2l8EOjTnKrNltZKpnmsGQZhuIIQXuEJ8KLzm
         nrY55Qa/YbeW/YrdhuckkVNDJduHm26cz6PW7TMaKPpoQ2I6hX0Y3RFmOQ3NcJVer3nw
         bJN0eXmdPmCuVse2OjhJ8Ubo2yJ8NOYs5TMTpieO00Liok55To10J0y+XyqSaUQhTAf9
         AQQ7yoCQQq2mKYb6nhIjTlKyk0n7pto8nA7ErrGE3HxEof7J/4i1FyH+DpYLqSHqBxV6
         chOWu5NVaTwHALcfSa+y8fUXiSBqFozLngrhJgbozBx7bxIoA14HeG0zSulXAfWIht2l
         KCuA==
X-Gm-Message-State: AO0yUKUycF0G9bACcJlqGwMwa9I9d4Kmh7Lih2koZMAR+2T28/aQu/CY
        LbAy0j76jltkBow1XVae59Ipuhzhv0yvRUSExaQ8JsQgnO1yoW0jFKg=
X-Google-Smtp-Source: AK7set+FEUkRGdw2WeCUYsjwLvr+Du8Tnt+nYDGtKM/Y2YalGFEl4mQZ/BUNXGu6VVlVUjYC+3pDEV8He5B1nV5rtGc=
X-Received: by 2002:a50:ce59:0:b0:4ac:b8e1:7410 with SMTP id
 k25-20020a50ce59000000b004acb8e17410mr2320258edj.6.1676270299734; Sun, 12 Feb
 2023 22:38:19 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>
Date:   Mon, 13 Feb 2023 14:38:08 +0800
Message-ID: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
Subject: bug report: symbolic-ref --short command echos the wrong text while
 use Chinese language
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

System: Mac Os (Ventura 13.2)
Language: Chinese simplified
Preconditions:
# git checkout -b =E6=B5=8B=E8=AF=95-=E5=8A=A0-=E5=A2=9E=E5=8A=A0-=E5=8A=A0=
-=E5=A2=9E=E5=8A=A0
# git symbolic-ref --short HEAD
Wrong Echo (Current Echo):
=E6=B5=8B=E8=AF=95-=EF=BF=BD
Correct Echo:
// I Don't know, may be "=E6=B5=8B=E8=AF=95-=E5=8A=A0" ?

Tip:
not all Chinese words can cause this bug.
"=E5=8A=A0" is one of them, but not the only one.
