Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4789C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 14:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbiGYOd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiGYOdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 10:33:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E08175AA
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:33:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b11so20870355eju.10
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KnV00dN9uHIw40YToW0faGA9Ph/4DNvnPLmNBi+Y7JQ=;
        b=eOK3FszN+9bqaonNwdGACl3xzlU7gApu43E7m68bINWUkXU4GaVCEcroN0KY3Hehyg
         cN8Zf8fhwfVlxDA8O6/U6UdQHE/URhDqpzWy8W3dNkUK7kPshKIsxog4pIs+qqHZoweY
         K4M2Al+aqQYJK9iK5v9TBJpoQTcCLF3svpAD32rsXiaforN+zCvdwiOjeovQt9k8hoTK
         Ca6mzjakUrSNHvewhUDlvtz9QlwJSZLs1pDG49jIKH8xQalYXpfHHXccKQsWpzSTqEkH
         f3x581lSAK+mA8LEq1dfSa6EDSajtYiNp7qGGBtHEbg1WHgpQDLDKQvcQoLrbikWJOH+
         H6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KnV00dN9uHIw40YToW0faGA9Ph/4DNvnPLmNBi+Y7JQ=;
        b=l4rwZ1rZsJRgIrqBZz1XHSWhHrtQk7LVVkggEO6OeZ//NaRpS9Jc1iEFGHgleXCgxP
         iOkyONkF7MC3WYu0x2MtEdDaHKTbSooRvKf/5mBGLg4Sk1I7nfZ2ywLn21OWLwIRAZtd
         tWUbCyiQR6OT8UpcdpquzVGqQoyFVqFvBteWxOLcg6bEpXenLg3tP+UT5gOjsK4ghIeK
         RXw0BbuOSP71iucqVgMteaLXWBg1VWQgKzmKEbJ8dSWEd5t7WGtAiqoTsUN4hR5eq/Ih
         JFLgvpodJkCheYrqFmjsaVVGubFnZDa4J+MUaKql8HkmDrsk0H8fJirfIdBRUsuljp2S
         a8RQ==
X-Gm-Message-State: AJIora+4xT+eOKG5uhSh3RkTKbrgWX9RJiUloPTXQuHloepZONY7Exmw
        AUp/vxZ4ePGbx4V5MI52e5I6mIEdqrA=
X-Google-Smtp-Source: AGRyM1v/cy4iZUM8nWd036JWfZbdoR4AyJ88xeJx+HtatrZd7QVLYA56MYqyo/x84UFO3eJVvT2hnw==
X-Received: by 2002:a17:907:272a:b0:72b:8cd9:9ddd with SMTP id d10-20020a170907272a00b0072b8cd99dddmr10582240ejl.299.1658759597974;
        Mon, 25 Jul 2022 07:33:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b0072b3182368fsm5391243ejc.77.2022.07.25.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 07:33:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFz92-005k88-Ml;
        Mon, 25 Jul 2022 16:33:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
Date:   Mon, 25 Jul 2022 16:31:40 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-2-szeder.dev@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220725123857.2773963-2-szeder.dev@gmail.com>
Message-ID: <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, SZEDER G=C3=A1bor wrote:

> Our Bash completion script can complete --options for commands using
> parse-options even when that command doesn't have a dedicated
> completion function, but to do so the completion script must know
> which commands use parse-options and which don't.  Therefore, commands
> not using parse-options are marked in 'git.c's command list with the
> NO_PARSEOPT flag.
>
> Update this list, and remove this flag from the commands that by now
> use parse-options.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  git.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/git.c b/git.c
> index e5d62fa5a9..c4282f194a 100644
> --- a/git.c
> +++ b/git.c
> @@ -489,14 +489,14 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
>  static struct cmd_struct commands[] =3D {
>  	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
>  	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
> -	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
> +	{ "annotate", cmd_annotate, RUN_SETUP },
>  	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
>  	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
>  	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
>  	{ "blame", cmd_blame, RUN_SETUP },
>  	{ "branch", cmd_branch, RUN_SETUP | DELAY_PAGER_CONFIG },
>  	{ "bugreport", cmd_bugreport, RUN_SETUP_GENTLY },
> -	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY | NO_PARSEOPT },
> +	{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
>  	{ "cat-file", cmd_cat_file, RUN_SETUP },
>  	{ "check-attr", cmd_check_attr, RUN_SETUP },
>  	{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
> @@ -514,7 +514,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "column", cmd_column, RUN_SETUP_GENTLY },
>  	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
>  	{ "commit-graph", cmd_commit_graph, RUN_SETUP },
> -	{ "commit-tree", cmd_commit_tree, RUN_SETUP | NO_PARSEOPT },
> +	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
>  	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
>  	{ "count-objects", cmd_count_objects, RUN_SETUP },
>  	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
> @@ -553,7 +553,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "ls-files", cmd_ls_files, RUN_SETUP },
>  	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
>  	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
> -	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
> +	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
>  	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
>  	{ "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
>  	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
> @@ -566,7 +566,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_=
TREE | NO_PARSEOPT },
>  	{ "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO=
_PARSEOPT },
>  	{ "merge-tree", cmd_merge_tree, RUN_SETUP },
> -	{ "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
> +	{ "mktag", cmd_mktag, RUN_SETUP },
>  	{ "mktree", cmd_mktree, RUN_SETUP },
>  	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
>  	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
> @@ -627,7 +627,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
>  	{ "version", cmd_version },
>  	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
> -	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
> +	{ "worktree", cmd_worktree, RUN_SETUP },
>  	{ "write-tree", cmd_write_tree, RUN_SETUP },
>  };

I have a superset of this change in my local tree:
https://github.com/avar/git/commit/f0076de17fd

I.e. "parseopt" here really means "handles --git-completion-helper", so
we can also address the diff family here. See the test that's associated
with the change (which you might want to grab in any case, i.e. to have
tests in this area).

But as far as this goes this looks good to me.

