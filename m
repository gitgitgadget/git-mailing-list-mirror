Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1294EDC
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 00:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722819202; cv=none; b=GJuIaBOfaBAi0ty+b5PIB0YCsNB+0uCHUxoZLko/QIwz6TD9afUfBLYsxqErfyiaXQfdYUoSdXTL1JHDG+bfVb4H6fjTer1u8yI6ketCpugpFEB4jye15+DjhPzs1j9ls87mkh05fKF0WfwZPJdSfF/2c/bJdQ4O2mfr5kMHdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722819202; c=relaxed/simple;
	bh=umcF7ZG6sk3eHbEfaD2i4Bj0alupvQQC8nZppML9I6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ1iuYdyzEJSPZGhHYKavIjI5S12qgWn5V0W3XPqhlP8y1nQMd8+SI6/QXww2rfY29ghBwBP9Kshf1sDN7Veu+m3HbcEOMSeTi4beBalcAvAwSJ+nTSUf+ls2MPUgj145E05937MyPc9d1LwJE9GxCtbXDob9P2twUMsTXCxHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22952 invoked by uid 109); 5 Aug 2024 00:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Aug 2024 00:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6265 invoked by uid 111); 5 Aug 2024 00:53:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Aug 2024 20:53:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 4 Aug 2024 20:53:11 -0400
From: Jeff King <peff@peff.net>
To: Kim Scarborough <kim@scarborough.kim>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Git and gettext
Message-ID: <20240805005311.GA66003@coredump.intra.peff.net>
References: <bf5a7771-f616-47d9-a014-f9d3e0afaa08@scarborough.kim>
 <Zq5UFYnWL1jdgDaH@tapette.crustytoothpaste.net>
 <7d507ea2-08e1-4597-bff8-8a2b40a01747@scarborough.kim>
 <Zq5qNwmTpL1H5LH0@tapette.crustytoothpaste.net>
 <1d6e0fef-9b9a-4239-aced-d20cd5c3434c@scarborough.kim>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d6e0fef-9b9a-4239-aced-d20cd5c3434c@scarborough.kim>

On Sun, Aug 04, 2024 at 04:26:19PM -0500, Kim Scarborough wrote:

> > Note that `config.mak` is not read by git-gui, so you do really have
> > to set `NO_MSGFMT=1` on the command line.
> > 
> > Can you show exactly the commands you're running and exactly the output
> > you're getting?  Also, what OS and version are you running this on?
> 
> Not working for me. I ran "make NO_GETTEXT=1 NO_MSGFMT=1" and it dies
> thusly:
> 
>     BUILTIN git-version
>     BUILTIN git-whatchanged
>     SUBDIR git-gui
> GITGUI_VERSION = 0.21.0.128.g2864e
>     * new locations or Tcl/Tk interpreter
>     MSGFMT    po/bg.msg     MSGFMT    po/de.msg     MSGFMT    po/el.msg
> MSGFMT    po/fr.msg make[1]: *** [Makefile:239: po/bg.msg] Error 127
> make[1]: *** Waiting for unfinished jobs....
> make[1]: *** [Makefile:239: po/de.msg] Error 127
> make[1]: *** [Makefile:239: po/el.msg] Error 127
>     MSGFMT    po/hu.msg make[1]: *** [Makefile:239: po/fr.msg] Error 127
>     MSGFMT    po/it.msg make[1]: *** [Makefile:239: po/hu.msg] Error 127
>     MSGFMT    po/ja.msg make[1]: *** [Makefile:239: po/it.msg] Error 127
>     MSGFMT    po/nb.msg make[1]: *** [Makefile:239: po/ja.msg] Error 127
> make[1]: *** [Makefile:239: po/nb.msg] Error 127
> make: *** [Makefile:2365: all] Error 2

If we don't have msgfmt, I think git-gui invokes a custom script via
tclsh. If you also don't have that, it will fail. Running with "make
V=1" makes this more obvious, since it shows the fallback command name
instead of "MSGFMT".

If you don't need git-gui at all, the simplest thing is to just run
"make NO_GETTEXT=1 NO_TCLTK=1". That's what I do, and I have neither
msgfmt nor gettext on my system.

If you do need git-gui, you'll probably need to make sure your tcl
install works (and has tclsh in the path).

-Peff
