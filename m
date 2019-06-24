Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1BEC1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFXNVZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:21:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46336 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFXNVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:21:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id h21so14340768qtn.13
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JLWmK708GsmxE8MunJ0MwsN4s6UvPd5rFuYuKrJ5a/o=;
        b=I/psItrugsXlXf/NGoIlpMv7v+Na4oqUyexM1YfXqdTBYxZw+ouyEDXuJGvnBy21bm
         EFUqAkHGOhpXzDuJOF51GL9GWjR/pz1P7Z5f24pyQDEnRQoqS2OaTK8pHsSO9Rw1gIEE
         DVNxoyszwaIdS82pRx5snkc/KyB17hSHVmvfaSGF7GdQO2XLNQNrs2/rFPYyyUlLp/9F
         JEpZFGABUDJbm6hqXCnk7TkG7pig/CorfudoAMFj7su+N2aj5vrl/nwoW6czMTbIJckO
         0Czyg/tQisri/dvpsZpBhamVkUrh8DPTna0qMleZ4ZxR+Var7ETpxs1as9k/nil8oE2U
         bVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JLWmK708GsmxE8MunJ0MwsN4s6UvPd5rFuYuKrJ5a/o=;
        b=dqhz4mRZvbKjPcxY+IIeYtNF1aRcKLJ689EZOY84C2saKGcgsY6PpPKVR6IF+YW/vL
         klwgRmM77wf1uTD20ajbwB6j2pync3CHS2jFsaxibezcDSmsdYvgLw2KV7m/kyxFTC4p
         V+KjtbraD7kyaVIRtjf/CrAnDU6LN3NR9PfCndvvURqexfGwzphMWSI1pAhxVBmuukZv
         KB5hjUPWN6Q6Xv6w08tnuTor6gjY8/VhMgMDFOsHtQT6QRiBsBDb3B7fATeC2AtINCII
         4MRxS1iJKPl446X4eEtVfX+h0SDduvlDCB/4tKSxe3LGLMQYKNo5M/Z4sJzb5XurIMGr
         lM5Q==
X-Gm-Message-State: APjAAAWjq5VSre4sJ5GJDv0Pn/GeD7VpjmO0Jh6OqIySTNa/XYyU1VOO
        7MksIDAYgz9UhSj1heqZv2idADJj
X-Google-Smtp-Source: APXvYqw9LL8YYcwYkqiSXfE192bbrQnTNzB1N22rzEu36caudpPHOgW1MKrJ0IRnO86FOsSjNtnJzw==
X-Received: by 2002:a0c:fb07:: with SMTP id c7mr58815395qvp.229.1561382484110;
        Mon, 24 Jun 2019 06:21:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd0b:1518:483a:73eb? ([2001:4898:a800:1012:6e3f:1518:483a:73eb])
        by smtp.gmail.com with ESMTPSA id c127sm5297993qkg.121.2019.06.24.06.21.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:21:23 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] repack: optionally assume transitive kept packs
To:     Nathaniel Filardo <nwf20@cl.cam.ac.uk>, git@vger.kernel.org
References: <20190624120711.27744-1-nwf20@cl.cam.ac.uk>
 <20190624120711.27744-5-nwf20@cl.cam.ac.uk>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fbbbbd2e-3f0f-ffbb-e617-220602c9950f@gmail.com>
Date:   Mon, 24 Jun 2019 09:21:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624120711.27744-5-nwf20@cl.cam.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2019 8:07 AM, Nathaniel Filardo wrote:
> If the user is careful to mark .pack files as kept only when they refer
> to (other) kept packs, then we can rely on this when walking the object
> graph in subsequent repack operations and reduce the time and memory
> spent building the object graph.
> 
> Towards that end, then, teach git repack to enumerate the COMMITs and
> TREEs in kept packs and mark them as UNINTERESTING for pack-object's
> operation.  Because this creates UNINTERESTING marks, we make repack's
> --assume-pack-keep-transitive imply --sparse for pack-object to avoid
> hauling the entire object graph into memory.
> 
> In testing with a 203GB repository with 80M objects, this amounts to
> several gigabytes of memory and over ten minutes saved.  This machine
> has 32G of RAM and the repository is on a fast SSD to speed testing.

Thanks for the performance details!

> All told, this test repository takes about 33 minutes elapsed (28
> minutes in user code) and 3 GB of RAM to repack 12M objects occupying
> 33GB scattered across 477 pack files not marked as kept (the remainder
> of the objects are spread across three kept pack files).  The time and
> RAM usage with --assume-pack-keep-transitive should be dominated by
> factors proportional to the size and number of un-kept objects.
> 
> Without these optimizations, it takes about 45 minutes (34 minutes in
> user code) and 7 GB of RAM to compute the same pack file.  The extra
> time and total memory use are expected to be proportional to the kept
> packs' size, not the working set of the repack.  The time discrepancy
> can be expected to be more dramatic when the repository is on spinning
> rust rather than SSD.
> 
> Signed-off-by: Nathaniel Filardo <nwf20@cl.cam.ac.uk>
> ---
>  Documentation/git-repack.txt | 21 +++++++++++++
>  builtin/repack.c             | 57 ++++++++++++++++++++++++++++++++++--
>  2 files changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index 836d81457a..014812c4bb 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -169,6 +169,27 @@ depth is 4095.
>  	Pass the `--sparse` option to `git-pack-objects`; see
>  	linkgit:git-pack-objects[1].
>  
> +--assume-pack-keep-transitive::
> +	This flag accelerates the search for objects to pack by assuming
> +	that commit objects found in kept packfiles make reference only
> +	to that or other kept packfiles.  This is very useful if, for
> +	example, this repository periodically repacks all reachable objects
> +	and marks the resulting pack file as kept.
> +
> +	Because this option may prevent git from descending into kept packs,
> +	no objects inside kept packs will be available for delta processing.
> +	One should therefore restrict the use of this option to situations
> +	where delta processing is disabled or when relatively large amounts
> +	of data are considered and the relative gain of a wider set of
> +	possible delta base objects is reduced.
> +
> +	The simplest way to ensure transitivity of kept packs is to run `git
> +	repack` with `-a` (or `-A`) and `-d` and mark all resulting packs as
> +	kept, never removing the kept marker.  In practice, one may wish to
> +	wait to mark packs as kept until they are sufficiently large
> +	(reducing the number of pack files necessary for a given set of
> +	objects) but not so large as to be unwieldy.
> +
>  Configuration
>  -------------
>  
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 4cfdd62bb8..a2cd479686 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -11,6 +11,8 @@
>  #include "midx.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "revision.h"
> +#include "list-objects.h"
>  
>  static int delta_base_offset = 1;
>  static int pack_kept_objects = -1;
> @@ -256,6 +258,30 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
>  		die(_("could not finish pack-objects to repack promisor objects"));
>  }
>  
> +static void apkt_show_commit(struct commit *commit, void *data)
> +{
> +	struct tree *tree;
> +	struct pack_entry e;
> +
> +	if (!find_pack_entry(the_repository, &commit->object.oid, &e))
> +		return;
> +
> +	if (!(e.p->pack_keep || e.p->pack_keep_in_core))
> +		return;
> +
> +	tree = get_commit_tree(commit);
> +	if (tree)
> +		tree->object.flags |= UNINTERESTING;
> +
> +	write_oid(&commit->object.oid, e.p, 0, data);
> +	write_oid(&tree->object.oid, NULL, 0, data);
> +}
> +
> +static void apkt_show_object(struct object *obj, const char *name, void *data)
> +{
> +	return;
> +}
> +
>  #define ALL_INTO_ONE 1
>  #define LOOSEN_UNREACHABLE 2
>  
> @@ -287,6 +313,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
>  	int no_update_server_info = 0;
>  	int midx_cleared = 0;
> +	int assume_pack_keep_transitive = 0;
>  	struct pack_objects_args po_args = {NULL};
>  	int sparse = 0;
>  
> @@ -329,6 +356,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  				N_("repack objects in packs marked with .keep")),
>  		OPT_BOOL(0, "sparse", &sparse,
>  			 N_("use the sparse reachability algorithm")),
> +		OPT_BOOL(0, "assume-pack-keep-transitive", &assume_pack_keep_transitive,
> +				N_("assume kept packs reference only kept packs")),
>  		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
>  				N_("do not repack this pack")),
>  		OPT_END()
> @@ -346,6 +375,11 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
>  		die(_("--keep-unreachable and -A are incompatible"));
>  
> +	if (assume_pack_keep_transitive) {
> +		/* imply --honor-pack-keep */
> +		pack_kept_objects = 0;
> +	}
> +

If you also set `sparse = 1;` here, then...

> -	if (sparse)
> +	if (sparse || assume_pack_keep_transitive)
>  		argv_array_push(&cmd.args, "--sparse");

...this logic can stay the same. And be simpler.

>  	if (repository_format_partial_clone)
>  		argv_array_push(&cmd.args, "--exclude-promisor-objects");
> @@ -407,12 +441,31 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  		argv_array_push(&cmd.args, "--incremental");
>  	}
>  
> -	cmd.no_stdin = 1;
> +	cmd.in = -1;
> +	cmd.no_stdin = !assume_pack_keep_transitive;

I wonder if this `cmd.in = -1;` needs to be here, or should be in
the `if (assume_pack_keep_transitive)` block below.

>  
>  	ret = start_command(&cmd);
>  	if (ret)
>  		return ret;
>  
> +	if (assume_pack_keep_transitive) {
> +		struct rev_info revs;
> +		const char *revargv[] = { "skip", "--all", "--reflog", "--indexed-objects", NULL };
> +
> +		repo_init_revisions(the_repository, &revs, NULL);

> +		revs.sparse_tree_walk = !!(sparse || assume_pack_keep_transitive);

Here is the bitflag! Excellent. Again, this can be simplified if we set `sparse = 1`
in the first assume_pack_keep_transitive block.

> +		setup_revisions(sizeof(revargv)/sizeof(revargv[0]) - 1 , revargv, &revs, NULL);

Some whitespace strangeness on this line.

> +		if (prepare_revision_walk(&revs))
> +			die("revision walk setup failed");

This string should be localizable. It's not entirely your fault, since running
'git grep -A 1 prepare_revision_walk' shows a variety of different uses, most
of which don't use the localizable string, but enough do that you could add it
here.

> +
> +		xwrite(cmd.in, "--not\n", 6);
> +		traverse_commit_list(&revs, apkt_show_commit, apkt_show_object,
> +				     &cmd);
> +		xwrite(cmd.in, "--not\n", 6);
> +
> +		close(cmd.in);
> +	}
> +
>  	out = xfdopen(cmd.out, "r");
>  	while (strbuf_getline_lf(&line, out) != EOF) {
>  		if (line.len != the_hash_algo->hexsz)
> 

