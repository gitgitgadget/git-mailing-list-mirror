Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCDF208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 10:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeHFMQy (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 08:16:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:58851 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbeHFMQx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 08:16:53 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGBB1-1fk9jY3nlf-00FAKF; Mon, 06
 Aug 2018 12:08:28 +0200
Date:   Mon, 6 Aug 2018 12:08:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Make git rebase work with --rebase-merges and
 --exec
In-Reply-To: <pull.13.v2.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808061159480.71@tvgsbejvaqbjf.bet>
References: <pull.13.git.gitgitgadget@gmail.com> <pull.13.v2.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qppb/JT2/1X9JC9X/2x2fwaz30pl4lKVmSu4ikfEplb8wmvVT5D
 v06hhAoRqLEdNsgfd3xjIGvs5Tn6RcJRlb/SjW0kPBWvL5MewGA0F17p7SzAPPfr6UEI+Tf
 e6hRF1uPJtIx6b6LHPCFYZzAsEl1kAkRWanLisTkjDNU6YrEYUOhGROI4uaQ2c2yjOfuvux
 njy11J4d7p8QjSIy3p+5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VDLTaFPkLwA=:M3shAKrSm+d7FOljcmzcC+
 cxtQTo2E+A+gp2t0DbK+N/uNgYlfUQLMTQZKXodlqqJElE0I6BBgLN7UFu/AZTL0314+Op3ka
 S4i6/D7DgyaHq0tU0VmWxbisiWq6vrecCRSU24okmEakSNrMCVPOef5X/QmDruEe6z3GaguOj
 g+K2LdDXB8eIdER7yCcHiq0OXMilsyxgaVT9JsL8u0fLReAH84QpHX6Ze8bYbZ7DY1DYMBclI
 3GbB46EYu31wd15P7vL3+MGpYnV5j9fKibATM0naovUsmM0yurmgHJtKSeDiTv/J5shdsJGa1
 zLlWLyCAbDlodDZypJQGqPEfflibOfVr6NhTVhwEQKwOxmooYN9slaA4fYWyQiP0fiCkTTHce
 5zWjphWzaMrhXRiucTLsv6V2QYLJwZw/tHZh4Ct5qYet6ztgTbt+HyFakISwbsCagWsFwT3R1
 n8ilxiQbXbvx41jpND9Z6mefR96tS4fVkUaqscjrsYMuU0UDn/kOlMPq+pRnt8fi8rUn1rT7I
 rS2/LB1vIBSCTt5hunL7vAETPtxdknqeSHTjt4Wk18AFfBeh44a/XHSFdCXPrg5Xj58XCeR8t
 w1dgVz/dsCXWjalUTe5VhDX6F4BDmjbPFPUqMNYVo2RIi2i8Kaq3dJoL+uQyuRVAYhGS4wBNj
 5hC4bf89DBF579YtfPk4PxG0bJoCNb2qUhtlVSKQqPgcNi8bx0sU48UMDmLTKVwf6h1DvhaLv
 CxFtkEwLhmI0a2kM5sYUPnn229cSmHyouc4WNgPPbKoXwotn0RUsMfLMVHWNuPWNMTMlmx+73
 lNHv/fx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Team,

On Mon, 6 Aug 2018, Johannes Schindelin via GitGitGadget wrote:

> It was reported via IRC that the exec lines are inserted in the wrong spots
> when using --rebase-merges.
> 
> The reason is that we used a simple, incorrect implementation that happened
> to work as long as the generated todo list only contains pick, fixup and 
> squash commands. Which is not the case with--rebase-merges.
> 
> Fix this issue by using a correct, if longer and slightly more complex
> implementation instead.

I should have paid more attention to detail, and should have updated this
cover letter. My bad.

The last paragraph of the part quoted above should have read:

	Fix this issue by using a correct implementation instead, that
	even takes into account `merge` commands in the --rebase-merges
	mode.

And the changes since v1:

	- Replaced the "look-ahead" design by a "keep looking" one:
	  instead of having a nested loop that looks for the end of the
	  fixup/squash chain, we continue the loop, delaying the insertion
	  until we know where the fixup/squash chain ends, if any.

One quirk I just noticed is that the new code does not really work
correctly in all circumstances: if the todo list ends in a comment (e.g.
an empty commit being reflected by a commented-out `pick`), we still just
append the final commands to the end.

I should qualify by "correct" in this instance: the `exec` commands are
not inserted in the location that I would have liked to, but they *are*
inserted. So it is more an aesthetic thing than anything else, and it will
probably not even show up all that often in practice.

Given that v2 is easier to understand than v1, in my opinion that slightly
awkward inconsistency in insert location is okay.

Ciao,
Dscho

> Johannes Schindelin (2):
>   t3430: demonstrate what -r, --autosquash & --exec should do
>   rebase --exec: make it work with --rebase-merges
> 
>  sequencer.c              | 37 +++++++++++++++++++++++++++----------
>  t/t3430-rebase-merges.sh | 17 +++++++++++++++++
>  2 files changed, 44 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-13%2Fdscho%2Frebase-merges-and-exec-commands-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-13/dscho/rebase-merges-and-exec-commands-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/13
> 
> Range-diff vs v1:
> 
>  1:  1d82eb450 = 1:  1d82eb450 t3430: demonstrate what -r, --autosquash & --exec should do
>  2:  b29c4d979 ! 2:  7ca441a89 rebase --exec: make it work with --rebase-merges
>      @@ -38,7 +38,7 @@
>        	struct strbuf *buf = &todo_list.buf;
>        	size_t offset = 0, commands_len = strlen(commands);
>       -	int i, first;
>      -+	int i, insert_final_commands;
>      ++	int i, insert;
>        
>        	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>        		return error(_("could not read '%s'."), todo_file);
>      @@ -52,59 +52,38 @@
>       -		if (item->command == TODO_PICK && !first) {
>       -			strbuf_insert(buf, item->offset_in_buf + offset,
>       -				      commands, commands_len);
>      --			offset += commands_len;
>       +	/*
>       +	 * Insert <commands> after every pick. Here, fixup/squash chains
>       +	 * are considered part of the pick, so we insert the commands *after*
>       +	 * those chains if there are any.
>       +	 */
>      -+	insert_final_commands = 1;
>      -+	for (i = 0; i < todo_list.nr; ) {
>      ++	insert = -1;
>      ++	for (i = 0; i < todo_list.nr; i++) {
>       +		enum todo_command command = todo_list.items[i].command;
>      -+		int j = 0;
>       +
>      -+		if (command != TODO_PICK && command != TODO_MERGE) {
>      -+			i++;
>      -+			continue;
>      -+		}
>      -+
>      -+		/* skip fixup/squash chain, if any */
>      -+		for (i++; i < todo_list.nr; i++, j = 0) {
>      -+			command = todo_list.items[i].command;
>      -+
>      -+			if (is_fixup(command))
>      ++		if (insert >= 0) {
>      ++			/* skip fixup/squash chains */
>      ++			if (command == TODO_COMMENT)
>       +				continue;
>      -+
>      -+			if (command != TODO_COMMENT)
>      -+				break;
>      -+
>      -+			/* skip comment if followed by any fixup/squash */
>      -+			for (j = i + 1; j < todo_list.nr; j++)
>      -+				if (todo_list.items[j].command != TODO_COMMENT)
>      -+					break;
>      -+			if (j < todo_list.nr &&
>      -+			    is_fixup(todo_list.items[j].command)) {
>      -+				i = j;
>      ++			else if (is_fixup(command)) {
>      ++				insert = i + 1;
>       +				continue;
>       +			}
>      -+			break;
>      ++			strbuf_insert(buf,
>      ++				      todo_list.items[insert].offset_in_buf +
>      ++				      offset, commands, commands_len);
>      + 			offset += commands_len;
>      ++			insert = -1;
>        		}
>       -		first = 0;
>       +
>      -+		if (i >= todo_list.nr) {
>      -+			insert_final_commands = 1;
>      -+			break;
>      -+		}
>      -+
>      -+		strbuf_insert(buf, todo_list.items[i].offset_in_buf + offset,
>      -+			      commands, commands_len);
>      -+		offset += commands_len;
>      -+		insert_final_commands = 0;
>      ++		if (command == TODO_PICK || command == TODO_MERGE)
>      ++			insert = i + 1;
>        	}
>        
>        	/* append final <commands> */
>       -	strbuf_add(buf, commands, commands_len);
>      -+	if (insert_final_commands)
>      ++	if (insert >= 0 || !offset)
>       +		strbuf_add(buf, commands, commands_len);
>        
>        	i = write_message(buf->buf, buf->len, todo_file, 0);
> 
> -- 
> gitgitgadget
> 
> 
