Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E42236F7
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551418; cv=none; b=DR1pEIZqnpZsOPZMyLF4ySYME7wp2ln99JVpYm+h9fqnjP7xWkfeNRLqrxLxzvwhPMjgHBxwaFNEUeildmgL5hJ9kZRfHu2hbK/RN1tFthQGE4ERMqK9nAirhrvjraKdOb6WjYIGh+a1LPeTnZuy7XWAnJ6sG0j7ZvioGf/5kko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551418; c=relaxed/simple;
	bh=6eSo5vaEippKa8Bsyn6+l+fNfSizLOzuHw/0NYaVU0I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=debh0g6N8Xb8MBwwbFL8cWmEtFaIn8BFm++sIJ0Z2AF+z240PRkgOXD7LwPZKWwVPkANzcpg7iLU8eJF5dR6d1kU1sn4XoIIp9TyLcuKwBivFoG1Q5CounWF8iPyM+IYC5Vn9uH6ruDS1x6eMGZqD1UMTxmTzJsSINY1Qdc3IxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Be3iYCz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AJDFA7vP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Be3iYCz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AJDFA7vP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C726F14000F5
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 09:10:15 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 09:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791551415;
	 x=1791637815; bh=crlgDhesCf5JuS5ihfVvJoQVcFEdpkcYQ6v2/EVTCLU=; b=
	Be3iYCz4sJVLooow75HA4e7FX/JYGtWX0viuiXbxJTE8gVIIBvyh184dEiehTdTu
	gW5Rmq955Ey36wKrFVJXzddTRGvJ3nvZttd5WY7UvXuZrCo803G8yqnEwo+DXBYA
	X+OSOZILaQ6BOg00yNiM6ndQ8apZUpoDkGlSj2b4TkdzUFik1Lprv4DRcVFkHt9W
	ospLgBQBZgtb3fCLJWf+9N6NzPPWgawgruUFo7eDYwDbRSNzpGYNng3Nh6J0JZHh
	HFBTz/w16/PLQvGgZ1PiTIyjRhwPL1aHWCqOLRlIIpJe+c4tai1S4gV2lEZK+bXI
	QS0R9cS4lKDrgmAnY41PLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791551415; x=
	1791637815; bh=crlgDhesCf5JuS5ihfVvJoQVcFEdpkcYQ6v2/EVTCLU=; b=A
	JDFA7vPwtgiIM0j5juvQy6m1zWjSNGQkGnOj9W0Oe4G95NQOWmlYdbTe0NubiLe8
	tGG7zKsIJ8sDgsy+K++bauPTXmexf47rb1cme1qzHBQWLfoarbHuPBjNZOoqhjUI
	AKEKA43y+NNo7zlErhxzJBSc7rGQHbjWhd6yPiFxTRQUtHySdR/lUeG1yplf8OZ3
	nU5hljapZH1DeWOs9adwF8j1ZmvhwVR/VUeuzSXPyRdZGmGWxGuVq/BfbeOvIQFv
	I6siOuCR4+VF6ykD/79Bpe0uCZK+pyOzsnAJdp6OJqVzrPqxaXVeeCM6UTgAWGGs
	OcMsu7m8Cj6MvG50299XQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791551415; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Gh7gTAPcDC4hVTuwxhSfpfLysrFz4rwxkpEFiY9ffXnP7Dm
	89ozG8AAdnnZNJ8L/BSY8FBuj+7qdtT1r5NmDmwb17Z+DqMwYc9OvtNUm3aDtJCV
	lroB0VCzyPSs9gMzxHCWp+FXRRWZsUnIqVgi0svKoPsKJb0kSO+Nbkas2Wvys4O/
	RmGPyurDiOEPlOV26yz+3p8vTlLtkuyn7W6pFrU4MbN5PTqvb4siXErySL2rl+i3
	2p9zfsVe/3oq3/IIM+g+xQqJcu2PglwkZcD8oUhcSc70LHzaU3H/7QcD1pf5K8kW
	8GsBASMzOLby5eovz6zw1q4zeDMt7HY8OtFSdzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NUKJiYSFEOpSuIv93pAeZg/25avLlKJ1JLyo97CfhF8=:6eSo5vaEippKa8Bsyn6+l+fNfSizLOzuHw/0NYaVU0I=;
X-ME-Sender: <xms:t-fIahMkZ4B4XSGAZoQCsJQgTtL43XM4qLxF169JJdhz9hFhbsVhig>
    <xme:t-fIauxBZu0w7Zi-XQgQ5ikx-xnTppm_Oygmid1nC-NYkaBL3hgmlbjah5ByX291i
    zHO3tx5BHgO6jLjoUEsyjMjlIRgjPxCxv_FJQIXkYXpva15JF-g5N0>
X-ME-Proxy-Cause: dmFkZTEHFvp/jIMi5Us3Biv6DNPo4lY2K4v9aqj6p4Ib+qdNzooAboXidyvLe+PScAZXbB
    7hunn5xsuwcWIvx8ipuaZ1/QVDlHeLUd8NoYldwpq9sAB+YfmihjNQ36e9eZGotwWRkyOU
    l4FDkUtyXTdzmNLe6Hu9xhyp+U+lg9BQ88C1HWurJ2bT1xCTHFr6vjK42GVzDsqcz5sL5o
    YNc5vWmJtffK3zUoVb9DECaoxtep3fWhRHbPzNChFi7ilVx3/IrPnbOCmsUlPfGafHhf1M
    xz2JNLFknIM/YdAYZDclZ3U1xkjILcD9f0Rl23PLToWq4CLwyaNGYuKcXJ3SF+iCNDo4ls
    Jhm5RBOaH/IVag08lu+mKWcr1OQUJN/Tscf5/nV8vBfc5tzZpl5Km9KpPCG1PpCOYo79cC
    oZSv0LbHE5z/nz+yAaeRib/Y3surLN2F+/cUmCKQGqRgJ4nBmxSwzs+wstpJCs0FCIMyaT
    4o/8qKfpSnfvWuxRUOdCGVgFFpWDBKqv7pBuSkVfySMZRC777zu/MaD7Ak4if2t0Pv2I3Z
    ixe5MNygsDpWxvDy7JPOoo/ISP/Ulgc0jv4YnUKuZDeW8XYx7xCVSSYU/8egm9ck/w1n6C
    vPjFvwRX/GL/UgwB99txU//lB5WQvG2bTnKr0qfXxdg1OeQq43lRhSW1sd2Q
X-ME-Proxy: <xmx:t-fIag1cGvCG6qpOdj7zzmW2x1f8xbBTM4-icAXdWWcVBaAvxwjpRw>
    <xmx:t-fIao7tCOVvMudubGKRcyQp4Gxs-c5YA5-5OAwr5e5yPdIbUsiHbA>
    <xmx:t-fIajXvY1o9o9aPuneBNG2HYFN3tDePFj46GpTWo3U_d5y_pBufgw>
    <xmx:t-fIanDF6A6bniIhFRzebDVohldZ5v3ZDnOCG9JachOGGmlQnIdtug>
    <xmx:t-fIahLvELRDXuExLRLHBJ-nSipbVQp07CfMbSkuo-5EyOz5bs61A9fJ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 931B9780070; Fri,  9 Oct 2026 09:10:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aisr1WIbeEPB
Date: Fri, 09 Oct 2026 09:09:55 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <23b09149-ddd6-4b29-9a30-3ce3ab323e22@app.fastmail.com>
In-Reply-To: <xmqq5wzeelmf.fsf@gitster.g>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
 <xmqq5wzeelmf.fsf@gitster.g>
Subject: Re: [PATCH] status: suggest `git merge --continue`, not `git commit`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 6, 2026, at 2:20 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> [Administrivia]
>
> As you have
>
>     cc: D. Ben Knoble" ben.knoble@gmail.com
>
> at the end of your pull request that you gave to GitGitGadget, you
> ended up with a bogus Cc: address that reads
>
>     "D. Ben Knoble <ben.knoble"@gmail.com>
>
> you may want to help improving GGG by raising an issue to reject (or
> ignore) such a malformed address.

done: https://github.com/gitgitgadget/gitgitgadget/issues/2385

> [end of administrivia]
>
>> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
>> index 942ddbbf0e..a9b435b5e3 100755
>> --- a/t/t7060-wtstatus.sh
>> +++ b/t/t7060-wtstatus.sh
>> @@ -37,7 +37,7 @@ test_expect_success 'M/D conflict does not segfault' '
>>  	cat >expect <<EOF &&
>>  On branch side
>>  You have unmerged paths.
>> -  (fix conflicts and run "git commit")
>> +  (fix conflicts and run "git merge --continue")
>>    (use "git merge --abort" to abort the merge)
>
> This message comes from show_merge_in_progress(), which is called
> only when the code is convinced that it is seeing an unmerged
> index due to a conflicted git merge.  We can therefore make this
> message as merge-specific as we want.  The suggestion to use
> 'git merge --abort' already does this.
>
>> diff --git a/wt-status.c b/wt-status.c
>> index 57772c7501..f7b0dc29d5 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1273,7 +1273,7 @@ static void show_merge_in_progress(struct wt_status *s,
>>  		status_printf_ln(s, color, _("You have unmerged paths."));
>>  		if (s->hints) {
>>  			status_printf_ln(s, color,
>> -					 _("  (fix conflicts and run \"git commit\")"));
>> +					 _("  (fix conflicts and run \"git merge --continue\")"));
>>  			status_printf_ln(s, color,
>>  					 _("  (use \"git merge --abort\" to abort the merge)"));
>>  		}
>> @@ -1282,7 +1282,7 @@ static void show_merge_in_progress(struct wt_status *s,
>>  			_("All conflicts fixed but you are still merging."));
>>  		if (s->hints)
>>  			status_printf_ln(s, color,
>> -				_("  (use \"git commit\" to conclude merge)"));
>> +				_("  (use \"git merge --continue\" to conclude merge)"));
>>  	}
>>  	wt_longstatus_print_trailer(s);
>>  }
>
> We could tighten "You have unmerged paths." even further to indicate
> that these paths came from a conflicted 'git merge'.  In the same
> file, show_cherry_pick_in_progress() and show_revert_in_progress()
> already provide instructions very specific to these commands.  Since
> the message for 'git merge' is the oldest, it is not surprising that
> we did not update it when 'git merge --continue', the instructions
> for cherry-pick and revert, or 'git merge --abort' instruction were
> added to the system.  This commit moves us belatedly in the right
> direction, and as always, it is better late than never.

Yeah I agree that "You have unmerged paths." could likely be made
clearer. Appreciate the note about how the implementation works.

> The changes look good.  Thanks.
