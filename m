Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD472639
	for <git@vger.kernel.org>; Sun, 27 Jul 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753607700; cv=none; b=pRSt+6K18R5eshKm6cYfv5C3kvQf/4EBqrmZcYLjVbObYUY5Bu3uSPVhTiXdf9dhRdy1Rvfa6QwtwaiU3ugOaRDdvICQDeB4GfsXNrJrIaUFV1YT+2QOzEC1xbxnP5YUy/JyYZxeq0AuoUnQy/ErZyWDSL+aqG+X0WurAEb6VTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753607700; c=relaxed/simple;
	bh=6LjmZRC5frmujOuvc5oWIS0Qp6bHvgkk462muZfO83Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQHs7n4uelVmePbgj0laoFi9FKEzRPEl/ltpYhEqS4w1B4QEHdFXHVo/owQDFtPaDK8KUwzCnmEXMYsRfj60qtgDhOk35HoTx18UpwUGrDujIr5EWIfHanx3uJQ/Wgrdv5JEpU2Skc6s3oazWcYENYMGLjT9nbunkfZWKDEpkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t7lXfhVz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t7lXfhVz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=13scGdvzmtsGezZSrR5pLvPVdY6k3J8wjsuIHovoenY=; b=t7lXfhVz6O0MEjhZnmt/ZSlZJ5
	hbrcZ2n3NGp+I74FuE/Od/OsNNPeEp5AAIAQwFy/zUAgmOtmSqEIInfmuHsUAXr/6nH4gwXxdLCg1
	MVPAZXJ5Uwg303gB8vEWjeCapXLHVunZFR3tnuJdXJHOIekrdsWGoB7QRER42Ij9sBf47EN7nuIlH
	+J3ix3lQX7F/G/d9Hc7haRrJ6ADfadfy7HIUKrCwCxsl47Kt8JH4SlRmmIVgBRiUxv7By7AgYXXxA
	UiQI23m04uHe4+OJuz42J/P15xTJrPdFruOs6PV8+XSpsRoJQgf0j3+ar3fH2Nj77Ct5dPcEVDKYK
	VZVirJjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43152)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ufxT2-00077p-2P;
	Sun, 27 Jul 2025 10:14:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ufxT0-0003dz-1a;
	Sun, 27 Jul 2025 10:14:50 +0100
Date: Sun, 27 Jul 2025 10:14:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jeff King <peff@peff.net>
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [BUG?] git-daemon 2.49.0 in F40 no longer exports user
 directories
Message-ID: <aIXuCv7hRyJq-Twm@shell.armlinux.org.uk>
References: <aIOslkzu-x8K9o_C@shell.armlinux.org.uk>
 <20250726075136.GA3032762@coredump.intra.peff.net>
 <aITd13mTx8t1dQbO@teonanacatl.net>
 <20250727064542.GA3091411@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727064542.GA3091411@coredump.intra.peff.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jul 27, 2025 at 02:45:42AM -0400, Jeff King wrote:
> On Sat, Jul 26, 2025 at 09:53:27AM -0400, Todd Zullinger wrote:
> 
> > I was curious, so I took Peff's recipe and gave it a try. 
> > 
> >     sudo dnf -y install git-daemon
> >     sudo systemctl enable --now git.socket
> >     mkdir ~/public_git
> >     git init --bare ~/public_git/repo.git
> >     git -C ~/public_git/repo.git --work-tree=. commit --allow-empty -m foo
> >     sudo git config --system --add safe.directory ~/public_git/\*
> >     git ls-remote git://localhost/~test/repo.git
> > 
> > And that fails as it does for Russell.  I suspected SELinux,
> > which is enabled by default on Fedora.  With luck, you have
> > not already ruled that out.
> 
> Interesting. That would explain why I didn't see the problem on my
> Debian system.
> 
> I am still puzzled why Russell would see the message he does, though.
> From my read of the code, seeing "not in directory list" but not seeing
> "...does not appear to be a git repository" implies that enter_repo()
> succeeds, but ok_paths is non-empty and forbids it.

Yes, I had an override in systemd that I'd forgotten about to work
around a previous issue (because the previous version we had on the
machine required the paths on the end of the git-daemon command line.)

I wonder if there was a bug - --export-all broke, and then required the
directories to be listed, and now it's been "fixed" and now the listed
directories become a list of those to exclude?

The override.conf had something like:

ExecStart=-/usr/libexec/git-core/git-daemon --export-all \
  --user-path=public_git --inetd --log-destination=stderr --verbose \
    --interpolated-path='/var/lib/git/%%H%%D' \
    /var/lib/git/git.armlinux.org.uk \
    /home/rmk/public_git

I can't remember exactly now as I've deleted the last two paths, and
added --base-path=/var/lib/git - and now it's working.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
