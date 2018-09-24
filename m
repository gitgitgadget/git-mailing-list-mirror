Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331A01F453
	for <e@80x24.org>; Mon, 24 Sep 2018 22:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeIYE2f (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 00:28:35 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38346 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeIYE2f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 00:28:35 -0400
Received: by mail-wm1-f50.google.com with SMTP id z16-v6so5150028wmi.3
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j/bR7CNHK+oUQvFtDB4J+/m+3A+eWFtZnHrhrM6hWSM=;
        b=uYobbMIp95KVNsJ08MOnaYUxxT5wNfDvQfxpO5NFRPcto3p5ifHWYbOUhyHYLYtf4P
         ts75DCXL0x/sqUtZTKNz4CR2jtkAt9YheGDtitq8JPLKQjF15mVj1CwClFFPUf773+qg
         4BXATFMdUVWvn6yzcHdJ6lcdqpMg370PAEB153G7f8Z40+A81I6iA5eaJTaV/EpV8qZe
         zDubgkpbGN50dGAUHPC9hxoG5R1rdQJohGfuDJNeoebwesbvkw/uI5qD02nkYTn6vDut
         rwa73wHXHc2VM6r8JH8MNAGcoOgMtRK7khjror9cAhHjtJNgC6JlvaDtLIAwWQdRJjk6
         YV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j/bR7CNHK+oUQvFtDB4J+/m+3A+eWFtZnHrhrM6hWSM=;
        b=IzXITzPhTosVC+Zyt3Kp+juTqt4YKg4QDyAL2wadY8sOQgvkrdBruyIwEqA+p9eP+Z
         RZvo+2eKCNTuFTZjQKxoKJN+krY+BdckvI4oIn7KzJqo3zuIrDwfIn0Nxd93qk4yS0fo
         aB2aDXkKretAD/rlIU4I8GJv68aOr5S0g2MPnuRnaNG9duY0oIsq31bCp6b3EPpcwppW
         k1WZN29yqf4rjg362o83Bp8bsb1E3RTF3hraew3uwDY5hDKnK2YkljYkbCnOobv9z/vW
         JFgC2DTAYuU2x7zHR92mSSwqVSS6NErZSud6M2GKeQoZfAZxc1yQvlKmTacH5/i9dezE
         khwQ==
X-Gm-Message-State: ABuFfogws4kJeQEpHRLEgh5c8+uQXtGD/qf2ynilB7REKz2+sV7yl3qH
        SiwUnSVqLjT6pEVKxOctOm4=
X-Google-Smtp-Source: ACcGV62QkHlyyMEKF8d3EdD7KMzLtcAC0icjhhlKhZzax6AefTpnECyqC2e3MVANvDdHU/DrBJySsg==
X-Received: by 2002:a1c:f611:: with SMTP id w17-v6mr250161wmc.143.1537827849288;
        Mon, 24 Sep 2018 15:24:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x16-v6sm318551wro.84.2018.09.24.15.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 15:24:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Kuzminsky <seb@highlab.com>
Cc:     git@vger.kernel.org
Subject: Re: bug in 'git describe'?
References: <fd340f7b-61c0-2661-bdca-c239e51bc464@highlab.com>
Date:   Mon, 24 Sep 2018 15:24:08 -0700
In-Reply-To: <fd340f7b-61c0-2661-bdca-c239e51bc464@highlab.com> (Sebastian
        Kuzminsky's message of "Mon, 24 Sep 2018 15:45:06 -0600")
Message-ID: <xmqqefdir0tz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Kuzminsky <seb@highlab.com> writes:

> I've got two tiny git repos whose commit graphs are identical, but
> where 'git describe' gives different results.
> ...
> The histories differ only in the timestamps of the commits...

describe does take the commit timestamps into account, so it is
expected you would get different results out of an otherwise
identically looking graph.
