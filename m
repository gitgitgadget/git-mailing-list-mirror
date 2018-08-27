Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF5D21F404
	for <e@80x24.org>; Mon, 27 Aug 2018 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeH0VUn (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 17:20:43 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:39132 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0VUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 17:20:42 -0400
Received: by mail-wm0-f44.google.com with SMTP id q8-v6so9047077wmq.4
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z77bEZaYxCrazykRiYB7W+p+D7wfx8ema/7kVROzido=;
        b=jKEJyjhvlymsFpZfjrAZvZESjWMevWhZuzARXjihhZ2Cw4LpQZ1PF8dFTZb/vyFuJK
         hZHCIBBIxpa4AiWI+bk0E3J6q1No+uiRqS4rtZRZbxms7tuvr3JChtLrVidFTCEcd+QO
         DXCtLZaQ+q2T5lTjTn61q6Tc7XZZ7FmSHDfGGaOQ4Cg26dfCXq7HZJyCa/KdICxiuZ0a
         bZ5w7LG+m2cNImOzV2QPu7b1mg2BXv/gsBLq9h6Zk+jabKu5vCUyfBmftzwivaElW+Oq
         GvRhFYzLiDgMK4o4SZ88oHtCopI1Q7Xsio1Fcsx4HqzK81iX34neekdJs19RAuma0NXY
         5EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z77bEZaYxCrazykRiYB7W+p+D7wfx8ema/7kVROzido=;
        b=LliAeLFh8M8n9RUtL5cf4Uek8mFejS5Cyehf1f5HTIaWMLXpqYxC6aeSfiSgV/wQ2L
         E9AiGzZrz8YQBDkDm9QrdSFE+kKYTFWUo/+9mtAv+jubUh6VkYckqES51xqdNPjqhEHj
         junMIwYhoOPTEU+nHlEkSW26ZHuG613plKxsEYO29iTwZpuJCJbWZLgbCvDTl4sWrUy2
         bpVu+/8awZDFHybzttTBXx18qquDDK1Gtzes6MgJKek3wLAK+a1vKp6OkCFBtNpWsaKW
         3SbCPPFAxQvyOhz8IROtt70omaaBVz9YD6c/YFPvxxdTWVoeHjOqshYKKG5k9u5ZAsmd
         yaeA==
X-Gm-Message-State: APzg51AcSa7Q3aJBcwCpkUL+1FmiFDHfrH9+kIYORfb94bP/NoD5VatN
        qvZC8Vfl3ygiuLwAFYc78DY=
X-Google-Smtp-Source: ANB0VdZUis/51dlKfhDe9DKlyVr3hMkuNBjyZsVNzHYmSNy+nqaH8HDFFSr9X7dQADyEGJf8YQSVlg==
X-Received: by 2002:a1c:2ed4:: with SMTP id u203-v6mr3131759wmu.19.1535391189818;
        Mon, 27 Aug 2018 10:33:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l16-v6sm8004668wmc.38.2018.08.27.10.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 10:33:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
References: <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180805172037.12530-1-t.gummerer@gmail.com>
        <20180805172037.12530-11-t.gummerer@gmail.com>
        <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
        <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
        <20180822203451.GG13316@hank.intra.tgummerer.com>
        <xmqq4lfmm7pb.fsf@gitster-ct.c.googlers.com>
        <20180824215619.GH13316@hank.intra.tgummerer.com>
Date:   Mon, 27 Aug 2018 10:33:08 -0700
In-Reply-To: <20180824215619.GH13316@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Fri, 24 Aug 2018 22:56:19 +0100")
Message-ID: <xmqqk1oblnor.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Agreed.  I think it may be solvable if we'd actually get the
> information about what belongs to which side from the merge algorithm
> directly.

The merge machinery may (eh, rather, "does") know, but we do not
have a way to express that in the working tree file that becomes the
input to the rerere algorithm, without making backward-incompatible
changes to the output format.

In a sense, that is already a solved problem, even though the
solution was done a bit differently ;-) If the end users need to
commit a half-resolved result with conflict markers (perhaps they
want to share it among themselves and work on resolving further),
what they can do is to also say that these are now part of contents,
not conflict markers, with conflict-marker-size attribute.  Perhaps
they prepare such a half-resolved result with unusual value of the
attribute, so that later merge of these with standard conflict
marker size will not get confused.

That reminds me of another thing.  I've been running with these in
my $GIT_DIR/info/attributes file for the past few years.  Perhaps we
should add them to Documentation/.gitattributes and t/.gitattributes
so that project participants would all benefit?

Documentation/git-merge.txt	conflict-marker-size=32
Documentation/user-manual.txt	conflict-marker-size=32
t/t????-*.sh			conflict-marker-size=32
