Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAF8E1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 18:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753823AbeBEStx (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:49:53 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54886 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbeBESs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id i186so28040659wmi.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/Qua91P1dDkTnAOrp+dc4CNib2e1ztzfsahuxZX2LdI=;
        b=e3HmN3arF7PeqEfaRCpLCoSuKn8zu9Zf3yOEJR7jwhoz8MQhgGrpqvCCzC/uQbUZze
         taq5Q8ln7aLzq8qHYSnxrShzaZDq3mJXNIx+OfEebISQGuoLD+SFv1V9bIanxD8LhkPi
         sxo81HC3rEchgmouSj6Oj1+huSPfi2D7i8UMWVc8+xeN2aDxOhadGyipzAGff4VTqxkU
         ON9n1B+JJACF0gc14ZGIgKeAFgDc5z90p+U814vzB5WQk/HcNu+3P/sWLFK6UGl28R5s
         OELCXlVGieQBpiSh74JYsYWZ0Am5NXQH+lLdZPqZDAPo7Pt/h6rPNaa/qhub1MsGl1ox
         WmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/Qua91P1dDkTnAOrp+dc4CNib2e1ztzfsahuxZX2LdI=;
        b=qbCxi9kMeMZ/FkJcA/NAA+lUr+d9dJVPw29/o/0RBj15Mh73tx5mHaWrgxPmAFn4eY
         mwgTE8UO6pKxMAmw2i6ThHYOfTox5fEefY+r257N343DwFRBqa/2dGUvRT/yvvb8sMlI
         IumHTpnUgs78f7kUhAbAZkLiy7UdeZ5dD7Z3/DfNC9JYkXtLJ1h+Q4j1jXqkXFw6xesm
         dun3xOnJMY9c00dTeEbJaOYNU5ss3HsH54WciQBnApMLEX4T0rUZk/TtIWSVWpP6h/9q
         U2cmbHWcJp6iZZsOp+no9zShOMmY4+rMAgloVHEdRzk1DTR/r0TMV+kwFc2ItxBcEQ1m
         ogiw==
X-Gm-Message-State: APf1xPAFUAN7qKtRdNWbFTrm1brZe2fLPzViWL9omoiHMXzi3Tc12K+e
        FI0JHccthRijDGGgloTmY9I=
X-Google-Smtp-Source: AH8x224CAYb8Jn1gr5D9msO96oUxuSXEteZXOwJPBEvLC0Fkj7EdjJrjjTYWG2CXHLzDVW2fct9o6w==
X-Received: by 10.28.198.132 with SMTP id w126mr223286wmf.37.1517856534733;
        Mon, 05 Feb 2018 10:48:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o11sm4706905wra.28.2018.02.05.10.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 10:48:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>, szeder.dev@gmail.com
Subject: Re: [PATCH v2 05/14] commit-graph: implement git-commit-graph --write
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1517348383-112294-6-git-send-email-dstolee@microsoft.com>
        <20180201153349.c94fe3de6b632e2fd8f843cf@google.com>
        <CAGZ79kb8kHAb6HYrxY_oMq5v3p1+AHX_ad40nwUEwiDKe=i+Ng@mail.gmail.com>
        <xmqq607fc8j8.fsf@gitster-ct.c.googlers.com>
        <25571438-bdb1-81ce-ac5e-18dd0b6292d5@gmail.com>
        <20180203092806.GA25927@sigill.intra.peff.net>
Date:   Mon, 05 Feb 2018 10:48:53 -0800
In-Reply-To: <20180203092806.GA25927@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 3 Feb 2018 04:28:07 -0500")
Message-ID: <xmqqd11jb7ca.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The big advantage of your scheme is that you can update the graph index
> without repacking. The traditional advice has been that you should
> always do a full repack during a gc (since it gives the most delta
> opportunities). So metadata like reachability bitmaps were happy to tied
> to packs, since you're repacking anyway during a gc. But my
> understanding is that this doesn't really fly with the Windows
> repository, where it's simply so big that you never obtain a single
> pack, and just pass around slices of history in pack format.
>
> So I think I'm OK with the direction here of keeping metadata caches
> separate from the pack storage.

OK.  I guess that the topology information surviving repacking is a
reason good enough to keep this separate from pack files, and I
agree with your "If they're not tied to packs,..." below, too.

Thanks.

> If they're not tied to packs, then I think having a separate builtin
> like this is the best approach. It gives you a plumbing command to
> experiment with, and it can easily be called from git-gc.
>
> -Peff
