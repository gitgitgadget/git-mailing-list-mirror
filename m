Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C681F78F
	for <e@80x24.org>; Mon,  1 May 2017 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdEAQwX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 12:52:23 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35568 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdEAQwW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 12:52:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id o3so42021261pgn.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jWNl4R7eZ6EbNql4X1JKuVzGMogtNtcTOWteUP4L8fE=;
        b=ss6plucuSRssvUBKg82egQ47HgQ8pTSxUZ89UybBgvbizxeIewszpVDgQKJG2hRuYX
         SGT6TSpGWs6mzhYNPIl8hLfyFxr42QRU/SprqmDjKQpGXcGrA1J8FPgnXC543kGRiS2g
         S/rrhLEU9mX7Ue+xxXLch62BcyqWm2J09IPY0NKdV++Wa81QokB+q2PzFBUn6g3uswqK
         40vhWAVaiDeEym8HW8g62vRxP4P8N6Ci17Ut5BLB+Xt9UDOIgCM3umWbuLJRNi8yLK8W
         4SmPDfJGBjix5i144ewEeKaUqZQnYSYa4SQJPR/bXYsz//EbTYersTNztDAbCF/nfwul
         fMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jWNl4R7eZ6EbNql4X1JKuVzGMogtNtcTOWteUP4L8fE=;
        b=L1Gp/dpe+uAvW7rg1Ikb7CAD4JbafTAFfB/H23TSnBSNVcTPsNMTRvgRMzzsgc8eS+
         PsUwi+PxUVW6u71rtWulQsz8Fjz33jxeRtn/QGkBNcNDX/Kms4PRBpQQ/NeDexNnhlyI
         FLXmDy7alGc7HKbar7FH81nrpznDvKXQe+NBKEHmRDw3GbLWYu5TCYjnw07UqhS0YsZB
         nzTko7U/OUqJyCqc3phtFS1XQy58+w2YnVFFoQ+jVc19BREeOYre0Ij9qb0sGAMY+Qf0
         AWMAiewGiu5njQbbhcbAi1DR7pJ8SPl8nFeCOTbaEjDcKioMvc2nTxGKGYVOnLa0cEjO
         8CZA==
X-Gm-Message-State: AN3rC/5r8znTWojyyHPwHafvY7Vmw0R2z/z0zqeY8xLIZhVt6lr43l72
        wlNYls3WVc13WxKVmXfO9r8o/YGTxKfP
X-Received: by 10.99.107.198 with SMTP id g189mr27405839pgc.162.1493657541263;
 Mon, 01 May 2017 09:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 09:52:20 -0700 (PDT)
In-Reply-To: <20170430231434.GA70010@google.com>
References: <20170428235402.162251-1-bmwill@google.com> <20170428235402.162251-6-bmwill@google.com>
 <CAGZ79kZzpyw0ijiM12TwMHAx1Ung-xKPEm2rVY9803hvk=+UMQ@mail.gmail.com> <20170430231434.GA70010@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 09:52:20 -0700
Message-ID: <CAGZ79ka=gALFrzj1OpL9tifiS7eSOSVAMfxY3gD3T6o-teJuaA@mail.gmail.com>
Subject: Re: [PATCH 5/6] submodule: improve submodule_has_commits
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 30, 2017 at 4:14 PM, Brandon Williams <bmwill@google.com> wrote:

> This hunk of logic is essentially a copy and paste from elsewhere in the
> file.  Essentially both code paths were essentially doing the same thing
> (checking if a submodule has a commit) but one of the code paths included
> this logic to ensure that it was reachable from a ref in the submodule.
> In order to merge the two code paths, I included that logic here.

yes, I get that. The question is whether the other code path omitted the check
intentionally or just missed it (Is it a bug or feature to have this
check in that code
path now)?
