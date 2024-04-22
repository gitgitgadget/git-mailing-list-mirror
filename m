Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27031B964
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818959; cv=none; b=pjNI6AkmbRSKPwKX5r3oJKn6P347/767MlRHZY4gOySmNIz2FaJ+IRvUrwTptdwhzgnKmaTHpBEgNsW17J8ij97DcZtjSlDf/pRUa2vke5CsqJ+mzSePnM453P2cw4GUNWmvgM4y0BbKGuX12tOaE91FES3W0TqmVN7KA74+0H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818959; c=relaxed/simple;
	bh=IIH+e4k4qQ2wM/1JvepTvzp6a+lRXXfEfAfXEV3PAfc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=B13yuPS4qmghWk/1d6GGcL9Qarl+mFmJlTYeOCFI+7k/nL4Hu/s4Vu/EafXVbHKl5fX5ak0Q15VfvImfk2N79Tp4M5+DJCCbtKkOWOKyOtDmHsTEeRHCjjWiWb4K3Oyq2PlxpIgWtMjXTo6xOSILKduBNc6JzTC7G+1q17yHiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adamj.eu; spf=pass smtp.mailfrom=adamj.eu; dkim=pass (2048-bit key) header.d=adamj.eu header.i=@adamj.eu header.b=sQOTcHTA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eYIjbskf; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adamj.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adamj.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adamj.eu header.i=@adamj.eu header.b="sQOTcHTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eYIjbskf"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 7C3311C00139;
	Mon, 22 Apr 2024 16:49:16 -0400 (EDT)
Received: from imap53 ([10.202.2.103])
  by compute4.internal (MEProxy); Mon, 22 Apr 2024 16:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=adamj.eu; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1713818956; x=1713905356; bh=kEoGRWctiE
	uBqN52kJWDIFD3c1lvkQUo2bpLveSBgVw=; b=sQOTcHTAfeQC7DnkgzYVLpJr2A
	v9J+lK2pxhP7woS5eyA17tOeQHblJ8RZ7inYb2PEjxf9p8nA1KLhOTwh2h5lNxCj
	ifZwxeZNZy4p5EmPilelRlo2O+zgf30GeeydpLQ8K/D7lCKo9V8JTJXFQf3LDaLU
	8vVUvF5uNEgCcOg5EZqYc7/11fG8OBA3csQtpE6v7KUIaEZVNuD4hR2A3J+oH+zJ
	tii7alTl3TOSEt9iMprQT43Q8EDycOJqywEisVPA2NYxFroTz6K9bTbAtwxaLZMu
	d/FIjo4R54u31jWhwdyMbOOqWMKn/vpkhZmJIDjioI+bw8q2g6tir6Hh868w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713818956; x=1713905356; bh=kEoGRWctiEuBqN52kJWDIFD3c1lv
	kQUo2bpLveSBgVw=; b=eYIjbskfa460hk/z86ehdAlOy/b774epIx61kPuegkKJ
	iDN5iRrEzDALv7z2G1mrwEvEy/J/7MDKAauj2NJgLrbpz88yvGe7R9q6OREOLNTa
	6YJ+3IfL0DrIWxvM//Lxr9WLM8RYGMYxQBuxGS4ldm4/9fdBjx1zfGOoFtR4Avk7
	JD1tPGuzsLdHEMruEA0kTNtP4WjeGfrkr7O2W1dHz5yOF5v+85yzX9xxy4zbLs3v
	OvdwmpBhNK9XRf955fY2UswqZABxqzw4YHvFAPcJvnJ04pGGbOkLcmW8LBc+FKZm
	DLjq40UMbTgaxqDuS4Kb4dwmaFgku8lOkfqD0fCAYA==
X-ME-Sender: <xms:S80mZjvtnWojxXnCGm6naj682lMD3xO5moMs3XdQvVXRpYq8vagzrw>
    <xme:S80mZkcgu2whTS8R6YewWMRoI94LPtfvnNfonjS5Mfo5EG_tze9gO7X8L3MA0wR8H
    uguM2vEMBfzlI8P-sE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    uggrmhculfhohhhnshhonhdfuceomhgvsegruggrmhhjrdgvuheqnecuggftrfgrthhtvg
    hrnhepieehheetudegtedugfdvhfejvdevteduvdefueejtdejtdefieejvdfgvdeiheet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvse
    gruggrmhhjrdgvuh
X-ME-Proxy: <xmx:S80mZmzggLUlYeYONHkHSzL2n_Rm0kqeePD7ju_hzgd53V_SjOU81A>
    <xmx:S80mZiMC9OFk70EzSaO_VwuIXZ1TOb02whS_1Hw73NNCVUbLp_5J3g>
    <xmx:S80mZj8fWP2zk-iFWdQTaDxeCAMQ66pgFUKTfDVpGvVZCiYtQYvG3A>
    <xmx:S80mZiWEkvspBWscL94WTEjNjjkYefmREDQIw6_dCSOuBQfCOKbpnw>
    <xmx:TM0mZk3_kFyB23y3UxUrGZNt8Mgp5tWCEqrwjk5-snjXmBrXNtba8VKb>
Feedback-ID: i8b3949f9:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A9C4D3640070; Mon, 22 Apr 2024 16:49:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f5da1265-004d-487f-ac65-deee50aaca0a@app.fastmail.com>
In-Reply-To: <xmqqsezdw7br.fsf@gitster.g>
References: <pull.1722.git.1713781694490.gitgitgadget@gmail.com>
 <xmqqsezdw7br.fsf@gitster.g>
Date: Mon, 22 Apr 2024 21:48:55 +0100
From: "Adam Johnson" <me@adamj.eu>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Jeff King" <peff@peff.net>,
 "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH] stash: fix "--staged" with binary files
Content-Type: text/plain

Thank you for the feedback, that was clearly explained. I will try to remember to CC more relevant folks in the future.

On Mon, 22 Apr 2024, at 20:00, Junio C Hamano wrote:
> "Adam Johnson via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Adam Johnson <me@adamj.eu>
> >
> > "git stash --staged" would crash with binary files, after saving the stash.
> 
> "would crash with" -> "errors out when given", probably.
> 
> We would be better off reserving the word "crash" to refer to an
> uncontrolled exit with non-zero status of the command, possibly
> killed via system signals like SEGV and SIGBUS.  In this case, I
> suspect that you would get an "error:" from underlying apply
> machinery, which leads the caller to exit with a non-zero status
> due to an error.
> 
> > This behaviour dates back to the addition of the feature in 41a28eb6c1
> > (stash: implement '--staged' option for 'push' and 'save', 2021-10-18).
> 
> When you find the commit that introduced the problem you are fixing,
> especially when the author of the commit is still active on the
> mailing list, it would be nice to give a carbon-copy of the message
> to them.
> 
> > Adding the "--binary" option of "diff-tree" fixes this. The "diff-tree" call
> > in stash_patch() also omits "--binary", but that is fine since binary files
> > cannot be selected interactively.
> 
> I love seeing an explanation like this in a proposed commit log
> message.  It is concise but very clear at the same time.  It is so
> clearly written that anybody who is reasonably familiar with the
> code does not even need to look at the patch text itself to see what
> the actual fix would look like.
> 
> Very nicely explained.
> 
> > Helped-By: Jeff King <peff@peff.net>
> > Helped-By: Randall S. Becker <randall.becker@nexbridge.ca>
> > Signed-off-by: Adam Johnson <me@adamj.eu>
> > ---
> 
> Will queue.
> 
> Thanks.
> 
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 062be1fbc07..7751bca868e 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -1205,8 +1205,8 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
> >  }
> >  
> >  cp_diff_tree.git_cmd = 1;
> > - strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
> > -      oid_to_hex(&info->w_tree), "--", NULL);
> > + strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "--binary",
> > +      "-U1", "HEAD", oid_to_hex(&info->w_tree), "--", NULL);
> >  if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
> >  ret = -1;
> >  goto done;
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 00db82fb245..a7f71f8126f 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -393,6 +393,15 @@ test_expect_success 'stash --staged' '
> >  test bar,bar4 = $(cat file),$(cat file2)
> >  '
> >  
> > +test_expect_success 'stash --staged with binary file' '
> > + printf "\0" >file &&
> > + git add file &&
> > + git stash --staged &&
> > + git stash pop &&
> > + printf "\0" >expect &&
> > + test_cmp expect file
> > +'
> 
> 
