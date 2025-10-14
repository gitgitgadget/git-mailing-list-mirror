Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FED2367CE
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465958; cv=none; b=fCBRMuXYNjjeciyc/NdUWUMXngrNcc4JfBY00d8VjQ1Vj9eoPFHT9HJ3NcC8vK9FG7TK+gP2FQU2hQirVV2WIHbe9yPOBeihu8Gqe+Ql09HbC69lexrV+yB4iaGqiNcUNXBdITTZ3C7uJzfCO+mBeHPVU8mJqtNwr8ApuKSYbgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465958; c=relaxed/simple;
	bh=RIV5XfjGj0J6xgM4w+zYW0NvRM6djzGpP61y06vSREg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLgOYcC3umPf3saZ3sgA4Au4ZawPYNkVxOybQNupIY2oxN4mKjj4aKxYLc2bwy3qbWLbcm/5LOmv5msgAJsbd/bbFxC9tXvLJdowIeyr+ISrOB0kBzPuYxg6cGuEY9SeFRwD+9xWSBd37+0L558xxd0kRAsRFcqPHiwWcrygAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zk9/pQ33; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BZlzhS+a; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zk9/pQ33";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BZlzhS+a"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 02CE71D001A7;
	Tue, 14 Oct 2025 14:19:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 14 Oct 2025 14:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760465954; x=1760552354; bh=WXGPqtTmx5
	i9XzqUIBdoPmElwEdrm+MoCa+rrn+wuOQ=; b=Zk9/pQ33VVlrFsJhl9iA/fBihK
	xDipUkvei674YBK0bnJY874vrE9ilybrRp/FrwOP6BrPEG8gj6/CHoWPVBUSR246
	ylTwLBm3lB4hAtUmllw6FDgayLQMeWT62eb1LQ/dgVPCeTA6IOH9qGDjc+pEUWhy
	nwv09KGJm5hz9NPznHfjkqJIBaAq+SqN/z9fzY3YkQoMZIjXTxXUHuCkvVCcTXtB
	i5di3oAG4jWpBrVW4HimuqL1ELgfuyHmFPuq8f8lvL8vs5x+o7opPjEdXrXz2BOD
	UtZneWf3Lh8VcwTJTmDq5URQrfmJRECtaoeQcXeQvH8Fh9hgmlXFHavu354A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760465954; x=1760552354; bh=WXGPqtTmx5i9XzqUIBdoPmElwEdrm+MoCa+
	rrn+wuOQ=; b=BZlzhS+aJCXGPTg5h0gceW0ydyQqRHETc5VWNBbGTpQ2Xdsfg5i
	8lMUyLVJT9oBzqKcZ5THm5HNBmNCtjdxw0Zq/oJWmRfTQndh7iTN/4gMyhrnjy8b
	G699/Mh2W4mXTDACiH59SVrub7QWoeNMeJhayhY4hlHp99P1MoYBlYzL9ZtWBohi
	GsIPImMXrSnC/V9O/nIyaDOjfpJJcDspabdyn0fZuVkOKYRWhP4bet0XxeS7keFe
	VLqDx3w4Ap1IZCiQJ4p04Fm36Qi47sJzE3gcJDTyJsJF6MlxLKtBFzci4EfAnbGa
	bNO+3Ry38qEy8Dhm8OMMLmwP5ov3ljexdcg==
X-ME-Sender: <xms:IpTuaD9Eg79NGX6QTLQaDiYo0-o8tKZa7J3JDECrc42hJofOMAXEdQ>
    <xme:IpTuaHKgGrhUMxW2km3WYu3ILfmxmmoMJCqT6uI0kBy28cLn8u8tNDuLH4X-caubY
    PSDBQ6XeMB6Xig1lygt8ERejg1h0OgNgpmWltEqczWnWCLQCmkiWQ>
X-ME-Received: <xmr:IpTuaObEEkm8ELTIJsD6gwiZdWAe1wBJVDa2lOgbqg8gAdSWy9ELCfsaaKLju9MbBAlF4p6_kmvZs6_Zh9_LiEo1PMcVM2MnURhj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsohhlohgs
    rghrihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IpTuaJL9ttpQ1pYTDeK7eR_aktUUVuK4AoPcY998314jk9oiswwrpA>
    <xmx:IpTuaMCetFBy3AAS9dol6h3f1BeeO3m3NQNqWB9EqnHVTmFn5WHgOA>
    <xmx:IpTuaOqYGYfpQ2CAyzXSjTb5bZSmzo4Rt6HkAVkzKeGmY1YKoXNmbg>
    <xmx:IpTuaHhh09ZEecyG4LehpqEQ9KQVKJFTeI3aYOnd7WcIIXZ77ttuQw>
    <xmx:IpTuaDKN-C374ii4sUPv2aA955nPrvBm25-4YGZs72PXbzbi8O1JmgN2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 14:19:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Solly <solobarine@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] t: update path checks using test_path helpers
In-Reply-To: <20251014161446.6135-1-solobarine@gmail.com> (Solly's message of
	"Tue, 14 Oct 2025 17:14:46 +0100")
References: <20251014161446.6135-1-solobarine@gmail.com>
Date: Tue, 14 Oct 2025 11:19:13 -0700
Message-ID: <xmqqa51txs66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Solly <solobarine@gmail.com> writes:

> Subject: Re: [PATCH 1/1] t: update path checks using test_path helpers

Using "t2401:" instead of "t:" would give you a bit more
information.

> Update old-style shell path checks to use the modern test
> helpers 'test_path_is_file' and 'test_path_is_dir' for improved
> readability.

This gives a wrong justification.

For readability, "test -f tested-file" is plenty readable.  The
point of using test_path_is_file and its friends is to get better
runtime diagnosis.

Read the helper you are using and understand what it does and why it
does it (they are found in t/test-lib-functions.sh):

        # debugging-friendly alternatives to "test [-f|-d|-e]"
        # The commands test the existence or non-existence of $1
        test_path_is_file () {
                test "$#" -ne 1 && BUG "1 param"
                if ! test -f "$1"
                then
                        echo "File $1 doesn't exist"
                        false
                fi
        }

And imagine you wrote your test using this, perhaps like this:

        test_expect_success 'ensure hello.c exists' '
		test_path_is_file hello.c
        '

What happens when (1) hello.c does exist and (2) hello.c does not
exist?  If hello.c exists, "if ! test -f" fails, and the control
does not go inside of "then" part, hence the helper will succeed
silently.  If hello.c does not exist, it will say "File hello.c
doesn't exist".  The person who is running the test will be told why
the test failed (and the helper fails because it runs the 'false'
after giving the message).  And that is the value these helpers
offer.

Armed with that knowledge, you can tell that ...

>  	test_cmp expect actual &&
> -	! test -f .git/worktrees/abc &&
> -	! test -d .git/worktrees
> +	! test_path_is_file .git/worktrees/abc &&
> +	! test_path_is_dir .git/worktrees

... this is a bad rewrite, right?  The original wants to ensure that
a file .git/worktrees/abc does not exist.  You want the test to
be silent when the path is not a file (i.e. "as expected, nothing
interesting to see here"), and complain loudly when it *is* a file.

And your "! test_path_is_file .git/worktrees/abc" would not do that,
would it?  They report loudly in a wrong case!

In this case, both of them should probably become

	test_path_is_missing .git/worktrees/abc &&
	test_path_is_missing .git/worktrees

because the _intent_ of the test is NOT that it would be happy as
long as .git/worktrees/abc is not a file.  Even though the original
uses "! test -f", seeing a .git/worktrees/abc directory there is an
unexpected outcome of the test (you need to read what is being
tested to fully understand this kind of thing).

Hope this helps.
