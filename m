Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D64F052F
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892214; cv=none; b=ZDOsiLvFHure07Zn9FvMCD/V9ausZYAr//Qzxr/FplCfI35G0biqfyVX5KY3ZcuW9vmyZxnn833YJWwEyFF4VaTNWNyKFayxABX9+murgfEgHc0w7LYgN1pfBuRbBTA9zEW7OrQYDEY8JM8bBrMzE5PdbYi59TGf8GDHWHqe1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892214; c=relaxed/simple;
	bh=u/euqqwNvYboaJGlLaODU+8DMgGNTni7Z+7THfcUUwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iw8cWyC1hIOZ7QZHwFIcNBrrddDy/JqqHb2bHxN1rtK353oWlfLcwElSKLT5G1ek9JKpMpC9jck2bS9Ijcf7XtrZMtrYmfrI/KNIdA9vItgeKTZR3/x28hKWuk7thx6gY9TXEWjSg3qAbr6EzFr+P3lt+J6oAfjp0+kJZTpBfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GUv4E0xF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKSyJkfv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GUv4E0xF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKSyJkfv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 28DDEEC04C4
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:50:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 07:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791892211; x=1791978611; bh=ySebOWgDgn
	sUEe7HvAhd59jj7Pp+AlY3yO7yuVA8rFA=; b=GUv4E0xFZZJWKC7Styu9SiKRFx
	3Kx87AFTzhYE13Nh7wtH9exWS+OUpnuHUFII2+WxvRzQuSmq16C0t9JExFfJ8sl6
	J6GrTq1YfYDtVUuZPSOd3gXdQ9qOhOZZFa3J8WwZVH1v3Pn2pk1awwH2nFnZtoY2
	4hIJE3O8fAKsE43z2t9qNIvz7piQ7UGW2ERCG+BOREp89JDfZylnLlIKuxi39isw
	FVKrH6jRg0ely8KKxZJnxl1rqq+oe3De6z0rdzUd+qfGekQw7mXjmur9wasWa5UR
	olj52WAxcrRDppDdfAXT9DbhlNurf+EUu9B3/GAhsQSTJu7bJ+/xBVWqH+ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791892211; x=1791978611; bh=ySebOWgDgnsUEe7HvAhd59jj7Pp+AlY3yO7
	yuVA8rFA=; b=VKSyJkfv6t1LUCzWTrbgTYDg6c/1dLOZnfx/gPko6TsAh/Y4RZ7
	BXGBmBf5YT8jHNNS1BXObX2wnErvArVo7ctoFkkAw7Mqw/KXE/qJi5Dgh9LpLOY8
	2iyDmdrS78vYRSAv3QRDRHBbVu4UMvBA1unDr9cdkP/GoLnX1K3FVtRzuZgSdz0I
	ZvvQqFDzSrodkUfidPYK7Ga9/p+wXRIHD21K1PXGGd372++2aTE/O1Pd+68p/3zX
	Ubl+DeQ9rOJYKRPhYzAe3jmUZDXq/Iuc7OjZFTl7jZEQ3a7vij0/DoHiffQRImDM
	WBkY9O45c3m9FKTNzPeZ9z9kbURRP77TI7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791892211; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lutda9O8JBs6bMsl/zXEPquHwT03bQTap55BHC8Pp+SKFfb
	uXN5IoVLQ4vKnC/iGDDLBMNcfzry4CVFL5TWHUWqY2m8VE7fJ4zmMReE1Y8Qpi+s
	Pj2LeCkBE4bfS7Lo4ZBcM3EBYumE/3d5hbaysqM0CewZ0t+zTzXgZeYA2Dy+zbIS
	aU3FFyHVMkk/pexahiarUWEjIP5r1BDlvb+kz4JD0PsvLDHLGOnmkK6eTRteGMbA
	bXE2VW5Q/5sPtZnlmeqy00xWOvbIqPX3gueFsX2E7pZjtT3Sp4x7DE4i4VWbPvfv
	q+QWs7F/VyhKhfzeBQFWBNFikjVWI+3GcbcoMTQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dVRBpPBlcw9dvkov3xmsC2oC+VHV/QuRD0RHxmXD46w=:u/euqqwNvYboaJGlLaODU+8DMgGNTni7Z+7THfcUUwY=;
X-ME-Sender: <xms:8xrOas2h7rVApn7o4ObLIsY6pEyXQYikEis8_03a7W1tvGr3bx2AdQ>
    <xme:8xrOaugJx3yMnGws2NnpMLJIKYYEgTSkeIbJv6SeOTPhOeFStVmkMGjZAS2EED9xG
    vxUMtduhI7KFlH8XA_RRYys_m_vVOlFfqqgW7jnvo0i_aGUKDPegw>
X-ME-Received: <xmr:8xrOaiSwA3qzgN9z0pD0TW3kyqWnKq21NxvVLdvqvX3YdhenxK_sng>
X-ME-Proxy-Cause: dmFkZTFYJC3FnU73p++EfUpqOMXx8UtXH2iLQOAajDemOtdXGDImdB1L96FTP+Sj6D7ZOn
    BI2n02FQapyw12TUkuirD+fuXjMstfHOsksA0qmz/TG29ggLe3QQeFHEMGmXNLDKcq2cfb
    DfysaHKSu7paK3jJ2DL6Rn0goJs46nn5tuanVsFEJ5cbXaBnJw6QPlFjRnbeNX9c0FesHj
    pbkup86P1y74mnWMjHncfUYFxhriWUuPiaiWRjtITkydSnN7UdTDlx4WS8HIeLsClMblDs
    5VTp8E+y3UJCd1MXMQDU/jAoze+vTcSDto/81z98ViZh7MFFvhz+HVwiKa3TSWASkmJTVY
    NJpy0nQoVF1PRdLRKyS7gulYWPlchaX34836qMTvTwVLj5+wSo/J3h0hL6KM1LUDyeJft8
    4mZXHqaN8f9m775Y9Gyy1GzVW//NbTKxaaCLJPC0bCiUW7LmUNcdi0e9pQpL1+v4ElRXpi
    bjfsrd51sU2Mvrj6l3T9NiRc92IRTEU0/r+RHZm4IwcxgsLmnCXHCbCAUKbdEVYonXHnRZ
    IeI6grTMb2NnliPZC8qXtfdcZqHS48qBGvNHaU49ch213J6XeB38o7qbqDp/8WWf0mk3i2
    LELQvuuy67FewsiEv+2BWrOyKkbXAOOl+hFD0O+Nyf2ufiGVqr6Hmz08zVZg
X-ME-Proxy: <xmx:8xrOavjazMXntafld3UqdaY7rLx5vU-mUX0AzNHavQepkb5QRUoTmg>
    <xmx:8xrOai6H9ZsEt8Kjo_LjPjSqsIbGgal7i6nlb_rrM7k2k_7LMJnEKQ>
    <xmx:8xrOasBj94v-qu2UJO3LPMkn1CCEWL93ameTpYw2qTERGeQx00GLUQ>
    <xmx:8xrOapYCx77_FA_uhadw65b4Q24KY1TP3iJh_H3b1tZiaxzg0bdxxw>
    <xmx:8xrOaigmhV_X7QDsr3yGpAkSLC84sd-ubPkh9eDwRlNlgGwpfeYjkuG3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 07:50:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 430e5f26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 11:50:09 +0000 (UTC)
Date: Tue, 13 Oct 2026 13:50:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com
Subject: Re: [PATCH v4 1/1] repo: add filtering options to "repo structure"
Message-ID: <as4a7t-NEQi-4Yqp@pks.im>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
 <20261010150539.930614-2-markchucarroll@fastmail.com>
 <20261010150539.930614-4-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010150539.930614-4-markchucarroll@fastmail.com>

On Sat, Oct 10, 2026 at 11:05:41AM -0400, Mark C. Chu-Carroll wrote:
[snip]
> This implementation makes an awkward trade-off involving
> "setup_revisions". In order to accept standard the standard
> revs parameters, it uses `setup_revisions`, which does a ref
> walk and populates the pending objects list that will be used
> by "repo structure". But this ref walk doesn't count refs in the
> way that "repo structure" requires, and because "setup_revisions"
> doesn't support a custom callback for its ref-walk, that's not
> changeable.

It's a tradeoff indeed, but I think it's a sensible one. I see these as
counting two different things, refs and objects, and the revisions only
filter objects.

> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index ed7d80c690..67be7efd23 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -66,6 +66,12 @@ supported:
>  * Total disk size of reachable objects by type
>  * Largest reachable objects in the repository by type
>  +
> +The set of objects counted can be filtered by specifying a collection
> +of revisions to select which objects will be counted. These parameters
> +follow the same syntax as the parameters to similar commands like
> +`git log`. If no includes are specified, then the include set is all
> +reachable objects.

Nit: I think it would make sense to define "reachable" in this case, as
there are a bunch of data structures that could in theory make an object
reachable. How about this instead:

  Defaults to all objects reachable from a reference.

> @@ -141,6 +147,28 @@ using the `nul` format:
>  git repo info --format=nul layout.bare layout.shallow
>  ------------
>  
> +* Generates information about storage usage in the repository:
> ++
> +------------
> +git repo structure
> +------------
> ++
> +
> +* Generates information about storage usage in the repository omitting
> +the branch "foo":
> ++
> +------------
> +git repo structure ^foo
> +------------

Wait, wouldn't this result in the empty set of objects because there are
no positive revisions?

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..081940a85c 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -766,10 +767,12 @@ static int count_references(const struct reference *ref, void *cb_data)
>  	}
>  
>  	/*
> -	 * While iterating through references for counting, also add OIDs in
> +	 * While iterating through references for counting, if we didn't already
> +	 * populate the pending list in setup_revisions, also add OIDs in
>  	 * preparation for the path walk.
>  	 */
> -	add_pending_oid(data->revs, NULL, ref->oid, 0);
> +	if (data->add_to_pending)
> +		add_pending_oid(data->revs, NULL, ref->oid, 0);
>  
>  	ref_count = get_total_reference_count(stats);
>  	display_progress(data->progress, ref_count);

Right. An alternative would be to simply never call `add_pending_oid()`
here and always let the revision walk handle this by defaulting to
"--all". That'd have the downside of walking references twice, but the
upside of making each of the steps completely self-contained.

I think ultimately it doesn't matter too much which of these two
approaches we pick. I'd have picked defaulting to "--all" myself, but I
won't insist on it.

> @@ -947,16 +953,20 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
>  		OPT_END()
>  	};
>  
> -	argc = parse_options(argc, argv, prefix, options, repo_structure_usage, 0);
> -	if (argc)
> -		usage(_("too many arguments"));
> -
> -	repo_init_revisions(repo, &revs, prefix);
> -
> +	argc = parse_options(argc, argv, prefix, options, repo_structure_usage,
> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);

Yes. We require `ARGV0` because of `seutp_revisions()` weird API, and
unknown options should of course be forwarded to it.

>  	if (show_progress < 0)
>  		show_progress = isatty(2);
>  
> -	structure_count_references(&stats.refs, &revs, repo, show_progress);
> +	repo_init_revisions(repo, &revs, prefix);
> +	if (argc > 1) {
> +		argc = setup_revisions(argc, argv, &revs, NULL);
> +		included_revision_args = true;
> +	}
> +	if (argc > 1)
> +		usage(_("too many arguments"));

Tiny nit: this reads a bit odd because we have the same condition twice,
and the second evaluation really only needs to happen in case we have
called `setup_revisions()`. So I'd have moved the second check right
after the call to that function.

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 02cc2b594a..e35b46a277 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -21,58 +21,6 @@ object_type_disk_usage() {
>  	fi
>  }
>  
> -test_expect_success 'empty repository' '
> -	test_when_finished "rm -rf repo" &&
> -	git init repo &&
> -	(
> -		cd repo &&
> -		cat >expect <<-\EOF &&
> -		| Repository structure      | Value  |
> -		| ------------------------- | ------ |
> -		| * References              |        |
> -		|   * Count                 |    0   |
> -		|     * Branches            |    0   |
> -		|     * Tags                |    0   |
> -		|     * Remotes             |    0   |
> -		|     * Others              |    0   |
> -		|                           |        |
> -		| * Reachable objects       |        |
> -		|   * Count                 |    0   |
> -		|     * Commits             |    0   |
> -		|     * Trees               |    0   |
> -		|     * Blobs               |    0   |
> -		|     * Tags                |    0   |
> -		|   * Inflated size         |    0 B |
> -		|     * Commits             |    0 B |
> -		|     * Trees               |    0 B |
> -		|     * Blobs               |    0 B |
> -		|     * Tags                |    0 B |
> -		|   * Disk size             |    0 B |
> -		|     * Commits             |    0 B |
> -		|     * Trees               |    0 B |
> -		|     * Blobs               |    0 B |
> -		|     * Tags                |    0 B |
> -		|                           |        |
> -		| * Largest objects         |        |
> -		|   * Commits               |        |
> -		|     * Maximum size        |    0 B |
> -		|     * Maximum parents     |    0   |
> -		|   * Trees                 |        |
> -		|     * Maximum size        |    0 B |
> -		|     * Maximum entries     |    0   |
> -		|   * Blobs                 |        |
> -		|     * Maximum size        |    0 B |
> -		|   * Tags                  |        |
> -		|     * Maximum size        |    0 B |
> -		EOF
> -
> -		git repo structure >out 2>err &&
> -
> -		test_cmp expect out &&
> -		test_line_count = 0 err
> -	)
> -'

Huh, why did you drop this test?

> @@ -144,6 +92,165 @@ test_expect_success SHA1 'repository with references and objects' '
>  	)
>  '
>  
> +test_expect_success SHA1 'repository with branches' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 1005 &&
> +		git tag -a foo -m bar &&
> +
> +		oid="$(git rev-parse HEAD)" &&
> +		git update-ref refs/remotes/origin/foo "$oid" &&
> +		git checkout -b grobble &&
> +		test_commit_bulk --ref=refs/heads/grobble 20 &&
> +		git checkout master &&
> +		test_commit_bulk 20 &&
> +		# Also creates a commit, tree, and blob.
> +		git notes add -m foo &&
> +		git repo structure --format=lines  >actual 2>actual-err &&

There's two spaces here between `--format=lines  >actual`.

> +		test_line_count = 0 actual-err &&

`test_must_be_empty actual-err`. The same applies to some lines further
down.

> +		test_grep "objects.commits.inflated.size=231976" actual &&
> +		test_grep "objects.commits.count=1046" actual &&
> +		test_grep "objects.blobs.count=1006" actual &&
> +		test_grep "objects.trees.count=1006" actual &&
> +		test_grep "objects.trees.disk_size=284547" actual &&
> +		test_grep "objects.blobs.disk_size=21022" actual &&
> +		test_grep "objects.tags.disk_size=126" actual &&

I think this would be a bit easier to parse if you instead:

    cat >expect <<-\EOF &&
    objects.commits.inflated.size=231976
    objects.commits.count=1046
    objects.blobs.count=1006
    objects.trees.count=1006
    objects.trees.disk_size=284547
    objects.blobs.disk_size=21022
    objects.tags.disk_size=126
    EOF
    test_grep "^objects" actual >actual.objects &&
    test_cmp expect actual.objects

It's also more efficient because we don't have to invoke grep 8 times.
But we'd also have to add the inflated size (which I've omitted out of
laziness).

> +test_expect_success SHA1 'filter by both positive and negative revs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 1005 &&
> +		git tag -a foo -m bar &&
> +
> +		oid="$(git rev-parse HEAD)" &&
> +		git update-ref refs/remotes/origin/foo "$oid" &&
> +		git checkout -b grobble &&
> +		test_commit_bulk --ref=refs/heads/grobble 20 &&
> +		git checkout master &&
> +		test_commit_bulk 20 &&
> +		# Also creates a commit, tree, and blob.
> +		git notes add -m foo &&
> +		git repo structure --format=lines  >actual 2>actual-err &&
> +		test_line_count = 0 actual-err &&
> +
> +		git repo structure --format=lines grobble ^master >actual 2>actual-err &&
> +		test_grep "objects.commits.count=20" actual &&
> +		test_grep "objects.commits.disk_size=3122" actual &&
> +		test_grep "objects.commits.inflated.size=4411" actual &&
> +		test_grep "objects.blobs.count=1005" actual &&
> +		test_grep "objects.blobs.disk_size=21003" actual &&
> +		test_grep "objects.blobs.inflated_size=11958" actual &&
> +		test_grep "objects.trees.count=1" actual &&
> +		test_grep "objects.trees.disk_size=53" actual &&
> +		test_grep "objects.trees.inflated_size=33063" actual &&
> +		test_grep "objects.tags.disk_size=0" actual &&
> +		test_line_count = 0 actual-err
> +	)
> +'
> +
> +test_expect_success 'filter by object type' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit_bulk 1005 &&
> +		git tag -a foo -m bar &&
> +
> +		oid="$(git rev-parse HEAD)" &&
> +		git update-ref refs/remotes/origin/foo "$oid" &&
> +		git checkout -b grobble &&
> +		test_commit_bulk --ref=refs/heads/grobble 20 &&
> +		git checkout master &&
> +		test_commit_bulk 20 &&
> +		# Also creates a commit, tree, and blob.
> +		git notes add -m foo &&
> +		git repo structure --format=lines --objects --all --filter=object:type=blob >actual 2>actual-err &&
> +		cp actual /tmp/test-actual-exclude-blob &&
> +		test_grep "objects.commits.disk_size=0" actual &&
> +		test_grep "objects.commits.max_size=0" actual &&
> +		test_grep "objects.tags.disk_size=0" actual &&
> +		test_grep "objects.tags.inflated_size=0" actual &&
> +		test_grep "objects.trees.disk_size=0" actual &&
> +		test_grep "objects.trees.inflated_size=0" actual &&
> +		test_grep "objects.blobs.disk_size=21022" actual &&
> +		test_grep "objects.blobs.count=1006" actual &&
> +		test_grep "objects.blobs.disk_size=21022" actual &&
> +		test_grep "objects.blobs.inflated_size=11962" actual &&
> +		test_line_count = 0 actual-err
> +	)
> +'
> +
> +test_expect_success 'filter using by ref^{tree}' '

I think I'd drop this test here as we're now starting to cross the
border of exercising the rev-walk machinery. The preceding tests seem
sufficient as you have tested positive revs, negative revs and options.

Other than that though I think this is on the right track, thanks!

Patrick
