From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #04; Thu, 20)
Date: Thu, 20 Mar 2014 15:31:35 -0700
Message-ID: <xmqqsiqcwlh4.fsf@gitster.dls.corp.google.com>
References: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Mar 20 23:31:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQlV6-0002Ay-3k
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934001AbaCTWbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 18:31:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47459 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933900AbaCTWbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 18:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26EFC76DEA;
	Thu, 20 Mar 2014 18:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kaFptoF01kB6NArav+hLvGIs96M=; b=eXCrqo
	xYKn+D//U4sKjTF5eWL6gvQVddDxGMBCwy8pGesHm70J6xRdpESkLWLZGFp6FDlz
	ATCIfQH78PKGEfWXGY0O3Vfc9xXoS5FsZ39q4PobKdT+OvU9+mfVz0r/miX6d87c
	7UqbDSxOBhX2E1HK/DIS24xc/55h028Nky3ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MqAYzOMlqJRXS4mwRbKDSz0RHPA9uAcI
	Wkmzh3inZMsBdrVvdgQmfAYUwlzvUDozLKMXHt/WMVY8M2ilQAMrosA/y7FVJN6H
	cpY7eadBW//R5CoPIuaGBkLFz36chLWEYLyZV1vqN462f15bBBBLEEeQXUUqJA62
	FUmp0TjFLWI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11B3576DE9;
	Thu, 20 Mar 2014 18:31:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1428B76DE6;
	Thu, 20 Mar 2014 18:31:38 -0400 (EDT)
In-Reply-To: <xmqq4n2sy3ux.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 20 Mar 2014 14:09:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 66A8840C-B07F-11E3-8587-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244594>

Junio C Hamano <gitster@pobox.com> writes:

> Quite a few topics are still outside 'pu' and I suspect some of the
> larger ones deserve deeper reviews to help moving them to 'next'.
> In principle, I'd prefer to keep any large topic that touch core
> part of the system cooking in 'next' for at least a full cycle, and
> the sooner they get merged to 'next', the better.  Help is greatly
> appreciated.
> ...
> * ks/tree-diff-nway (2014-03-04) 19 commits
>  - combine-diff: speed it up, by using multiparent diff tree-walker directly
>  - tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
>  - Portable alloca for Git
>  - tree-diff: reuse base str(buf) memory on sub-tree recursion
>  - tree-diff: no need to call "full" diff_tree_sha1 from show_path()
>  - tree-diff: rework diff_tree interface to be sha1 based
>  - tree-diff: diff_tree() should now be static
>  - tree-diff: remove special-case diff-emitting code for empty-tree cases
>  - tree-diff: simplify tree_entry_pathcmp
>  - tree-diff: show_path prototype is not needed anymore
>  - tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
>  - tree-diff: move all action-taking code out of compare_tree_entry()
>  - tree-diff: don't assume compare_tree_entry() returns -1,0,1
>  - tree-diff: consolidate code for emitting diffs and recursion in one place
>  - tree-diff: show_tree() is not needed
>  - tree-diff: no need to pass match to skip_uninteresting()
>  - tree-diff: no need to manually verify that there is no mode change for a path
>  - combine-diff: move changed-paths scanning logic into its own function
>  - combine-diff: move show_log_first logic/action out of paths scanning
>
>  Instead of running N pair-wise diff-trees when inspecting a
>  N-parent merge, find the set of paths that were touched by walking
>  N+1 trees in parallel.  These set of paths can then be turned into
>  N pair-wise diff-tree results to be processed through rename
>  detections and such.  And N=2 case nicely degenerates to the usual
>  2-way diff-tree, which is very nice.

So I started re-reading this series, and decided that it might be
easier to advance the topic piece-by-piece.  Will be merging up to
"consolidate code for emitting diffs" to 'next', after tweaking that
last commit a bit (see below).

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Currently both compare_tree_entry() and show_path() invoke opt diff

s/show_path/show_entry/;

> callbacks (opt->add_remove() and opt->change()), and also they both have
> code which decides whether to recurse into sub-tree, and whether to emit
> a tree as separate entry if DIFF_OPT_TREE_IN_RECURSIVE is set.
>
> I.e. we have code duplication and logic scattered on two places.
>
> Let's consolidate it...
> ...
> +/* convert path, t1/t2 -> opt->diff_*() callbacks */
> +static void emit_diff(struct diff_options *opt, struct strbuf *path,
> +		      struct tree_desc *t1, struct tree_desc *t2)
> +{
> +	unsigned int mode1 = t1 ? t1->entry.mode : 0;
> +	unsigned int mode2 = t2 ? t2->entry.mode : 0;
> +
> +	if (mode1 && mode2) {
> +		opt->change(opt, mode1, mode2, t1->entry.sha1, t2->entry.sha1,
> +			1, 1, path->buf, 0, 0);

This is not too bad per-se, but it would have been even better if
this part was done as:

	if (t1 && t2) {
		opt->change(opt, t1->entry.mode1, t1->entry.mode2,
                	    t1->entry.sha1, t2->entry.sha1,
			    1, 1, path->buf, 0, 0);
	}

Then we do not have to rely on an extra convention, "'mode == 0'
means the entry is missing", in addition to what we already have,
i.e. "t == NULL means the entry is missing".

This is minor, so I will not squash such a change in while merging
to 'next', but we may want to revisit and fix it up as a follow up
patch once the series is settled.

> +	}
> +	else {

Style; I've merged these two lines into one, i.e.

	} else {

There was another instance of it in show_path(), which I also
tweaked.

Thanks.
