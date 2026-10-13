Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6B3515D1
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912631; cv=none; b=PDgdTE+n54JNF0Y09DHR++HQTfjuzpELFVvyae/GU6UgAIsQpi7zQqLzjdhrsooe5774tdWrP8/W1qeRYRT4kAEoBER7mV4vSy5OJkNTtBenVNbtOw8BN5v/ZvV4Mrdql9/SztJy+dI6vwTZTpKfkAobC0hNjq6PNwY0j1LNGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912631; c=relaxed/simple;
	bh=KdDOX+8oNhBG9MMXUzoGvVpaWPxKAp5P9B2qqyjgrBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSPrpLr4lfn0fn/WWtkDXQtaFXpW4cpPNEmWJIodYTIRCxjqns5lE2OrFNfAZbE7C7Fmw2xu/L8Ix8h/tsos6JhABI3AsmMP8R3tnXlU26prH0MKdkauQg1I6g9442WICxbCFkduiYMh0Txkdsp2h4I5Pu3JrDhqj3iogBHE8VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U1i3NrN3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hDlMQLnN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U1i3NrN3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hDlMQLnN"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DF9001D0011A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:30:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 13 Oct 2026 13:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791912628; x=1791999028; bh=8SHKZ3Dvrt
	rpFapGARzyIRlVK88RXwlAGjegGwRCVRs=; b=U1i3NrN3jINEVGz9JqZ5Te0PGZ
	clIUTMllhZmAOyF1UeeCEQ7Bf4K6ld7LuBZqZWAk4NPML79prXb2RcSMWe/Sw4on
	LKdzZTPOGmzqWxCHLP/JeJoFoQr3SN5zJtqxN66uLPZKxuodWulVBNWvP/5QaG61
	lo5ql80kto6v2TKgWDu0nLHLDAc6FNnCs8OzqKwOlp3SnbcvGYAdgehy7skZipW0
	AS7UDh74XydbEWTuYDGEAWezJJ+TFT9eyjZRRmjwCD27QaVXf2vLfWPWX+BDS1/q
	L8wxIdcnPt5KTiDS3ossyUI2RA/7OSd3HcFBMYMhE//e/7Pxod/JExHb4LLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791912628; x=1791999028; bh=8SHKZ3DvrtrpFapGARzyIRlVK88RXwlAGje
	gGwRCVRs=; b=hDlMQLnNqy026h8r+dhBSSGmRZ6zJl/o8OgkAPwFZ6oUA/LvpcZ
	GuWklKark/SAVuR3qUh7Z+yLCtDM5mu7WXeqk8EiYPYf0NbjemeFqXW/gZrp5hUe
	kICKJQzKjAVVj8Ls2iTIKB1yHBWM92CRQbRO/H13BHp4VQFNmJIyA7c1rIqNfc+j
	VHNoQDqhSBhZRDWmbsnvomMLR6d139kGkfKsFVHEAZrf4wO06yvE1cHqlqYujZLT
	kEVrsfTqX6IJ98a8XD/FC/k42h7r0451ylc7QkSxNrF1ZtcrgpYkVDvxTuMFbRd0
	HwCNTy3IxUIwq4YvuVeF4cr2MOLsy5AfAUA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791912628; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:T5NgIVRa83vWpY3CnTQBPfmCimj8fFKkhHeMmI1Y9gGXiip
	OOsbYQ/kxzJdfex8nIOA1k6Ntk1RZr0L3EpTpry8+Euqtzvx4nx43JINiGspUr14
	6woXAhoJ4X7ZeD1tcGXZ0BsAq68gzEaOlTKqLQewFRRmhsG6z4dGzJ/fvgCjUnzc
	5OyOZ4UwNpT7JkVhpnuTduckiLwSeObWI3tdr+D01xWq/BqHgcXTAxNEOsbDN3Te
	LMR1wPr1MUE44OEj4aggbb72jmwamh2QaQcT0dxn3US9GotiFfc4cY9y808hkA5b
	mkgPcH58nLqyUVEcCOi79HPU+paJRc/riOX5Sjw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:guL0KQZpToeZJjVLyYa9nTguxG6CRxHVo+sz0YPzqUE=:KdDOX+8oNhBG9MMXUzoGvVpaWPxKAp5P9B2qqyjgrBI=;
X-ME-Sender: <xms:s2rOagpb2ziq_i7L8r8ljfsXoN74-L6qnocoww7AyHaw7LcnsUWZsA>
    <xme:s2rOarl09e90wZDPqvYb5BqX8hLhWCupg5qpKbRwLQfe1cGFy6Mhzgptzt-zY9OKh
    3H8HDmT_eZkJUDLWfWQ2symfwr5iqXEE8cngjH6Uf4XJ-C1WI59FPU>
X-ME-Received: <xmr:s2rOapcYbTwEHbAu_XwXlz_FJfki4kL2BPEpF7Z0NxvFW85F8T8mDWJmKrjPMdchR9krNa5NKTDxz2lgzq1xjgEPoasp862D8rpa>
X-ME-Proxy-Cause: dmFkZTFoHapUDCTfKUkLM01v2hJ8aWWNI/4GGTVoSPubnm0m083m/3XtLXmCbm7LgIb73h
    w6kO3V+HXOkzM7p+eXJXoRscs5lTSGx1CoWP7mqgYq7E+JeCIIyMIF1MCL0+Q/SlMSTB6C
    /kBgLzn7C45ejP58/9gu9xfAz6HFw5L2cg30B00E8A0/kl8hxS2UStbjktzjS6+9TI7qBS
    d16oITqt19mZMRyRpZYvWHB/70SXYePPRVd9zTZVYvIxxfxf5PKmwjKWrAUKCMPMpB3V7A
    NksZF4DENrkBE/DfpbsGfD4JMev0IIvRlstcF9SCHnFUI/pOX9zPknEL3B5bqcDZV/EERH
    Lm7+lxCQhi7kVfgnGywRdWFMD0+cz8pUv+sJqOzzgHSUHNpmKHUbtpObKYYFNFRjs2fPMh
    kMjMuXqFv5nf+cKMjzh1ZeggLNUpiUvaiWe9uoDu4ShZi+xfNQ18/HlYReuXV2hM8K0ncz
    zZ/5zVbDXCKc4/yylPH8+5s1RugrNKGP8ui1ghcPtdLCFbaltjhaXPphlIKxvgitZGz5Yz
    u+09pfNyc+x6JpM9URZOn1D32D8ayoWkzv/iF0o2QxAAL0P4/+sALfMEfT/YTZ0O4jxzkj
    IOosFXlRpU+u8Ttp6UyD8ywNcltXNYvzxekrMnK6dxz/6ShpnnlFVVIBHp5g
X-ME-Proxy: <xmx:s2rOanrYYG2ZrfhzKQrl5TIiM7feDF7dAJpAX6gAjK2fr0_88ICrag>
    <xmx:tGrOajPEOLqWqvweiLUznFAfPJ8MgbOy8mRk9IGnVXd2r8XGivip7w>
    <xmx:tGrOaqhCQdtBZIyi008ugy4OqybgtIluFFWKmV1fLL2gv38u30QNdw>
    <xmx:tGrOamuKMpOoMvjI84A9YV3EBIIenuaiG3MVYYWInMX3QJntq3umrA>
    <xmx:tGrOaniPve3Ku7vQhm0yQC9-gCfivcJ2y7WO_W7TJ8gWLTObht18fMuR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 13:30:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Abhijeetsingh Meena <abhijeet040403@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Eric Sunshine <sunshine@sunshineco.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Ravi Mistry
 <rmistry@google.com>
Subject: Re: [PATCH v5 0/2] blame: ignore revs in .git-blame-ignore-revs by
 default
In-Reply-To: <pull.2224.v5.git.1791902175.gitgitgadget@gmail.com> (Ravi Mistry
	via GitGitGadget's message of "Tue, 13 Oct 2026 14:36:13 +0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v5.git.1791902175.gitgitgadget@gmail.com>
Date: Tue, 13 Oct 2026 10:30:26 -0700
Message-ID: <xmqq4iepzex9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

>      +    tree when a working tree is available and fall back to the
>      +    HEAD:.git-blame-ignore-revs blob in bare repositories. Reading from the
>      +    working tree in non-bare repositories makes it ergonomic to prepare a
>      +    new .git-blame-ignore-revs file or add revisions to an existing one and
>      +    immediately test the effect with git-blame(1) before committing, while
>      +    falling back to HEAD:.git-blame-ignore-revs allows bare repositories to
>      +    respect the committed ignore list as well.

Very well written justification.

>      ++	processed after the default `.git-blame-ignore-revs` file at the root of
>      ++	the working tree (or `HEAD:.git-blame-ignore-revs` in a bare repository),
>      ++	if it exists, and any files specified with the `blame.ignoreRevsFile`

Good.  A bit more comment on this later.

>      ++	config option.  An empty file name, `""`, or `--no-ignore-revs-file` will

That's "a configuration variable".

>      ++static void parse_default_ignore_revs(struct blame_scoreboard *sb)
>      ++{
>      ++	if (repo_get_work_tree(sb->repo))
>      ++		parse_default_ignore_revs_file(sb, ".git-blame-ignore-revs");
>      ++	else
>      ++		parse_default_ignore_revs_blob(sb, "HEAD:.git-blame-ignore-revs");
>      ++}

Here, HEAD:.git-blame-ignore-revs is used only in bare repositories
so that those working in a working tree of the project and on a
revision with a committed ignore-revs file can remove it from the
working tree, verify the behaviour of "git blame" to test before
committing the removal, if they no longer want to use the committed
ignore-revs list.  Which is great.  We do not want to say "we have a
working tree, we do not have the file there, fall back to HEAD".

>      @@ builtin/blame.c: int cmd_blame(int argc,
>        
>        	setup_default_color_by_age();
>       +	string_list_append(&ignore_revs_file_list,
>      -+			   "HEAD:.git-blame-ignore-revs")->util = &sb;
>      ++			   ".git-blame-ignore-revs")->util = &sb;

Hmph, build_ignorelist() ignores the string and only pays attention
to the fact that the string_list_item having a non-null .util member,
so this diff, and the fact that a specific string is on the list, is
a bit misleading in two ways (i.e., the string itself does not
matter, and the value of .util member does not metter, either).

In other words, a cute hack like this

		string_list_append(&ignore_revs_file_list,
                		   "<builtin default>")->util =
                                   "see build_ignorelist()";

may still give us the same behaviour, which is *horrible*.

It probably deserves a comment to help future readers, e.g.

		/*
		 * An entry with non-NULL .util member adds the
		 *  .git-blame-ignore-revs at the project root;
                 * see build_ignorelist()
		 */
                string_list_append(&ignore_revs_file_list,
                                   ".git-blame-ignore-revs")->util = &sb;

or something?  It is especially misleading to pass &sb here because
it is not used as a scoreboard at all anywhere.

Thanks.
