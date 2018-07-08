Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E741F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 21:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933003AbeGHVbq (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 17:31:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:47445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932834AbeGHVbp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 17:31:45 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvhC4-1gAN3024vk-017Z1p; Sun, 08
 Jul 2018 23:31:38 +0200
Date:   Sun, 8 Jul 2018 23:31:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratik Karki <predatoramigo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 3/4] sequencer: refactor the code to detach HEAD to
 checkout.c
In-Reply-To: <20180708180104.17921-4-predatoramigo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807082315350.75@tvgsbejvaqbjf.bet>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180708180104.17921-1-predatoramigo@gmail.com> <20180708180104.17921-4-predatoramigo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y3Wi6KgyaUhl+ZIBcBnaKDtGNKYwlB7NLPakgc9uii5YLVOq+JY
 ZIE4uiKurMpP37UGoXQHndNiLGpyIP3K3Z8aLtk5zg0X7t0ohTx6zZakrW92HGhNQ+wDjMc
 Z8gEt/5JJ8d5mInThmzx4i4CDA8sArL7S0PETNUuQm4Gu/+ZarK1D0sQY8CyWQbO4CTbkHp
 +j7gTY9GpXBxKNLub3rzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4sKB3ADj2Sg=:V3Uug1ioOPFSveB8iDXnOQ
 0hz6Ap/KBy0gjumRcJZ3307S1chMA/q/SH9pZb+uVwgDZ9FUcThGtfGvtuF27vbar2ah/b567
 mD11CMAKbjHI8vOZBXJepjW4tvBd8BvUw2th38vfwCW3FwfEtpoj0dglaBeSCjTUwS3WSbhAp
 tUP28i+Q9dvHpLcY+Rke3tMEcxRrmwHowypQoBEJ58auCnbkX5qEEYfyQIH2iRDadqMnP5Rdn
 CERJ/CIDzt6sw+2dL/gGx3qZ8o5i1r2IVJzUZSBMkeyDGL3ZaK0pV6pcOXqp0K/sBr9eEyM3e
 zusmr7h1QDkwZCwKJD2Uq/O/XSYfoiRls5YaTyymTCzDHldMBW0+J14Z1sMmVMtpC2l7TyzBB
 he7yQCSiTkG+p1oV1cfkDYW59kS03ygp/nxuRIP2keGnlP18/AWTtpWBrcTMPtiGtDrtdmgus
 wd+tlmAGgbelvycznB2JxAupp0vBzCqRi/TobLvTvDlK2IJwKNh4rpFGy4wC17Zcm8QTfZvfj
 qMeFEhCdQfxeQKfF4JxxbExYiT3SI4fMd/9492K8QKp8oczRa+WAatNZ7++GzWCGFQ37wH4yH
 kuExF87fErh6L5EyL1/7ok8lNHmuWN9YnTxj9fhA5h7XVmOY3coSeUn4VANVxhJqxrxXqqh8o
 kkfVhDz0Gj6kw3uKBqyGGHeuBTtJxiyYszf4wfgC6A6Kn+v+Qe2KFYtRqQqThYy9BvtbDGEkd
 sjvQq1gjOzcG2V0DiiULjpUJQEbDAOGd5C/ppAavZ4R4GdN1PPoqaXRnQZxJR5jZrd9vP1Jv1
 szFqj9s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

On Sun, 8 Jul 2018, Pratik Karki wrote:

> diff --git a/checkout.c b/checkout.c
> index bdefc888ba..da68915fd7 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -2,6 +2,11 @@
>  #include "remote.h"
>  #include "refspec.h"
>  #include "checkout.h"
> +#include "unpack-trees.h"
> +#include "lockfile.h"
> +#include "refs.h"
> +#include "tree.h"
> +#include "cache-tree.h"
>  
>  struct tracking_name_data {
>  	/* const */ char *src_ref;
> @@ -42,3 +47,62 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
>  	free(cb_data.dst_ref);
>  	return NULL;
>  }
> +
> +int detach_head_to(struct object_id *oid, const char *action,
> +		   const char *reflog_message)
> +{
> +	struct strbuf ref_name = STRBUF_INIT;
> +	struct tree_desc desc;
> +	struct lock_file lock = LOCK_INIT;
> +	struct unpack_trees_options unpack_tree_opts;
> +	struct tree *tree;
> +	int ret = 0;
> +
> +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +		return -1;
> +
> +	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> +	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> +	unpack_tree_opts.head_idx = 1;
> +	unpack_tree_opts.src_index = &the_index;
> +	unpack_tree_opts.dst_index = &the_index;
> +	unpack_tree_opts.fn = oneway_merge;
> +	unpack_tree_opts.merge = 1;
> +	unpack_tree_opts.update = 1;
> +
> +	if (read_cache_unmerged()) {
> +		rollback_lock_file(&lock);
> +		strbuf_release(&ref_name);
> +		return error_resolve_conflict(_(action));
> +	}
> +
> +	if (!fill_tree_descriptor(&desc, oid)) {
> +		error(_("failed to find tree of %s"), oid_to_hex(oid));
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	tree = parse_tree_indirect(oid);
> +	prime_cache_tree(&the_index, tree);
> +
> +	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> +		ret = error(_("could not write index"));
> +	free((void *)desc.buffer);
> +
> +	if (!ret)
> +		ret = update_ref(reflog_message, "HEAD", oid,
> +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);

I noticed that this does not actually detach the HEAD. That is my fault,
of course, as I should have not only suggested refactoring the
`do_reset()` function from `sequencer.c`, but I should also have
remembered that that function has the benefit of *always* acting on a
detached HEAD (because it runs during an interactive rebase), and
therefore does not need to detach it explicitly.

In light of the `reset_hard()` function that you added in a `wip` (see
https://github.com/git/git/pull/505/files#diff-c7361e406139e8cd3a300b80b8f8cc8dR296),
I could imagine that it might be better, after all, to leave `do_reset()`
alone and implement a `reset_hard()` function that also optionally
detaches the `HEAD` (I *think* that the flag `REF_NO_DEREF` would do that
for you).

Alternatively, just update the code in `do_reset()` to use that flag
first, and only *then* extract the code to `checkout.c`.

(I could not resist, and made this quick change on top of your
`wip-rebase`, and together with a couple more, obvious fixups, this lets
t3403 pass. It still needs some things that you have not yet sent to the
mailing list, such as support for `--skip`.)

Ciao,
Dscho

