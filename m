Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B92EC43217
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 13:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242534AbiBGNrp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 08:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449010AbiBGNPY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 08:15:24 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670EC043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 05:15:23 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id o25so10788018qkj.7
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 05:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/6AvKfskNZlRMcbY/UbBcNvJ8miG820+ADNojowhYUQ=;
        b=ANW0WNGacTzQwlb63pC+wbt0yibkSUW3TPGDe+8hB57tqSLPYhtXVQYQg2FkV0G5wu
         zBR4SnQb7GkqyTCj+ELoc6EWaxbmEisMPzPIsKLbuhS/PoZJG7zq6CY0kQdsX+FjHpTM
         +Fb/l8Okrck6hEQWYRhs8mt5YigHb3PeqxpPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/6AvKfskNZlRMcbY/UbBcNvJ8miG820+ADNojowhYUQ=;
        b=BcPL76qubecYke3lkSUU+PmYM2hsZVpaMky35CNYnvDgRfY13RV6+fwoRiLjzXVG7H
         6s/CWqebdSs/LSSd0xhK48y74EDtGORKzU9TwIxn/xj6TbAe3qM/ivnKTVSIzRdGqXVH
         HZEZCu22VchSYgCiY2Zrp0XruowpZ1EXyEKrVMZeTWC4VpXm+Dhg+G0rwCO29JzVVRim
         /Dmy3Ue7gl+JClFNiF50S8bdGvw6srIQLRlRMl49VTnn+OLdiv4y20k7XHPc2AjfWXNB
         AGyernwFy6cP/R9T4uQbRDsLUiRp7k/fcslJrzm5aQI7e8j7wY/ex0bF1h41QgqkC48/
         hFiQ==
X-Gm-Message-State: AOAM533uvsFStrsp8UqnAquYgRGwsNmYXB5t+maHP+3pnJH6+i3jDDvq
        CiE8lk/KAL+kuAVXfKmhznEsMw==
X-Google-Smtp-Source: ABdhPJz/8HTCk06Sh0Oy6rOVRS+8Mmae1SoAYmc8gsH67LYzkq0hihZTeA0kdOop2fUAMrtLnc6+Vg==
X-Received: by 2002:a05:620a:404e:: with SMTP id i14mr6180239qko.297.1644239722562;
        Mon, 07 Feb 2022 05:15:22 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id p9sm5979366qtw.43.2022.02.07.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:15:22 -0800 (PST)
Date:   Mon, 7 Feb 2022 08:15:20 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Gamblin, Todd" <gamblin2@llnl.gov>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Commit SHA1 == SHA1 checksum?
Message-ID: <20220207131520.cqkdtmceddqquwlg@meerkat.local>
References: <ED97E252-CABA-41BB-B18C-819A5EF305E3@llnl.gov>
 <121ce485-bea8-3168-aa35-d11eb13022da@iee.email>
 <xmqq1r0gjo6h.fsf@gitster.g>
 <eca83634-ee91-89bd-567e-6b0807b5ff79@iee.email>
 <xmqqee4fix0l.fsf@gitster.g>
 <13f21a57-1519-5ace-30e8-def598fad38b@iee.email>
 <734DE4FA-E4B1-43CB-89EE-3C200FA21F4F@llnl.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <734DE4FA-E4B1-43CB-89EE-3C200FA21F4F@llnl.gov>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 07, 2022 at 08:15:58AM +0000, Gamblin, Todd wrote:
> In our case, the initial trust doesn’t come from a PGP signature — it comes
> (at least for now) from having cloned the package repository from GitHub.

Not really the case, if you're relying on a particular commit hash, as you
state. Once you specify a target hash, you don't really have to care where the
repository came from -- the hash is either going to be there and be valid, or
it's not going to be there.

It only matters where the person who picked that hash cloned the repository
from and what steps they made to verify that it is a legitimate commit. If "I
cloned this repository from github" is sufficient for your needs, then that's
fine. The alternative is to use PGP verification, but in either case once you
pick a hash to use, you can rely on git to do all the rest.

> That said, I guess I do still have one more question — how soon will git
> notice that a given repo is corrupted/tampered with (insofar as sha1 can do
> that)?  On checkout?

Yes. I've asked this question before as well:
https://lore.kernel.org/git/20190829141010.GD1797@sigill.intra.peff.net/

The relevant bit:

    Then yes, there is no need to fsck. When the objects were received on
    the server side (by push) and then again when you got them from the
    server (by clone), their sha1s were recomputed from scratch, not
    trusting the sender at all in either case.

-K
