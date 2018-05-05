Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4102C200B9
	for <e@80x24.org>; Sat,  5 May 2018 04:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750738AbeEEEDN (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 00:03:13 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46201 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEEEDM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 00:03:12 -0400
Received: by mail-pg0-f68.google.com with SMTP id z4-v6so16666502pgu.13
        for <git@vger.kernel.org>; Fri, 04 May 2018 21:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=yg1H+90k8Ae+eYHUlsA2fEp0Rw3zET7DV4oMZ2P+Uv8=;
        b=0lXv9FesrbCQPyLteeI7pLDXX5idaWF2Nbbm2scOVwZtxEb3qf8Zg3m9xCUcJv7fEN
         tGehjEoMpK4rAbuGZaTdjOTMmvU9yCRRCpHhXYX0RzLHV3K+CKGb1g6H4Waxq6km1Za2
         EmKmXM3EYycRjaqNluqX5o0uYcDwUGTtJawQXunR2Ran0hmhuw/8p3gSEDzrd1Hhm/eP
         4iFJzOvQSJCTP+voTJTLPVbqQzBkXBAZf8nGzIMBc0u1bpGBa0qV1yFK10GCZ1zzW06S
         1T5GwLWdhASol/VnuRqUMG/UcU9a5+vnO12xllmijGVYtJ0DPL5scpJutIb4mKTR5QbL
         9ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=yg1H+90k8Ae+eYHUlsA2fEp0Rw3zET7DV4oMZ2P+Uv8=;
        b=d4CKBI9UfVTyP3mFxaEmZiJp/2G4BGvuNcQKB94z6eV8+o3SD8eICd9VqjKMgcQCVw
         Hyh2dv/KJMdLHx4/8TK4pBhXLk8kGQt5uhQVdHAtL5yN37d0IZIpGvL2QdZuareMqiUm
         WKAECl79Eddv3vCDDQDPXT8n3LzzJcBb8/6ZeKrGul0ECT8xhXWzQVqroHmcBXIv0fS2
         FAChjyg+M7BOwFXgRufv5Ba+L65+mhaNkg1ENaTxmL33+aqW+KeSTgwhiDk8e2wKIjN9
         lGpYcq2yG1JZckm7Uq3keb+5g4hnDOtnLaml4en6pFZUAK6VRWNktZUJhbwTokiK6J5u
         CxhA==
X-Gm-Message-State: ALQs6tDQz/zMcu+CTpV3TA08h+O4dFBeWfEFx0DjxoYboUfQxOPsjLS2
        Cc0bFkSMOT8tTSLGVmtf0vC/tIAFaEs=
X-Google-Smtp-Source: AB8JxZqBjIBflYxYg6oEfKlpLbIfVniGQ1+bFmr+Ec5xd3O/Q9XPJEdi/uRyX6D4jaX87NWLG14Pqw==
X-Received: by 2002:a63:790e:: with SMTP id u14-v6mr24551892pgc.445.1525492991171;
        Fri, 04 May 2018 21:03:11 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a961:c277:c90f:2435])
        by smtp.gmail.com with ESMTPSA id s7-v6sm4532109pgv.4.2018.05.04.21.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 21:03:09 -0700 (PDT)
Date:   Fri, 4 May 2018 21:03:08 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 0/2] builtin/grep.c: teach '-o', '--only-matching'
Message-ID: <cover.1525492696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a series to teach 'git-grep(1)' how to respond to
'--only-matching' (a-la GNU grep(1)'s --only-matching, including an '-o'
synonym) to only print the matching component(s) of a line. It is based
on v4 of tb/grep-colno, which was sent in [1].

This was suggested to me by Ævar in [2].

This change was fairly straightforward, as Ævar suggests in [3], with
the only complication being that we must print a line header multiple
times when there are >1 matches per-line. This requirement pushes the
implementation towards the extraction of a show_line_header() function,
and some minor changes in show_line() to reflect.

Thank you in advance for your review.


Thanks,
Taylor

[1]: https://public-inbox.org/git/cover.1525488108.git.me@ttaylorr.com
[2]: https://public-inbox.org/git/874lk2e4he.fsf@evledraar.gmail.com
[3]: https://public-inbox.org/git/87in9ucsbb.fsf@evledraar.gmail.com

Taylor Blau (2):
  grep.c: extract show_line_header()
  builtin/grep.c: teach '-o', '--only-matching' to 'git-grep'

 Documentation/git-grep.txt |  6 +++-
 builtin/grep.c             |  1 +
 grep.c                     | 67 +++++++++++++++++++++++++-------------
 grep.h                     |  1 +
 t/t7810-grep.sh            | 33 +++++++++++++++++++
 5 files changed, 85 insertions(+), 23 deletions(-)

--
2.17.0
