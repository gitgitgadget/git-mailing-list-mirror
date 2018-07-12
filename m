Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515081F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeGLSfd (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:35:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38296 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGLSfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:35:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id m1-v6so9929933wrg.5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WEA0NE5LE7rY5oW4W9+zVp9lcTa9HDEOXzP1bcGlnX0=;
        b=OjNLMuv5+D9ZWhVA/jMiX2Fmv3miwsm7d6LpEs6EHxBrC0EuJ9mRL/OBUfUr2IWXEz
         UZtUnsS+DBrJW/wnZ18SFYixuU6GYcbP8wrAWlktzvWkWjzBNgL6Gjg+4garHNyt9NQL
         jrKF8+rMJie1nB++F4fXg0IIGoJ8prPyATSODlmeUAG2P0gDGMMGesE/sP4diGQauB9F
         VOhF3kfZv96SMx76wz32q1eB6lRoxr2tB9piubHlpnMe/33p3rzDwr236Cf2SCZMDk+4
         Poe+QrkxThKyxxy6eXIYKRD2vWJtoGKx8ARxP8QBcEICJDLLbEIgmbSe39SDR7lhBblZ
         lrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WEA0NE5LE7rY5oW4W9+zVp9lcTa9HDEOXzP1bcGlnX0=;
        b=s/weuWGo/SaKCU/ujjZ9cg0hu2AiLbV4K3Rlgz4KKbLAw2v0wFVib3Ml03zI3I7atS
         velazmMyg7mm6OL46+ODeaOIkKfMrPwuq7NBrdqrxl7PYYviQLhW1shCP+K7OcQiRsui
         ivTKys7k8DCDAH62uRfuIN6zkmMx4O0HD5NNiDzoTv/EpRwUyjEYymJs3WMDBcKPtBmN
         Bfs58LwndusSU7Uq6RBG9Mym22AVaoZPqE7/6ChUo2l7B5XsSkYN+4P8M3NPoEZa5SWf
         xZQG9esxclpNCE/MDJe7obqgNTanT/htXwLapYtp9+82u7Pz2fRkmEvr0MoMhrvKJOHF
         vBqw==
X-Gm-Message-State: AOUpUlG2YxE8KQvFkZi5qoIBXfgMe+N26kK8cQ3UnN0tuoPWP8a6eomc
        U18+TO3bUxMP1cbUQlIx3/Y=
X-Google-Smtp-Source: AAOMgpcYn/YAY7bNRHQp9jNwMqBvWeO6BaF0CSxpDUeSjyQy4aVukNpQg3ZiMPns3ZEy9vsoDVe/FQ==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr2700874wrw.209.1531419889066;
        Thu, 12 Jul 2018 11:24:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z9-v6sm40718784wre.49.2018.07.12.11.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:24:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 12/13] rebase -i: implement the logic to initialize the variable $revision in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-13-alban.gruin@gmail.com>
        <xmqqo9fcxquk.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 12 Jul 2018 11:24:48 -0700
In-Reply-To: <xmqqo9fcxquk.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 12 Jul 2018 11:15:47 -0700")
Message-ID: <xmqqk1q0xqfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If I am reading the body of this if() block correctly, I think it
> does everything init_revisions_and_shortrevisions shell function
> does, i.e. compute $revisions for both cases with or without
> upstream and write squash-onto state if needed, so that we can call
> the sequencer_make_script() helper with necessary $revisions arg
> without being passed from the command line of --make-script helper.
>
> But the hunk below tells me that you are still calling
> init_revisions_and_shortrevisions shell function before we are
> called.  Why?  IOW, why isn't this step removing that shell function
> *and* the call to it, now its logic is fully implemented in the body
> of this if() block?

You can ignore this part (but not the rest) of my comments, as 13/13
answers it adequately.  After this step, the shell function still
needs to be called to set $shortrevisions.

Thanks.
