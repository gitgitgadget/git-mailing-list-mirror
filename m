Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388E3164C3
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531377; cv=none; b=SyYf4QdtqSQzrbAjBZ6f5G4I8iv/DslAhThGKwVOAduKeVM8Zd5BM7oVgTzIgeaglmj7AcXxaxpmnR/Id6K4gHO88GaatbUsTjI1u/66JWtqCjgdWix8L8AVW1BBkFYJY9fW6uSnRqQB0ctzQRcpQJvuQZV5zVkLlUQQWPSyjpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531377; c=relaxed/simple;
	bh=Wb2Y6Scpkk1QeuKMUXLYkzZ63zQJcN8tYrWyvD4RpEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLaii7nSo0LTMoHvAZV1JJgN/fp8anGavU07O/J1crz/+sRqzljhPqlDBnUxakoAsmSDrSBCuzuCDIegTXwEJTxG1SDHAws2fBD7CSFaoI3ZlYL68KLyWiEi2ZBJcFMcpl12itotsiir05WHUwNQLIqOGcPR/RWFrBHg08lVVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WV3sQbQZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ESOkOuLi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WV3sQbQZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ESOkOuLi"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 5AEBC1D0018F;
	Tue, 27 Jan 2026 11:29:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 27 Jan 2026 11:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769531375;
	 x=1769617775; bh=/C0hng8w0MzmY2cgqSay92m9Mt4qYcENIIVtI/mu2uU=; b=
	WV3sQbQZ15NLZn/BToY2r8KVq+Cy2qL+Cn7zkSOJlWEKIaz4nJgF4BlufLpgfPTr
	3Y44TGLwOPyUfm42tA0qJRfwCE8DJfpuYarwZQ3eUziUaVFgIxM5GT3CIyDp2hDk
	A4JeB3w9ad41y3aRa5iwGA26mfuV3doJEQE8EuUPq7kn/uK+xQRvsY94XAbItB6m
	sRT5UQn2ObNugmOI/skKMFax+M/a0m9KLHMdSHGR6T8I/Di6ROxLIFlINw6P0hWZ
	LsuTsx6Ln9gDrlotSeoiKb3fjvGtRhud2Fc9T1pgiw6Ff5/R50s0yzBCqILrTB4I
	ycEzjslnB6CIOE5cAfpgww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769531375; x=
	1769617775; bh=/C0hng8w0MzmY2cgqSay92m9Mt4qYcENIIVtI/mu2uU=; b=E
	SOkOuLig0af1ib7nJiGraR6PKcWL0Nv6jqc3LSxW6heIKfIsrG/wiO/wA+0OAreX
	73Y3nZ+q48Z7X3vJx9L9kFSoa7F8assmtPXpfBGrMQ2U5TM9HQoyhyysNNdwuoWk
	rTdWPzf8XV3gdhWBlE3IZXDoZlqOknvhOySWhzit0PAWHlLbfQMGvh/YY+hJkon/
	xcNaDte4yz8Mn7zmNFopC0i4MoySWqsdy9Y5Xkk379+cJ3hqBRq3rnJy2kbWGDi3
	1GG2cNdIABh4cTbGP9YYxakS66+51BnH7S6hpJeZXcyiRNVShJNmMhvNTR84YwIy
	RIvBvvCZn3sMozu+KZ5SQ==
X-ME-Sender: <xms:7-d4abxGodZ9vpLBDgnapow8tJ_RiWcDwZXFnVzkmhDu3bHpfN0-SQ>
    <xme:7-d4aav9WTc6LpoZUfOn1gz16-Ed86wj-GswFMKXY9Y8UvcOBq_xrhYIXkMGuHEBu
    EPOpi6lMogAHYm6zwtIdqNacjxLE8jmKdO_By42IRx7ocPGOOGhUA>
X-ME-Received: <xmr:7-d4aSusWsPciaOlq8RLb5yasMxLhIpLF-1XU1RzPhQQKL1J_eLgjmPfSklgBNtjGQ0bUHedPYilqSCXQPAgZW_IyyEKbOCr45XKCgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekof
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnhepleejleeuheektdetgfdvheeuve
    eftddtjeffudffkeeuhedtjeekveegheeiheeknecuffhomhgrihhnpegthhgvtghkohhu
    thdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptgihqhhsihhmohhnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7-d4afNzuI6aoEUpYGog2AeFWqUeg805zJ428SQORfsupdfF8P29AQ>
    <xmx:7-d4aQ0sG4X2iuKZXHqMnapqfR4G77whPT0fz96QAlDuzxhp1dx1Fg>
    <xmx:7-d4abPwsgImQm8hCctV__5Ko6WO4u3W8jVnj6kawkLLtk3O6fRaJQ>
    <xmx:7-d4aQ1YSHeHMA2vBHhVLiMsICcbyLlPL-YM1AQRtX8qC3VVD66OBQ>
    <xmx:7-d4aatLQgAZSSfR_XVw44DfHBG_5SNRGw2cyS74R5GhfDpiRNOTYjzm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 11:29:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Simon Cheng <cyqsimon@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Remote tracking option hint for git-switch still shows
 git-checkout command
In-Reply-To: <CA+itcS0iyqNyzOP0cueLg7B3yadoEr_VWJ-QoL+YPFUPJiE2RQ@mail.gmail.com>
	(Simon Cheng's message of "Tue, 27 Jan 2026 17:31:06 +0800")
References: <CA+itcS0iyqNyzOP0cueLg7B3yadoEr_VWJ-QoL+YPFUPJiE2RQ@mail.gmail.com>
Date: Tue, 27 Jan 2026 08:29:33 -0800
Message-ID: <xmqqecnbggsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Simon Cheng <cyqsimon@gmail.com> writes:

> When `git-switch my-branch` is unable to guess a unique remote
> tracking branch, the shown hint still displays an example with the
> `git-checkout` command.
>
> ❯ git switch my-branch
> hint: If you meant to check out a remote tracking branch on, e.g. 'origin',
> hint: you can do so by fully qualifying the name with the --track option:
> hint:
> hint:     git checkout --track origin/<name>
> hint:
> hint: If you'd like to always have checkouts of an ambiguous <name> prefer
> hint: one remote, e.g. the 'origin' remote, consider setting
> hint: checkout.defaultRemote=origin in your config.
> fatal: 'my-branch' matched multiple (2) remote tracking branches
>
> Of course that works too, but it keeps the user guessing whether the
> `--track` option also exists for `git-switch`. Not to mention that
> `git-checkout` is now largely superseded by `git-switch` and
> `git-restore` and is no longer recommended, as far as I understand it.
>
> So I think it makes sense to either:
> 1. make the recommended command match the one ran by the user, or
> 2. always recommend `git-switch` as opposed to `git-checkout`

Here is what I did while waiting for -rc2 to pass my local tests,
which is unfinished, but it would be a good start.  What missing are

(1) get rid of the usagestr[] parameter from checkout_main(), move
    the usage strings for these three commands into the function
    scope of checkout_main(), and choose among them based on the
    value of which_command parameter;

(2) tests.

We are not deprecating checkout in any way, so #1 is far more
preferrable than #2.


 builtin/checkout.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git c/builtin/checkout.c w/builtin/checkout.c
index 0ba4f03f2e..4d0e70ea15 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -1293,9 +1293,17 @@ static void setup_new_branch_info_and_source_tree(
 	}
 }
 
+
+enum checkout_switch {
+	CHECKOUT_CHECKOUT = 1,
+	CHECKOUT_SWITCH = 2,
+	CHECKOUT_RESTORE = 3,
+};
+
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
-				 int could_be_checkout_paths)
+				 int could_be_checkout_paths,
+				 enum checkout_switch which_command)
 {
 	int num_matches = 0;
 	char *remote = unique_tracking_name(arg, rev, &num_matches);
@@ -1308,14 +1316,30 @@ static char *parse_remote_branch(const char *arg,
 
 	if (!remote && num_matches > 1) {
 	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
+		    const char *cmdname;
+
+		    switch (which_command) {
+		    case CHECKOUT_CHECKOUT:
+			    cmdname = "checkout";
+			    break;
+		    case CHECKOUT_SWITCH:
+			    cmdname = "switch";
+			    break;
+		    default:
+			    BUG("command <%d> should not reach parse_remote_branch",
+				which_command);
+			    break;
+		    }
+
 		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
 			     "you can do so by fully qualifying the name with the --track option:\n"
 			     "\n"
-			     "    git checkout --track origin/<name>\n"
+			     "    git %s --track origin/<name>\n"
 			     "\n"
 			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
 			     "one remote, e.g. the 'origin' remote, consider setting\n"
-			     "checkout.defaultRemote=origin in your config."));
+			     "checkout.defaultRemote=origin in your config."),
+			   cmdname);
 	    }
 
 	    die(_("'%s' matched multiple (%d) remote tracking branches"),
@@ -1327,6 +1351,7 @@ static char *parse_remote_branch(const char *arg,
 
 static int parse_branchname_arg(int argc, const char **argv,
 				int dwim_new_local_branch_ok,
+				enum checkout_switch which_command,
 				struct branch_info *new_branch_info,
 				struct checkout_opts *opts,
 				struct object_id *rev)
@@ -1436,7 +1461,8 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 		if (recover_with_dwim) {
 			remote = parse_remote_branch(arg, rev,
-						     could_be_checkout_paths);
+						     could_be_checkout_paths,
+						     which_command);
 			if (remote) {
 				*new_branch = arg;
 				arg = remote;
@@ -1767,6 +1793,7 @@ static char cb_option = 'b';
 
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
+			 enum checkout_switch which_command,
 			 const char * const usagestr[])
 {
 	int parseopt_flags = 0;
@@ -1893,7 +1920,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
-		int n = parse_branchname_arg(argc, argv, dwim_ok,
+		int n = parse_branchname_arg(argc, argv, dwim_ok, which_command,
 					     &new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
@@ -2032,6 +2059,7 @@ int cmd_checkout(int argc,
 	options = add_checkout_path_options(&opts, options);
 
 	return checkout_main(argc, argv, prefix, &opts, options,
+			     CHECKOUT_CHECKOUT,
 			     checkout_usage);
 }
 
@@ -2071,6 +2099,7 @@ int cmd_switch(int argc,
 	cb_option = 'c';
 
 	return checkout_main(argc, argv, prefix, &opts, options,
+			     CHECKOUT_SWITCH,
 			     switch_branch_usage);
 }
 
@@ -2107,5 +2136,6 @@ int cmd_restore(int argc,
 	options = add_checkout_path_options(&opts, options);
 
 	return checkout_main(argc, argv, prefix, &opts, options,
+			     CHECKOUT_RESTORE,
 			     restore_usage);
 }
