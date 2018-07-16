Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34251F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeGPTsO (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:48:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35666 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeGPTsO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:48:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so2557864plq.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CYN2dRDl8Mu6ggUT6uoWQ/TjgWwrw8zHuMNuAC17afQ=;
        b=R3XuTFFPw6z7k2rdE/GkDZw9iVJQ+ixQtOL5k3C0nMdua+xWIojutPYL59IHKju/CK
         Ouxv/Pr6qg8AKX4GSlEXv1dHTSZK/YBz7oqz9pOy/hrgs6Bc/xlu9c7of4gMPlECj3j6
         Bd0uDiLilDB4nmQgcZP40NlEVZJoYjhfEEasSP6ElQE+FAomVHzLVCfkxY07foYsDkRP
         SB2z24gSyuSGmFOJLyKZhJP2UzAF136hPJqZh3QubKZQAujcXKRX3JVaF7qP9wB3dMYj
         EZ0tToy+7FcjSUIXcQ+k4KxaqfhKPK/n+IGgM8gVWQvRvJTBapO9Qxz8+SDlrpVjtOZV
         uRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CYN2dRDl8Mu6ggUT6uoWQ/TjgWwrw8zHuMNuAC17afQ=;
        b=fZGp5SGArhuGa6Ck41PVzDWhNGH5aHBAMJvmHoqctv1ePclQnMeTeviSjk8sCqr/Zj
         5215l+Yve5U+JO/2F1EtDBwCP1xGtXz2ZJ6PASv/jhBnYc4uusShQ/xOjmcqbbQUEMJK
         6SIl7D1l8MmyBknpwBvI0H45HlxAgpwcqyzX/6+xG7wHM2+fA1b40A8lf4/3gTLgL1Sx
         5GIT3h2cPIPNDKY0ycIvoBHiMxK+DWo5/CIYbUHV7YK+NHKuJxikUutG83yca/1TpRiH
         dj8+30T5JFZbGwNbwg4j98p7jVdS+0CD+Y2tf/B7limkfcD5KUkAl2CPUXazIWy9HNMX
         aDgA==
X-Gm-Message-State: AOUpUlEf5XogGwMsdkF0Ns1EqqS9/OHVLV7W/nAUIYyc6326Zy9jgzhe
        F6KGX+1dAWm7sSusLbBBcJU=
X-Google-Smtp-Source: AAOMgpcPxFZ8UUHe5x/eipJgBcNfmi72dDflly04eybxMRhIKqOrHpufs0EcfJne40T6bS5xSd9edA==
X-Received: by 2002:a17:902:3281:: with SMTP id z1-v6mr18062926plb.226.1531768765496;
        Mon, 16 Jul 2018 12:19:25 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h190-v6sm67804331pge.85.2018.07.16.12.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 12:19:24 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:19:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716191923.GC11513@aiede.svl.corp.google.com>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716191505.857-1-newren@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> The basic problem here, at least for us, is that gc has enough
> information to know it could expunge some objects, but because of how
> it is structured in terms of several substeps (reflog expiration,
> repack, prune), the information is lost between the steps and it
> instead writes them out as unreachable objects.  If we could prune (or
> avoid exploding) loose objects that are only reachable from reflog
> entries that we are expiring, then the problem goes away for us.

My understanding is that exploding the objects is intentional behavior,
to avoid a race where objects are newly referenced while they are being
pruned.

I am not a fan of that behavior.  It's still racy.  But when we've
brought it up in the past, the consensus seems to have been that it's
better than nothing.  Documentation/technical/hash-function-transition.txt
section "Loose objects and unreachable objects" describes a way to
eliminate the race.

Thanks and hope that helps,
Jonathan
