Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9392E36E3
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008757; cv=none; b=HICAe7gFgV08jSYmn61yAReADIPymrJRR8HhIK+17lY7pT+H32FkSF2SUArLZV/PAuLGoHymkrIBipn0DVs2cEzwHjzFtwV0wh5pSVLClzA1qe7gCMm8WsKch++zI5IoDh4ZOEApEgoJt5fTGlc2N3iRZkRA4TF04Q0p27P0XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008757; c=relaxed/simple;
	bh=emseh3z3SCcMoF8BTiKk6f9/igRzuQR2QXSxOs1a5qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7Ak+h26XJ8+tBt9JyHUUU8cqPqvREaPU3Y/JRfmGz16eTCEpePXgwzE4z/yTGZlzZpH7NnKc3/OUvivIEandr0k4NLYUc6nJQLpmYdUfo0V6Df3Wte7m4naPlVI6LGHpvMbM2YzqNVuKQLGQDulSVkkbkzji6tzoqMR8eIYgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qsxtkXmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KdrYoLEM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qsxtkXmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KdrYoLEM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B59041D0025F;
	Tue, 16 Sep 2025 03:45:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 16 Sep 2025 03:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758008754; x=1758095154; bh=QtRRhp3RvX
	YPtYgJh9QXhjMYVE/55Gf363nBPbZiSyE=; b=qsxtkXmPqoKkAPQVUc1+evhxry
	cGRCKwgVIacFj5pJruTtTakH3+XqYOaXv54jLhIDtw5q8eOghf1X7to1RDgHSKJl
	EkX8RMvekx5f0477sfqKLsOoZlMFE5d7KvfZXAwRDCRWFMiVQXspTCF96t/2Y7s3
	exUYQGDnVTw9M7Q2eONQtIkrm86DwKBc3RqVixCruuTwo/ZdX6WKsWGSPRZ0fXnJ
	vRnljxpFo7G8259QXSME7KcZQR1AVvVCApMiPDG5M7P/zHeV2L6vDRQShcvnYuVt
	8kvyPqX7ZxtmejsVE1WyoH/5M//1risOsqqefjdbwgfcmSX5uOWDoj7T8W6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758008754; x=1758095154; bh=QtRRhp3RvXYPtYgJh9QXhjMYVE/55Gf363n
	BPbZiSyE=; b=KdrYoLEMmOwEdwtK7d06B9qBPHA4nQBjOU1XDq6xOa+OJM/QBs9
	X2sHxU/ZLVrOjFKDqoNFeXsIdQxj+qZC725nFfHl+NWtXa/jfQmTgqokclyusooc
	KhqZLSPKDR3LnsPRY6RsYU7kR2nFrQ18GlIjUHysF2UrgNnPTVJQuds1Luk+xzwi
	pqKVKZFcxymCM6oFaLd7HdckNPGM1KyiOO0UekdRN2Rljo1gLhGjiAKMuGDCI+QU
	i4iZjSSkx/KhZEDf8YWTJ/yhoD9Op1Iu2deq5xcgIlnqJSoU3rtUp08A2YpveeGm
	YqvB/ovgMa74WH3TLHloJYB+k+M8qo1LKnA==
X-ME-Sender: <xms:shXJaJmcFz3wsdUaEef2fB3ddqX0YX6dkIOfr1w5ZDtgRaK1bVXTJw>
    <xme:shXJaIErSXkwiBldQNIFTmWtvWBDq-yBGLNGKbr-yVd4PeEZlvA3REKEtMHERPCkW
    2TAYLqJrjatvPKeeQ>
X-ME-Received: <xmr:shXJaJHv80Jif7AMAFscSR9Si0I1QA6_1WKYYNaT-ERUG-fAIEOvJszk5bLxbh5uCwirKSng14h7WgOZObW18XYRTKFjAhk4RgWwV962pSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrghtthhhvgifhhhughhhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:shXJaFPCJq2HzyQqOqsC7Jn0ul1EVLauvdNW4Ifrh7j7gUgVMw4fNQ>
    <xmx:shXJaIHQLLV67SHxXD5Nk4uUL9BwusLl7bqSd41va5tFGrYACKbL1g>
    <xmx:shXJaMO2J-r9dp-wg-pSL6OHZL9kv--kd3uQaS_qDja1gv-ZGDcu9g>
    <xmx:shXJaJ_DDloLRV54xWYy_WvyzARGPHcxuH8Vv-7ihe09Isae3JxfeA>
    <xmx:shXJaMB1JwKUdRQW2KX63aU4bMT_w9R6ua_gUbX25ACiOnx0YcFkdvuO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 03:45:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 38319196 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 16 Sep 2025 07:45:52 +0000 (UTC)
Date: Tue, 16 Sep 2025 09:45:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [QUESTION] how to find options set by scalar?
Message-ID: <aMkVqNbdgxqBJ9K4@pks.im>
References: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vppjutjcdglp44qvsk4qozphycyg663yrq5775zztim2oe7ty5@uttjrshb52bd>

On Tue, Sep 16, 2025 at 07:21:21AM +0100, Matthew Hughes wrote:
> Hi,
> 
> I'm wondering about making the config options set by `scalar register` a bit
> more discoverable.
> 
> Background: I was recently working in a large repo that recommended I run
> `scalar register` to help make git run a bit more smoothly, and I did (and
> didn't think much of it and forgot about it). It was a couple of weeks later I
> was again working in this repo and wanted to update my config, but was a bit
> confused when I saw a bunch of things set that I didn't remember setting, e.g.
> 'status.aheadBehind false'. It took me remembering that I had run `scalar
> register` and some poking around the code to discover where these options had
> come from.
> 
> I'm not sure if this is something best addressed by documentation, or maybe by
> `scalar register` adding comments to the config lines it changes?

I think documentation wouldn't help much -- the config entries we set
may change over time, so at the point in time where the user reads the
documentation it may already list entries that we either don't set at
all anymore or that we started setting now. So these config entries that
scalar(1) did set and the config entries that its man page claims to set
will diverge over time.

But doing this via comments may be viable indeed. A start for such a
change could be the following patch, which causes us to write a comment
"# set by scalar" after every config that we set in the repository:

diff --git a/scalar.c b/scalar.c
index 4a373c133d..c69ec57374 100644
--- a/scalar.c
+++ b/scalar.c
@@ -8,6 +8,7 @@
 #include "abspath.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "path.h"
 #include "config.h"
 #include "run-command.h"
 #include "simple-ipc.h"
@@ -102,8 +103,11 @@ static int set_scalar_config(const struct scalar_config *config, int reconfigure
 
 	if ((reconfigure && config->overwrite_on_reconfigure) ||
 	    repo_config_get_string(the_repository, config->key, &value)) {
+		char *file = repo_git_path(the_repository, "config");
 		trace2_data_string("scalar", the_repository, config->key, "created");
-		res = repo_config_set_gently(the_repository, config->key, config->value);
+		res = repo_config_set_multivar_in_file_gently(the_repository, file, config->key,
+							      config->value, NULL, " # set by scalar", 0);
+		free(file);
 	} else {
 		trace2_data_string("scalar", the_repository, config->key, "exists");
 		res = 0;

With that change in place, a (subset of) ".git/config" file would look
like this:

    [extensions]
        refstorage = reftable
    [core]
        repositoryformatversion = 1
        filemode = true
        bare = false
        logallrefupdates = true
        FSCache = true # set by scalar
        multiPackIndex = true # set by scalar
        preloadIndex = true # set by scalar
        untrackedCache = true # set by scalar
        autoCRLF = false # set by scalar
        safeCRLF = false # set by scalar
    [am]
        keepCR = true # set by scalar

Which I think is quite helpful overall. This cannot grow stale over time
and it's immediately obvious which entries have been set up by scalar in
case the user wants to drop them again.

Cc'ing Stolee, the primary author of scalar(1).

Patrick
