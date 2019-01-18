Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9A41F453
	for <e@80x24.org>; Fri, 18 Jan 2019 14:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfAROS1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 09:18:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:56511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfAROS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 09:18:27 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUTSJ-1gbsH03zhT-00RFxy; Fri, 18
 Jan 2019 15:18:22 +0100
Date:   Fri, 18 Jan 2019 15:18:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/4] rebase: teach `reset_head()` to optionally skip the
 worktree
In-Reply-To: <xmqqpntcclot.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1901181516240.41@tvgsbejvaqbjf.bet>
References: <pull.24.git.gitgitgadget@gmail.com> <21939140e00d96cf6f76e4c994638fecd3a95639.1545398254.git.gitgitgadget@gmail.com> <xmqqpntcclot.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bJzFIdApSJjVKdgWeDa/eIhJQpt5EYiOFf/16o18GtnEr3RSRL8
 NLlzLJsJsgYlycWper3gNbWfN5HoXx6+Kyk2zXhiX6IWm0Tz/AmbUvT4U12rjYcpQxVqyvo
 CWEhSFmqZiaFw4l5XcuSXEEwX0Ok8Exa31Ev7yIs2rEg/SApK75DmhMP6w7msEiAC1IIR0M
 4J30U7BxeAHhhMW6C41Vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sugAkovjVGw=:KFzMZttUqhbbAyTT4ht4XU
 IovrQbqWPRRFcnKePzyY0IFaRHz9vkPzPeAoLDE8YMEmKcEcOEtI5KLlmMBE18brrKn2MH4Ii
 vpfAnhmZ3tR8g/doLNq3xbbiMpWvXCgVuQQKBwRvX8DpxOkEtWoiMYdbTAiUUsMFE1Kq4a4lt
 g3OiteUTAKHxU1hUQMSXNc92XLrsOa9GEmueGpt4z182N1rauDy/NgDJN/0ye7163Ley3PhYI
 /FvpB/oTmccS4L/s79L/8u+9vbmbL6rHJvO3H2TjBq3o7HzSqUKdcfQzz2+fpO/bX+ZUFhQgs
 LNst5W+ucbi205ctBz/y/hlpOGLc5Ofx/3YC6P7eIe/OosubsL7YJ2bRe+/KoV7+6T0NUSEUt
 eT1U13eGo89RwwxFpo8ComqTK2w/yyLPXkPP2ZClMzsZt4gVPjT9lhbkzgfMxzcEP2RO3BrSP
 mk+fZYuR3W3+ag2UtHe7ueyAfCyp5lp1Dp7Av3hfDdQwqQAGg7l382JJQx7GXuMrNSwc56T7d
 Oeal4GN9liGGhaJxj1hK08Crk6GeA4Cm6lRs7WBg7EYP4MZ2aEeTsDjL+Yj7RHT5N+aqzDwpp
 GBd6dTHj/XmUSbQgU/8z4NyY08+RZWr1zKv2ognx9C51jSc5NA33kXWZXpTmAja7SLqQy8Cbj
 qsDEohYDJDUOFqHnJLyPU7rWhkxXs19xOECOeq2iXM2C2NvAMSiNg21+Z410fGWD7tExV8nUc
 VC04Mp+t4twYLDkzEujTFqPLmJCI/AaRaeZ5j9kKFKbNKpKC62+vjCMEF+I4FcQFhrpWj241W
 c/8dmrbwsKFYlpUpFzDtCGvHlJtCD2D5El1G21UwMq1RMuiWN/tlS2nJh6/pkRHDQ+8O5nRYD
 4PuQ8bs3L8zmg5TqUbA+6Nv5Y32UckJJBj2jBiY5kVq9dFNMTwEJdsdcJA5SDp9OYmh7zrjq/
 pJLYpGNgIjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 4 Jan 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This is what the legacy (scripted) rebase does in
> > `move_to_original_branch`, and we will need this functionality in the
> > next commit.
> 
> The move-to-original-branch helper does:
> 
>     - point $head_name to the commit pointed at by HEAD
>     - point HEAD symref to $head_name
> 
> without touching the index or the working tree files.  It's not
> exactly "reset --soft" but more like "switch-branch --soft" ;-)

Right, but it does reset the HEAD softly.

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/rebase.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 768bea0da8..303175fdf1 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -337,6 +337,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
> >  
> >  #define RESET_HEAD_DETACH (1<<0)
> >  #define RESET_HEAD_HARD (1<<1)
> > +#define RESET_HEAD_REFS_ONLY (1<<2)
> 
> In the future codebase in 'pu', we have 1<<2 already taken by
> another topic, so I'll tell my rerere database that the bit
> assignment needs to be adjusted.

Okay.

> >  static int reset_head(struct object_id *oid, const char *action,
> >  		      const char *switch_to_branch, unsigned flags,
> > @@ -344,6 +345,7 @@ static int reset_head(struct object_id *oid, const char *action,
> >  {
> >  	unsigned detach_head = flags & RESET_HEAD_DETACH;
> >  	unsigned reset_hard = flags & RESET_HEAD_HARD;
> > +	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
> >  	struct object_id head_oid;
> >  	struct tree_desc desc[2] = { { NULL }, { NULL } };
> >  	struct lock_file lock = LOCK_INIT;
> > @@ -359,7 +361,7 @@ static int reset_head(struct object_id *oid, const char *action,
> >  	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
> >  		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
> >  
> > -	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
> > +	if (!refs_only && hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
> >  		ret = -1;
> >  		goto leave_reset_head;
> >  	}
> 
> Not touching the index, so no need to lock the index.  Makes sense.
> 
> > @@ -372,6 +374,9 @@ static int reset_head(struct object_id *oid, const char *action,
> >  	if (!oid)
> >  		oid = &head_oid;
> >  
> > +	if (flags & RESET_HEAD_REFS_ONLY)
> > +		goto reset_head_refs;
> > +
> 
> Why not "refs_only" that we already prepared above???  Are we
> munging that secondary variable before control comes here?

No, just an oversight. Will fix.

> In any case, not touching the index nor the working tree, so no need
> to call into the unpack_trees machinery.  Makes sense.
> 
> >  	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> >  	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> >  	unpack_tree_opts.head_idx = 1;
> > @@ -412,6 +417,7 @@ static int reset_head(struct object_id *oid, const char *action,
> >  		goto leave_reset_head;
> >  	}
> >  
> > +reset_head_refs:
> >  	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> 
> And the control continues from the point we update the reflog.
> Makes sense.
> 
> >  	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
> >  	prefix_len = msg.len;
> 
> This helper is touched by two other topics in flight, and that was
> one of the reason why it took a bit longer than usual for me to
> merge this topic.  Please sanity-check the result of the conflict
> resolution at the tip of 'pu' branch.

Sorry, I *just now* had time to take care of this patch series. I will
gladly check once you integrate the new patch series iteration.

Thanks,
Dscho
