Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688C1EFFBB
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268058; cv=none; b=R9nCvpNXdckHLkFDi/Fl5grKTTMRcsRcRZgxvve8AEQWICJzPLYxXbrdT5kmXxGj8I6wrI6dy2Fx+Lxyieq+ZD4D32gVTu7mkMCQigaYil741ksyiTkUql2oGpVrYYLIc70oqN6f2WqJetUrq1NPJpD65zbCcV4F/mid6JGHw/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268058; c=relaxed/simple;
	bh=pAJ5jKVCZ9H1IWFKq0Qpra0HaNDyOE66wXoDNrbZOyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dFEYXFUHlTIJExqR40PsyukQBsNfzW6gwFRI2oL2UqxxibzBaXKXxbOAWOetiTm2eRyC81iBgVhpOCM3I1gkBaIwvc4BC8Ii5q6Ly3Br/49EC28IUz4A1hp9KObam1inDcpPGU0+xsrzIGdotR8OWT0HMPuhDmeORGGsS+N0Vc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wdLn2YvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NadMvjBu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wdLn2YvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NadMvjBu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 88CE2114019B;
	Mon, 21 Apr 2025 16:40:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 21 Apr 2025 16:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745268055; x=1745354455; bh=N96Hm301am
	pBf+csu1louz3ektM8ELIH5wqFsxPxnzw=; b=wdLn2YvGUejNLr7E0TRy95Ven7
	Lx4jhQiPvdepQ60mlg/Qg8b8YLkIkajIHNZPyZujHAYZ1vo+rdAzzPB+EIJl5IP2
	N/UrzRte9FHj/uzHT7Sx4E9IUnowF/e6xuisTAORjp6TsTRFcVY7yjEGuBfk8VTv
	8XjQqQ10pVk69TqM/m1DGnteEzIEV+tm5wvbwowsIYNQLl1UKjW/csVSpUqWedSG
	F7mpFv7mrtTgFSQppvC+4OzsaigSVffukXiIHlupL/EKTZ9BAtQRqBdQOdUWueZQ
	6Uf09+fxStF7O8NO/MuH6jQrVrv8lcbT7eUQXb3ThWbCbVT1txX6DBm17Rfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745268055; x=1745354455; bh=N96Hm301ampBf+csu1louz3ektM8ELIH5wq
	FsxPxnzw=; b=NadMvjBuybQ/3AfzxUDyX99FalKjt7jru5ND2wBVGgtcgN4Bnx6
	3rOCrpmDn3EFiUzC7u6b7CQ4gRdesGipnRj0+SaACN3pX8AnXDpzVg/1/GCBTgPh
	weGNOO+obbHXC8vs2kCxZmNOI1GkBlPjQBuxiAUOKNbeNAfwaYZe1fbwmFemZaOO
	z4HLF8n74vk1S2q1G1Cm10eUlXrt9vbcsNjV29hprDfKDv5Oy59tTJsBUrG5pIRP
	F5qJCFATDfxmt+h4XvnAdHSzkB2fPxd9CidH+2ydTFFiAb9IsDseEactMewP/qWP
	kkGXE4ns6UNnuGuSyjoznyNHo9DUzyuNH+Q==
X-ME-Sender: <xms:Vq0GaF6SDsjeUx-iUn3jFCXOjBbU2fYDSSyC9ZuwJXE7hU6bxHxbWA>
    <xme:Vq0GaC7iUgBDc992aXr9P6swNXxnOGm-xRxiAk1klitBK1NzU_DcVlcGPKTfKrajY
    IMfbL40_KncStPt6A>
X-ME-Received: <xmr:Vq0GaMf5R_g2-LUSRvaeB2ydcbupXUfSKPF5wNflE8P6709Tpf7mGMpdSEOq25st1eTCffpSnXrOD4cKcqKFbQyGdK_6EphpN8-u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedukeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Vq0GaOKPZXuO1A1o2qbCMt3kRc49EvxO2UGYli6Lv0V60_QE7fZkZg>
    <xmx:Vq0GaJITH6Z4pzs9cG7APNjc7p5ZfimxY05QdwuGojJE9YDtQHMLYw>
    <xmx:Vq0GaHwdT87Haa-xwuy-xXuqE4RGDlhj1S0R8T7psi4Q_fHgYVFRXw>
    <xmx:Vq0GaFKHGhVfY_5TdGhF7OOFLxUw99grPRWPGYek9lNV_TPb9CJ-PA>
    <xmx:V60GaHsJR5ONY-qr6xoDft8xe4WqfU6byP49ZyfbxFpVvNy2BOEgf9zT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 16:40:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  toon@iotcl.com,  ps@pks.im
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
In-Reply-To: <3389d086-4e6e-4896-94dd-9f62d7c4f2df@gmail.com> (Phillip Wood's
	message of "Mon, 21 Apr 2025 19:54:16 +0100")
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
	<20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
	<xmqqh62i6jli.fsf@gitster.g>
	<8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
	<xmqq8qnt7c9w.fsf@gitster.g>
	<3389d086-4e6e-4896-94dd-9f62d7c4f2df@gmail.com>
Date: Mon, 21 Apr 2025 13:40:52 -0700
Message-ID: <xmqqplh55ju3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 21/04/2025 16:41, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> "git ls-files" is complaining that there isn't a git
>>> repository. Looking at the output of the checkout action (reproduced
>>> below) it appears it is extracting a tarball rather than using "git
>>> clone" because git is not available. I don't know what the best way to
>>> fix that is - I guess we could run "apt-get install git" before
>>> calling the checkout action.
>> Interesting.  The use of actions/checkout@v4 is nothing new in
>> Karthik's series and we haven't seen this issue come up.  What's so
>> different with this particular series, I have to wonder...
>
> Good Question. Looking at contrib/coccinelle/meson.build which is
> where the invocation of "git ls-files" has been moved from it starts
> with
>
>     coccinelle_opt = get_option('coccinelle').require(
>       fs.exists(meson.project_source_root() / '.git'),
>       error_message: 'coccinelle can only be run from a git checkout',
>     )
>
> I think it is probably fine to skip checking our headers and running
> coccinelle when we don't have a git repository but we should ensure
> the meson build can still be configured in that case by skipping those
> targets. The Makefile falls back to using "find" if "git ls-files"
> fails which is another option.

Yuck.  I somehow thought that CI jobs are always using a git
checkout, not tarball extract (after all, that is what
actions/checkout implies to me X-<).  Of course it is good to
automatically ensure that our tarball extracts are buildable, but
the way tarballs are built upon release is probably different from
how these tarballs are made automatically (*), so in that sense not
building from a repository but building from "git archive" extract
is not doing anybody a service.


[Footnote]

 * "make dist" is how a release tarball is built for this project,
   not "git archive dist.tar HEAD".

