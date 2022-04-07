Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC52C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 21:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiDGVrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 17:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiDGVrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 17:47:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50BF200
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649367923;
        bh=IGwiVx1gcKkblcUIw7okWYDsYmSdcf59awlPnC+qmlg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TqTaMwYTR8EqCIEq+36THlc9wFvY+7c3QBOto4n5f+jIKsD4elgPErDWCwkNlJQ+6
         nSs8VTk2rNf0dSWEZUdJQel0KAb5a3rdB+kG5UUveHlcs0vtxSSMXeikOxkz8eVqoh
         XuN3USfAmPJZCQGGBK/y4iLbnKmMpinc87kREGho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.255.204] ([89.1.212.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbIx-1nkaHY0kUd-009gt4; Thu, 07
 Apr 2022 23:45:23 +0200
Date:   Thu, 7 Apr 2022 23:45:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Danny Lin <danny0838@gmail.com>, git develop <git@vger.kernel.org>
Subject: Re: [PATCH] git-prompt: fix sequencer/todo detection
In-Reply-To: <xmqqwngdzque.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2204072315330.347@tvgsbejvaqbjf.bet>
References: <20220325145301.3370-1-danny0838@gmail.com> <xmqqwngdzque.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:HsqiSmhM0/sYfiVL6V728McL18fDoWLkaQAAn5jq4KIGSooW87T
 qsydx04V2/R2hexv2d9Z40V6M60tjg82e03e2+wuf5lFQbZKdrc2vMLb6Lki/xplB5Ka2gO
 haTW3lkpOedgwQIDmZOvNnzWF430mcUE2uen9+xaIYx6oJE2TVGwUB0QWt+4fd/ti7jN1jX
 vggFnEknViR5R02o8oOvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SeObHmhyOiA=:0JxOk/7PYa6dlQXJMTMhuV
 zfMDdQxIBJa0dwbUMHeAEu0NLm4xdcm3FR4N3v3Ce5CwTLaxRiurtwvL6wEGemHugsIKZ7Eyh
 +YFnAlKtcA0sdO//2TH0yb5b1QEeD6/N3Y1HQJi7q4nvxkVcukxGHlXiCGlP6whi4923q/VIM
 UGzMkIQPlXxzhKwnVuGfv8j1B/V82Q+UnJiQN2ljKww6USYItC5JGDQpqCFRtuibtCnwbt5bn
 IJkRZg6wgwjM6QX4EFCppJXf4M74zocOVGYSpLQNhzNQSy2TSdnyiDLsKZhF0KxYdX+eBSu5c
 LpLHtNjUCfqGQL1R0OL3Q+zB9uji305crkka34mnbB/U2Qxc//DHfcPjm5lKMMskfj3StK23U
 Eut6xu82ZgeLTYJGL74KKjOMtHMatAHVV1BJ9HQeCiBCNiPJufMfR/CmFyS8slCz4awOtR+PO
 LEjRP1SZrrSfFy7N+zkHsdAbwWqBeIQSBh50s6aAYWaQSSByA7lP50jI8r8h2t+b0jZe7Ufod
 J+hF0MKIPQLvTpTAeMvJmZl8AyR57iZAFTbl7wfc8plcEgmga+7N6KxwzHrRRpr/kMBrN/JWg
 sscL1RlI2oTwLHsv2xU8EMXlVBAIFGued4SZ0Nbr4WI6rh56MHrUrWTv6NXnqBPpqfASNawPA
 3BqU4UDa9/G1ecbPr4/owaJLq+lf+tG0JFRPIHWYrrvbQQisuRebpdCdPcYUONsAC06xkWu7Q
 4oUgS5DHfbYkM4bouqrSkbJY5noq/bjxu6arIkgFi70WtfdPS9bAO12WRr9ggFdjtWNI8zUz1
 +vs9oUzrptE9FKMKHlPZkxnrsxKzZ2BEeVJmWr5o1C7jhg4dDSlIEYY/iWW6yaCRCqTp4u5sx
 x7NDfaOUR7x+7p/NZ2dqdmrDo07MHl4zbGm6QxQ3JsmgXarctGLpFOGnlvopu52wNagFsj0C1
 4LDoTleJJTIYTXzsAKpnbg7289pdvMlNl/lWgOvcvxO0slmm4aWSPvFucbETpeLegIGURjX5Z
 /UL18WatVDqIg51YF3Tv8VwCfsTo7YQ7KLvL/YSYL/8h2TaIAg/Z6XdoudBtufTQ3sdm4Lz2o
 KmCOkoM9N81i24=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Mar 2022, Junio C Hamano wrote:

> Danny Lin <danny0838@gmail.com> writes:
>
> > Previous case does not correctly check the "p ..." pattern.
> >
> > Signed-off-by: Danny Lin <danny0838@gmail.com>
> > ---
> >  contrib/completion/git-prompt.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git=
-prompt.sh
> > index db7c0068fb..8ae341a306 100644
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -315,7 +315,7 @@ __git_sequencer_status ()
> >  	elif __git_eread "$g/sequencer/todo" todo
> >  	then
> >  		case "$todo" in
> > -		p[\ \	]|pick[\ \	]*)
> > +		p[\ \	]*|pick[\ \	]*)
> >  			r=3D"|CHERRY-PICKING"
> >  			return 0
> >  		;;
>
> It is obvious that the original code is *not* prepared to see 'p'
> followed by whitespace followed by other things, but I am not sure
> how the code in sequencer.c::todo_list_write_to_file() can choose
> to pass flags & TODO_LIST_ABBREVIATE_CMDS to todo_list_to_strbuf().

At first, I thought that if `rebase.abbreviateCommands` is set to `true`,
we would write out todo lists with one-letter commands.

But that's not true, it's only while we edit the file that that config
setting affects how the todo list is written.

I _guess_ it is during that time window that the prompt does not work as
expected?

> Danny, do you have a reproduction recipe, preferrably one you can
> turn into a new test in t9903-bash-prompt.sh?  Or was this found
> merely by inspecting the code?

I _guess_ there is a script at play which rewrites the `todo` file and
which runs when a cherry-pick fails due to merge conflicts. Here is a
patch that will exercise the code and verify the fix:

=2D- snip --
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index bbd513bab0f..c5c3e3c83de 100755
=2D-- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -221,7 +221,10 @@ test_expect_success 'prompt - cherry-pick' '
 	git reset --merge &&
 	test_must_fail git rev-parse CHERRY_PICK_HEAD &&
 	__git_ps1 >"$actual" &&
-	test_cmp expected "$actual"
+	test_cmp expected "$actual" &&
+	echo "p HEAD" >.git/sequencer/todo &&
+	__git_ps1 >"$actual".2 &&
+	test_cmp expected "$actual".2
 '

 test_expect_success 'prompt - revert' '
=2D- snap --

> Dscho, as far as I can tell, builtin/rebase.c can set the bit in the
> flags word when rebase.abbreviatecommands configuration is set, but
> that configuration variable is about rebase and it shouldn't affect
> how multi-step cherry-pick would work, should it?

Indeed. In a multi-commit cherry-pick, we call `walk_revs_populate_todo()`
which uses the long form of the `pick` command, always (look for
`command_string`).

> I am wondering if an uninitialized "flags" word, whose
> TODO_LIST_ABBREVIATE_CMDS bit randomly was turned on, caused
> todo_list_to_strbuf() to write an abbreviated insn in the todo file.

I don't think that `todo_list_to_strbuf()` is called during a cherry-pick.
Instead, `walk_revs_populate_todo()` is called in `git cherry-pick
=2D-continue`, and it does not modify the todo commands if run in
non-rebase-i mode.

> If so, the insn word being abbreviated or fully spelled out would not
> affect the correctness, but the flags word affects other things that are
> more crucial to correctness, so...

It looks to me as if the abbreviated commands cannot be generated by Git
(the `replay_opts` in `builtin/revert.c` are all initialized to
`REPLAY_OPTS_INIT`, so there is not even any chance of uninitialized data
there).

Ciao,
Dscho
