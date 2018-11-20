Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363B31F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 02:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbeKTNUr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 08:20:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60437 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbeKTNUr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 08:20:47 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8708B125513;
        Mon, 19 Nov 2018 21:53:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8V5IB1KArq1TpulZ8qleeVeFQ+E=; b=f0xRo5
        MVGi/azkXkf2ndAxgw6YAyHJJ0sodYqCd0JyVa6IBga1WTZ+MtE1ROhPY/IUXc5i
        B78rZNyahWWkhIpmguyzUAaLfwa5k11TCY4INLp25A8+nHVzfCEclaIAAHBKPNSZ
        G7QMF6Cb/dia5/tli6pvwZ+I4DiHCsBaRA4Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sis28iopEm+6U6mIe2Nc/XMA4JlKgfjQ
        qUBoVbvzTe2dy+IKma6RrDyx6jSPxJ2EI2D6gDQOUXcFN9HLdTz6gathTQuZIYQM
        I3YK8MJeXMbZBCmnpeMwT+yyNZW/8IuLKR8ayHLI5t4Y519mWsGNLlERGeD4DWfB
        NGcIr9XW8wM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FD88125512;
        Mon, 19 Nov 2018 21:53:56 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 023C5125511;
        Mon, 19 Nov 2018 21:53:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] checkout: print something when checking out paths
References: <20181110133525.17538-1-pclouds@gmail.com>
        <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
        <8736rx1ah9.fsf@evledraar.gmail.com>
        <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
Date:   Tue, 20 Nov 2018 11:53:54 +0900
In-Reply-To: <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 19 Nov 2018 16:19:53 +0100")
Message-ID: <xmqqpnv0bgsd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8581B61A-EC6F-11E8-A962-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> > I see this at the same level as "Switched to branch 'foo'" which is
>> > also protected by opts->quiet. If we start hiding messages based on
>> > tty it should be done for other messages in update_refs_for_switch()
>> > too, I guess?
>
> No let's drop this for now. I promise to come back with something
> better (at least it still sounds better in my mind). If that idea does
> not work out, we can come back and see if we can improve this.

Let's leave it in 'pu'.

I do agree that this is similar to existing messages that talk about
checkout out a branch to work on etc., and I think giving feedback
when checkout paths out _is_ a good thing to do for interactive
users.

If we were to squelch such "notice" output for non-interactive use,
we should do so to the "notice" messages for checking out a branch,
as well, and also to other subcommands that report what they did
with these "notice" output.  And that is a separate topic.

The primary reason why I was annoyed was because "make test" (I
think I have DEFAULT_TEST_TARGET=prove, if it matters) output was
littered with these "checked out N paths", even though I am not
asking for verbose output.  

It could be that the real cause of that is perhaps because we have
too many "git checkout" that is outside test_expect_* block, in
which case we should fix these tests to perform the checkout inside
a test_expect_success block for test set-up, and my annoyance was
only shooting at the messenger.

For example, the attached patch illustrates the right problem but
addresses it in a wrong way.  This checkout_files() helper does too
many things outside (and before) the test_expect_success block it
has (other helpers like commit_chk_wrnNNO share the same problem),
and making "git checkout" noisy will reveal that as a problem by
leaking the noisy output directly to the tester.  But the real fix
is to enclose the set-up step inside a test_expect_success block,
which is not done by the following illustration patch, which instead
just squelches the message.

 t/t0027-auto-crlf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index beb5927f77..3587e454f1 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -293,9 +293,9 @@ checkout_files () {
 	do
 		rm crlf_false_attr__$f.txt &&
 		if test -z "$ceol"; then
-			git checkout crlf_false_attr__$f.txt
+			git checkout -- crlf_false_attr__$f.txt
 		else
-			git -c core.eol=$ceol checkout crlf_false_attr__$f.txt
+			git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
 		fi
 	done
 

