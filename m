Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA72E336F
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865316; cv=none; b=MYaRSagSEbVCydHpGc/e9Q/BG+JDzC23bBgGEhksM5hnrIY5Z+7PM8VF8enV3fb8gjcli/R4D7ioXuJLmJi+09WS0UqFYWZ93p05e/88LHVyeJvMNQvhav/HwqAJV9prwswHwR6FNsr6CoQ+UP+m4qiaRR6S7qYb5/n1s2OGfdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865316; c=relaxed/simple;
	bh=baN20LmNfPhD8q5n0PGjxLqCJMt2hBiSSVDvF6pElfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcUtZ7M8ZC7AzTH+1VIsXEPiKkCB7R6H16G6Guud6zJ667YzT+9Ae7Sr/xBm3CP6gbL8xcuTCGnwR7WXA1mO4BYzRm2qoAYyoMHueXUs0lIlBxQNj2Wgo+xFtur5LUkA4RFkzlkYIfLrFLYEMMRQX4mBR3g55HBz4v4RMCpObAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DKq0FQWx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2kb/OK/; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DKq0FQWx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2kb/OK/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AE38BEC00CE;
	Fri, 22 Aug 2025 08:21:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 08:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755865313;
	 x=1755951713; bh=GizrLkTCig4Ne7RcDdxgRsjVDRQG36VKZ0lrxQOBiEk=; b=
	DKq0FQWxt3/aOPO1D+u5kQeXRp49Uea20Y8FEmeKN3KK2rBGeVRwv/fLg3HZmXyd
	HpiwLQObthNETsyPODb22sTRU4mHTK1QexpK0dHzp9GtiZTW6doMcI5SpjQcPaFd
	QcnKbrVAPhWINTgloNKr895fmzHJSfzf+R400PzQJwPUNtlUKUBYY0f/4BhNDHoK
	oC+SFgu4khTEAyWMkyMnb5BRTqC7hT7lvKtpQlAvIR0Uzvc/zgd3AFRn0JjsTo3a
	8wgBYkNqJMbAIA61XzS04eayysE8S5+4nBOXFSqIwU6o8ksmUw85OZcKkfySQAdv
	S5I4wZobIVOg0w37R+FN2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755865313; x=
	1755951713; bh=GizrLkTCig4Ne7RcDdxgRsjVDRQG36VKZ0lrxQOBiEk=; b=H
	2kb/OK/B44vobQDDE0hSbRCPIionbPzJCrjbadzWbxRZ804e9NWmH2C2xR6zaIHd
	8tC4MpcIF3JSU2nexY6uaOeoqC+U21aJRRGGA2tU1zO80KFTW4igCcypnh6S0OBd
	shxtsbzEKgrHlHV8sd2zYfKvgvFzG3quktZwvsc93OyEJoDoA6xyDz8O6oMv2Vpf
	wE83boDjB/9VjAf3a4ndP+VCCZOcOlCpXXs7qAtKQft6KUQu98KhYiRn6vbGMalk
	j6KKHDQ/6DjhIJq+Qo4IX3SlVEDJlsQMo527/u7XzeTltbtufGD5+I2+5mXaeP4r
	6BW9AW0jByhcODWiU77zQ==
X-ME-Sender: <xms:4WCoaDozErVEvaeT1mE5NHxp-NV4-GzS8pHNSpgvwpWnpUpCPY8biQ>
    <xme:4WCoaN3hhizraPxYwxLSk9pOfNH8G27qoTM6trXhVI4I3QiAHesc_AHZiOsb48Zx9
    tk0HLBlfaswCQCNzg>
X-ME-Received: <xmr:4WCoaCAC8Sn-N0HSgnI1aoKOe0j6USR2LR7ccq6cwQc0byqWXSJbCCVjj-gKnW1kuGCuA5xagzXfUEBYhxGMBLcWPm8-2cnLqkGdB_7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4WCoaFclzQIAzml6hxZQWo8P0x6V5P9KS8lt9Y77oZ4u6woROX_l7g>
    <xmx:4WCoaHj7sPzZE4Rr6EGCuv6CUapm8xAM1qLi8vZ2uMDG1jPJLXQfBg>
    <xmx:4WCoaNqUfVfNDRdpwzVG3kpNknwc96wtqMBMcEZvB_67lvbZMgnQag>
    <xmx:4WCoaHE0_gpdFpfvHkSUNKCFwN8rED64quXmfJqimobKVeSaUwuSkw>
    <xmx:4WCoaK7jwck0K_XtRlBABH7nO3oIzU28bmK05IzE_iWyGhHKh69nr8l9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:21:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9487a77c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 22 Aug 2025 12:21:52 +0000 (UTC)
Date: Fri, 22 Aug 2025 14:21:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 05/11] builtin/history: implement "drop" subcommand
Message-ID: <aKhg2WxKC_1fVJZW@pks.im>
References: <20250819-b4-pks-history-builtin-v1-5-9b77c32688fe@pks.im>
 <F0D09FB0-5978-4BFA-87D1-BE5FA49EA839@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F0D09FB0-5978-4BFA-87D1-BE5FA49EA839@gmail.com>

On Wed, Aug 20, 2025 at 04:39:34PM -0400, Ben Knoble wrote:
> > diff --git a/builtin/history.c b/builtin/history.c
> > index d1a40368e0..183ab9d5f7 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -1,20 +1,311 @@
> > #include "builtin.h"
> > +#include "commit.h"
> > +#include "commit-reach.h"
> > +#include "config.h"
> > +#include "environment.h"
> > #include "gettext.h"
> > +#include "hex.h"
> > +#include "object-name.h"
> > #include "parse-options.h"
> > +#include "refs.h"
> > +#include "reset.h"
> > +#include "revision.h"
> > +#include "sequencer.h"
> > +
> > +static int collect_commits(struct repository *repo,
> > +               struct commit *old_commit,
> > +               struct commit *new_commit,
> > +               struct strvec *out)
> > +{
> > +    struct setup_revision_opt revision_opts = {
> > +        .assume_dashdash = 1,
> > +    };
> > +    struct strvec revisions = STRVEC_INIT;
> > +    struct commit_list *from_list = NULL;
> > +    struct commit *child;
> > +    struct rev_info rev = { 0 };
> > +    int ret;
> > +
> > +    /*
> > +     * Check that the old actually is an ancestor of HEAD. If not
> 
> The “old commit” perhaps?

Yup, indeed.

> > +     * the whole request becomes nonsensical.
> > +    */
> > +    if (old_commit) {
> > +        commit_list_insert(old_commit, &from_list);
> > +        if (!repo_is_descendant_of(repo, new_commit, from_list)) {
> > +            ret = error(_("commit must be reachable from current HEAD commit"));
> > +            goto out;
> > +        }
> > +    }
> > +
> > +    repo_init_revisions(repo, &rev, NULL);
> > +    strvec_push(&revisions, "");
> > +    strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
> > +    if (old_commit)
> > +        strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->object.oid));
> > +    if (setup_revisions(revisions.nr, revisions.v, &rev, &revision_opts) != 1 ||
> > +        prepare_revision_walk(&rev)) {
> > +        ret = error(_("revision walk setup failed"));
> > +        goto out;
> > +    }
> > +
> > +    while ((child = get_revision(&rev))) {
> > +        if (old_commit && !child->parents)
> > +            BUG("revision walk did not find child commit");
> > +        if (child->parents && child->parents->next) {
> > +            ret = error(_("cannot rearrange commit history with merges"));
> > +            goto out;
> > +        }
> > +
> > +        strvec_push(out, oid_to_hex(&child->object.oid));
> > +
> > +        if (child->parents && old_commit &&
> > +            commit_list_contains(old_commit, child->parents))
> > +            break;
> > +    }
> > +
> > +    /*
> > +     * Revisions are in newest-order-first. We have to reverse the
> > +     * array though so that we pick the oldest commits first. Note
> > +     * that we keep the first string untouched, as it is the
> > +     * equivalent of `argv[0]` to `setup_revisions()`.
> > +     */
> > +    for (size_t i = 0, j = out->nr - 1; i < j; i++, j--)
> > +        SWAP(out->v[i], out->v[j]);
> > +
> 
> But doesn’t this swap out->v[0] on first iteration? I only skimmed the
> code that built it up, but it doesn’t look the comment is right 🤔

Very true. This comment is indeed stale from a previous iteration, where
`out->v[0]` was indeed `argv[0]`. Will fix.

> Rest looked reasonable, but I don’t know the sequencer APIs very well.

The sequencer API is quite complex overall, I cannot blame you :) Took
me quite a while to get the hang of it.

Patrick
