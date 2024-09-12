Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F951A42B2
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141985; cv=none; b=EfM540+lWxBvOmIjwfF4mKlwcjZ0r1+g+QPgjP+r6fzw4BvJ2bZiIzxyVakx/nsqG8DBo5aWkzCCrv/CreUkeqlnTAYeIMwiX/EMVaTv7ClRrIbnrBZBxVOtj2NOjvQlJYrWr94fFruJ/b9kPk7ZSCWw79lF4MyPszUjwAAhc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141985; c=relaxed/simple;
	bh=QBlIsVFCWCVOgetQWEXx0lo3YVWXhwaJ+XgVi8k2ryM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbY3R+JTLyc2GNa8i4nOj1teG7MTSkyNb62vomAx+FBgcXU6N0NGS9MMRk0hljUgPbjrGOh1kluHvRIhLucVblQUd9Ewh41XiKt7SF53DLd6+Gmd6a2ML1vIRLoLBx7+qV92ot+B8n5sjDf0pTOlUsyVSlx98qKsKAD+9jkFC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P0E9Y2yc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t+vQm2BW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P0E9Y2yc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t+vQm2BW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BF88E13800E8;
	Thu, 12 Sep 2024 07:53:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 12 Sep 2024 07:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726141982; x=1726228382; bh=TppjBRk2HV
	dme/czG5B0/2u7zuHL/SyOxccb45f1Hp0=; b=P0E9Y2yc8NwePcVSxiSc276C56
	aCgfG+TIADT49WyGAo+9WKXskXJdF+7Ef9XGHebW7lD2vtIK5PLfmKJFNcABfKK6
	TAVrnobg4uksvUT2KyxVhCvKnINs/3Y5ekJArEA54HSLqAnRjycuILf7Ek/sUWzr
	cYWmHbajh2lBuBZm50qUKsabBKXJJvg9vdgXoAe5I561+HMB5NAbAeO8JpEIg3AN
	3lQ4Su/GutzZ9oSfQMaVqxp51QvOPkbNRormep0ywq6jGM434uo39brqCgf+30Z4
	MgUPtaJ/ULIF9v6wIDBCkJw3adifxrnyVBHHQDIpsyCbQntRlUrI7ofSewgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726141982; x=1726228382; bh=TppjBRk2HVdme/czG5B0/2u7zuHL
	/SyOxccb45f1Hp0=; b=t+vQm2BWiDNnG1evQ2E7M1CEMORaEntkZfT4ptyP8dwl
	pD8QdV43UhCdFKRE3cx8vOECmqFZI39ddVcx7y3+R6mac+Q1AGMowAcjaJiNeKQP
	Ol/ZLREVFnQEzEb+GcRuIqmIGjBjmCKH0jT13k8B5i+1twhOREat/BOnxxsvuYv0
	YgMUnIPlHDnIe6TJchbptEhgLlrdcO8shNpkKi8qPob4KD2VTfEBUQA/OrWBfoFV
	KZReC3vvCOG5nRY+XbWETcvzf8DJHbDK3LAl8bIFNp3IBfA+xZerjkHloAQbnKlP
	OhMo6AldHn50yj6vUEohpKTXoDwqa6y70R2vXXx4WA==
X-ME-Sender: <xms:HtbiZkRv9Aaa0oILSDzFGoNipXRC29_T55A4LufWqGcwCSGrgrTbIA>
    <xme:HtbiZhyUsGRtrDsPlZEuCN5awQJh_bPlXlFXZkTN8Zuxfg0Ro5Zp58KwnAyEPZYIV
    QQTrHk7wmA4sQ1KIA>
X-ME-Received: <xmr:HtbiZh2QcE2DoqpinmvNypEwTOyOFe9GQPh0V2aEmaRlSnjsNyO3vDI0BQwyoIp2E2ljK0sOd0ggc-TgDrMqd5olQfDTAvx4tcsVUJpM0i3o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeekveffjeehte
    evtdffgfegvefhieehheetleelffduffejieeltefgvddvieefteenucffohhmrghinhep
    mhgrihhnmhgvthhhohgurhhunhhnvghrrdhruhhnpdhgihhtlhgrsgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HtbiZoDWBmCGUW7YDzCV8HR-Kf8xRVM_-dPdpmpONc2528XfMc74tw>
    <xmx:HtbiZtgY5AFJTqD737nfuyq-PYa0WEfenuydES0eRVyGkNQq--6-Kw>
    <xmx:HtbiZkpAd3RnptDEHZ_MokcBqACHwqLhLNCm1D_5OMzdqVCO1T7DBg>
    <xmx:HtbiZghtXp1la39O8guXrnHIGcq7mLMnVg4SYmn2vdZh93-NFNJcuQ>
    <xmx:HtbiZiulpzqWS5vxCjst6ycOtl9f7np1mJLmkhi2iDMH5h4Ce6jdIi7b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:53:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 48bb09b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:52:51 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:53:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci: use more recent linux32 image
Message-ID: <ZuLWHBvrT31KVd9W@pks.im>
References: <20240912094238.GA589050@coredump.intra.peff.net>
 <20240912094730.GC589828@coredump.intra.peff.net>
 <ZuLFPxsDiMB9UBhF@pks.im>
 <20240912112242.GA622312@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912112242.GA622312@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 07:22:42AM -0400, Jeff King wrote:
> On Thu, Sep 12, 2024 at 12:41:03PM +0200, Patrick Steinhardt wrote:
> 
> > On Thu, Sep 12, 2024 at 05:47:30AM -0400, Jeff King wrote:
> > > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > > index 97f9b06310..db8e8f75a4 100644
> > > --- a/.github/workflows/main.yml
> > > +++ b/.github/workflows/main.yml
> > > @@ -339,8 +339,8 @@ jobs:
> > >            image: alpine
> > >            distro: alpine-latest
> > >          - jobname: linux32
> > > -          image: daald/ubuntu32:xenial
> > > -          distro: ubuntu32-16.04
> > > +          image: i386/ubuntu:focal
> > > +          distro: ubuntu32-20.04
> > >          - jobname: pedantic
> > >            image: fedora
> > >            distro: fedora-latest
> > 
> > We could counteract the loss of testing against Ubuntu 16.04 by adding
> > it to GitLab CI instead:
> > 
> >     diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >     index 2589098eff7..80b1668ebeb 100644
> >     --- a/.gitlab-ci.yml
> >     +++ b/.gitlab-ci.yml
> >     @@ -25,6 +25,9 @@ test:linux:
> >            fi
> >        parallel:
> >          matrix:
> >     +      - jobname: linux-old
> >     +        image: ubuntu:16.04
> >     +        CC: gcc
> >            - jobname: linux-sha256
> >              image: ubuntu:latest
> >              CC: clang
> > 
> > I didn't test it, but it should work alright. GitLab doesn't put any
> > additional executables into the container, so it is entirely self
> > contained. Let me know in case you think this is a good idea and I'll
> > run a CI pipeline against this change.
> 
> That seems like a good thing to do to mitigate the loss. In a perfect
> world we'd have all platforms running all the tests, just because it
> helps align the work between finding and fixing (i.e., I might introduce
> a bug and not even know it is failing, and you have to spend time
> reporting it to me). But the world isn't perfect, so finding out about
> my bug _eventually_ is OK. :)

For reference, [here] is the merge request. The [first] pipeline failed
because Java is too old, as you also mention in one of the preceding
commits:

    JGit Version
    Exception in thread "main" java.lang.UnsupportedClassVersionError: org/eclipse/jgit/pgm/Main has been compiled by a more recent version of the Java Runtime (class file version 55.0), this version of the Java Runtime only recognizes class file versions up to 52.0
        at java.lang.ClassLoader.defineClass1(Native Method)
        at java.lang.ClassLoader.defineClass(ClassLoader.java:756)
        at java.security.SecureClassLoader.defineClass(SecureClassLoader.java:142)
        at java.net.URLClassLoader.defineClass(URLClassLoader.java:468)
        at java.net.URLClassLoader.access$100(URLClassLoader.java:74)
        at java.net.URLClassLoader$1.run(URLClassLoader.java:369)
        at java.net.URLClassLoader$1.run(URLClassLoader.java:363)
        at java.security.AccessController.doPrivileged(Native Method)
        at java.net.URLClassLoader.findClass(URLClassLoader.java:362)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:418)
        at org.springframework.boot.loader.LaunchedURLClassLoader.loadClass(LaunchedURLClassLoader.java:151)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
        at java.lang.Class.forName0(Native Method)
        at java.lang.Class.forName(Class.java:348)
        at org.springframework.boot.loader.MainMethodRunner.run(MainMethodRunner.java:46)
        at org.springframework.boot.loader.Launcher.launch(Launcher.java:108)
        at org.springframework.boot.loader.Launcher.launch(Launcher.java:58)
        at org.springframework.boot.loader.JarLauncher.main(JarLauncher.java:65)

I've thus added the following hunk:

    diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
    index 735ee6f4639..c85b1f55700 100755
    --- a/ci/install-dependencies.sh
    +++ b/ci/install-dependencies.sh
    @@ -55,6 +55,11 @@ ubuntu-*|ubuntu32-*)
                    ${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE

            case "$distro" in
    +       ubuntu-16.04)
    +               # Does not support JGit, but we also don't really care about
    +               # the others. We rather care whether Git still compiles and
    +               # runs fine overall.
    +               ;;
            ubuntu-*)
                    mkdir --parents "$CUSTOM_PATH"

And with that the [fixed] pipeline builds and executes our tests just
fine. I didn't wait for tests to finish though.

Patrick

[here]: https://gitlab.com/gitlab-org/git/-/merge_requests/210
[first]: https://gitlab.com/gitlab-org/git/-/jobs/7808775485
[fixed]: https://gitlab.com/gitlab-org/git/-/jobs/7808836999
