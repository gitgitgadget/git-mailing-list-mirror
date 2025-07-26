Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966E285CAC
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753538012; cv=none; b=iygk2JyfI7lwYGoUjbjeJe8vQDrrvTFajCDrG7meCcCkhpk2eL0dHDHikXI5cu56JTUCsEg4pHQL2rK1d8nMZH/54r2TzFXollyNw4Nj9dLKCsqxBaxZWvMEZu6uUd1RT9cYgSfGUzFI6EdnTdkNTAfE2FKPF2vk+kyV/u81s8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753538012; c=relaxed/simple;
	bh=4ajj3vJytPVDAFKK39Yc3WlWeK5ZZiI7qxsnaQFzXIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osmYu9A/TD4n7eezMHc6y7uIviEcReQd1o7Hz2rFsBDsmWB0B/Lsrxi/GgCokPm7t3ooQ4bvTGR1CcdnwSZBgDAqOrqI1oUl4FP6n3lfTxnp1550dOwpr/Wjl/kGSc+RFD0MiCJT9YGMe6fGcFVoaQFFdjd+4/ef4EQGuamGG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QSvQLwau; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJTBGNXm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QSvQLwau";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJTBGNXm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BA704EC00D1;
	Sat, 26 Jul 2025 09:53:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 26 Jul 2025 09:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753538009; x=1753624409; bh=QUtcRjOw0S
	5+Ukg1soLLYYtJMWPWJdxxDd1+ZZaK4EE=; b=QSvQLwaumgD4Oh+sIYP4L+R3F4
	btg+OUaxCIe7kG0Bft+vg3OYDVg0Dhgdh0+H4FpSzFPeXfk0OS6A9h6J0sxDygc8
	Fi4kQD3LEHnbiFtuPRDoXhiOykJqLUHj6bJoy6sMmM6XMvnWTKeh8xkK+ts5ED6L
	wASXolsYcKZCEz8FdIt6hGhWqJ4D1bdtKjRbUNd6Oo5FFSZhwC0nAYouahwtRaG2
	Cqq+RaNUij8D7ky0fOrcXojXA3/wm2HkebzfdRDuVcASrFqbkY9pwMJ302ZFfnhl
	nJQ1xYBuna1FVDoEYJp/PLzzjWRqQ86cm89HVSGZ26MD7JnVQtYDBKBm2BdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753538009; x=1753624409; bh=QUtcRjOw0S5+Ukg1soLLYYtJMWPWJdxxDd1
	+ZZaK4EE=; b=jJTBGNXm2bWO9fE+q2amg401mTXwkLu1OEhBgjV1o5KG0Azspim
	cXOoCzYzC3e4NeX3w34/BjnVE3jVKWVgyCbu406vMMDPRs2apxLc0K3xZoJu19tO
	W4II/9Z4taipjDvMTG1l2QhB7R1k9dkAJOD7tjcc5gFlSe+iT1MNFo45ZybecaYc
	V/HQGd9LBeSTldpxx9aP0e8ZINJtHuLmFNNKBHVbfpJuf9I5mp6coIXgjdB3RK+p
	tomnyd4CnPt9BKKYG1XqeAsdOl2ucmcMvL886FQtaTHSrG81c5cvia1LB9JUgvCk
	yFPS1fGKTepBMiZs8HPMNg3MSPLz8673Z6w==
X-ME-Sender: <xms:2d2EaJLgi33O4rcaJVlWAZOzzop2rr9A4pg9qFkBYsNlZtG7KwTU_w>
    <xme:2d2EaMBFSy1nN2UfN9MURINWkLi1lYuqIYl1QPFeufL-lr15NTkkUav-aODzd-HBm
    HwoBubwlRQMBPjQPw>
X-ME-Received: <xmr:2d2EaOqzSMEzQkUAQxQoLetbKQXNxn9kaY1t_EO4HxREfNYFZ3IsiDjFS03xZTBMYx8cRchJsnsLRH7myDO_1kGyVoAzLQy41jH0JuP82ONH96jcCGoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekieehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidr
    tghomheqnecuggftrfgrthhtvghrnhepgfevfeeviefhheehhfegtefhvdffheefheeule
    ehieffuedvvdeuhfevffeigfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtohepfe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2d2EaHjgI9OCJbJMfDMPbqzWyUT9zypsKAmrvj4_N2P5ojYHKXEm-g>
    <xmx:2d2EaLAjwYOSkwG32JLj6yTfifqbUzNpqZWkvjeRg-KFOQLkvD8Mcg>
    <xmx:2d2EaMFfdpNRDS9rTnR1-X_dQSi8xzSEu7GcixfuXDnHRj5xTkB7sg>
    <xmx:2d2EaDI5eqDQ_TWodKOpa3qaI_3ldWEw2qxMQMVBQL5w6I9uQSGfnA>
    <xmx:2d2EaLAdLRvij40sG8KN9LyBFXU0Zhz7WMfmI1bs3eT_QzHCcAbYMkuY>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Jul 2025 09:53:29 -0400 (EDT)
Date: Sat, 26 Jul 2025 09:53:27 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, git@vger.kernel.org
Subject: Re: [BUG?] git-daemon 2.49.0 in F40 no longer exports user
 directories
Message-ID: <aITd13mTx8t1dQbO@teonanacatl.net>
References: <aIOslkzu-x8K9o_C@shell.armlinux.org.uk>
 <20250726075136.GA3032762@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726075136.GA3032762@coredump.intra.peff.net>

Jeff King wrote:
> On Fri, Jul 25, 2025 at 05:11:02PM +0100, Russell King (Oracle) wrote:
> 
>> While I've been away on holiday over the last three weeks, my co-admin
>> updated ZenIV to Fedora 40, and now I find that git-daemon no longer

While this isn't relevant to the issue, it seems worth
noting that Fedora 40 went EOL a couple of months ago, so it
no longer receives any security updates.  That's not ideal
if this system is not entirely internal. :)

>> exports my "public_git" directory. My attempts at debugging this have
>> failed - I tried adding strace to the git@.service but I get nothing.
>> This is a regression.
> 
> I'm not aware of anything changing here recently, and ~user expansion
> does seem to work for me. E.g. using v2.49.0 and running:
> 
>   git daemon --base-path=/tmp/foo --export-all --user-path=public_git \
> 	--verbose --log-destination=stderr
> 
> and then running:
> 
>   mkdir ~peff/public_git
>   git init --bare ~peff/public_git/repo.git
>   git -C ~peff/public_git/repo.git --work-tree=. commit --allow-empty -m foo
> 
>   git ls-remote git://localhost/~peff/repo.git
> 
> works. I get a similar log message to you here:

I was curious, so I took Peff's recipe and gave it a try. 

    sudo dnf -y install git-daemon
    sudo systemctl enable --now git.socket
    mkdir ~/public_git
    git init --bare ~/public_git/repo.git
    git -C ~/public_git/repo.git --work-tree=. commit --allow-empty -m foo
    sudo git config --system --add safe.directory ~/public_git/\*
    git ls-remote git://localhost/~test/repo.git

And that fails as it does for Russell.  I suspected SELinux,
which is enabled by default on Fedora.  With luck, you have
not already ruled that out.

Two things were needed with respect to SELinux and one other
for basic permissions.

First, ensure the permissions on the home directory allow
access by others, as git-daemon will be running as nobody.
By default ~/ isn't searchable by others.  (This isn't
likely the trouble in your case, but only because you'd
probably changed it well before the OS upgrade.)

    # ensure ~ is searchable; git-daemon runs as nobody
    chmod -c o=x ~

The permissions on ~/public_git and the subdirectories were
already okay, but if you set a strict umask, it might be
worth ensuring they're okay (also unlikely for you as this
worked before an upgrade).

Then ensure the SELinux context type is correct.  It should
be git_user_content_t.  You can add -n to the restorecon
call to see what it would change.

    # The -F isn't strictly required, I just like setting
    # the user, role, range portion as well as the type.
    restorecon -FRv ~/public_git/

This is close, but still not enough as SELinux doesn't allow
git-daemon to search user home directories by default.
There is a boolean to enable that so you don't have to
create any custom policy.  But for reference, audit2allow
tells you just that:

    $ sudo ausearch -ts recent -m AVC | audit2allow
    [... needless blank lines elided ...]
    #============= git_system_t ==============

    #!!!! This avc can be allowed using the boolean 'git_system_enable_homedirs'
    allow git_system_t user_home_dir_t:dir search;

Enable the boolean:

    sudo setsebool -P git_system_enable_homedirs=1

And `git ls-remote git://localhost/~test/repo.git` now
returns successfully.  It's empty in this case, but I cloned
a repo with content into ~/public_git and confirmed it
worked as expected.

With luck, it's SELinux biting you (or, less likely) a
permission on ~ or ~/public_git and this will help.

It does seem like the git-daemon package in Fedora could use
a README-SELinux.md which explains this stuff, like the cgit
package.  That might have helped you or others in getting
started.

-- 
Todd
