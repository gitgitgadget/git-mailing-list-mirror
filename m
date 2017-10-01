Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9891E202A5
	for <e@80x24.org>; Sun,  1 Oct 2017 03:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbdJAD1I (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 23:27:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59939 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750905AbdJAD1G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 23:27:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0233BA9004;
        Sat, 30 Sep 2017 23:27:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d4AOB/eg4T4mWfsUnlyzwxGrzxg=; b=yi6aQ4
        KQzu3I4pg7t9qOnJxXrftkwlwt3VDNdXBxGw3K9wX16b3a5t0eeXzF/xF7PziMf7
        sdG0obL3wKk+0muwJwUrlXBuGOS/cn2MJeQeS16faPga/ZNjg7fXwfHN/STtjN6g
        kqrkYBPYQY+C3NNS1PdPldhsTI87CGxNX2uYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VObQa1ccKFM4he5gepCBXZx8j+Zq5jur
        8JSaNF6XjNhY7atnNCuR5bL4EDoF96NNc0sCCYRJsEviyVxBdWhpFNs2YEn2l+f4
        rQrp5OY2A9075bTpw59GNdl/KHMHDNYX1NU8DgG9B6inI1icTDCOacWMZQyEdBiE
        RJyYWkpr/Gc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA552A9003;
        Sat, 30 Sep 2017 23:27:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E310A9002;
        Sat, 30 Sep 2017 23:27:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>, git@vger.kernel.org
Subject: Re: [idea] File history tracking hints
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
        <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
        <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
        <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
        <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
        <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
Date:   Sun, 01 Oct 2017 12:27:04 +0900
In-Reply-To: <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com> (Jeff
        Hostetler's message of "Sat, 30 Sep 2017 04:02:35 -0400")
Message-ID: <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65C25B44-A658-11E7-A0C7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 9/29/2017 7:12 PM, Johannes Schindelin wrote:
>
>> Therefore, it would be good to have a way to tell Git about renames
>> explicitly so that it does not even need to use its heuristics.
>
> Agreed.
>
> It would be nice if every file (and tree) had a permanent GUID
> associated with it.  Then the filename/pathname becomes a property
> of the GUIDs.  Then you can exactly know about moves/renames with
> minimal effort (and no guessing).

I actually like the idea to have a mechanism where the user can give
hint to influence, or instruction to dictate, how Git determines
"this old path moved to this new path" when comparing two trees.  A
human would not consider a new file (e.g. header file) that begins
with a few dozen commonly-seen boilerplate lines (e.g. copyright
statement) followed by several lines unique to the new contents to
be a rename of a disappearing old file that begins with the same
boilerplate followed by several lines that are different from what
is in the new file, but Git's algorithm would give equal weight to
all of these lines when deciding how similar the new file is to the
old file, and can misidentify a new file to be a rename of an old
file that is unrelated.  Even when Git can and does determine the
pairing correctly, it would be a win if we do not have to recompute
the same pairing every time.  So both as hint and as cache, such a
mechanism would make sense [*1*].

But "file ID" does not have any place to contribute to such a
mechanism.  Each of two developers working on the same project in a
disributed environment can grab the same gist and create a new file
in his or her tree, perhaps at the same path or at a different
path.  At the time of such an addition, there is no way for each of
them to give these two files the same "file ID" (that is how the
world works in the distributed environment after all)---which "file
ID" should survive when their two histories finally meet and results
in a single file after a merge?  A file with "file ID" may not be
renamed but may be copied and evolve separately and differently.
Which one should inherit its original "file ID" and how does having
"file ID" help us identify the other one is equally related to the
original file?  These two are merely examples that "file ID"s would
cause while solving "only" what can be expressed in "git diff -M"
output (the latter illustrates that it does not even help showing
"git diff -C").

And when we stop limiting ourselves to the whole-file renames and
copies (which can be expressed in "git diff" output) but also want
to help finer-grained operation like "git blame", we'd want to have
something that helps in situations like a single file's contents
split into multiple files and multiple files' contents concatenated
into a single new file, both of which happens during code
refactoring.  "file ID" would not contribute an iota in helping
these situations.  

I've said this number of times, and I'll say this again, but one of
the most important message in our list archive is gmane:217 aka

https://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/

I'd encourge people to read and re-read that message until they can
recite it by heart.

Linus mentions "CVS annotate"; the message was written long before
we had "git blame", and it served as a guide when desiging how we
dig contents movement in various parts of the system.


[Footnote]

*1* There are many possible implementations; the most obvious would
    be to record a pair of blob object names and instruct Git when
    it seems one side of a pair disappearing and the other side of
    the pair appearing, take the pair as a rename.  And that would
    be sufficient for "git log -M".  

    Such a cache/hint alone however would not help much in "git
    merge" without further work, as we merge using only the tree
    state of the three points in the history (i.e. the common
    ancestor and two tips).  merge-recursive needs to be taught to
    find the renames at each commit it finds throughout the history
    from the ancestor and each tip and carry its finding through if
    it wants to take advantage of such hint/cache.
