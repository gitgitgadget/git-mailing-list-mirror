Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA88C1F8CF
	for <e@80x24.org>; Thu,  8 Jun 2017 10:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbdFHKVJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 06:21:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:56355 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdFHKVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 06:21:08 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbaS9-1dbOmO0ZmP-00J2Jx; Thu, 08
 Jun 2017 12:20:53 +0200
Date:   Thu, 8 Jun 2017 12:20:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] read_early_config(): optionally return the worktree's
 top-level directory
In-Reply-To: <20170607181333.GD110638@google.com>
Message-ID: <alpine.DEB.2.21.1.1706081204330.171564@virtualbox>
References: <cover.1496851544.git.johannes.schindelin@gmx.de> <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de> <20170607181333.GD110638@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pYyNtUqycyrcVx4UnxJSdKp4Qf1exZsxpSdmir+ujr3KFniSFgD
 UIU8EgudjhuQSGt5Bsd2FS/x+HtDffjLDy8a/sT9qN/ULQHJuPOA3m/TbbNKHjBW/huV4k8
 tWZLuiV/CaIHT2aREEgosWJC63rQI/B54iNZa5yjaLV1sKxRddhKJnJWWFRrie22MyYTcOZ
 gPvDnCB6uzxNILZsrlrNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SsdH8dNaPkE=:4DEPR0abjd8nBNCdoWJ8Uw
 1HyWsiQLBxFiuh1r0u8cO0DpTF1ti1qMGiAlljnCjJBpEzcpnic8fIX5EOSq8MpJZpD4FWZOd
 vizFkzmI9qnVDC0jCfsRs7hTkiQiAsb0MJl8zni2WGONFH7sWo5ZQfLNbmyKKY/ucqHQ4XSV2
 Rhh+JfsUuqmbqU4X6L4n49TN42pGqauvNjZKEkodYxYSCT8YFj+Chkl9rZHC+/9jgOTOE9+I9
 g5VAAhqhVpHmBNSkRf2zHaHUSDoRwGLVaqOxz0FH21O0Okf5K2oJpr9ZAkulzahHlDNSPr/Gh
 HSYap/bHBb+W2mqaWk58AOX/5fE6o9wM2SzgibU6w1/qpJiaxtBF73py7UqZPljfymeGa8tv0
 19XYUs1nkigiv8WWWwWk4ogeoDyOttfuG9VVHyy2Nf5Sk7IE1lG9WoJHeRK98+DobtXPUfABn
 XzcfMuhddCiPfcy/4OgJtOL3f2GqHxFoFjKTywL+HmkGi/fNeyLQAMe08WsK9eE1HyUJUm9MG
 oWHwf/IBmjPQl6ZfkrfaFUtfO8Duk7wJVQnSzWG5RRbqSNEhDkF5b9FKOmS6Z+4/Tf3UqXRTH
 5MYjon+toUViQs9qyHPnFLmopD3ZOk4Qxv8/D9AyLhXJrxV3JQt0JxwWJK4UHT3Uhhkkep3Ti
 d48Ujum3MMTRo8omIOjkl8XZL+pqYt2GPxY3uRO1pthlfBF0lAlN7yBo9frZp1i3L6avT3hTv
 Egu/RwVqWFwV7spdjmlUspsw2LDwCspK1GTKXBhz/rCdf/CtVZsZY5dNRbW03LIqr5TQmzlWO
 EhLlvk2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Wed, 7 Jun 2017, Brandon Williams wrote:

> On 06/07, Johannes Schindelin wrote:
> > @@ -1668,7 +1668,7 @@ void read_early_config(config_fn_t cb, void *data)
> >  	 * notably, the current working directory is still the same after the
> >  	 * call).
> >  	 */
> > -	else if (discover_git_directory(&buf))
> > +	else if (discover_git_directory(&buf, worktree_dir))
> >  		opts.git_dir = buf.buf;
> 
> It feels kind of weird to get back worktree info after calling
> read_early_config but I understand why you need to get it.

Yeah. It is awkward. Required for backwards-compatibility, though (and it
is hard to explain *when* it is needed, and even harder under what
circumstances it is *not* needed even if there is a worktre).

> One thing to consider is the 'if' statement not shown here since you
> aren't adding any worktree information if that branch is taken.

Right. For lurkers, that `if` statement reads thusly:

	if (have_git_dir())
		opts.git_dir = get_git_dir();

> Maybe we can drop the first if statement all together as
> 'read_early_config' is used before setup is run and it should really
> only be triggered when setup has been run.

The `read_early_config()` function is *sometimes* used *after* setup has
run. Look at `run_builtin()` in git.c:

	if (p->option & RUN_SETUP)
		prefix = setup_git_directory();
	else if (p->option & RUN_SETUP_GENTLY) {
		int nongit_ok;
		prefix = setup_git_directory_gently(&nongit_ok);
	}

	if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
		use_pager = check_pager_config(p->cmd);

For builtins having either the RUN_SETUP or the RUN_SETUP_GENTLY flag, we
do not need to re-discover the .git/ directory at all when checking the
pager config.

Back to the worktree_dir variable.

I think part of the confusion here is that it may be left alone even when
there is a worktree. For example, if we are already in the top-level
directory. Or if the worktree somehow points to a different directory than
the one containing the .git/ directory.

Therefore, I renamed this variable to `cdup_dir` to reflect the fact that
it is only touched if Git determines that it is in a subdirectory of the
directory containing the .git/ directory.

Ciao,
Dscho
