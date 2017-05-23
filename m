Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5752023D
	for <e@80x24.org>; Tue, 23 May 2017 03:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758525AbdEWDfs (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 23:35:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36360 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757865AbdEWDfr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 23:35:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so24312131pfb.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 20:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NstUZx80sfxGCgG6t3HLeHigqzT6ztyGJ7hSMt1rm5A=;
        b=t8KuqqUynjhQjaWoLseL2a1m2R0uihwnZX0HkqD9u++XrsN2AD+nnGt43X1O74Qikq
         ejvgN8zlMAgW5ENFLCL4IzIr6X6nLfJkQhSYFeL44y3KdCANGWnB5PuM2Iwk7Ysxo8cm
         yc4WiDYbXMe6OGuK8IthftpJsPciXlby1TTGkYdBUjl6rT75hNaMhWw6BhXZNQwGhihc
         sgi3hDMMm4hlJ+yJp9begSlLmzTP9tASi6kZUFqiSg6EeAlLhPWoL4dANqBFplCJ8wLT
         xenDNp58M2ApNWJWZrFG55yrmD5hNEPwyfDIX4ZDqYN0QwprMPfpMopRX4L0ZqGzhVxi
         RgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NstUZx80sfxGCgG6t3HLeHigqzT6ztyGJ7hSMt1rm5A=;
        b=fjZmhUUVipWGfvn/LgIqU+0jdZAWFwRcsNPW1zs0I8vuIg0GmO6yZb6jUCujqPvWNw
         7p3zgu+dEfoSViNB+GNQ8xwq5UZqYTDo1YKeUqVDE/NkvZKVYjxl67MXPT5xaqiztMEp
         Vim/D11PVpjwC3GnDnlUEwOHA6nP8QuHyz39TykRrQQwzPRCx0VvezqO/bRpEWJp3yXX
         BCf7dB6YhSl5tT/3F8ERnx0+U2XqFjBxNmbnnQ+ZwYHDASeGSdB57hhR2Wxi1eQDZgxU
         w//7zMrfIjdQGEt6Dxg0VRTLXVjqhCTGya24wwc5v2xEH+FJ7EfwAHsDTPV5oF2CSFzP
         vQ8Q==
X-Gm-Message-State: AODbwcDI+iYTPNAFacDFAne6bmHph1dVtCmqmOK2qPdaNgY2oFZ+itHL
        nJdMnXZAfGzmqA==
X-Received: by 10.99.247.83 with SMTP id f19mr30073934pgk.190.1495510546677;
        Mon, 22 May 2017 20:35:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id q28sm28688521pgc.0.2017.05.22.20.35.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 20:35:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v3 1/6] Fix build with core.autocrlf=true
References: <cover.1493891336.git.johannes.schindelin@gmx.de>
        <cover.1494334366.git.johannes.schindelin@gmx.de>
        <6bc890b10de8a59f90005462f8767d6b022b0749.1494334366.git.johannes.schindelin@gmx.de>
        <20170522175709.GC17710@aiede.svl.corp.google.com>
Date:   Tue, 23 May 2017 12:35:45 +0900
In-Reply-To: <20170522175709.GC17710@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 22 May 2017 10:57:09 -0700")
Message-ID: <xmqqh90cmei6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio, how do you prefer to handle this in git.git?  Would you need to
> amend the patch to remove the git-gui/.gitattributes change and wait
> to get it from Pat, or is getting the same change twice okay?

Yes, getting the same change twice should be fine.  I'll see
conflicts when I update from Pat when it happens next time, but we
know what the resolution should be already.
