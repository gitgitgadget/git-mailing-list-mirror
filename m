Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032F2C87C
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716061536; cv=none; b=cl46ErE0XOZMkfrI3LEeL+TpoPEbi4TXGSu0Jk+AaZppHVLdjA1IiNl03M8SsY4q3aC650DYmeiuZWuH/HpMgJh7YKHwUU0JQh+x8Do80Sp0ATsg8xF0M9ou1RKVWirkgGnHxduuApVx8BVRVTKILyME5IjrSLiINauNJZkFnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716061536; c=relaxed/simple;
	bh=s/cx4WhNiW+WRHCWjJG1m7qIo7xjBJvngVgwiVTVhUM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bnIVJr3A9Z0SSBJnGSReV/tAT8WeB6VrMCO7QS2SrSSRaCgdI7q4dTjTHDX5ZaAzfSv32JPoJDXAd7BtikQg07RMj7dbZutqk3D2ShEM9dHZJK0SNeEst+Zw2sdVUnLzjq+yGnaFbwuf93pTi/W53Y4kATbFsWbmW8YOXZ6iKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=MJ1qpbeb; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="MJ1qpbeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716061524; x=1716666324;
	i=johannes.schindelin@gmx.de;
	bh=tArmucQ2mETlj10SCysb71mDqzHhOMnyuGTY8t/+aLc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MJ1qpbeb5YaSsks6pUQ3l0n1dvCm7f482kXOq4eO45aH5tQ9Ge7kt21S7g5giMxh
	 SAdTET+QIfs2jfT3KwqQNG1OftbHzqOhj4nqmlTK5HyjO/IG0J/Oy495t8Estk0ep
	 EDuTNrpyLWmSvorFJYM9lrx/plJ20OBkQGAjPaiBylLAarkiH7Wu8b90cJFccOS5X
	 ck1pOakfFSG+wVUqA1VzE9IRyZvq3i1t6crA3NaCWYWSGYMoUmaGkKOPl2BVOFW1M
	 Xt//ALWvJpdUp68N1TQDxiLDAwD3UEmv6fwKBmlbw7rJ/MN/ahfZYJe9PnKLtfEgu
	 tNjVRueJhe0HKTZfDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1sU64g2gww-00zG5y; Sat, 18
 May 2024 21:45:24 +0200
Date: Sat, 18 May 2024 21:45:23 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Marcel Telka <marcel@telka.sk>, git@vger.kernel.org, 
    Victoria Dye <vdye@github.com>, 
    Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH] scalar: make enlistment delete to work on all POSIX
 platforms
In-Reply-To: <xmqqbk54go51.fsf@gitster.g>
Message-ID: <fb20ebe4-e643-211e-29c8-2cbfb4b49abf@gmx.de>
References: <Zkds81OB7C5bTCl_@telcontar> <xmqqbk54go51.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Qz3ctOxW+KHZ4tqOqmixB4f8sQC7pcgwbZaikcnVyH3W6ahO6XV
 Xb2fY92qILF9q5e4eIy6GHxDrHWJ5TRYKDIJXgMRA6Al08NC/cm13jrbVvz+nnHTmXUDOTv
 JTPn7HKqMBG8vlsnQhzRtV1OYUcp0OBwHsKh7kzpurwNj+VfbCtgVOA0FKUX10k/GOwrGYI
 guVXbgcBC3qf/b4fys6vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MZ1FlB5JiqU=;yj3oV4YYTWD5PN98PhMIRF0FYMO
 MHViAx97XkYLXjM+IGUOZxQ6Dnj5e0Xc+psB6yrSRfwwXVau1/JGgCdx8Rv7oD3LyJs9y7V8i
 We3AyzMZENNoRPy2BVNcdy9O//FUrVAHZZNigSu/6VMNreV2meuJesVf+gJ/yjRbJkZnhteH/
 bsO7e5oacUmeEdiJkkhnAg5s1moppyjGHcTbAYr6wnngikWi/Bk5FSk8wi4cbXzvxcyGap67X
 p7b8FADGSqk4wEkeJw21oPQCJ8c9Nn2tAn8mZs0On1DWLoitMa1iec1sh/9abpEQEvvSLOXJZ
 nMBv2jvdr1UrgmHXVlFkR5In3e/MvBaZKrG1c4tzWblY5wNahksSWiXcla6aa5aSMLps5SMYZ
 9l+Hj2kKjr3DhkdT4jzLRJqQH4UGbz28yEyVEZPuG1Ft9Je6O6wTKZz7rKA/ZeI/ihYFwB41g
 krMXmU3f/qeR78bhiK861EX2lm45+0qNVlwK86h1BuTiq2BTy45sTYVp1uPuRM2b80fiZYkIH
 1y+Fw8LWwUZkPMrAI6deph6cgYUIpm37sgOy7PoJ0ECX5uWD+8tAgJrtttJCZNakKxm6/dXln
 BQngtw+1REq9rBM9STQLEGxg0IYjzPTsYYHDLHPW7BDdXH5CFqnG1LIH4k4zVN/WDbWRlhplu
 MWo7kGfdbLzLTYc0Nn9BwH/0RCjQ3RfhzigGH1W+zUVFGb4XPy2mHw2K3LyIN7fVXHVhVTcrn
 3s8LRbJGzpDrbE2H0w7ldYwOk3qMbqR/5dRjDgtlYTBTcyv7Vmv2f93vcjiK894ocgO0VRFiT
 nvJVQLXF6P3NBFr2eNzXkj650bt/dyNkzICKmBjVpvRhE=
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 17 May 2024, Junio C Hamano wrote:

> Marcel Telka <marcel@telka.sk> writes:
>
> > The ability to remove the current working directory is not guaranteed =
by
> > POSIX so it is better to go out of the directory we want to delete on
> > all platforms unconditionally.
> >
> > Signed-off-by: Marcel Telka <marcel@telka.sk>
> > ---
> >  scalar.c | 4 ----
> >  1 file changed, 4 deletions(-)
>
> Let's CC a few folks that had their hands in the delete_enlistment()
> function over the years for their opinions on this change.
>
> > diff --git a/scalar.c b/scalar.c
> > index 7234049a1b..331b91dbdb 100644
> > --- a/scalar.c
> > +++ b/scalar.c
> > @@ -361,16 +361,13 @@ static char *remote_default_branch(const char *u=
rl)
> >
> >  static int delete_enlistment(struct strbuf *enlistment)
> >  {
> > -#ifdef WIN32
> >  	struct strbuf parent =3D STRBUF_INIT;
> >  	size_t offset;
> >  	char *path_sep;
> > -#endif
> >
> >  	if (unregister_dir())
> >  		return error(_("failed to unregister repository"));
> >
> > -#ifdef WIN32
> >  	/*
> >  	 * Change the current directory to one outside of the enlistment so
> >  	 * that we may delete everything underneath it.
> > @@ -385,7 +382,6 @@ static int delete_enlistment(struct strbuf *enlist=
ment)
> >  		return res;
> >  	}
> >  	strbuf_release(&parent);
> > -#endif

Basically, this turns the previously Windows-only logic to `chdir("..")`
into the now-universal logic.

I like it!

Thank you,
Johannes

> >
> >  	if (have_fsmonitor_support() && stop_fsmonitor_daemon())
> >  		return error(_("failed to stop the FSMonitor daemon"));
>
