Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4921F5EA
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776628565; cv=none; b=CgcqOpYs3PMaT08kvQj26SbfeCUIqXYcfjQDlviZU/Lb+JAHvMQpx6ASflk4Jz57injTlsELgnSK/AtwQhev9fynNOS7aubDRs5a1j154pH6vFae9WCKm7H++meBTq/hMrfWOpvJRBXHLtKgUC8L3+JF0mPswg8mjcSQD4ErFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776628565; c=relaxed/simple;
	bh=YfcpaAqQqdGmPjiadAaOUsc+ZsmnrtjjhJFCozCoZkk=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=Ib8S38pM6HU3UdoUSmTHMQErwDkC/DICrAMgJp4F07OGZOLJg/fF1q78ACyJwr/SYVUJz3sF0Vm1cqzYlLe+XTVyMA+pBY9t7yP8C2sg8PT6iddmytz3u2RibgcF+T+0W9eL/KDa3/zFGKCGQ5YU7mLb8KbcfKQWNxh3nbI0eHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=j6UIhAl6; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="j6UIhAl6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=l.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=pekDg/GIdcbPkXFAq4Vxk0Ic83D4/qM+i0Dq+lPbSXU=; b=j6UIhAl63iwB
	GQEZOHnDSjwcOgn5OQi+ZqXWNCYp+OgF6BBqGQ31tPsWxGrIisLu/hI3HgfYj47H+PXzcJTBOTTsw
	vb9byHuoDxV4Sy/3SLU+fQ4vITJEBqVLRakx6ZC+A93eOSpAFApQg/ovxkNUeX8QlKlGI2Dp7TFx8
	kSTDPtQ9HyO86TZssJxNi4XdQELYONBLs8OjsgDz4UzJ18aIE1NTFxMWzp2lh64gMPkcGEEnAMCpz
	6g/w8viqJu4rWE9ZnQiHvx7UCi9A0bWNQ7IHDarRhAZ1KeZGKrv75C5Ti6V2FDF7MJiEezSB9Cjm2
	MNORicApWvZiLIoPVywYeg==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wEYFF-0000hx-EZ; Sun, 19 Apr 2026 20:55:53 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27109.13129.424068.382997@chiark.greenend.org.uk>
Date: Sun, 19 Apr 2026 20:55:53 +0100
To: Colin Stagner <ask+git@howdoi.land>
Cc: git@vger.kernel.org,
    Christian Heusel <christian@heusel.eu>,
    george@mail.dietrich.pub,
    Christian Hesse <list@eworm.de>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<27104.58166.993109.63505@chiark.greenend.org.uk>
	<a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/bf/bf13173403c20b2583cf5a7d188c878d.pem

Colin Stagner writes ("Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split"):
> That said, a native Rust version of 
> git-subtree-split would be much faster and easier to read.

I prototyped something along the lines of the algorithm I described
earlier.  It is very fast, as expected.

The output looks plausible when I look at it by eye, but there are
some things that I need to look at more closely.  I should think some
more about invariants and tests.

Overall, I think this is worth pursuing.


Algorithm

I don't think it is going to be possible to precisely reproduce the
output of the existing git-subtree split.  Indeed the existing
git-subtree split is a bit cavalier with metadata (eg `committer` [1])
which probably ought to be changed in any case.

Even so, it should be possible to avoid foolishly rewriting the whole
history of the subtree, since we can stop at all the merges made by
"git-subtree merge", which are easily detectable by the extra metadata
keyword fields in the commit message.


Packaging

Before I go much further, how do we think this would best be packaged?
Currently my experiment is a standalone Rust package using
dependencies ("crates" as Rust calls thme) from current Debian stable
("trixie"). [2]  I haven't tried it with recent deps from upstream
crates.io.  There is not currently any entanglement with git.git; the
repository is accessed using libgit2 via Rust's git2 wrapper (and there
are no tests yet).

I'm tempted to continue this way and rewrite the other git-subtree
subcommands too, since they don't look that hard.  Using git.git
offers some packaging and testing continuity but the dependency
situation might become annoying.

It will probably be possible to make a Rust package which will build
with both recent upstream dependencies, and (say) Debian stable.
Going back much more than that is going to be awkward.

I see there's already some Rust in git.git:contrib/libgit-rs but that
looks like a poc.

Regards,
Ian.

[1] I don't think it's justifiable to convert a commit from the
downstream, into the subtree split version, and retain the original
committer line.  That can violate many people's expectations.
Here's an example from another context:
  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1124226

That means we need to use a dummy committer in split commits, and put
the original committer into the message.  We should name the original
downstream commit in the commit message too.

The dummy committer needs to be a fixed string: changing it would
cause history proliferation (maybe even leading to unnecessary merge
conflicts).

[2] I wrote a blog post

   How to use Rust on Debian (and Ubuntu, etc.)
   https://diziet.dreamwidth.org/18122.html

which explains why this is a good approach.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
