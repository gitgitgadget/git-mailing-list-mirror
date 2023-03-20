Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E83C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 15:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjCTPIH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 11:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjCTPHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 11:07:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3F11EA3
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 08:03:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x11so10491002pja.5
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679324583;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:reply-to:user-agent:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLwOf5M8vryROySJEuFWVMtDBpNJ5UvrZrNNDGJtnzI=;
        b=DOQi7l1qPEso/UrN9dsL9nDviEeNl6CWaG8a8lXSU4jnvKrMqjnk9w+eJL5NOnVr+/
         v3sP7LinY4o9fz57jHfgcfWDRbZTG1uONYzM4+HFUAZICwI9xvU++Um0bD1DQdS1/DzZ
         8/XwhSpQUytyYrt38TVDM/oVn2Q8nqNUME1x7yeTXWTStDJfqkSnFzs/N7YnxFk3xAUr
         +l2OogMsQBvPbqQfFj9WRwSxFLxAhjIhJLtx0UJOwjtT0tLiZhIjdMI6mvSEdJzLXyCt
         5qKlJCT8mGtAuRVdL3AQhYAlAKIxd/7lU5FNYZ2KZUujUXqSTKiZzHr2O9Vqhoc2uVq1
         bQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679324583;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:reply-to:user-agent:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLwOf5M8vryROySJEuFWVMtDBpNJ5UvrZrNNDGJtnzI=;
        b=rgiqOnm1W0gFDKCmfKnT/I3qR6UHbSs8F0bDUY7vC12cfbEwS7sP0BqN4HotZGLgp0
         Yn/gcvezLSKbxgkZESKNartqwUsY4eWyNrNDOewRv8SNDaDE24VCGklQwBeCiT3tiWUe
         vsuOs9lgTVAoaBwAo544tSKQAiK3BH3RlQ+/HhIF4nieZ1lMKYBan9q60/mcUGYsgvai
         qnEJ5sesb1GJwPd1aqXr1wBW7TGxmLZSjhXU1MA53xJ6PkwHFSCa83PaQMQnRdZSWMET
         D91Riu4hH1uh0TCjps+uvh7eyHHwCm+tarE6n4YsvBmIXkuAD0UGbFFaoouFgAENqso/
         gQWw==
X-Gm-Message-State: AO0yUKUiBE7EKVhftUVU/Xvi+VUTR9G54UgLg2AIioxfwq0EbJlCCpcM
        aHrPKg6QYCE1Mx8G7302m9o=
X-Google-Smtp-Source: AK7set9C3a74KtsqxAcX8BChBL6AE7e4JfvaPV3sMTPMv8gEc41cuLaJfD5E2PjybJc7ikRnh0qJ5Q==
X-Received: by 2002:a17:90b:314d:b0:23f:618a:6bec with SMTP id ip13-20020a17090b314d00b0023f618a6becmr11957433pjb.49.1679324582950;
        Mon, 20 Mar 2023 08:03:02 -0700 (PDT)
Received: from [127.0.0.1] ([103.230.107.12])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a154900b002372106a5casm6146383pja.44.2023.03.20.08.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:03:02 -0700 (PDT)
Date:   Mon, 20 Mar 2023 21:02:32 +0600
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     stanislav.malishevskiy@gmail.com, git@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_That_change_for_support?= =?US-ASCII?Q?_different_sslcert_and_sslkey_types=2E?=
User-Agent: K-9 Mail for Android
Reply-to: pull.1474.git.git.1679233875803.gitgitgadget@gmail.com
In-Reply-To: <FFDFA968-58F9-43C8-9139-B8733BFD4665@aol.com>
References: <FFDFA968-58F9-43C8-9139-B8733BFD4665@aol.com>
Message-ID: <1C4BE23C-0D7D-4B44-94B8-6243E1985BAC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the commit title please mention the subsystem you are=20
changing=2E Also, a good commit message sounds like a command :)=2E

An example would be:

http: add support for different sslcert and sslkey types

Lastly, put the sign off email address in angle brackets=2E Good luck!

thanks,
  -- Khalid Masum=20

