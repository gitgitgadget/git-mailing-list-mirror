Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 366EF208CD
	for <e@80x24.org>; Thu,  7 Sep 2017 16:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754836AbdIGQuR (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 12:50:17 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35332 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754622AbdIGQuO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 12:50:14 -0400
Received: by mail-wm0-f41.google.com with SMTP id f199so2515617wme.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kkj/kbMeYoKsa5/3Ir6qCCzN8LQazAj+knhpa9//mHg=;
        b=eXmZE4C6+bSf1K7NVqjysgFb8UxWNWXw65RviEL674T6XNrRaMylz/SMWp+AvouDqw
         4qX7dCFVuVwBaMj0TKLR1DI7PUqtFqyz+q5f4a++WWm3xPw6XOaj8k4nUu1X/2Drd2Fq
         8xa/MvdaByUZCGa2TcIqJY+XHTby+MSKQFqQ04DK9bsPytUnYKb4q53+E9IP+1b2NUT+
         9i/TjrVSs2m920PW3bi7T3P52yCalqB93Tc0ElXA5Vq3ONURSMQe+tbLPuKrzxvwPF1U
         FKcU+qiPpClI/GR7tXLjFfxC/ezqgvngQYkx2UoZzx/iNskvKgb4Ep4Ic2aAVZ7ulSUg
         Um3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kkj/kbMeYoKsa5/3Ir6qCCzN8LQazAj+knhpa9//mHg=;
        b=LqQiv6Ae0A2gvfAKO7kOH94TWDqAA0G7rOpAzwkCErNS+0eip52ePknVIhnsUOLhLm
         plteiqNjL05g+H1njI9y1dmpGILRJ92P90ExmGKZ3TkiOZ7eomSBgy6KwaZHgwYpuHcg
         dU2qnQULiTHUQkgGwKMr+N1xgN9dLbqaRvOR8RuVL1pCDwNowspRJaHLpRvNpfgqnXPp
         j1f84HwNEtkWJTaH9AXA2ZUf7g+kl4WRf+GSwJI/STOT/k72S5wztaTnODJQqqC5/50u
         vKqEXOvkcQZBNragKd4KBs1/8XB0QaBpa38UHIjgj04EKwZIxi1X5GpH7cPCkDShGajM
         sPNQ==
X-Gm-Message-State: AHPjjUjaEPEZBpNdDOs4irwYcwMVNbvFZQiD0MtsOln+AVqFl7IwSOqo
        lSkLTqo2oWQ47hNcSlmjT+KFOMEcwc8cN2k=
X-Google-Smtp-Source: ADKCNb5QUQ6I1j+QsEBS//JSwtsGHek1SYN1/gOqUwhVtokxxqxhu3ig3Mmt/S3S1vqs1Q2Zcrsapk2N/qw7+4Qrc8c=
X-Received: by 10.80.187.42 with SMTP id y39mr3072103ede.287.1504803013383;
 Thu, 07 Sep 2017 09:50:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.204.206 with HTTP; Thu, 7 Sep 2017 09:50:12 -0700 (PDT)
From:   Kermit Short <heraldstorm@gmail.com>
Date:   Thu, 7 Sep 2017 10:50:12 -0600
Message-ID: <CABjWGHx5VQaLubeWsqWJzufDU3vt9BSS0=LpwgOtMDYhje=qMA@mail.gmail.com>
Subject: clone repo & history to disconnected server
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings!
I have to set up a workflow where I'll be developing and testing on
one network, and then deploying to production on a disconnected
network. I'd like to be able to have the full commit history for all
branches, tags, etc. on the disconnected side, in case I need to
perform a roll-back, create a hot-fix, etc.


Most of the solutions I see involve creating a mirror clone that is
then merged with a different repository. My problem is that my servers
are on two separate networks and I am unable to talk to both repos
from the same computer. I'd need to be able to transport the files
using sneaker net prior to importing on the second repo. I need to
keep the production repo in full working sanity...i.e. import only new
changes or completely overwrite the repository such that the full
project history is intact and working.


Does anyone have any suggestions? I've been looking at the archive
command but I'm not sure it would bring out the full project history.
Thanks in advance for your help!!
