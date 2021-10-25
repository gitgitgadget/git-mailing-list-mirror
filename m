Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E3EC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6C160527
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238566AbhJYUQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:16:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:32813 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236509AbhJYUP7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Oct 2021 16:15:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id DCA8F5C02E2;
        Mon, 25 Oct 2021 16:13:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Oct 2021 16:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=aP0TuHg7wIjn0oIZ7zWw274tlFX
        h8zoNuKTd6TH23gs=; b=eoblY+N6Y9Ztv3cDUjb3XvMN/n9jTzveHrSfJY1BRmh
        xgOJspvgFKOU86VlfifSu4ouVeisemmiRZ94uVroHKIOCe3QaOyoxL1frXOE2/gZ
        PQ1ioyHkJhHtcZHbtk6FmNhaXVi+mjjO5SDoPQlk1kHSJUJPIrDG4f5hW+4a3i74
        aoqTqUQV/37MOROoev9AXSGlRUWBbnLCp/UUnVpKc2vJe8p8lsm3aFgIOYJl/aM1
        vWHkQoyz61eZ807QO13f+lTNWX+SM4OZCAbs3He0YfFd4Oj/p2UgtSvuJ35JBfaB
        Tc7E6/9YJNKYrPKMqPhuidwvYD9WuPvGJ5r36soS1Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aP0TuH
        g7wIjn0oIZ7zWw274tlFXh8zoNuKTd6TH23gs=; b=bHKp41yDWOCUAFxYy9c/tf
        pwYSYwLirEf7VCZ6X0bAcEZak3vm/OpelebxnQlBJ9J05+mbt4uZvuKsASFuCplC
        YFqjQIn36EIMZ/PYOshnH9IEU+RrKgTMR0GwMbo2iugt4G81tER4izUwSMOugkET
        ecT8AecudK9e+FGDR4ATluqLJIj3nQkD1YNv6aNWYjdgiX0pLlpHcUVVh5Ihv6Bq
        MO2NF/m80Igko8R93AneeM5DmDyz757lpRi38sTxYBRVwFQZXUySKoXlj+yvtbDA
        rt6ww33iF4L0IvNY2Et+4GHbATYnHWPTPB6KCy1YLzysTAqoQncNRZetisPDbeng
        ==
X-ME-Sender: <xms:8A93YeaX26xt--wqsht2E_LRQfTxoOmikRf4iPZ8oFT6RWVyQZeaCw>
    <xme:8A93YRZt9qf2bKXlgE1IP8sbw48l6xWbypwhhFH9AlKGQKeQym61v_Nhupia-EobJ
    mbCUdz6Y0c2mg2tBA>
X-ME-Received: <xmr:8A93YY-OloWkCPRW2MHBSFKgk8l5jDe7iexGZJyifeEF6rLWVotNxe_UqvG5mPr1BtAEWr0N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdefhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghrnhgr
    nhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtth
    gvrhhnpedvjeeifeelhfetiefhhfdthfefkefhhfeutdetvdfgvefgveefheffgfekjeef
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:8A93YQqZ5tczRLo9SY-cuy_S0H3aNqJInju5gql3atKKdFwv0quFdQ>
    <xmx:8A93YZrpKRiHY9pE23DCgua5IYFLSSuUW9QZrG2Pd5zj1DMVLMtX3w>
    <xmx:8A93YeRul1hSOA2RA7ThBTcWqsJqCsJnrO1Mmm1S1pLSHeVFj-d-RQ>
    <xmx:8A93Yano7zQ784HUBxlgP_b5AL-KuFJJA9WAstPFcCLZ-1XDA0revw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Oct 2021 16:13:34 -0400 (EDT)
Date:   Mon, 25 Oct 2021 22:13:30 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [RFC PATCH] mergetools/vimdiff: add vimdiff4 merge tool variant
Message-ID: <YXcP6kf3tGr+WFRS@zacax395.localdomain>
References: <20211019212020.25385-1-greenfoo@u92.eu>
 <CAJDDKr5frTgh4_x5yvskJfppew3ntvpgBe9MnUB9CfGQaw1TLQ@mail.gmail.com>
 <xmqqk0i10xzt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0i10xzt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks David and Juno for your feedback.

I completely agree that adding another vimdiffX variant is ... not elegant.

So I've been thinking a bit more about how this whole "vim layout" mechanism can
be made more generic and this is what I came up with:

  1. Let's add a new configuration variable to the "vimdiff" merge tool called
     "layout":

         [mergetool "vimdiff"]
         layout = ...

  2. If this new variable is *not* present, vim will behave in the same way it
     does today (ie. a top row with the local, base and remote buffers, and a
     bottom row with the merged buffer).

  3. In all other cases, the contents of the "layout" variable will be
     intepreted following these rules:

       - ";" is used to separate "tab descriptors"
       - "," is used to separate "row descriptors"
       - "|" is used to separate "column descriptors"
       - "+" is used to load buffers that won't be displayed by default

     This will be better understood with some examples that emulate the behavior
     of the current "vimdiff", "vimdiff1", "vimdiff2" and "vimdiff3" variants as
     well as the proposed "vimdiff4" one:


       vimdiff  --> layout = "LOCAL | BASE | REMOTE, MERGED"

           ------------------------------------------
           |             |           |              |
           |   LOCAL     |   BASE    |   REMOTE     |
           |             |           |              |
           ------------------------------------------
           |                                        |
           |                MERGED                  |
           |                                        |
           ------------------------------------------


       vimdiff1 --> layout = "LOCAL* | REMOTE"

           ------------------------------------------
           |                   |                    |
           |                   |                    |
           |                   |                    |
           |     LOCAL         |    REMOTE          |
           |                   |                    |
           |                   |                    |
           |                   |                    |
           ------------------------------------------

           NOTE: In this case (where there is no "MERGED"
           buffer specified in the "layout" string), a "*"
           is needed to indicate which file will be the one
           containing the final version of the file after
           resolving conflicts.


       vimdiff2 --> layout = "LOCAL | MERGED | REMOTE"

           ------------------------------------------
           |             |           |              |
           |             |           |              |
           |             |           |              |
           |   LOCAL     |   BASE    |   REMOTE     |
           |             |           |              |
           |             |           |              |
           |             |           |              |
           |             |           |              |
           ------------------------------------------


       vimdiff3 --> layout = "LOCAL + REMOTE + BASE + MERGED"

           ------------------------------------------
           |                                        |
           |                                        |
           |                                        |
           |               MERGED                   |
           |                                        |
           |                                        |
           |                                        |
           ------------------------------------------

           NOTE: LOCAL, REMOTE and BASE are loaded as hidden
           buffers and you need to recall them explicitely.


       vimdiff4 --> layout = "BASE | LOCAL | REMOTE, MERGED; BASE | LOCAL; BASE | REMOTE"
 
           ------------------------------------------
           | <TAB #1> |  TAB #2  |  TAB #3  |       |
           ------------------------------------------
           |             |           |              |
           |   LOCAL     |   BASE    |   REMOTE     |
           |             |           |              |
           ------------------------------------------
           |                                        |
           |                MERGED                  |
           |                                        |
           ------------------------------------------

           ------------------------------------------
           |  TAB #1  | <TAB #2> |  TAB #3  |       |
           ------------------------------------------
           |                   |                    |
           |                   |                    |
           |                   |                    |
           |     BASE          |    LOCAL           |
           |                   |                    |
           |                   |                    |
           |                   |                    |
           ------------------------------------------

           ------------------------------------------
           |  TAB #1  |  TAB #2  | <TAB #3> |       |
           ------------------------------------------
           |                   |                    |
           |                   |                    |
           |                   |                    |
           |     BASE          |    REMOTE          |
           |                   |                    |
           |                   |                    |
           |                   |                    |
           ------------------------------------------


The nice thing about this approach is that, as we have seen, it is generic
enough to rule all current variants obsolete.

So, please let me know what you think about this:

  * Do you like this approach? Or am I trying to crack a nut with a sledgehammer
    by making the whole thing too complex?

  * In case you like it, should we keep the old "vimdiff1", "vimdiff2" and
    "vimdiff3" variants for backwards compatibility?
    If the answer is "yes", I'll just alias them to the new "layout" mechanism
    so that the amount of extra code needed for supporting them is minimal.

If you tell me you like this proposal, I'll go ahead and implement a patch for
all of this, taking into consideration David's suggestions for avoiding problems
with file with spaces in their names and also adding new documentation for all
of this.

    NOTE: The only non-trivial thing about implementing this is how to parse the
    "layout" variable syntax *in bash* to convert it into a sequence of vim
    commands that achieves the expected outcome... but seems like a funny
    weekend project :)

If you think it is not worth the effort, let me know if it is OK to just add
"vimdiff4" + documentation instead for now (or something else).

Thanks.
   

