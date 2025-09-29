Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976818A93F
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 23:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759190269; cv=none; b=JpwjE46mGr/cCJc3PwqHLZnNUv8SogSTiRzrKajyuozumi+jfnSyJxfKQSnuQesafQFRVkwOXo4UMZl3gStObrzFUlvEdXvGL/L/ur89Egbv+Gq9zX1vYFlzoglMO/Gqp/FUZas6lMOc17GWITTQY9/JWxYvvJ4ooesaL5XirGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759190269; c=relaxed/simple;
	bh=2TK9/xxcIentux5MDsVOnbJfGIil/Yr5oFdoV1GoHsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDEm2RMM7nzFaZHBJACc4/JMCEXVSqijZ6BZgNZZmHmXICf5/vGCqOyscZ/kFi9853zOoFEHeLQCdArZ1Py5lEIrX3PTp0WZm3Ozes/clJ7VxhZ4Lr/QkOqWukH3dRYEzvmLpgUTB9NPHTy6g8C6RKzh3Tc689aQwq5FOGWpsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gN14avqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G3px6E6e; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gN14avqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G3px6E6e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B270EC001E;
	Mon, 29 Sep 2025 19:57:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Sep 2025 19:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759190266;
	 x=1759276666; bh=KEsRLe5kHeUPJV60lfwZHv1GNDCYiV5SggVzepQESy0=; b=
	gN14avqoxuobgmo5h6UxEhRsaZOmY12VBYN/boHUVFs17ed6ZwQ+Nikz1r1M1z4/
	fqTyOpDRyCmCZ9ud4ushOu662KAtIyduzcbhnY7bRDlaKhjE4J4dEAEtQqj/eeUb
	HwUbrblvUuZfCPXt3XsdQ7ombhjLZZs9WD/pBCwX++Jxe8CjgDSA3CZDaJWPG7Ou
	VSfpYTbARGOeb/kU3isIrqNolzFrWOd963ntuvOaEW9vgco9uYCfPKCRfazkEhPM
	BYCU790vA35K8s+4PBaseaxv9jfqQfCTzFCpoIVPBSaXPD/dLHxuv4jUGPkoBcEb
	JEXjnxAHUdFjC9rcb5GMzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759190266; x=
	1759276666; bh=KEsRLe5kHeUPJV60lfwZHv1GNDCYiV5SggVzepQESy0=; b=G
	3px6E6eshyohqk7tCf/vMe5avEYbMvtbRZ+RJW8/gq/lQh5Rk4vDtF6blcjhzvzi
	ONZ1DyAi8TPGUpB6ui/XCdefOWhs1I3OwAW2YNpJlPSHZW8qgNam2/dygENyeagW
	Mbdy7UvDUqAfSvgmQcGxFwWCKS0t4niBdmKD7YHRm01Q/uYATkefkI0RTJjIX0TV
	TpcEUhkGyfR5AT1iy0zX51gzsfRomnfAqu+uan4vHP3WkeJoRhUjf6fhnoA4N1lg
	jYuMUD82KFM1VxXRpc91A/Wg8Hvd9RNHYWVLO7znup5kQZ1A3bg0gM4BPQJ0Dv/B
	LayXrEfeccPz6IUyl4KbQ==
X-ME-Sender: <xms:-RzbaDAYVPzXEDFRpmWIYefRsSuFeQyqBT-oM7hsZDh9bjegNETzSg>
    <xme:-RzbaPgLXcIr3yinvvj8WuOv66HF66Nv3eFX8SGd27-vivfex9S08ZjZ0Bf3VW4sK
    Fow2Ce9pNO7RGdlJSeBqxRAvuazOz5T8bispC2SP8VTP8WkEgArNw>
X-ME-Received: <xmr:-RzbaMPeR6czAi9ULaBPO93GxIOOj8tVNbbYWD16SgkgFel5u1Q4tuic8ufKltJe3PTt-uVJjAUJuGdi_qeAD9bqXhq1NjTYZbCTpEFjLUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhmlhhkohesnhhothdqvghvihhlrdguvg
X-ME-Proxy: <xmx:-RzbaA5UW2nxYIlPTyzVL29xD76rr_1dPS7cxncxqYE5fYbxZn9T4A>
    <xmx:-RzbaK3bFXTMv-qFIpOQyq4WobSiW_ojJzzKDHacEr1YvYfLe90UPA>
    <xmx:-RzbaBbivzdNIpQGNj3nlzBURK7msQpveTorIuYM09vAmSTL6_CuQQ>
    <xmx:-RzbaCC6r31dE-mSNrEblmGvJF4cRjt-jz0c-oxVAaufzumLySp08Q>
    <xmx:-hzbaFNNgTnHCkYEdi2nTBDdZY5RBcSKnOHZgFPoR6xhWpRJs5IVfzml>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 19:57:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 97ea6efb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 29 Sep 2025 23:57:42 +0000 (UTC)
Date: Tue, 30 Sep 2025 01:57:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael <gitmlko@not-evil.de>
Cc: git@vger.kernel.org
Subject: Re: git reflog write does not pick up user.name and user.email from
 config
Message-ID: <aNsc9En-DjxVOLcV@pks.im>
References: <519E887F-2028-476E-B26D-85E23F7974A5@not-evil.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <519E887F-2028-476E-B26D-85E23F7974A5@not-evil.de>

Hi Michael,

On Mon, Sep 29, 2025 at 01:11:56PM +0200, Michael wrote:
> Hi there!
> 
> I've been playing around with a toy project (an interactive step by step
> git tutorial that is just a repo) where I have been creating a reflog
> manually so far. I was happy to see the new `reflog write` feature and
> wanted to integrate it.
> 
> When comparing the results of my hand made reflog with the new
> `git reflog write` result I found some differences: It does not seem to
> pick up the "user.name" and "user.email" from the local git config.
> 
> Example:
> 
> ```bash
> git init example && cd example
> git config --local user.name "C O Mitter"
> git config --local user.email "committer@example.com"
> 
> message="hi"
> oid="0000000000000000000000000000000000000000"
> 
> # Setting env vars works as expected
> GIT_COMMITTER_NAME="$(git config --get user.name)" \
>   GIT_COMMITTER_EMAIL="$(git config --get user.email)" \
>   git reflog write "refs/test_vars" "$oid" "$oid" "$message"
> 
> # Picking up the information from the local config does not work
> unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
> git reflog write "refs/test_no_vars" "$oid" "$oid" "$message"
> 
> # Since setting the env variables to the config value, no diff expected
> # but:
> diff .git/logs/refs/test_*
> # 1c1
> # < 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 Michael <michael@mycomp.local> 1759142076 +0200	hi
> # ---
> # > 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 C O Mitter <committer@example.com> 1759142076 +0200	hi
> ```
> 
> Intuitively I would expect these values to be picked up from the local
> config instead of having to specify them in env variables. I didn't
> expect it to fall back to some system values, instead of git config. Is
> there a reason that this information is not used from the config? And if
> yes, could you set some config, so that it gets picked up?

Thanks for this great bug report!

You're definitely onto something. The problem indeed is that we don't
parse any of the configuration right now, but I agree a 100% that we
really should.

The reason why I never noticed this issue is that our test suite by
default sets both GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL. If set,
we'll end up writing those into the reflog as expected. So it's a bit of
a test gap we have.

> Unfortunately my ability to understand C is too limited to grasp how
> `git_committer_info` works…

You't typically call it with `repo_config()`. So if you want to work on
this, the below should work. Only thing that's missing would be a test
to verify that the gitconfig is parsed now as well as a proper commit
message to tie it all together.

Thanks!

Patrick

diff --git a/builtin/reflog.c b/builtin/reflog.c
index c8f6b93d60..40884787b9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -422,6 +422,8 @@ static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
 	if (argc != 4)
 		usage_with_options(reflog_write_usage, options);
 
+	repo_config(repo, git_ident_config, NULL);
+
 	ref = argv[0];
 	if (!is_root_ref(ref) && check_refname_format(ref, 0))
 		die(_("invalid reference name: %s"), ref);
