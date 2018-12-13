Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DBE20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 03:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeLMDJn (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 22:09:43 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39491 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeLMDJn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 22:09:43 -0500
Received: by mail-wr1-f43.google.com with SMTP id t27so446642wra.6
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lvpgblCiz0/JPv90Zf/8rvVCB9YSfrYyOJsoo/wSzQc=;
        b=gIs85Pd7LN/fcPATV3n9aRkaRzmdoXqoBNjNOyx0P6fk71Qry+2i+ll0MFI8kcOM62
         k1PDPO1UTly0I+WYfWWLRreBxdtRiDek7Nu8z7lY0ZBE+DSl0KzeLCS32RHxLUlXm5xp
         1f/qhFJoTL/MOdBjYvH+9RBu2EgDb7R9hNZmykxwRjDwNTjZWzugkAyzDAs9m74SLmYF
         nthIT9RueWB1lgEC7ad3n3fuU1ORiNUBjLzSgeUblXI+5SC4RAZpNwVXEv1dtwoSi6N2
         uPVEY33/HxTxrADsc0w9hCaxCK+jX2/huNF0iGvZPhJUOd6M3jNqhPAq0fpveDH36LI2
         /pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lvpgblCiz0/JPv90Zf/8rvVCB9YSfrYyOJsoo/wSzQc=;
        b=K+ln/JlGorP3R584e/B+jx969I+eSuRU+p/uj+E1+ld/KlrlZjNnoDg/UqCApVgDq+
         /445LlOzg0k10gH5uscexliDjUjkffPGh8nYXb29OJcrcKy2esZDx/eiW+Q/TNmNknBu
         Cv0N9MIbCt9gw0PLWf83ugfsJ+/ovv02fcqcp4Cz/SxK2XalKUf4cEtMO8UUnGQ5bhaJ
         F25hyjWi8ZwFAvZjTy2KFymstIKkCnw/7gGqf5djBcU1kAm7tefAOw4O9eCkISCuQCwL
         AYHQ56J+d8QPU+PSZFaOH1wcjrDDVOA1tYU8yT+p9T/cesSKXcGeszSYfcSYuoQ5tZbz
         dpSw==
X-Gm-Message-State: AA+aEWZhGsC4JOBM7IPtWsjeCXkHvYBsWGwVc29Fq3rsx/SGF0If+J2P
        FIClTS+CBX7YNE9PiE3ZLfIOhkJwonU=
X-Google-Smtp-Source: AFSGD/V9liwP/xbo9oc8CIVqhL3VH0DpKP9V1fvLmdcl3M757JaNiVpae4XPhFW3r6z4tmhL2Xxtqw==
X-Received: by 2002:adf:b502:: with SMTP id a2mr15364862wrd.54.1544670580179;
        Wed, 12 Dec 2018 19:09:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h131sm771583wmd.17.2018.12.12.19.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:09:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks and other cross-references
References: <20181211234909.2855638-1-tj@kernel.org>
        <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
        <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
        <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Dec 2018 12:09:39 +0900
In-Reply-To: <xmqqefamgmey.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Dec 2018 12:01:25 +0900")
Message-ID: <xmqqa7lagm18.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> As long as we can keep the reverse rference notes consistent, wouldn't
>> amend propagation just consume them?
>
> Yes.  Would that mean you do not need the notes/xref-* series we are
> seeing here, and instead (re)use what Stefan's series, which already
> needs to have access to and record the information anyway, records?

Just to avoid confusion or unnecessary guessing.

Please do not take the above as "don't do notes/xref-; instead read
from the 'meta commits'".  I do not have a preference between the
two proposed implementations.  The important thing is that we won't
end up with having to maintain two separate mechanisms that want to
keep track of essentially the same class of information.  FWIW I'd
be perfectly fine if the unification goes the other way, as long as
goals of both parties are met, and for that, I'd like to see you two
work together, or at least be aware of what each other is doing and
see if cross-pollination would result in a mutually better solution.

Thanks
