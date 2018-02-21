Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4508C1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751158AbeBUXfy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:35:54 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40011 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeBUXfx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:35:53 -0500
Received: by mail-wm0-f67.google.com with SMTP id t82so420993wmt.5
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 15:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z77ZEG10R7tQEerUgE5p40bwujjUuWvk4mt9zb8I3Zs=;
        b=dyUncaClKgxqi1sEPDUkTNI+op7BmcFTNpb0Eyx75kK+hI8Ui91WtY/5QnmDEka88v
         tSjeWh47A2bow8GMGtJwcJkz1dUWQQpw3sQ5BfGc0uew+YAOqGw9PGN530ZxuUH+JGwV
         0aNzxBdZEK9mlBv/mQPzvmvReU72R6mrAKfP0I2V4+AliwmZ6w7awkU6FzYNh+DXfsHs
         yOZq6z95nNmkQ3plcH0tXRKO9t5od1yzZ/pI8vpPfU7LQScsoAKtss8zXKvneGISD5St
         YB3C4JE3/wuf1ZPLhLIQbZEl/dNX2Oi75OU/jVs1x3aBC+ZZtJ3BD0exrr8y5xjTCnCh
         e72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z77ZEG10R7tQEerUgE5p40bwujjUuWvk4mt9zb8I3Zs=;
        b=KeSw1X6E4xqpX6iAbiBeqQB+oGAYuImetXOLkHJRKLmtgeKWFviuDsRHx63fgZDnBR
         w+Ne24jbQvr4Ah/zN8d+LeumHVDm1laEIbvEiO+hqAq2BSzaTREvvVF3qy5lYqDi/ydN
         D9lN/T+IG3iMiXnxiLTd5XNop8DjKsb9USR+niS7yRc5uE4mn07CBwX+d++ZMVoQ0GKE
         1sxFoJ0i5ONfMf8Ar2yCpVpsYg+NpGFatqB29oBPrhiX0YK8mMZeExgZ+RGR2uJR6zEs
         wJBUb0BjsGve0ILKdp8sSog5gSn9IVwWp9nE6+g4By8jm+IPSRIT0b+AvQ+qJzcTUOqO
         Gb/Q==
X-Gm-Message-State: APf1xPCpEbb1L0rmH3qfrskEVUqLTTGsUTCHNacrO2MrOLgLK0zBIAKK
        Io4972J+QXRGlCg/ieDmEfY=
X-Google-Smtp-Source: AH8x225hwIhjGVNXvoscMiTankEtkJpafbqrrPlYrpBEglkPLqWEa6Dk7HTPTjBlsh7SzZLuuH5gFA==
X-Received: by 10.28.3.4 with SMTP id 4mr3430881wmd.60.1519256151615;
        Wed, 21 Feb 2018 15:35:51 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m69sm11244116wmd.32.2018.02.21.15.35.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 15:35:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH 04/26] upload-pack: convert to a builtin
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-5-bmwill@google.com>
        <CAGZ79kb2=uU0_K8wr27gNdNX-T+P+7gVdgc5EBdYc3zBobsR8w@mail.gmail.com>
        <20180103203956.GA44365@google.com>
        <20180221214755.GA10327@aiede.svl.corp.google.com>
Date:   Wed, 21 Feb 2018 15:35:50 -0800
In-Reply-To: <20180221214755.GA10327@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 21 Feb 2018 13:47:55 -0800")
Message-ID: <xmqqefldykyx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> For defense in depth, it would be comforting if the git wrapper had
> some understanding of "don't support --help in handle_builtin when
> invoked as a dashed command".  That is, I don't expect that anyone has
> been relying on
>
> 	git-add --help
>
> acting like
>
> 	git help add
>
> instead of printing the usage message from
>
> 	git add -h

Sounds like a neat trick.

> It's a little fussy because today we rewrite "git add --help" to
> "git-add --help" before rewriting it to "git help add"; we'd have to
> skip that middle hop for this to work.

I do not quite get this part.  "git add --help" goes through run_argv()
and then to handle_builtin() which is what does this "git help add"
swapping.

"git-add --help" does get thrown into the same codepath by
pretending as if we got "add --help" as an argument to "git"
command, and that happens without going through run_argv(),
so presumably we can add another perameter to handle_builtin()
so that the callee can tell these two invocation sites apart, no?

> I don't think that has to block this patch or series, though --- it's
> just a separate thought about hardening.

Yeah, I agree with this assessment.
