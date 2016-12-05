Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 597341FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 23:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753234AbcLEXR1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 18:17:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59460 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752330AbcLEXRY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 18:17:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A973E564D2;
        Mon,  5 Dec 2016 18:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zev2cSg0lxpiX8tLj7V7GuTegX4=; b=jaJJMe
        tZAUEk0GMKuqdEOheDUnveWJuHJKixGmLEw52wUSvI1h50ttZPVSTUOPdxVt4DCx
        Jvi/zPDoTH8IvIF9L2u/3/YP4mRWDFi6v0+uWZENw3ZOFhCuExlkyDpparCTHonP
        /7Sl0yjPl+1TeyFFNtr5wF9Hl9ZzGvIO+IoYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D+uz+klWd1fdv0xISFx1nZCQc0LAY6QD
        8vnTKR+MyTr8GJF0R7fJDswGUBHjnff6XdTKmE+9x1NLF6qw7LuvIP+wgBxnvnOx
        epSZ7MLe1gxkPVsVhsDx8foePMwPHJKsH5IZJS/Tvjvl5vfjwFfwC2/lO5g3kUu3
        5LsbWyZJbrQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1697564D1;
        Mon,  5 Dec 2016 18:17:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F99D564D0;
        Mon,  5 Dec 2016 18:17:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCHv1 1/2] git-p4: support git-workspaces
References: <20161202224319.5385-1-luke@diamand.org>
        <20161202224319.5385-2-luke@diamand.org>
        <xmqq8tru3xom.fsf@gitster.mtv.corp.google.com>
        <CAE5ih78Y_AbfgtW_6zMKLC8NzBxCKSagrgrjtfWZVOEwaAg6ZA@mail.gmail.com>
        <xmqq4m2i3w8b.fsf@gitster.mtv.corp.google.com>
        <CAE5ih79efEu_2jgE9V-N7+UetyYu7RjH62whcfvMBtwM-Nb8Sg@mail.gmail.com>
Date:   Mon, 05 Dec 2016 15:17:20 -0800
In-Reply-To: <CAE5ih79efEu_2jgE9V-N7+UetyYu7RjH62whcfvMBtwM-Nb8Sg@mail.gmail.com>
        (Luke Diamand's message of "Mon, 5 Dec 2016 21:55:17 +0000")
Message-ID: <xmqqeg1m2cfz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F99C0F30-BB40-11E6-BE99-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

>> What I am trying to get at is if we want to use a single command
>> that can be given a path and answer "Yes, that is a repository"
>> here, and that single command should know how the repository should
>> look like.  I offhand do not know we already have such a command we
>> can use, e.g. "git rev-parse --is-git-dir $path", but if there isn't
>> perhaps we would want one, so that not just "git p4" but other
>> scripted Porcelains can make use of it?
>
> That would be nicer than random ad-hoc rules, certainly. I couldn't
> find any obvious combination that would work.

I've already sent an update but my reading of this code is that
there is no need for the program to be able to, given a random
directory path, ask isValidGitDir() "is this a Git repository?" at
all.  

What the program wanted to know, IIUC, is "Where is the 'Git
repository directory', if there is one?".  This is needed primarily
because the program wants to error out before doing any operation
that requires a Git repository to work on, when the answer is "there
is none".

It also wants to know it because (for whatever reason) it wants to
export it in GIT_DIR [*1*].

And isValidGitDir() is a helper function used by the handcrafted
logic in main() to answer that question, but as far as I can tell,
you'd get a more correct answer by asking "rev-parse --git-dir"
unconditionally (even when the user of the program exported GIT_DIR
to you).

I just was reading Lars's LFS changes, but that one has hardcoded
"Is there a '.git/lfs/objects/' directory directly inside the
current working directory?" and similar, which I do not think would
work well in a secondary working tree where ".git" is merely a file
[*2*].  In a "secondary working tree"-aware world, I think you would
need to ask locations of --git-dir and --git-common-dir to rev-parse
upfront and choose which ones are ought to be shared entities across
the family of worktrees and which ones are to be private per
worktree.  I suspect that LFS objects want to be shared across
working trees that share the object store, for example, which would
mean that "--git-dir" is not what Lars would want to use.


[Footnote]

*1* I do not think this is necessary.  Git tools know how to find
the repository by first checking GIT_DIR environment and if it is
not set then by walking up the directory hierarchy just fine without
the program exporting GIT_DIR for them.

*2* The part that bases this path relative to getcwd() is OK, as the
start-up sequence in main() does a cdup to the top before everything
else.
