Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892C15697A
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725666138; cv=none; b=E7pbr8EATt2bTigoBo8MYDXKO3EgJOZGePFJxoXjGfppiLxuj21jiy54R3S4IQme6R59rJxQKtaxeuEnFS4vRwOhexnhUO2+IpBjuoPy/kYmsh7+PdNWuzWeXOOxEPpFnDcASZOEHaQTgS2BDz9OOjqQnkOiClr4DyWhUe2tDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725666138; c=relaxed/simple;
	bh=I+Y5ZiyX8feh8+vWsXbosIKgXf6O9CYuF1uFN7Ou/AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn3EshN7M2KHHd93ZTRHe0XSwyJmULiP0mI0sG6DOmbxb0jpndhyU+o9IAz1fU7lRl1G10XozqdW7ADR5AdMux6rNo2yqGVz2Mes97hXtU9bWTt7c+yV7VFRHb4X2mRy+XUWsa3F9sF6ELC9h0p8YlHIf8UjAJOJ3LxG8VFtgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1smi0A-002lLy-2y;
	Fri, 06 Sep 2024 23:04:32 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1smi03-003H57-2I;
	Sat, 07 Sep 2024 08:04:19 +0900
Date: Sat, 7 Sep 2024 08:04:19 +0900
From: Mike Hommey <mh@glandium.org>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	Josh Steadmon <steadmon@google.com>, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com,
	gitster@pobox.com, sandals@crustytoothpaste.net, Jason@zx2c4.com,
	dsimic@manjaro.org
Subject: Re: [PATCH v3 2/6] libgit-sys: introduce Rust wrapper for libgit.a
Message-ID: <20240906230419.r4hej7qsmx7yasl7@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-2-calvinwan@google.com>
 <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>

On Fri, Sep 06, 2024 at 06:39:17PM -0400, Eric Sunshine wrote:
> > diff --git a/contrib/libgit-rs/libgit-sys/build.rs b/contrib/libgit-rs/libgit-sys/build.rs
> > @@ -0,0 +1,31 @@
> > +pub fn main() -> std::io::Result<()> {
> > +    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
> > +    let git_root = crate_root.join("../../..");
> > +    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
> > +
> > +    let make_output = std::process::Command::new("make")
> 
> Providing a mechanism for people to override this hardcoded spelling
> of "make" could be another item for your NEEDSWORK list; in
> particular, I'm thinking about platforms on which GNU "make" is
> installed as "gmake".

And/or, use the `make_cmd` crate.

Mike
