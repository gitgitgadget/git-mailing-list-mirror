Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C17C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 17:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiHBRiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 13:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiHBRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 13:38:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C095433A29
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 10:37:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y13so13219671ejp.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X8yx3jckCZmr5NFldefZzVfRylzf/1G6QmLY78A9l0U=;
        b=BS2RBlezBPUrbV+l1MYZOM3IEWN7Z6Gv1Em0cM4cB3we+k9xxHgrSLOaFUyHuBv+rN
         lrEAbehsTBQBT64rwD0N0UztiCJR58cRVT7KjIgcc3DIiWeUbP8nXvhHSnMMsq5X9Mz5
         U1GBd8PWvoogOfnzJyb21nkBPRMWTqhmreTdGlMRcZOqG4AOnzmV1CwHMGn6/c+7KsU1
         4LgOF+U/BzNhFmRCKLKlQyjPHwX8i4XJ2BX6HajNINHV7E9HeS88PR+X4P29mAa6LjQf
         drrDFMiUuF+4AZRfZJZZPFrpiT9Fnh80tJqturg0qCSpzXajq8l7Q5VlsGXLDlCF1Gi9
         Sm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X8yx3jckCZmr5NFldefZzVfRylzf/1G6QmLY78A9l0U=;
        b=Bj9F9mEa7ZrSzuSRM42htdJEdd9//rRXDCVbSmtWbnwSD4+S8NbPAMRdQptkd3xAp6
         aVjIKhyw6N6CScQuO2JJov4XY/aY1EoDuXUql2RVaHzfbbbLGQbOUndmYJFZQBu6zksb
         0uGjbQ/LYS9MS5kC7kfUOXtsmObGGudNdtANe44d09Gr1t68wC95l5SyFv6ekaWUK7b0
         Xl2vndWf1hJV3QYmYKqRh8sXAeEx2swmMi6NrdUxT8SECh0Y22iGsyAMFky+zmUgyIbZ
         lDgpTCRHijUVwxhwrtPSsKi4RU74BfcI2bLz3shNhazjEFb8Kvap5XH78aGJSWzmz66I
         tWGw==
X-Gm-Message-State: ACgBeo31E6UtKHVdBnwwcp1Cwf31CiWrymPG1U5fjoFiBoutNWH4pFQ3
        J5H6uOTZ9tCfVCg0o8gZJucOw+kHIlo=
X-Google-Smtp-Source: AA6agR4Q84LfxAF+TbzPh7pQn2n9tOnehkStvhHca5/QDrBlKR2ErCWHV9CTGNr1JtxKJ2cBhlsMbg==
X-Received: by 2002:a17:907:2ccb:b0:730:aaca:fc10 with SMTP id hg11-20020a1709072ccb00b00730aacafc10mr766604ejc.153.1659461877226;
        Tue, 02 Aug 2022 10:37:57 -0700 (PDT)
Received: from localhost (84-236-109-245.pool.digikabel.hu. [84.236.109.245])
        by smtp.gmail.com with ESMTPSA id b7-20020aa7cd07000000b0043a87e6196esm8586851edw.6.2022.08.02.10.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:37:56 -0700 (PDT)
Date:   Tue, 2 Aug 2022 19:37:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Message-ID: <20220802173754.GA10040@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-2-szeder.dev@gmail.com>
 <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 04:31:40PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jul 25 2022, SZEDER Gábor wrote:
> 
> > Our Bash completion script can complete --options for commands using
> > parse-options even when that command doesn't have a dedicated
> > completion function, but to do so the completion script must know
> > which commands use parse-options and which don't.  Therefore, commands
> > not using parse-options are marked in 'git.c's command list with the
> > NO_PARSEOPT flag.
> >
> > Update this list, and remove this flag from the commands that by now
> > use parse-options.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  git.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/git.c b/git.c
> > index e5d62fa5a9..c4282f194a 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -489,14 +489,14 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
> >  static struct cmd_struct commands[] = {
> >  	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
> >  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
> > -	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
> > +	{ "annotate", cmd_annotate, RUN_SETUP },
> >  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
> >  	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
> >  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
> >  	{ "blame", cmd_blame, RUN_SETUP },
> >  	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
> >  	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
> > -	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
> > +	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
> >  	{ "cat-file", cmd_cat_file, RUN_SETUP },
> >  	{ "check-attr", cmd_check_attr, RUN_SETUP },
> >  	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
> > @@ -514,7 +514,7 @@ static struct cmd_struct commands[] = {
> >  	{ "column", cmd_column, RUN_SETUP_GENTLY },
> >  	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
> >  	{ "commit-graph", cmd_commit_graph, RUN_SETUP },
> > -	{ "commit-tree", cmd_commit_tree, RUN_SETUP | NO_PARSEOPT },
> > +	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
> >  	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
> >  	{ "count-objects", cmd_count_objects, RUN_SETUP },
> >  	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
> > @@ -553,7 +553,7 @@ static struct cmd_struct commands[] = {
> >  	{ "ls-files", cmd_ls_files, RUN_SETUP },
> >  	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
> >  	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
> > -	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
> > +	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
> >  	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
> >  	{ "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
> >  	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
> > @@ -566,7 +566,7 @@ static struct cmd_struct commands[] = {
> >  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> >  	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
> >  	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
> > -	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
> > +	{ "mktag", cmd_mktag, RUN_SETUP },
> >  	{ "mktree", cmd_mktree, RUN_SETUP },
> >  	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
> >  	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
> > @@ -627,7 +627,7 @@ static struct cmd_struct commands[] = {
> >  	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
> >  	{ "version", cmd_version },
> >  	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
> > -	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
> > +	{ "worktree", cmd_worktree, RUN_SETUP },
> >  	{ "write-tree", cmd_write_tree, RUN_SETUP },
> >  };
> 
> I have a superset of this change in my local tree:
> https://github.com/avar/git/commit/f0076de17fd
> 
> I.e. "parseopt" here really means "handles --git-completion-helper"

Indeed, with additional subtleties, like it doesn't try to read from
stdin before handling '--git-completion-helper'.

> so
> we can also address the diff family here. See the test that's associated
> with the change (which you might want to grab in any case, i.e. to have
> tests in this area).

Dunno.  I don't like this NO_PARSEOPT thing, and instead of testing it
I'm thinking about removing it altogether.  It seems to be doable, but
of course conflicts with the upcoming 'completion-subcommand' patch
series, so I'll leave it for later.

  https://github.com/szeder/git/commits/completion-poc-builtins

