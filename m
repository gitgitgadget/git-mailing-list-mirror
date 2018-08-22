Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D4FC1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeHVTcH (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:32:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeHVTcH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:32:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so2044894wre.10
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=D0j4BUl9zZo742Z564XDtMRcDQRJiDEpI4hDvoFGJRE=;
        b=GwXp3SnxenOdtuSH/CQ5KsUtzByDNVLt0jPAseDL15NTLsY8raWqZnrPMR+XBr8FKD
         0DOCQrsaiYrCvAEuqZSdw3xh6m9+kAzThhY0g42jz77tEZCbqvWpVfIVrxsDwQuqfNx7
         21YnTPComNcnpnzEI1A5cKcr+mwkxGTkyMhmS80tjptU5R/EHdrk6B5WZJpzkqdAByK5
         TgUiCqn97fS6SxnLUOMf717Z/2SbDM6D8CveXkLM23AcTKbZzkYr6Zus7HmCtMbUDtVD
         3YyIiXsUuXFIFBEfplHLhHFKtoPR0bUPHn0OSg5qQJjGyMb2x4zvNh+c8XF588U1kVjq
         kZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=D0j4BUl9zZo742Z564XDtMRcDQRJiDEpI4hDvoFGJRE=;
        b=qNGh87WhRS8vJIkiRovXIGxNv1PZG56n5CChqPud0hCJ/7GBvU++7Lb7v0HXKit89Y
         CJ1UqgfTBW6tE2vpF+Owr6ROpb2PW60ScjDZR5LON0IFJ2PjOXfbHCJHRtQk2kfx8PlM
         Z+hNjIHyzNGdtAYMLJyUWbt0lg86RKIuGHr/GLmgkIKDxcjn0uhw+CCi3TKJGFu+Q6er
         9gt83nrgH8b8uxAIaUCr/fginxZs23XKbzQRXk8O2QA362pVTdWdG2ciR6iTMWivsSQV
         t6pRBR7tbejhLPuJiW+7gdSFnTjBqcSj0amLREpgxzu7xukQ9PwPBQ1a5DCh5NQQG3yg
         4jZg==
X-Gm-Message-State: APzg51AfMywoajz10ARQS27EixQ4RKstWUgcDVz5Y/VE/SdXB7O8BQcp
        WBqPAa9GYl4YFdeKPWvM7Rg=
X-Google-Smtp-Source: ANB0Vdaj8oabvdOQx4YgvO61GkNRB5/hBZ2TssLFqoAu93BNQzgDSgLrOyCil+96ssc7L3yAPCsU4g==
X-Received: by 2002:adf:c38e:: with SMTP id p14-v6mr10569066wrf.68.1534953996981;
        Wed, 22 Aug 2018 09:06:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 204-v6sm2934457wmh.25.2018.08.22.09.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 09:06:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
References: <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180805172037.12530-1-t.gummerer@gmail.com>
        <20180805172037.12530-11-t.gummerer@gmail.com>
        <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
Date:   Wed, 22 Aug 2018 09:06:35 -0700
In-Reply-To: <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Aug
 2018 13:00:55
        +0200")
Message-ID: <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> But why not add this to the git-rerere manpage? These technical docs
> get way less exposure, and in this case we're not describing some
> interna implementation detail, which the technical docs are for, but
> something that's user-visible, let's put that in  the user-visiblee
> docs.

I actually consider that the documentation describes low-level
internal implementation detail, which the end users do not care nor
need to know in order to make use of "rerere".  How would it help
the end-users to know that the common ancestor portion of diff3
style conflict does not participate in conflict identification,
sides of conflicts sometimes get swapped for easier indexing of
conflicts, or conflict shapes are hashed via SHA-1 to determine
which subdirectory of $GIT_DIR/rr-cache/ to use to store it, etc.?

By the way, I just noticed that what the last section (i.e. nested
conflicts) says is completely bogus.  Nested conflicts are handled
by lengthening markers for conflict in inner-merge and paying
attention only to the outermost merge.  The only case where the
conflict markers can appear in the way depicted in the section is
when the contents from branches being merged had these conflict
marker looking strings from the beginning---that's "doctor it hurts
when I do this---don't do it then" situation.  The section may
describe correctly what the code happens to do when it gets thrown
such a garbage at, but I do not think it is a useful piece of
information about a designed behaviour.

