From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] format-patch: add '--base' option to record base tree info
Date: Thu, 31 Mar 2016 10:38:04 -0700
Message-ID: <xmqqy48yo8eb.fsf@gitster.mtv.corp.google.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
	<1459388776-18066-3-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 19:38:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1algXt-0006l3-JF
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 19:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbcCaRiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 13:38:08 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752228AbcCaRiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 13:38:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1ED2F520BB;
	Thu, 31 Mar 2016 13:38:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NHsUoN80/ttLEVsC5v7HWAR2wqQ=; b=tns1+R
	ePDkZHYVUgSKIZ7Yu1OLRIE4pn46bnLGUVeNOQSkMM9mGT3NXPYvU7Pb3tsWgfAk
	B4G4MU2Hxs00lhsXpESjp/grY/b3Xt0zopQaSh5pVmUTYuGUz7n3RnUVGyX8psku
	IedqeTdy7zCXo3sMOWUk1Y+LBosLUcPuVjsAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Paxq8xUBxF8HGKHYeg9hukc3VwJLrXUZ
	hgHAp3srUyzjfJT58W2cEdgLjJ1TFUasBvYpXpEobp53C+JkRyN6pGsuS0OxM/cq
	jKE3YRkkBwC6BlG/nNYtTl9woSbtHbFfo/WGc2UwbycbYD94lM7hob5XAPU2DCj8
	Ou7vyXXZ5hw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 166FB520BA;
	Thu, 31 Mar 2016 13:38:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7474F520B9;
	Thu, 31 Mar 2016 13:38:05 -0400 (EDT)
In-Reply-To: <1459388776-18066-3-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Thu, 31 Mar 2016 09:46:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 533D5D12-F767-11E5-9D8E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290429>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> Maintainers or third party testers may want to know the exact base tree
> the patch series applies to. Teach git format-patch a '--base' option to
> record the base tree info and append this information at the end of the
> _first_ message (either the cover letter or the first patch in the series).

You'd need a description of what "base tree info" consists of as a
separate paragraph after the above paragraph.  I'd also suggest to

	s/and append this information/and append it/;

Based on my understanding of what you consider "base tree info", it
may look like this, but you know your design better, so I'd expect
you to rewrite it to be more useful, or at least to fill in the
blanks.

	The base tree info consists of the "base commit", which is a
	well-known commit that is part of the stable part of the
	project history everybody else works off of, and zero or
	more "prerequisite patches", which are well-known patches in
	flight that is not yet part of the "base commit" that need
	to be applied on top of "base commit" ???IN WHAT ORDER???
	before the patches can be applied.

	"base commit" is shown as "base-commit: " followed by the
	40-hex of the commit object name.  A "prerequisite patch" is
	shown as "prerequisite-patch-id: " followed by the 40-hex
	"patch id", which can be obtained by ???DOING WHAT???

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Wu Fengguang <fengguang.wu@intel.com>
> Signed-off-by: Xiaolong Ye <xiaolong.ye@intel.com>
> ---
>  Documentation/git-format-patch.txt | 25 +++++++++++
>  builtin/log.c                      | 89 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 114 insertions(+)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 6821441..067d562 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -265,6 +265,31 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
>    Output an all-zero hash in each patch's From header instead
>    of the hash of the commit.
>  
> +--base=<commit>::
> +	Record the base tree information to identify the whole tree
> +	the patch series applies to. For example, the patch submitter
> +	has a commit history of this shape:
> +
> +	---P---X---Y---Z---A---B---C
> +
> +	where "P" is the well-known public commit (e.g. one in Linus's tree),
> +	"X", "Y", "Z" are prerequisite patches in flight, and "A", "B", "C"
> +	are the work being sent out, the submitter could say "git format-patch
> +	--base=P -3 C" (or variants thereof, e.g. with "--cover" or using
> +	"Z..C" instead of "-3 C" to specify the range), and the identifiers
> +	for P, X, Y, Z are appended at the end of the _first_ message (either
> +	the cover letter or the first patch in the series).
> +
> +	For non-linear topology, such as
> +
> +	    ---P---X---A---M---C
> +		\         /
> +		 Y---Z---B
> +
> +	the submitter could also use "git format-patch --base=P -3 C" to generate
> +	patches for A, B and C, and the identifiers for P, X, Y, Z are appended
> +	at the end of the _first_ message.

The contents of this look OK, but does it format correctly via
AsciiDoc?  I suspect that only the first paragraph up to "of this
shape:" would appear correctly and all the rest would become funny.

Also the definition of "base tree information" you need to have in
the log message should be given somewhere in this documentation, not
necessarily in the documentation of --base=<commit> option.

Because the use of this new option is not an essential part of
workflow of all users of format-patch, it may be a good idea to have
its own separate section, perhaps between the "DISCUSSION" and
"EXAMPLES" sections, titled "BASE TREE IDENTIFICATION", move the
bulk of text above there with the specification of what "base tree
info" consists of there.

And shorten the description of the option to something like:

--base=<commit>::
	Record the base tree information to identify the state the
	patch series applies to.  See the BASE TREE IDENTIFICATION
        section below for details.

or something.

> diff --git a/builtin/log.c b/builtin/log.c
> index 0d738d6..03cbab0 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1185,6 +1185,82 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
>  	return 0;
>  }
>  
> +struct base_tree_info {
> +	struct object_id base_commit;
> +	int nr_patch_id, alloc_patch_id;
> +	struct object_id *patch_id;
> +};
> +
> +static void prepare_bases(struct base_tree_info *bases,
> +			  const char *base_commit,
> +			  struct commit **list,
> +			  int total)
> +{
> +	struct commit *base = NULL, *commit;
> +	struct rev_info revs;
> +	struct diff_options diffopt;
> +	struct object_id *patch_id;
> +	unsigned char sha1[20];
> +	int i;
> +
> +	diff_setup(&diffopt);
> +	DIFF_OPT_SET(&diffopt, RECURSIVE);
> +	diff_setup_done(&diffopt);
> +
> +	base = lookup_commit_reference_by_name(base_commit);
> +	if (!base)
> +		die(_("Unknown commit %s"), base_commit);
> +	oidcpy(&bases->base_commit, &base->object.oid);
> +
> +	init_revisions(&revs, NULL);
> +	revs.max_parents = 1;
> +	base->object.flags |= UNINTERESTING;
> +	add_pending_object(&revs, &base->object, "base");
> +	for (i = 0; i < total; i++) {
> +		list[i]->object.flags |= 0;

What does this statement do, exactly?  Are you clearing some bits
but not others, and if so which ones?

> +		add_pending_object(&revs, &list[i]->object, "rev_list");
> +		list[i]->util = (void *)1;

Are we sure commit objects not on the list have their ->util cleared?
The while() loop below seems to rely on that to correctly filter out
the ones that are on the list.

> +	}
> +
> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));
> +	/*
> +	 * Traverse the prerequisite commits list,
> +	 * get the patch ids and stuff them in bases structure.
> +	 */
> +	while ((commit = get_revision(&revs)) != NULL) {
> +		if (commit->util)
> +			continue;
> +		if (commit_patch_id(commit, &diffopt, sha1))
> +			die(_("cannot get patch id"));
> +		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
> +		patch_id = bases->patch_id + bases->nr_patch_id;
> +		hashcpy(patch_id->hash, sha1);

The variable patch_id is used only once here.  Perhaps either write

	hashcpy(bases->patch_id[bases->nr_patch_id]->hash, sha1);

to get rid of the variable, or move its declaration inside the
while() loop to limit its scope?

Has this traversal been told, when setting up the &revs structure,
to show commits in specific order (like "topo order")?  Should it
be?

> +		bases->nr_patch_id++;
> +	}
> +}
> +
> +static void print_bases(struct base_tree_info *bases)
> +{
> +	int i;
> +
> +	/* Only do this once, either for the cover or for the first one */
> +	if (is_null_oid(&bases->base_commit))
> +		return;
> +
> +	/* Show the base commit */
> +	printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
> +
> +	/* Show the prerequisite patches */
> +	for (i = 0; i < bases->nr_patch_id; i++)
> +		printf("prerequisite-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));

This shows the patches in the order discovered by the revision
traversal, which typically is newer to older.  Is that intended?
Is it assumed that the order of the patches does not matter?

> @@ -1209,6 +1285,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)

The remainder of the patch looks very sensible, including the call
to reset_revision_walk().

Thanks.
