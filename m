Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB337464
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162342; cv=none; b=CtP6xZlkr970I2xfesvmkKf+pNSbWfNKO4qz0GEsa1ZTy7xyIpsZpNZETHLZ2M890kfybXM2JosZnNoxfSSvDKUcT7vNXoBWkZWe2yjnjS0rtZHrgMcCrX8SB/Sq0xKHjOk4jHp5iGo5HGnn+07JPTYRLjywKDHobsVQWrkfaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162342; c=relaxed/simple;
	bh=ruua+FxV1uBe825/ykNCvxHZilHhgOKkKk/HznwFc/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q5I0Y4PZIPMmj6rD3kdEwwS5pHptGuUQxNETPZaYPazkq5InYTsTfW5rN/jCTRTmrgff6Ha508mVUQ9VWIBLCCYFvINkKtoK/pi4WjVtGya+D5apG7d9OaHS/ubMSV94ZOTpfk0f8eQdplrgoTQ5HMW3HPB1lrYpk9EakJ7m+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WacjwPpU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KrSmhLZ/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WacjwPpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KrSmhLZ/"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 462ED1D00263;
	Thu, 10 Jul 2025 11:45:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 10 Jul 2025 11:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752162339; x=1752248739; bh=5lzqCZLY74
	M/KT0uPfpFH3bOC7xCq6wywYEg9JQebKQ=; b=WacjwPpUl5JIKYia3UE7BxQZF7
	616IXb9MkloleVtiHDvCb1GydldTDz3dL34Hla80ohlNn0GmS5X9Wvf9txgYH+xW
	hKarpx+gaysOerbj0hgPVij1HgO+y/LeyVvPIo/v5IBQTV4DYo/PFjYYQOZyD7iI
	6mDL/v3wekuWm2hLCWRiF5BJx3rTm+wm3FC2sL3+WE2LkdXGQOdrgDgLV38q36vI
	vnAZhxpUogk4x41atPjFlXga19bPFYc/EPbwIJNj3g5+JlHf5QDLZWCXfIOzmDOq
	OzK+sa4B2ES8B6u+wylaCX7yQvRExHs4W56JYYDOe7yAhwAydolJZkoRT5Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752162339; x=1752248739; bh=5lzqCZLY74M/KT0uPfpFH3bOC7xCq6wywYE
	g9JQebKQ=; b=KrSmhLZ/ldRsIZl5Em175SwcJqD3aBG/nSKAAyQwbWuX/JDT4Me
	KM7qmY/SQuW3D+G91PAKaF57lfe794Haq2oKiHPXC1lCbowC/1t9L+r/b8WYEQ1E
	GuTdFaFnxBCcCIDiTjRtVpl3FSM5xijPObmTMd5ol7SCS8JVR31nhsXhBt+cNeku
	LUC5696RRjP4euDCFnIliRWd6J8FNQ+0Qw8Ru4vColNCitJBitjHLeXuy5hchjIN
	VcHA6Wx8DUa+5F5MaFAb3PkGumbkzQNFk8Bs5831p2BwgsaL1a6edtvAEh4nZbTG
	ef0OES3s/tDJkv43sp1+v/uw9IKCYmR0VRw==
X-ME-Sender: <xms:IuBvaHhsH9f9dYHDhojIn2O-Jhgv_4Jlfkhg-LxpAQ1T0T6ieM3m5w>
    <xme:IuBvaHQH8xbqwjab7lS9nr8BCfobIfxMEXrZaN9yrC6Dw5Lih_hg5vNGtTNuID8py
    Yw5Nb7yYUW_COkjNA>
X-ME-Received: <xmr:IuBvaAjo5n2wdIPjs22rkJGhiuzNu8gQBPOS04LBzRoInYNAVOs97ZGwvQNwmDi8PC3qEFMIQ18BWobyyAWaxZfIHGtnOu-cAcqFTu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegveevffdtheeukeeugfdvveefvdffffdvjeevuedtgfetfedtieekffdvfeeh
    leenucffohhmrghinhepfhgvthgthhdrtghinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhrvghnlh
    esvgigohhnqdhmvgguihgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IuBvaP52iVEi0SLITte7RP_Z_NeKEmihWsPhbMYd2FdricEJoBUlXA>
    <xmx:IuBvaFBfKTksivPw0GAJXIrhGCQEk_XN_JMWY-JM39hRCRDlDstBKQ>
    <xmx:IuBvaOZ-0i0lmKDjeRbIBUT7d97mwQfmefhOsfO65dF7sWDYVPomSA>
    <xmx:IuBvaIZs2XNN56EzwjE0zZBDwOAKlUBSSm9A97mp1VR8Toa1Vzn0Kg>
    <xmx:I-BvaP7U-xqWUMl6BElCe80mLEWTa4EdcF54gcywmVUt3t_32VJxTQSw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 11:45:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oren Levi <orenl@exon-media.com>
Cc: git@vger.kernel.org
Subject: Re: bug: `git commit --verbose` not removing text below scissor-line
In-Reply-To: <CACpw4KCYrgjCPO6z-czSa=rW+5z5m4Xpy_RSgxEkUGdeMEvULA@mail.gmail.com>
	(Oren Levi's message of "Thu, 10 Jul 2025 12:07:21 +0300")
References: <CACpw4KCYrgjCPO6z-czSa=rW+5z5m4Xpy_RSgxEkUGdeMEvULA@mail.gmail.com>
Date: Thu, 10 Jul 2025 08:45:37 -0700
Message-ID: <xmqqecuo82xq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oren Levi <orenl@exon-media.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. Run `git ci -a`
> 2. Edit COMMIT_EDITMSG (using vscode)
> 3. Save&Close

As you have commit.verbose set, and your "ci" is merely a short-hand
for "commit", this is "git commit -a -v".  It should give us a patch
text after a scissors line, that looks like

    #
    # ------------------------ >8 ------------------------
    # Do not modify or remove the line above.
    # Everything below it will be ignored.
    diff --git c/builtin/fetch.c i/builtin/fetch.c
    index d48262bdc7..3267617a54 100644
    --- c/builtin/fetch.c
    +++ i/builtin/fetch.c
    @@ -640,9 +640,6 @@ static struct ref *get_ref_map(struct remote *remote,
            return ref_map;
     }

Here is what I did as a quick sanity check

    $ git checkout --detach HEAD
    $ git reset --soft HEAD~23
    $ git commit -a -v

and

 (1) I do see the "# ---- >8 ----" followed by "# Do not modify or
     remove the line above."

 (2) after making edit near the top of the file, without touching
     anything around the "---- >8 ----" line, saving the file made a
     commit.

 (3) "git show" does show the patch after the log message, but "git
     show -s" or "git cat-file commit HEAD" do not, i.e. "Everything
     below is ignored." the message says was true.

so, in short, does not reproduce for me with the info provided.

Since I do not use vscode, my reproduction attempt used an editor
different from it.  It is possible that your editor may be mangling
the line that it is not supposed to touch, but that is not something
I can tell.

> Anything else you want to add:
> related config:
> core.editor = code --wait
> commit.verbose = true
> alias.ci = commit
