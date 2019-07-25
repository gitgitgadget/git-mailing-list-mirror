Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4371F462
	for <e@80x24.org>; Thu, 25 Jul 2019 19:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfGYTvI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 15:51:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:48139 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGYTvI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 15:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564084263;
        bh=EsO23/WDj1SvXIOn+tV4RN9foTesYAGqY/0dS7AbJw0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W6+GO4ZUF/no8XT0DbEGRVmf0Lvn7lB6OiDlJIRnQeOpkwrzjUb49+0SpnqWRb2YE
         CWYtTuhwC9bXthO/W+d3QO88XBZmbccB65YhO+Mroaw86LWR6y5WhfL79y+Ixch0XB
         LLcR7RPzotD63u11NZUj8/enPClZTGleR61QlIqE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSutp-1i11JD3d3d-00RtSC; Thu, 25
 Jul 2019 21:51:02 +0200
Date:   Thu, 25 Jul 2019 21:51:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] merge-recursive: exit early if index != head
In-Reply-To: <20190725174611.14802-5-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907252142470.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-5-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rI2wS8AcSEF+4hVmm5JZX/74wPKHlkGshJHSfbMC6wUpg5fhfVR
 yBinwMiO+Ezgx3w2jT1NSqMjOqQ/vIC7SRXQI6mVxgPGgI9ef+SuCzmtIC9S1gYpWIaFB//
 6DFRtBexm+SLhKtFN1CVzqRO8mcZbYizvi10F5O+WDWiT6uqbSuXnNFsthdbXmuGnvfVS0+
 2558TbDiWiYqgwYixA+uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qNBcmEu9hZg=:TtmsXpLgTp7i2wCLUUGCXy
 Hl63yImFBXINkrKNaHXPP4aDkfM6Xz0vRQOdtOETLStHqH01lQMYG1qLGn0Qyp8RmAvl96kA8
 048K102NPY21dmNki8ciy601eUGOvEXgJpfTT9KA1QdmFEIWcfee/IKnfQfntOQ15BE7fC/Z9
 5Cddb2LJZQoZFP/cCpY936Tcw0pY2FiLUayZYNhusHerMxsQ4lx8obakFOH32iZP/NPprhUPo
 KGs+qEebxtPuYohd2Rk3zXVSoMi0U07X1wOlBc0XL6+n1lyLt6UEbDiq2RS9/SjSWBa+r71cm
 lJ94RssBq6xyPwVmo4hR3XJcOh9mlcIF34035ozd8A3J5VmvGLB+8rfYHkZhfla6T51sUJHtl
 3ymbwZjessuSyBznhUhWMgH6RRXZuLKLUK4ZQ0W2Kpm/ltZLrP17Z4x9q3/vus4dIVrrnN8+5
 aVI0KQs233jo6C4ipggyn6a8fzTfELmX/SwWvmBVmNfkR20B/VcN3xlJv6PFZePE0cXbwmAYU
 m6av/KxZURey0CCd7Dg58YJxTZgpaa0zuyKVR7sDVwSYOtraAaMQl0et9FfdERRaFXGso2QYv
 r7gKUUpwkWuXDF9DYYR1Rj/B2UY6MwbTDxk1fmEFSDs2vyv/jqhogncFEut2YynfE7h7vnZVK
 bmlvCLFzMylg9bKv2cTmcjvr1ixQ30BIUtqonon4JKCH/ghJfmuIm0b7x7ZylOFIgBcIWja6L
 77PmS+kpYRBv2Y4vqr7FBpQ1ytW2Q9l03Sir0hsxegqxphmf0/deNIRSTtMCDM0F8fNRezEeh
 I/gV/HtbuF0DQ6g4eHwiaekBP5fXd/fbhjRmGanxl1w+vCgTMH46uu9oThIHzsMz9/RTt7YxP
 AzW3v9HkqA8gyxKoKn4wX47gYx8k6uE7D3huQTN8D5LQnT5j+ASKcLnj/NeOLxtSq+Mwymmk2
 4kgZYI48aW38bvt5q9ivRr+shmQ+kl3Ms2REEJFVo7J29hr1oCuAMNJHyignMInIZL/EwYywT
 aQJ49w8PFLZTvc7p6pdQTOv98U9HtRo2Fxt+AJvIXF12gp/xBy/i3ZDytD8gExXJoJOfLoC39
 1dxUHKpMRzCcvZnSNqS+3uGGMkulmnePa3v
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

> We had a rule to enforce that the index matches head, but it was found
> at the beginning of merge_trees() and would only trigger when
> opt->call_depth was 0.  Since merge_recursive() doesn't call
> merge_trees() until after returning from recursing, this meant that the
> check wasn't triggered by merge_recursive() until it had first finished
> all the intermediate merges to create virtual merge bases.  That is a
> potentially huge amount of computation (and writing of intermediate
> merge results into the .git/objects directory) before it errors out and
> says, in effect, "Sorry, I can't do any merging because you have some
> local changes that would be overwritten."
>
> Further, not enforcing this requirement earlier allowed other bugs (such
> as an unintentional unconditional dropping and reloading of the index in
> merge_recursive() even when no recursion was necessary), to mask bugs in
> other callers (which were fixed in the commit prior to this one).
>
> Make sure we do the index =3D=3D head check at the beginning of the merg=
e,
> and error out immediately if it fails.

Very clear commit message.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 37bb94fb4d..b762ecd7bd 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3381,21 +3381,14 @@ static int process_entry(struct merge_options *o=
pt,
>  	return clean_merge;
>  }
>
> -int merge_trees(struct merge_options *opt,
> -		struct tree *head,
> -		struct tree *merge,
> -		struct tree *common,
> -		struct tree **result)
> +static int merge_trees_internal(struct merge_options *opt,

In other, similar cases, we seem to use the suffix `_1`. Not sure
whether you want to change that here.

> +				struct tree *head,
> +				struct tree *merge,
> +				struct tree *common,
> +				struct tree **result)
>  {
>  	struct index_state *istate =3D opt->repo->index;
>  	int code, clean;
> -	struct strbuf sb =3D STRBUF_INIT;
> -
> -	if (!opt->call_depth && repo_index_has_changes(opt->repo, head, &sb)) =
{
> -		err(opt, _("Your local changes to the following files would be overwr=
itten by merge:\n  %s"),
> -		    sb.buf);
> -		return -1;
> -	}
>
>  	if (opt->subtree_shift) {
>  		merge =3D shift_tree_object(opt->repo, head, merge, opt->subtree_shif=
t);
> @@ -3499,11 +3492,11 @@ static struct commit_list *reverse_commit_list(s=
truct commit_list *list)
>   * Merge the commits h1 and h2, return the resulting virtual
>   * commit object and a flag indicating the cleanness of the merge.
>   */
> -int merge_recursive(struct merge_options *opt,
> -		    struct commit *h1,
> -		    struct commit *h2,
> -		    struct commit_list *ca,
> -		    struct commit **result)
> +static int merge_recursive_internal(struct merge_options *opt,

Same here.

> +				    struct commit *h1,
> +				    struct commit *h2,
> +				    struct commit_list *ca,
> +				    struct commit **result)
>  {
>  	struct commit_list *iter;
>  	struct commit *merged_common_ancestors;
> [...]
> @@ -3596,6 +3589,58 @@ int merge_recursive(struct merge_options *opt,
>  	return clean;
>  }
>
> +static int merge_start(struct merge_options *opt, struct tree *head)

I would prefer to call this something like `check_invariants()` or
something similar.

> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +
> +	assert(opt->branch1 && opt->branch2);
> +
> +	if (repo_index_has_changes(opt->repo, head, &sb)) {
> +		err(opt, _("Your local changes to the following files would be overwr=
itten by merge:\n  %s"),
> +		    sb.buf);

I know that you did not introduce this leak, but maybe we could slip an
`strbuf_release(&sb);` in at this point?

> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void merge_finalize(struct merge_options *opt)
> +{
> +	/* Common code for wrapping up merges will be added here later */
> +}

I was about to comment that this complicates this here diff and that we
should do this when we need it, but I just peeked into the next patch,
and it uses it, so I leave this here paragraph only to show that I
actually reviewed this part, too.

And of course, if we have a `merge_finalize()`, then a `merge_start()`
does not sound all that bad, either.

The rest looks good to me.

Thanks,
Dscho

> +
> +int merge_trees(struct merge_options *opt,
> +		struct tree *head,
> +		struct tree *merge,
> +		struct tree *common,
> +		struct tree **result)
> +{
> +	int ret;
> +
> +	if (merge_start(opt, head))
> +		return -1;
> +	ret =3D merge_trees_internal(opt, head, merge, common, result);
> +	merge_finalize(opt);
> +
> +	return ret;
> +}
> +
> +int merge_recursive(struct merge_options *opt,
> +		    struct commit *h1,
> +		    struct commit *h2,
> +		    struct commit_list *ca,
> +		    struct commit **result)
> +{
> +	int ret;
> +
> +	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
> +		return -1;
> +	ret =3D merge_recursive_internal(opt, h1, h2, ca, result);
> +	merge_finalize(opt);
> +
> +	return ret;
> +}
> +
>  static struct commit *get_ref(struct repository *repo, const struct obj=
ect_id *oid,
>  			      const char *name)
>  {
> --
> 2.22.0.559.g28a8880890.dirty
>
>
