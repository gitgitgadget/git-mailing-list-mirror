Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D9B2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 15:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbdCUPuA (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 11:50:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57968 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932794AbdCUPsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 11:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 716F76C8BD;
        Tue, 21 Mar 2017 11:48:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GO5sWHGFobcMFBHFpajXIotSLts=; b=wZiTF1
        GMulsQxLdCuW8MShTkTTpDXC2lNLS01xxDPNfup/yzonjcEGdKAVWG1szGux5IH/
        Mid5xajQC0JUPigNNK520KxfLDumO53NT+dSK19eXyYJSoNA0MYW1v74Bw4Yj1T+
        57Lzv5I13UebWA8qa7nM82I2bU/qDfhXV/R3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T2lUY/9ic3FO+IqA6x8Mk+dThBZAlDPC
        zdkJ7RtJAk/0+uYQoklvSD/wUOjJjS7+UjtiXdMjcfaq9emZTzG+OgFbMCq3ROMf
        sGv8aYDUgSjXtkvKw7eDRCaKUnOVJQjUbvax7JtvbSApqIC0jStCAhCkTqiym058
        gsg4uXK9zSQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68C436C8BC;
        Tue, 21 Mar 2017 11:48:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D23586C850;
        Tue, 21 Mar 2017 11:48:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on the file system
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
        <20170317225110.13417-1-sbeller@google.com>
        <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
        <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com>
        <20170320185038.GU26789@aiede.mtv.corp.google.com>
        <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
Date:   Tue, 21 Mar 2017 08:48:32 -0700
In-Reply-To: <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 21 Mar 2017 17:37:08 +0700")
Message-ID: <xmqqvar2ska7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6E5D754-0E4D-11E7-AC9E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Mar 21, 2017 at 1:50 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Junio C Hamano wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>
>>>> While it may be true that you can have bare worktrees; I would question
>>>> why anyone wants to do this, as the only thing it provides is an
>>>> additional HEAD (plus its reflog).
>>>
>>> A more plausible situation is you start with a bare one as the
>>> primary and used to make local clones to do your work in the world
>>> before "git worktree".  It would be a natural extension to your
>>> workflow to instead create worktrees of of that bare one as the
>>> primary worktree with secondaries with working trees.
>>
>> For what it's worth, this conversation makes me think it was a mistake
>> to call this construct a worktree.
>
> For the record, I am totally confused with Junio's last line, with two
> "with"s, "worktree" and "working trees" in the same phrase :D

In case this wasn't just a tangential note, what I meant was:

 - In the old world, you may have had a single bare repository and
   then made clones, each of which has a working tree (i.e. non-bare
   clones), and worked inside these clones.

 - In the "git worktree" world, you can start from that same single
   bare repository, but instead of cloning it, use "git worktree" to
   create "worktree"s, each of which has a working tree, and work
   inside these "worktree"s.

and the latter would be a natural extension to the workflow the
former wanted to use.

>> It's fine for the command to have one name and the documentation to
>> use a longer, clearer name to explain it.  What should that longer,
>> clearer name be?
>
> No comments from me. I'll let you know that if Eric (or Junio?) didn't
> stop me, we would have had $GIT_DIR/repos now instead of
> $GIT_DIR/worktrees, just some extra confusion toppings.

I forgot about that part of the history, but you are saying you
wanted to call these "repos", not "worktrees"?  I can see why
somebody (or me?) would stop that by fearing "repo" is a bit too
confusing with a "repository", in the same way that we are now
realizing that "worktree" is too similar to an old synonym we used
to call "working tree".

