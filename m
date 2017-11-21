Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D55D2036D
	for <e@80x24.org>; Tue, 21 Nov 2017 23:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdKUX3j (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 18:29:39 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:38748 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdKUX3i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 18:29:38 -0500
Received: by mail-io0-f194.google.com with SMTP id h205so20546392iof.5
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 15:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8vxWyquoNvjOwTXPkGQ5E0tYfCXz7jQEUFD5MKtrAps=;
        b=mft+kwFfkBw4NLLdvVO96uKsFuYkk6EkkV4un8oVaU0eAAVi0SFKUylpwA/c/AxAoi
         vqfCPR1someMSTMxH4dwQv+Cf4qFf6fCxB2zEj8R4A835YOwFqTwAoXjhnaESWBAeRx8
         W9FoUTG93wuz67WrCBjeFSFsCRLAuYW/fJXnxVf9GezLRwFw9hwe2AK9RAS2gV6Dzug0
         91pAffwJArHymtsTaBUCgQyL4kEU3C9YdXOdrdq/nMeqWhwQ2gkRlUrlnDx0kb5yuB2Q
         RRtoVeMwqBN5xwRvIw71qE4if9La9c18arOXpvYcrpEh4hpnSs3EQ5cHmCpbdAzc1Gjt
         Gxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8vxWyquoNvjOwTXPkGQ5E0tYfCXz7jQEUFD5MKtrAps=;
        b=PQJyb2ZpqKGAvMlW7LsFamseEVZV/PgO+XnRpTuK1iIZm6zMfWwGl8T2gIWZ9OCShZ
         is5yb9EnCipMFbZTYaruD+wdcy00/hCSUr8CsRr+FR4AJj4b2rY75Hq64JtgeE3U5R3B
         o5+AO4zwszoxJxKPcbjaEGyUHsHfp+Cs5TCjVH5nRpDuMWQvi1xb69JHih5rABnUFdNe
         898/9wM39+SbwoP/5qqEQcuh3T9DczXLw5qQg+ij0wSC6IW9P75Eo/0p96rib2zPKkMZ
         mQdO5LQPtaPF1/zDbqrQXXJ6zqNfUGJwckjA3ShAq7YZyt/5GNdG0a99f6M7T2h3mLA0
         PDaQ==
X-Gm-Message-State: AJaThX62cyc9xCurU6xxReAW3zdSswc3lcLYbfSt7P76MPUVroPuuMzv
        nIEtWKfluXOqPLEZTCqTkvRq1bjZ
X-Google-Smtp-Source: AGs4zMbbewkc1nKFa3XkB5GcSmxeZaV2qoP2fUcW+t9Q3jPP590TTqlxZla42D3Y3SO9LXxyVqbiXg==
X-Received: by 10.107.156.209 with SMTP id f200mr19305844ioe.226.1511306977868;
        Tue, 21 Nov 2017 15:29:37 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d14sm1208292itj.11.2017.11.21.15.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 15:29:37 -0800 (PST)
Date:   Tue, 21 Nov 2017 15:29:35 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Improving build reproducibility
Message-ID: <20171121232935.GM3429@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

The reproducible builds <https://reproducible-builds.org/> project has
been working on making it possible to verify that binary packages of
open source projects were built from the source they were claimed to
have been built from.

To that end, Debian has been carrying patches 1-2 for a while.  Patch
3 is a Google-internal patch with a related but distinct goal of
making builds go faster.

I think these should be ready to apply.  Thoughts of all kinds welcome.

Sincerely,
Anders Kaseorg (2):
  Documentation: allow overriding timestamps of generated asciidoc
  git-gui: sort entries in optimized tclIndex

Jonathan Nieder (1):
  generate-cmdlist: avoid non-deterministic output

 Documentation/Makefile               | 7 +++++--
 Documentation/technical/api-index.sh | 5 +++++
 generate-cmdlist.sh                  | 2 +-
 git-gui/Makefile                     | 2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)
