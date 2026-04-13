Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11421CFEF
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119525; cv=none; b=fKheXAFuv8Jic69tuhUvRd5sGETvOwl37WwcAvuCnTt9/EZOnf3kp7t/GtBozYN0R6rI0J5Cag0BGtYLeUqXjBtmHZVehYUo+neYS2rm3HmMjNkj/eOzfSBBnu2lkVAcDZWwAWWPeLRbW3p1675mDjTHkB45CmGeG8loLW2ZkHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119525; c=relaxed/simple;
	bh=d6h4phNKMv2xHXmNGY09zhsgrcnus5lMmyJMEenjxZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZjIqLCEIOEgmlRzqQiretGgyoVB3jUA0eIaawrZfzLQbjqIeqQANnjEW9viopEuq9S4Q3OJyWd8DKfYd1ZBmoZGtXu9FEvFATlkxyzjyvg7ojxpu/623SbqRyDCZMt7QBjNy1QB8I3nPCyTCnnZtFjiTgQ75BuYFOOQzP5aos18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MSeA41Mq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ejJEYEnU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MSeA41Mq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ejJEYEnU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C54FAEC005A;
	Mon, 13 Apr 2026 18:32:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 18:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776119523; x=1776205923; bh=1E+yNa1TIm
	nR45zmnGyiscl+/UNdqSB9oRpfE4mtJaI=; b=MSeA41MqxG//glY7r1Nb3B2iSh
	wzMTlMRYTJCqZF5nhHTcLcqEUqLKXCev+NPiNjSYcm7+qXNxJOCRk/giC1+R1GXS
	zH8frBSQelpnOmC54DcBiLN5PzNqMHo9i32WwSsfiu2OE0THdo351NzCBhOApkwr
	29A6hatjk/kuwddgtoT/K5jTJt1UZjh6YoLMJYF1PRtaHnXginlhd78hO5oVK6dL
	BWJoekU4z1qyldMlAKo5KnY/DJeg2CFsB8uoTKFHa2jTjgEJ8c+OHePaihdplyuX
	tA1wt6auABk2cNqAGct6ZIOQKehwjRzu0k1DGM3vQkosuwjcgTGv12JGQA8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776119523; x=1776205923; bh=1E+yNa1TImnR45zmnGyiscl+/UNdqSB9oRp
	fE4mtJaI=; b=ejJEYEnUoepD0/cz6m+GRKUJERTIRB7VXy4IkUwIjpP2lNi0X2w
	RFjLgIyc6SNFFsgcbrGBBEBpR6lkyeUi9Fp9L2XUOR/DXqx4bn4eQDWUXAdNqxBG
	YpOm3vzmUpdaJlsyeROvwWvNX0AntEx7SqsX357mOnuMaRXCj9OZ1QB4J1X/RrML
	E9V9SyxOsYQJvlrly3U5+C7HHun/a2CXEiOxYJ1y6L4fxxAZEm3jjBZMMCCuDfxI
	6lnPc/UKSr8MhXdrzXnAXVLGz4SiUKmfvudXntSdWY7rM/dg9Wxr3qAL+TBPILRR
	eR/LQuqisRJSeB09LU7VsMzUr+pE/OBXelg==
X-ME-Sender: <xms:427daS6xFxrc4WflnaOWYYF2pWgGgPXcfxqAuVKMSgM1IyutWTk3lg>
    <xme:427daTW8f1GNOrp23JYLj2T8yQU13vTgCLtWGOy_JRE0WDt-6rslOLsK82njb-jxn
    fN3SYfgNOaZTNW35Ws3U4uB2IW3Dmg2G0lOTv5agsETewGVJyz4-w>
X-ME-Received: <xmr:427dae3I1CGty843JlMfS2nzRvhNAXeBzhYQ9JS6bAIsXjxHPYhhCsBEhpXTkZv9UPVEoDY9bH9RWZ4hvfbV3HAUMt8wHBQ-bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:427daY3-ZD1oWzGfmF8GXYtnme4X8zjmcj1ieRrYYNqcKNE0l1T74g>
    <xmx:427daZ-LEDsQOO-y72bOZb9jHxb7gHBrOOGNKbsDyHHGfRKSvTuETQ>
    <xmx:427dad3NoabXogpEkzEX4HnDcxoQ8GLuIsn08trS7NwF-gYpjyKOZg>
    <xmx:427dae8-aC0Ks6rzVtAEbfdKuzQaf4UIX4uAjh8Sj3_XziYvXnefWA>
    <xmx:427dabdoXr87yZJg5dJRamiN8XCMvtT05slu-Y4N5iP-dRNynJTonp4k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 18:32:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:27 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 15:32:02 -0700
Message-ID: <xmqqeckifq59.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 2fde2353fd..07d86ea244 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -15,8 +15,7 @@ GIT_SVN_DIR=$GIT_DIR/svn/refs/remotes/git-svn
>  SVN_TREE=$GIT_SVN_DIR/svn-tree
>  test_set_port SVNSERVE_PORT
>  
> -svn >/dev/null 2>&1
> -if test $? -ne 1
> +if ! svn help >/dev/null 2>&1
>  then
>  	skip_all='skipping git svn tests, svn not found'
>  	test_done

I think I know what is lacking in this patch.  Following the above
section (which is a good conversion), there is this bit that needs a
similar handling.

 t/lib-git-svn.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/t/lib-git-svn.sh w/t/lib-git-svn.sh
index 2fde2353fd..24c15d17eb 100644
--- c/t/lib-git-svn.sh
+++ w/t/lib-git-svn.sh
@@ -27,13 +27,13 @@ export svnrepo
 svnconf=$PWD/svnconf
 export svnconf
 
+x=0
 perl -w -e "
 use SVN::Core;
 use SVN::Repos;
 \$SVN::Core::VERSION gt '1.1.0' or exit(42);
 system(qw/svnadmin create --fs-type fsfs/, \$ENV{svnrepo}) == 0 or exit(41);
-" >&3 2>&4
-x=$?
+" >&3 2>&4 || x=$?
 if test $x -ne 0
 then
 	if test $x -eq 42; then
