Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C20C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 16:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCHQ4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCHQ4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 11:56:31 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC5C4EB5
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 08:54:51 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3534832000D9;
        Wed,  8 Mar 2023 11:54:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 Mar 2023 11:54:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sebyte.me; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678294481; x=1678380881; bh=Wq
        hX4vCxvzSBoJZ7HGRZf9F1Tl7NlvsZrV5WByZGhng=; b=2LRkvp7YiMSdwEIWZB
        m7H84BgEy8izkVwq4khYF/YiQ4oowgGpQpLzHm1tuCOAcTXCxN2wQSgDnhpWuK/B
        WN5cp6Mhjzgx4l/7xBRlj1ndfN5aXn6NUEXr+3RGQ9CaPjhSpxAThMmI4qqa4mXx
        9Eu5CUIN9l/pQPJQslak0moJczutsB05KL1Ondk0aLobjw05Tk60beYNBK24TgbL
        33G21RDWxRl2PoNVqEhlhC55jT+6iUN7rH+dRTp2CoGRFfj0I0EW3VR15i3T0iIZ
        zRP3ozoyz6KWGNo/Oidqyv7krmzbRD1XZocatfJMeG2Ndf1HWCy5tp5aoL+QbKN9
        1/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678294481; x=1678380881; bh=WqhX4vCxvzSBo
        JZ7HGRZf9F1Tl7NlvsZrV5WByZGhng=; b=iDUC4fOzrlvaZ8V9+Kpc4RBW/lrjr
        TcaAoplahRbh0Uw9XMCXCe0GqU6Iuz8CO4/QCwqtnMz7GYJyJfmv8TzS21rms0dp
        +u7Wd1RvfaSDkfns0gatTFek5IuWHeQ7fUdlnkYl9mS/emwYf9GE1sCCQw+PEPu1
        Uf7d0WH7NaBDcpj8jDCWo6s7O2IUmHXVCI3MMbltVQIxVtaLZ7PlDeunL6TwR7LI
        nn5zKu/jWJMq5aQAiEbyMDVAmZ2kM6jwTcDPi+POY0pQu5lMGcxmriB8N1dcI1ZO
        AtDNgHD0ErMXKEJFFTBhr7QEJmjswDdUtmkZhsirw9I1/XNhT3orkB3QA==
X-ME-Sender: <xms:0b0IZH0IgbQcMSl4X3HbGA-1Qy1w64-tAOXEfxqeB8zTlNfMZvM7Ng>
    <xme:0b0IZGEHw0m2cVFUbNlcKD_DWn7gxl-PRwV2U598PAZwIhOarCU_9dp6Lfa-NTyO1
    -CM5hIGG21EK471bQ>
X-ME-Received: <xmr:0b0IZH6id4P0zJmChIo84JTsRXHZJus8E3rCETvfVLlsrX0w14Ju0w5jjt2sNkZhJaCpk0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufhfffgjkfgfgggtsehttd
    ertddtredtnecuhfhrohhmpefuvggsrghsthhirghnucfvvghnnhgrnhhtuceoshguthes
    shgvsgihthgvrdhmvgeqnecuggftrfgrthhtvghrnhepveeuiefggeejtedugeegtddutd
    ffhfeiueehudekveekkeffgfeugeeugfeijeegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshgvsgihthgvodhrvghtuhhrnhdqphgrthhhse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:0b0IZM3P-MpNZRyILfG6qEFC10bw0jeK_D5c7CXzyB-caVQsToQsnA>
    <xmx:0b0IZKFs4okN3-BzPaznU5ZSZZHjJTu8Fr6n0wpQQGiDdfxf-ZUXLg>
    <xmx:0b0IZN-CU2ackSW13tDwDLeRGZy0UoaA3ie8IMVUmVWDQGeqbzCpng>
    <xmx:0b0IZFNR2yajIkJr_hk5_H8Hh1h8wUvdjISULF6VSp2-8suCI25bkw>
Feedback-ID: i9e78401f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Mar 2023 11:54:41 -0500 (EST)
Received: from sebyte by balor with local (Exim 4.94.2)
        (envelope-from <sebyte@balor.gnukahvesi.net>)
        id 1pZx3n-001Iim-GN; Wed, 08 Mar 2023 16:54:39 +0000
From:   Sebastian Tennant <sdt@sebyte.me>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
References: <87ilfgemkb.fsf@sebyte.me>
        <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net>
Date:   Wed, 08 Mar 2023 16:54:39 +0000
In-Reply-To: <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 6 Mar 2023 03:08:50 -0500")
Message-ID: <87fsaf9oa8.fsf@sebyte.me>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jeff,

Thanks for your explanation.  It's been really helpful.

Quoth Jeff King <peff@peff.net>
on Mon, 6 Mar 2023 03:08:50 -0500:
> On Sat, Mar 04, 2023 at 12:19:16PM +0000, Sebastian Tennant wrote:
>
>>  Augmented mirror:
>>
>>    $ git clone --mirror <upstream> upstream
>>    $ cd upstream
>>    $ git remote update  # regular cron job
>
> The problem here is that your refspec for "origin" in the mirror
> will be "+refs/*:refs/*". So it claims to have responsibility for
> the whole refs namespace. And because of the "+", it will happily
> overwrite local refs when fetching, including branches pushed up by
> the client. You noticed it most with "prune", because that deletes
> local branches not present in upstream repo. But a similar problem
> would happen if both a client and the upstream had a branch named
> "foo".

Understood.

>> I've tried running the augmented mirror as a plain bare repo, i.e.
>>
>>    $ git config --unset remote.origin.fetch
>>    $ git config --unset remote.origin.mirror
>>
>> but then the cron job (git remote update) is no longer sufficient in
>> making all upstream activity available downstream.
>
> Right. If you drop the fetch refspec entirely, then it will only fetch
> HEAD during your cron jobs, which is not what you want.

Precisely.

> You want a refspec that tells Git to fetch everything, but you need
> to divide up the "refs/" namespace into local stuff and mirrored
> stuff.
>
> You could use the normal "+refs/heads/*:refs/remotes/origin/*" refspec,
> but it's awkward for the clients to access "refs/remotes/" on the
> mirror.

Indeed.  To fetch a known ref, a client (also with the normal fetch
refspec) would have to do something like this, for example:

 $ git fetch origin\
       refs/remotes/origin/<ref>:refs/remotes/upstream/<ref>

Alternatively, they could add an additional fetch refspec to their
config:

[remote="origin"]
 ...
 fetch = +refs/heads/*:refs/remotes/origin/*             # normal
 fetch = +refs/remotes/origin/*:refs/remotes/upstream/*  # additional

This would have the advantage of fetching all the upstream refs on the
next update giving them a better idea of what's happening upstream.

Is my understanding more or less correct?

> So you probably want to keep the upstream branches in "refs/heads/",
> but mark a special part of the namespace. Like:
>
>   cd augmented-mirror
>   git config remote.origin.fetch '+refs/heads/*:refs/heads/upstream/*'
>
> And then "git fetch" will pull all of the remote branches into the
> "upstream/" namespace.

I see.  And creating the 'upstream' namespace under 'heads' (instead
of under 'remotes') is crucial, since any client (with a normal fetch
refspec) will then receive those refs automatically, i.e. without the
additional fetch refspec I've described above.

> And it's safe to prune, because it will only delete branches in
> refs/heads/upstream/ (and you may want to just "git fetch --prune"
> as you fetch via cron, which is a little more efficient than a
> separate "git remote prune").

Understood and noted.

> Clients can name their branches whatever they like, as long as they
> don't start with "upstream/", and that won't interfere with the
> mirror.

Got it.  Thanks again.

Sebastian
