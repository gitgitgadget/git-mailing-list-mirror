Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77732ED24
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047033; cv=none; b=GSV6SoqGv0Y/n10RfsPxN1n5DUieGBkOB9WqaUSVAd4Xkgph7GH4ETamHrC3itfc3h2IeL3Ei6b8HsGcaPOZOGee8w5JXiBdLYFFzFAuJ8TEhtaAI2CoHPy/T22whrPoKPV+RY6uicsnOBPsZ9ywLARhb00XmAj470q2IjGvZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047033; c=relaxed/simple;
	bh=tWIua7HSLJuqBNe5wR03CVYwue2F+aRTYktXvAxPbQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrKRB4eda+PgPXEzWxN2CjDzTx2gNzOUnk8xQ3dGSeIE2PhhR2A/uLXDz5k4b4wDfVj8nHEG/HDKtD7REVKmaKXYCYzxDVHaCuflfPt1sZNBaGH7Q370RTY97t7ksG0fTWvZe3TvlmfFGe9/N+oHCQMIUiVCoNS7p39OLrLJTCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CW8LKZct; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CiGel47B; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CW8LKZct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CiGel47B"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2E11314000B7;
	Tue, 21 Oct 2025 07:43:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 07:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761047030; x=1761133430; bh=QTfwTkjHef
	n9Ao5DPhFQxMNG+Bpo4Nv2X2OSqgiIQes=; b=CW8LKZctkFFMg1AWnv5lx6VZcs
	Cyj7Skdb/mw8o4FFp1718YxVN+G6e1+5VdaaPROB+zQxzIWMn8SVr9Ifq71nKT7a
	qRs+ZeiTR1v4SxLA/xC4h2spKk2oeKiCRmWqX8HqKYkNV6CssmCVhB142n8Jdi0q
	zs1wfPu5hcVbiDIvUNv7/+cHIeo1McsPzXEne9k/SqoZgxhXrNpiMTXkWPhtz8T3
	STCOQVv+SlYe3ETtN+iAlWVdKVrpd0mtsBjiL0GKOjkA5PrPoQDNzUMOCLejpe9u
	CknndEWJ6A8+OBTEGzvQx4oKUPPY2TLBwXWCDqa260TlOH3L+7REoSOZMFcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761047030; x=1761133430; bh=QTfwTkjHefn9Ao5DPhFQxMNG+Bpo4Nv2X2O
	SqgiIQes=; b=CiGel47BwPgiO+AthRT+chk1ZiKR1pzziF3hYiiR4mhHc42WhM0
	SZE7RYMx/T0gdjWU7ZovgOOt8MacUyZOGUXeoMLCf95QHTEhnMKipHyWs0VWL2kJ
	KXLw5KotI6DlXlQlzeIHg/KEiEnNAtLK7U9WfPAL0wOO3egdyns3wnXaCkauQEsj
	zJnED8Ey9lkSrdf2DJELYDNPHww609/XWV0YAYxd5Y/1oGrnxo0m8l4cdoBaKP8N
	b0O9MB+PkYbO47xAEylYAtLNIejVX1pPcd9rz2DOgTw/dsMw5jS7N27HsrpQtMCD
	XvSl5WLjMsZLNu0NZ5uz88S8VN5pckxqqCQ==
X-ME-Sender: <xms:9XH3aOmL6yFCEJuMy1ceRCJzag_V5l8IL1Oi1Pxcqf4NPMQqyks_4w>
    <xme:9XH3aIbIfUytLSNhYPZDIbNBFNnTLFotfrDDEJjMsc288ztBr9PaZRSUJb_aNhqU1
    xrNGPA0UMVql7bXdsczYRlVmcONWXq45T4P1_4mAf_m6y66P3eV5Q>
X-ME-Received: <xmr:9XH3aASaXCp13nU4GGZDZmO9Lu-MQYgzgGRrCk9m1HxOctFmOp9v7t6W-M5jTkNA28t_7v5VcR7rHg7wG3UXX8LnbWhQcqPhd-lolWoPS7Ekhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdr
    fhhrpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    horhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhii
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:9XH3aCvhCb3hLZXs2BwH-tlkkNPgrat_yLarrWREoIe8cBWV9wpqxw>
    <xmx:9nH3aCGxpbxal1RehnGrvDp8HYpNLdiiWxHwlQLRr5jz6uczmI5KnQ>
    <xmx:9nH3aDzHvSkCkJtGKLowBli9NSiKfzk0MD5ufp_rgVMTi_cGMFRVHQ>
    <xmx:9nH3aM24JMPMWv-FtimMzaXCeqM6hxoEdsPYt-wrMJOS-HD7FJ2HrA>
    <xmx:9nH3aIS_bPg1hlB0Q9DaFc8bB1a5XsWVe_moVooC_85mADquHNSJ1T3M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 07:43:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff0da868 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 11:43:47 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:43:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 06/12] builtin/history: implement "reword" subcommand
Message-ID: <aPdx8Pv-9UQDpe7I@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-6-8e61ddb86317@pks.im>
 <CAOLa=ZSU8yr9Gn0EZ7x705qPyVM-qiMjgMCNCb8p8SMGTToxqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSU8yr9Gn0EZ7x705qPyVM-qiMjgMCNCb8p8SMGTToxqQ@mail.gmail.com>

On Tue, Oct 14, 2025 at 07:04:06AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/history.c b/builtin/history.c
> > index f6fe32610b..7b2a0023e8 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -1,22 +1,389 @@
> > +#define USE_THE_REPOSITORY_VARIABLE
> > +
> >  #include "builtin.h"
> > +#include "commit-reach.h"
> > +#include "commit.h"
> > +#include "config.h"
> > +#include "editor.h"
> > +#include "environment.h"
> >  #include "gettext.h"
> > +#include "hex.h"
> > +#include "oidmap.h"
> 
> Nit: This can be dropped, perhaps needed in a future patch?

Yeah, it's indeed needed in a subsequent patch. Let me move the import
around.

> >  #include "parse-options.h"
> > +#include "refs.h"
> > +#include "replay.h"
> > +#include "reset.h"
> > +#include "revision.h"
> > +#include "sequencer.h"
> > +#include "strvec.h"
> > +#include "tree.h"
> > +#include "wt-status.h"
> > +
> > +static int collect_commits(struct repository *repo,
> > +			   struct commit *old_commit,
> > +			   struct commit *new_commit,
> > +			   struct strvec *out)
> > +{
> > +	struct setup_revision_opt revision_opts = {
> > +		.assume_dashdash = 1,
> > +	};
> > +	struct strvec revisions = STRVEC_INIT;
> > +	struct commit_list *from_list = NULL;
> > +	struct commit *child;
> > +	struct rev_info rev = { 0 };
> > +	int ret;
> > +
> > +	/*
> > +	 * Check that the old commit actually is an ancestor of HEAD. If not
> > +	 * the whole request becomes nonsensical.
> > +	*/
> 
> Missing space here

Good eyes.

> > +	if (old_commit) {
> > +		commit_list_insert(old_commit, &from_list);
> > +		if (!repo_is_descendant_of(repo, new_commit, from_list)) {
> > +			ret = error(_("commit must be reachable from current HEAD commit"));
> > +			goto out;
> > +		}
> > +	}
> 
> Makes sense. There is an inherent assumption using the 'git history'
> command that you want to modify the history of the current reference.
> 
> One question, wouldn't it make sense to parse and check that the commit
> to be reworded should be checked to be a descendant of HEAD earlier on
> in `cmd_history_reword()`?
> 
> This would ensure this function `collect_commits()` doesn't worry about
> how it is meant to be used, and simply worries about collecting commits.

The reason why I opted to move this into `collect_commits()` is so that
we don't have to reimplement that check for every single subcommand, as
they also have the same restriction.

[snip]
> > +static int fill_commit_message(struct repository *repo,
> > +			       const struct object_id *old_tree,
> > +			       const struct object_id *new_tree,
> > +			       const char *default_message,
> > +			       const char *provided_message,
> > +			       const char *action,
> > +			       struct strbuf *out)
> > +{
> > +	if (!provided_message) {
> > +		const char *path = git_path_commit_editmsg();
> > +		const char *hint =
> > +			_("Please enter the commit message for the %s changes. Lines starting\n"
> > +     "with '%s' will be kept; you may remove them yourself if you want to.\n");
> 
> Shouldn't this be s/kept/removed? Also this line needs to be aligned.

Huh, yes, indeed.

[snip]
> > +	if (repo_parse_commit(repo, original_commit)) {
> > +		ret = error(_("unable to parse commit %s"),
> > +			    oid_to_hex(&original_commit->object.oid));
> > +		goto out;
> > +	}
> 
> Isn't this already done as part of
> `lookup_commit_reference_by_name_gently()` which is called by
> `lookup_commit_reference_by_name()` ?

Yes, you're right.

[snip]
> > +	ret = commit_tree(final_message.buf, final_message.len,
> > +			  &repo_get_commit_tree(repo, original_commit)->object.oid,
> 
> Can't we use original_commit_tree_oid here?

Yup, indeed.

> >  		const char **argv,
> >  		const char *prefix,
> > -		struct repository *repo UNUSED)
> > +		struct repository *repo)
> >  {
> >  	const char * const usage[] = {
> >  		N_("git history [<options>]"),
> > +		N_("git history reword [<options>] <commit>"),
> 
> This string is used twice, perhaps we move it to a macro?

Yeah, why not.

Patrick
