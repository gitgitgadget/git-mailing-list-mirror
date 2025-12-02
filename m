Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0621D3C5
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701357; cv=none; b=FoL5Xd3Lx/KHHCRef8f7HwPWGBepZlUGMKBgQFLrAIzxoXHUg5/xqQNlaflaH0f6A8HsPJM04qeSP8irk4e5ETL5IxXu3dqtlmWdowFDSjMUjY5tuiMvpDI/AoCOkZdraD/6wiT9FW27ZGZcamUgSJP58IQ/f+mPO5dB0OoaiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701357; c=relaxed/simple;
	bh=aSsLiyL4f5tLVc4WSQKhvhJ+MUB9siZ5Hzjcnn6hs2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0yHFKv09z2BB7MRr5L4vAdsX7e4DJPzMrQLj70p5BZPHwXwCe2LsbioRughhNo+HHINKq8cCwMdShjkgvg8OKcVxQQY62itDEiQpr/UcscPK4TFS2P9J8ahRIhYJ7uD1rdP9B5Wa4tejS2LDQxWd9YyRJiIuKfnM5puYcleEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XUMEtceM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mr7Mc8yR; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XUMEtceM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mr7Mc8yR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 74BC5EC05A8;
	Tue,  2 Dec 2025 13:49:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 02 Dec 2025 13:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764701354;
	 x=1764787754; bh=HnnCAvKQhOt554aV/qVi9Ru0PJrE2Myn1svb0snRl70=; b=
	XUMEtceMuT+Ud5AeM6nLunI2tmezd69njAAHqPTPL7PH4VQVHROv83wxJgfmFmwY
	eg6AvstWsyRhrUh8w2edt1Xca6DF47TotreaTHrrguqlIuCfC8WWV7AfLgj7B6j+
	ZtUz1mULm+XyB/hdMQFtyFGCIBOCW+cnKzGvRxUklpuKl8uXwckxT8Ffqmi61nYC
	MzB8moiCULXnft6MMyyb8wWDbE5D5s74pNvUBJwegeEYt1eYycloIvq60i/SO+rC
	9yFfOsEzBe2UIVU18LrXN6gIim5O4Fjms6IVFdi9S8hoEC0RSNE4KH5HcLrGO9sa
	fDwJDKHyr1KoA9n60Pc0eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764701354; x=
	1764787754; bh=HnnCAvKQhOt554aV/qVi9Ru0PJrE2Myn1svb0snRl70=; b=m
	r7Mc8yRO1ReGzLWaUS/S55eXm+nS0C0294a6btEyg1/0X8CtDaC4UDDzZ1RFnj4c
	H+c7e7BSh8S1HbSNehnam3/0FzixGWm7v8xV0zoUSaeUIfa7i/R0ETgyutspg4Ny
	dAfZjWtFGSDFnQE/UGcLCLeyyFJsk3LycG9svQIh1sVbKTk/L3zSPX73pSy7mLB4
	eZgG5Kn5HMvgduy49qqJiuY9ond2EzIAkbE3C0bc9xT8GX7FkODjOvylauLQd16q
	Oe3NnR/+wASBs285nGstL1ctfBKhESw1Gb9ZujtT/yCDqtzSlVgT5o+pHrHjGWLA
	8ZYGgBCGLbZQlBrY3nGJQ==
X-ME-Sender: <xms:qjQvaQ07cwcnc_75bNIlavDpVVG5sXyptZryydrUgSkuWMixk4Ed7w>
    <xme:qjQvadqyzZsjzdUjrgXdA5V6u-CmFW0csV0yRHFu5z1uG72HCNcQSjdfbFc_ZbE1P
    tVuFp69KRkrkliqVcNHmpoYj-ON_8j_-V7z1t_PL9-UpZGTL0m_Tw>
X-ME-Received: <xmr:qjQvacjXWpnRAj1d5kUYWj3Nz71O4nuQWqyTQMU6gOfs8uTsJSRp-z3tNg-VPF0wXeTrbPEv_qnJ31Llky8R2aWC8N0AH4m1qAevFKJ2GX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvd
    efjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtih
    hnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qjQvaZ9FeFPtMjkxHaCLZ0Jw-e3eU_77PWdK9gUb9X1veOSD7AOEYg>
    <xmx:qjQvaYWu1ioAARPjNUjsMkZwUo7Q6QY3XYTiHs7mdbmf0vxzVFjRoQ>
    <xmx:qjQvadCCcWhqROdIGk4kvOhZwbm7L3x1OWtddH8kJW3FFyXdz8xW6w>
    <xmx:qjQvadGOojR3llS1xtBCU_kLOhCwdnslEIuWM4f9nOZBB1_4BnNiPQ>
    <xmx:qjQvafgB8CbNWfvkgenjGYsyCQ6jdvHzrEYxlymIslHhnA5OPyMQ8p_U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:49:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ab4a5b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:49:11 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:49:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 09/11] add-patch: add support for in-memory index
 patching
Message-ID: <aS80oc61kHICD0zZ@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-9-407dd3f57ad3@pks.im>
 <CABPp-BGRnx7+qvFcDeWCZEZm1aRn=kRezZ2KZA0E=8hji9Vjiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGRnx7+qvFcDeWCZEZm1aRn=kRezZ2KZA0E=8hji9Vjiw@mail.gmail.com>

On Wed, Nov 19, 2025 at 11:04:21PM -0800, Elijah Newren wrote:
> On Mon, Oct 27, 2025 at 4:34 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
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
> > +               ret = -1;
> > +               goto out;
> > +       }
> > +
> > +       for (size_t i = 0; i < s.file_diff_nr; i++) {
> > +               if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
> > +                       binary_count++;
> > +               else if (patch_update_file(&s, s.file_diff + i))
> > +                       break;
> > +       }
> > +
> > +       if (s.file_diff_nr == 0) {
> > +               err(&s, _("No changes."));
> > +               ret = -1;
> > +               goto out;
> > +       }
> > +
> > +       if (binary_count == s.file_diff_nr) {
> > +               err(&s, _("Only binary files changed."));
> > +               ret = -1;
> > +               goto out;
> > +       }
> > +
> > +       ret = 0;
> > +
> > +out:
> > +       strbuf_release(&parent_revision);
> > +       add_p_state_clear(&s);
> > +       return ret;
> > +}
> 
> I'm totally unfamiliar with add-patch.[ch] beyond what I've been
> reviewing in this series, so this may be a dumb/naive question, but
> why add a sibling run_add_p_index() to run_add_p() via
> copy+paste+modify?  (Or is it not copy+paste+modify in some
> interesting way?)  I'm worried the two will drift, and I'm curious
> whether run_add_p() should just be calling run_add_p_index() and just
> passing r->index for the index field.  Is there a reason that doesn't
> work?

Most of the function isn't actually copy-paste-modify. Out of the ~90
lines of code of the new function only ~20 are the same. We could of
course introduce a function to share those lines, but it doesn't save us
_that_ much.

I think the logic is non-trivial enough though to warrant it being
duplicated regardless of that.

Patrick
