Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCC5C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAD464E2B
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 18:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBOSt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 13:49:59 -0500
Received: from mout.web.de ([212.227.15.3]:54069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhBOSt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 13:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1613414869;
        bh=ff6TVf02NJialGqXPnH5lhQIXyFzieNgJIUzJhcbmOA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OJNM/82S4LmwK7Sl3iMevZBPy+siXxZITnWf7nh4k1tSZOuQPwviUpB7pC1R3ryUj
         VBF1cWv91hH7TvOUqy9ekj1K+GmNSnQPllYIXagxwzDGguZiyhbE7lO2f6Ai8/Rh2E
         axbaArL4KgOBgcZXV6T+qkzKinUOwbwl1SSm4w1Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.90]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M3V6E-1lBAwg3woM-000xyl; Mon, 15 Feb 2021 19:47:48 +0100
Subject: Re: [PATCH 1/2] diff: do not display hunk context under -W
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Jeff King <peff@peff.net>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210215155020.2804-2-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <d02c99b8-ae26-9804-480c-eae880f4a6cb@web.de>
Date:   Mon, 15 Feb 2021 19:47:48 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210215155020.2804-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l8wgbjLcu0kJ112IM1WQAib6jty3Hzz3h8aCXc9i4F6enb56H9W
 LnzMBqf2O7aVyjtl5Kpg5fZT2yiblV+xy1DHjVgK9m8IriT3LL/A5CP8e73/FkG4hDnx4aA
 8+35nQP2SB6qNsbZ4kj3q66Hton/jAhgjxm0oarDdLJ6gTbuR9OFt2c2OLMxNlFbWkOUjxJ
 cnjjV0dJeZ085SKs1wT1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y6NVRzwFZDo=:7h6gnOC3V44M1lkWLBf8Ru
 95J2uIqJ/Dzm+o/7d3Xd/16jrlvrCLv53i1yQwRP9VVCYiytw3iennC6vn7NfC3v9ZYMo06Gk
 BRVz16l1WTXpAyWj9HW9Nmqsr1qoptm2UXOwSqzSDVsvpBSt8Rl6H7gkhnPoMhF7UHZt3MTNK
 LWKIWL9HhBnpw7VHxJt6lld5Kr99zjMEZGu4UqO13i6B7vOKl3WEhRSonDZqKDTWHbRJQBsWN
 M3eWo1MdI9YrjfGSgSCFlYf7ACxSiO6pTOAinHHLOxdXeioiC7TonKjMhUDmX+hRCfDnvLVSS
 /yk1bhsrtrUWTPR/OqxNZSlwCpYtPvUK77rYRIns7KnFM7ZXaeN7Uz2CjlG7c9bl1Tdwctxt5
 eYc3fH4OPbIeiFPSw+aArZv8oIw8qB2/+PdyDqNK+S034juEkbq4EWkVTMdaJ+fP6m7BBBwJZ
 AuTDUmHOrJlvHvatU8QiDZTN7yF2yRXu1smdDnakFZLn6MNneAGe426vcmEP/UTqMzPfvJUdO
 cMyeyxqOWyqI2RbDhVG0vzwZq4dw4/FJnIQz7+kcNC6s25bT1ndJtWPCf78AhMrpENlrpgLvH
 qPrT9c+tJjCogqmX/K5kFFW9tCBIRYRwq1MM44TxzH4+3jtY1Kvwi5ztozoP169LtnXGfNZg5
 VTlol+kFu4aYkqvyJegMNFoFAS6KirjygxDHVdqlVQW9CmwExuQ1rnzrzk5IwIcOSXoXKltDA
 KUW+Pxnjg15HIgiQIV1W4Any43g/3C445AT5vLlcgp/okQv26Byk9sW7L3GvTWdTRZziIm1gi
 vYYYCX563vWg0NR+xkwsJuzbYo0kpoJkG2+XRPSgjFDOO/IJC4lGPNB+ViLs+H+H2jCINn2L/
 8vdPLL9btud6U4pPEZ9Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.21 um 16:50 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Fix what I believe to be a long-standing bug in how "-W" interacts
> with displaying the hunk context on the @@ line: It should not be
> displayed at all under -W.
>
> The long-standing semantics of how -W works and interacts with -U<n>
> are rather easy to reason about:
>
>  * -W extends the context line up to the start of the function. With
>     userdiff this means the language-aware regex rules in userdiff.c,
>     or user-supplied rules.
>
>  * -U<n>, which defaults to -U3 shows at least <n> lines of context,
>     if that's greater than what we'd extend the context to under -W
>     then -U<n> wins.
>
>  * When showing the hunk context we look up from the first line we
>    show of the diff, and find whatever looks like useful context above
>    that line.
>
> Thus in e.g. the xdiff/xemit.c change being made in this commit we'll
> correctly show "xdl_emit_diff()" in the hunk context under default
> diff settings.
>
> But if we viewed it with the -W option we'd show "is_empty_rec()",
> because we'd first find the "xdl_emit_diff()" context line, extend the
> diff to that, and then would go look for context to show again.
>
> I don't think this behavior makes any sense, our context in this case
> is what we're guaranteed to show as part of the diff itself.
>
> The user already asked us to find that context line and show it, we
> don't need to then start showing the context above that line, which
> they didn't ask for.

Hmm, that's subtle.

Your reasoning applies to patches generated without -W as well.  If the
precontext contains a function line then the @@ line should not contain
a function comment.  However, e.g. with this:

=2D- snip --
cat >a <<EOF
func a

func b
1
2
3
EOF
sed 's/3/three/' <a >b
diff -up a b
=2D- snap --

... I get this:

=2D-- a	2021-02-15 18:30:21.000000000 +0100
+++ b	2021-02-15 18:30:21.000000000 +0100
@@ -3,4 +3,4 @@ func a
 func b
 1
 2
-3
+three

So diff(1) shows the previous function line.  git diff does the same.

The behaviour of diff(1) and git diff does make sense to me: It's easy
to implement and the only downside is that it produces extra output in
some cases.

I can understand that users would rather have a tidy diff without
distractions, though.  So I like the output change you propose.

However, I'm not sure it would be a good idea to clear @@ lines of hunks
generated without -W that have function lines in their precontext, even
though it would be a logical thing to do.

> This new behavior does give us the edge case that if we e.g. view the
> diff here with "-U150 -W" we'd previously extend the context to the
> middle of the "is_func_rec()" function, and show that function in the
> hunk context. Now we'll show nothing.

Well, the 150 lines of context are still shown (as they should be), but
the @@ line contains no function name anymore.

> I think that change also makes sense. We're showing a change in the
> "xdl_emit_diff()" function. That's our context for the change. It
> doesn't make sense with -W to start fishing around for other
> context.

It does make sense in the context of the diff(1) -p implementation, but
your change is consistent with the description of that option: "Show
which C function each change is in."

> Arguably in that case we could save away the context we found in the
> "XDL_EMIT_FUNCCONTEXT" in "xdl_emit_diff()" and show that if we end up
> extending the diff past the function, either because of a high -U<n>
> value, or because our change was right at the start.
>
> I wouldn't really mind if we did that, perhaps it would be a useful
> marker with high -U<n> values to remind the user of what they're
> looking at, but I also don't see the usefulness in practice, so let's
> punt that for now.

It could be confusing for someone who expects the old behaviour, leaving
it empty makes more sense to me.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/diff-options.txt | 4 ++++
>  t/t4015-diff-whitespace.sh     | 2 +-
>  t/t4018-diff-funcname.sh       | 7 +++++++
>  xdiff/xemit.c                  | 4 +++-
>  4 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options=
.txt
> index e5733ccb2d..8ca59effa7 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -759,6 +759,10 @@ endif::git-format-patch[]
>  	The function names are determined in the same way as
>  	`git diff` works out patch hunk headers (see 'Defining a
>  	custom hunk-header' in linkgit:gitattributes[5]).
> ++
> +When showing the whole function for context the "@@" context line
> +itself will always be empty, since the context that would otherwise be
> +shown there will be the first line of the hunk being shown.
>
>  ifndef::git-format-patch[]
>  ifndef::git-log[]
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 8c574221b2..0ffc845cdd 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -2133,7 +2133,7 @@ test_expect_success 'combine --ignore-blank-lines =
with --function-context 2' '
>  		--ignore-blank-lines --function-context a b >actual.raw &&
>  	sed -n "/@@/,\$p" <actual.raw >actual &&
>  	cat <<-\EOF >expect &&
> -	@@ -5,11 +6,9 @@ c
> +	@@ -5,11 +6,9 @@
>  	 function
>  	 1
>  	 2
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 80f35c5e16..f3374abd98 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -91,6 +91,13 @@ test_diff_funcname () {
>  		fi
>  	' &&
>
> +	test_expect_success "$desc -W" '
> +		git diff -U0 -W "$what" >W-U0-diff &&
> +		echo >W-U0-expected &&
> +		last_diff_context_line W-U0-diff >W-U0-actual &&
> +		test_cmp W-U0-expected W-U0-actual
> +	' &&
> +
>  	test_expect_success "$desc (accumulated)" '
>  		git diff -U1 "$what".acc >diff &&
>  		last_diff_context_line diff >actual.lines &&
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index 9d7d6c5087..02b5dbcc70 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -274,7 +274,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xd=
emitcb_t *ecb,
>  		 */
>
>  		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
> -			get_func_line(xe, xecfg, &func_line,
> +			get_func_line(xe, xecfg,
> +				      xecfg->flags & XDL_EMIT_FUNCCONTEXT
> +				      ? NULL : &func_line,

Why still search?  It would be better to turn off XDL_EMIT_FUNCNAMES if
XDL_EMIT_FUNCCONTEXT is enabled -- a one-character change in diff.c.

>  				      s1 - 1, funclineprev);
>  			funclineprev =3D s1 - 1;
>  		}
>
