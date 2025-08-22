Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF3B663
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865331; cv=none; b=tyXs7KvM78oXRo4zbXtDEMkpHveC6n+CCFe09SeNxoaUaLmWQulaXVIYebrsgGgy8mPpOwagIVLaFD+QMj4fsZcUYsU7IYi5/r2ph3dPmtu7/FSxicOHmKpFjWTgw5pRr35HvFIyxwjcnrDKY95N/HkeaMf/4v6cmVpDauKtxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865331; c=relaxed/simple;
	bh=3bgeCGEpgdEAAcPXz2eR2TsPl/crOO+w6qam73BYckk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcuZq92/jtCIOdvBxrn2JtIQbEVEl+rc5B+zzynjbKchOAIRqKiVABWl3kvp6w5H0MUgm29OFfh36EuUWfq2TjGtd6uPd7d+0ulFJ90YPcpOxPx+12+1XAOmCNXbg1/IxtQAq5Tf/Li/JKKnhtmXjZqBVhVPySEqE9Z5M378ehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QDsh1xbU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ET0xhq5D; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QDsh1xbU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ET0xhq5D"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68D771400898;
	Fri, 22 Aug 2025 08:22:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 22 Aug 2025 08:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755865328;
	 x=1755951728; bh=lM2p0Oc/h07gP3iCuPIY2ap/i84qVydtUfX7TJqBgT4=; b=
	QDsh1xbUrbKn7+uepf/3HlK//3dRVETzkBausxWlM2i4X1qXjHSGo9pwMDz8oViW
	CpalusPbhOumUCYI1bGiDi8IJZmFIbvNRckJt20XS7Nw9VSTh4CBNev1Z6wECBHt
	9g+wMpyrhD4v/s7eXwQB9mUjBxaUpU26YFzHUstoArvT+F38sdrmNPhu+J8qDIos
	EkQ5hgUzG1B4nkAb255qtJkYnvUZzN/4IlryHJrEHSVHT4Jm9ECJpIHNrvBABQH4
	56xNqhJWPV5rHQvbA2V6QvpZZ7YFtfzSs4hq17z0lipVJY7aXzow8stmsC9aklIO
	Uw0EkcNukYuN7iSq+oEBuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755865328; x=
	1755951728; bh=lM2p0Oc/h07gP3iCuPIY2ap/i84qVydtUfX7TJqBgT4=; b=E
	T0xhq5D4GskU21JaqYK1oT0w+DhTrBs28x8cS3ESOkfQ2h334ePfjZiWyTWSqoui
	X/velsZaU4s7bsQhSLuo/LCDr0n1njqFu+3zsJLyf5leVja3pSUnee+shzCavbNr
	yfcX+qccS5nm2Bo5oEB3go+ZJoKrL20KajcHGYWeNpdCw5peDwmxF+rBdWo8Keuj
	QElCxONexR2PQmJP7PV5DAQrpWNZbwczF/oVrs+mxD6HslO9DpDpHnujzcT6yWwm
	2HWWwbFw+vKVdH3RG768UDSmf0VlYELOLKtZmSKNMBlTcssdbZitrJj3EywJ05mO
	ndh8gqam38PkrLM/5IEvg==
X-ME-Sender: <xms:8GCoaK1emsq3EjFzsRsii8DzWFoGUYBpO3Jksp25pkz81v9VLeDHxQ>
    <xme:8GCoaNSzjnZAB7IenucevXczP_966HDxvIixU0o7_LVoiLy8vGBnf8lUqNMEp82tM
    4Co9ji3_HrweLaBOQ>
X-ME-Received: <xmr:8GCoaEtSnXcZM9o4VCYl7DzOsdfjYbhoFtbE8VUAVs8HAXj8QmopC4ObAUhH1YnRt0N4QcTFVSANifsjI5eXZ0XeFSkL8IdYItu-rUgz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8GCoaKbp1RbWsAU4OAAqeXuUZnQGduiJsDQZ0CPoUiSE7pcdyblCbg>
    <xmx:8GCoaBuLn9_nKEy-4l_3Zim1z7kHECSG_O6lGNrQPDMb73nGqYTvsg>
    <xmx:8GCoaEEvYRAALtnnusx7TgBygUFSoxUjUDf6w1c1HqNM-3kSw3Ajkw>
    <xmx:8GCoaEx8k-m4XfD-0-RG6IYSKL3jhHMUVHDxziaEECvGL4OpiqILHA>
    <xmx:8GCoaFFO1Ftq3z338Z8082QqZueT27tDYbXPRZZWp3n1Qyzr54Ag9ND9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 08:22:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a6dadc7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 22 Aug 2025 12:22:06 +0000 (UTC)
Date: Fri, 22 Aug 2025 14:21:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC 10/11] add-patch: add support for in-memory index
 patching
Message-ID: <aKhg5o-dwp2UDZ4y@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-10-9b77c32688fe@pks.im>
 <CALnO6CAPugqDC8sGO1Si=5Wk-pz52BF84Ai7ZQjwb3vLMs6A=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAPugqDC8sGO1Si=5Wk-pz52BF84Ai7ZQjwb3vLMs6A=A@mail.gmail.com>

On Wed, Aug 20, 2025 at 05:15:03PM -0400, D. Ben Knoble wrote:
> On Wed, Aug 20, 2025 at 4:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> > diff --git a/add-patch.c b/add-patch.c
> > index 1bcbc91de9..adef20c02b 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1849,9 +1853,12 @@ static int patch_update_file(struct add_p_state *s,
> >                                          NULL, 0, NULL, 0))
> >                                 error(_("'git apply' failed"));
> >                 }
> > -               if (repo_read_index(s->r) >= 0)
> > +               read_index_from(s->index, s->index_file, s->r->gitdir);
> > +               if (read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
> > +                   s->index == s->r->index) {
> >                         repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
> >                                                      1, NULL, NULL, NULL);
> > +               }
> >         }
> 
> Is this call to read_index_from duplicated? I don't see anything that
> indicates that would be desirable here.

Indeed, good catch!

> > @@ -1922,3 +1931,99 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
> >         add_p_state_clear(&s);
> >         return 0;
> >  }
> > +
> > +int run_add_p_index(struct repository *r,
> > +                   struct index_state *index,
> > +                   const char *index_file,
> > +                   struct interactive_options *opts,
> > +                   const char *revision,
> > +                   const struct pathspec *ps)
> > +{
> > +       struct patch_mode mode = {
> > +               .apply_args = { "--cached", NULL },
> > +               .apply_check_args = { "--cached", NULL },
> > +               .prompt_mode = {
> > +                       N_("Stage mode change [y,n,q,a,d%s,?]? "),
> > +                       N_("Stage deletion [y,n,q,a,d%s,?]? "),
> > +                       N_("Stage addition [y,n,q,a,d%s,?]? "),
> > +                       N_("Stage this hunk [y,n,q,a,d%s,?]? ")
> > +               },
> > +               .edit_hunk_hint = N_("If the patch applies cleanly, the edited hunk "
> > +                                    "will immediately be marked for staging."),
> > +               .help_patch_text =
> > +                       N_("y - stage this hunk\n"
> > +                          "n - do not stage this hunk\n"
> > +                          "q - quit; do not stage this hunk or any of the remaining "
> > +                               "ones\n"
> > +                          "a - stage this hunk and all later hunks in the file\n"
> > +                          "d - do not stage this hunk or any of the later hunks in "
> > +                               "the file\n"),
> > +               .index_only = 1,
> > +       };
> > +       struct add_p_state s = {
> > +               .r = r,
> > +               .index = index,
> > +               .index_file = index_file,
> > +               .answer = STRBUF_INIT,
> > +               .buf = STRBUF_INIT,
> > +               .plain = STRBUF_INIT,
> > +               .colored = STRBUF_INIT,
> > +               .mode = &mode,
> > +               .revision = revision,
> > +       };
> > +       struct strbuf parent_revision = STRBUF_INIT;
> > +       char parent_tree_oid[GIT_MAX_HEXSZ + 1];
> > +       size_t binary_count = 0;
> > +       struct commit *commit;
> > +       int ret;
> > +
> > +       commit = lookup_commit_reference_by_name(revision);
> > +       if (!commit) {
> > +               err(&s, _("Revision does not refer to a commit"));
> > +               ret = -1;
> > +               goto out;
> > +       }
> > +
> > +       if (commit->parents)
> > +               oid_to_hex_r(parent_tree_oid, get_commit_tree_oid(commit->parents->item));
> > +       else
> > +               oid_to_hex_r(parent_tree_oid, r->hash_algo->empty_tree);
> > +
> > +       strbuf_addf(&parent_revision, "%s~", revision);
> > +       mode.diff_cmd[0] = "diff-tree";
> > +       mode.diff_cmd[1] = "-r";
> > +       mode.diff_cmd[2] = parent_tree_oid;
> > +
> > +       interactive_config_init(&s.cfg, r, opts);
> > +
> > +       if (parse_diff(&s, ps) < 0) {
> 
> I noticed run_add_p() calls discard_index() right before parse_diff()
> [but it also reads/refreshes the index there]. Sounds like that's not
> something we need for in-memory indices?

No. We don't want to discard contents, as it might even be that somebody
has an index that we want to apply multiple revisions to. Discarding it
is not sensible in that case.

Patrick
