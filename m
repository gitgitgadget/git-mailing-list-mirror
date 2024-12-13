Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC31C07D1
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086441; cv=none; b=I6ZVtSV0WlgRDl+PLLuy+eGOAqc8QHKVEeHSCnj9ELOoKqWMbQ1NPVDtPiIDJ1/QYcFvOpmYRSB0Q9q2oB4yVSSzofzR75o2BhAsMpIsQNfHARk3+vHJJBU4BVQL7Kc/WAUGH0znikMkzRj+CAegHYP8NX6VxgYYa4/fJSwiY2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086441; c=relaxed/simple;
	bh=L/kCu7sAp12BmRDwT4l44REZ2GVt5vO2KWciYBlr0OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR3CFhICOZCFQZ4wJ/KhsZBOVd18uu3X9GSgFXxiLGzFlPADjhD0U+jMDgLFYvQO4ekGXdSsrKcz4ru8cuuqOoqjX94p4u5J70v2COgnJLrYoEANcCsbqSi3P9kgj3c+cj7nVDAZ2/SpPeugCRkjJGdmM+AESIY0E75MbIWsxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gdObBYeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E/xqXr+H; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gdObBYeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E/xqXr+H"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8ABEA25400E8;
	Fri, 13 Dec 2024 05:40:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 05:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734086438; x=1734172838; bh=eafR3V+Ppv
	pYmybf1Ns6VQIdhnjRRwSLRLCEdhtOOP8=; b=gdObBYeVbsmypQClJBSoYAdP2y
	heInqz1oQ3sB3fRZfpyctWeLlxLnqOSnTycK3WDl4bwKxCAnhT+97aznrBUg7cIA
	qhpnRidFTYK4HoyM28tvbHV34RnxUA0aGBcWnFN9mb2433mSd+Y2OKKl7XDAj4N8
	+CvAreiPiBJ0GcSzVnw9w5+Dr4i02e/AHQOOuaK2vE2ddWAJCpNU1PvgCTXUdaOZ
	mz8FYw2Tn3ODhDPkVsz2sgjItn6C7DWRMR4oOVKRNPn8OsX+TcXvHJS0tX/n0Oyr
	Sam0LTaTG6+44ovGBSNFQq9pcRczc9mKoSH3E3BYnfJaentDkGprHbCnZuPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734086438; x=1734172838; bh=eafR3V+PpvpYmybf1Ns6VQIdhnjRRwSLRLC
	EdhtOOP8=; b=E/xqXr+H4+LhXQpvUJwO3FD0OPzi2I5g2YBdaZkLOrQlZn07Y+7
	EctiAXnU4/NX91pkxZmp18fUzojQ4bNefeUOLyuml2GAQVDgfAQiRSuzaET5bt1S
	5MMbG2yvMICPz6k9UQMPih/FoRwdS0SAN79PP2Ebdr385TvSYdnezWxyAW/t+4u+
	kfzSl5x7YwxeTkggfQkvuexb22PH164DMI+P0fxXERvIfZ6OyHyegJ0gKW28eTSR
	Rdbonb9N7C6O46dUlgPQ7VWaktrdfdz4Gqvw7hpAm69vZ7twig5wqSrWIfQXqODC
	43CRs9NsoQJLkXzNGjOwhQ2VzELsGxvhoOg==
X-ME-Sender: <xms:Jg9cZwISS6yQs2gF7kxE2saHLFQvBA4ISiSuRhrePzKhYxkl-RGvlQ>
    <xme:Jg9cZwKT8mvzEtb1x5yyGLcOt0hZ-K5UyQQazDdbcUAekCaMXvwupS_Yao2iT6TRC
    2zN_ZRDxwDDWOPbzA>
X-ME-Received: <xmr:Jg9cZwu8lB8YQzH4ssmeBE6w5iHX9MPJJgpGp163Fu24G3Fa5ra6a5v-NYqNsmgr1itmKe_CoVuJhOi79X2wFt1AQ3F9UOL5jBXU6rTTv0AlDOo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpefhkefggeelfeevhefgteduleekgfeviefgveeltddtgeeu
    veehteffteevteffjeenucffohhmrghinhepthhoohhnrdhlohgtrghlnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomh
X-ME-Proxy: <xmx:Jg9cZ9ZeTTytCi3MLOujg4McZT352aJckgvl3_OPGbmzskJ7CGeR4w>
    <xmx:Jg9cZ3ZpsW0vHPdSaXqrVTPciXOnFJmhgD8TnKMkWnPpPlh9jWVRNg>
    <xmx:Jg9cZ5CH-CbSElfrzM5eRImE1_xHE4hLqs-foXEgLosnDSnv2ADKsw>
    <xmx:Jg9cZ9ap-iyWPnUwSLKtqtJGDYhAWW8aDQDjgUaBweZtCeQmqQZqjA>
    <xmx:Jg9cZ2nvN5m8MlohzckNnWG69LhrNNMJNs9gdUfkh17ciuoxSAjNvCHH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:40:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ffc34483 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:38:51 +0000 (UTC)
Date: Fri, 13 Dec 2024 11:40:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] t: fix out-of-tree tests for some git-p4 tests
Message-ID: <Z1wPD7xSHRs1ID_g@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-6-28d18b494374@pks.im>
 <87a5czj420.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5czj420.fsf@iotcl.com>

On Fri, Dec 13, 2024 at 11:00:23AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t9835-git-p4-metadata-encoding-python2.sh b/t/t9835-git-p4-metadata-encoding-python2.sh
> > index 036bf79c6674f6f1f0d667c7270674168428ffee..02f9ec09053890a4d41b7dc95644066d6481bbb6 100755
> > --- a/t/t9835-git-p4-metadata-encoding-python2.sh
> > +++ b/t/t9835-git-p4-metadata-encoding-python2.sh
> > @@ -14,23 +14,25 @@ python_target_version='2'
> >  ## SECTION REPEATED IN t9836 ##
> 
> To be honest, I don't understand why this section wasn't put in a
> function in lib-git-p4.sh in the first place, instead of duplicating?
> Anyhow, I think for two test files it's fine to duplicate this code, and
> after all you're not changing that.
> 
> But I've noticed you are no longer using `python_target_version`. I
> would suggest to either remove the variable, or use it again so the code
> between the two test files is identical again. Doing the latter would
> probably mean you also need to create a variable like
> `p4_python=p4-python$python_target_version` and use `$p4_python` instead
> of `p4-python2` throughout the script, so I'm not sure that improves
> things.

Good catch. I did it in the Python 3 test, but forgot to do it here, as
well.

> >  ###############################
> >  
> > -# Please note: this test calls "git-p4.py" rather than "git-p4", because the
> > -# latter references a specific path so we can't easily force it to run under
> > -# the python version we need to.
> > -
> > -python_major_version=$(python -V 2>&1 | cut -c  8)
> > -python_target_binary=$(which python$python_target_version)
> > -if ! test "$python_major_version" = "$python_target_version" && test "$python_target_binary"
> > +# These tests are specific to Python 2. Write a custom script that executes
> > +# git-p4 directly with the Python 2 interpreter to ensure that we use that
> > +# version even if Git was compiled with Python 3.
> > +python_target_binary=$(which python2)
> > +if test -n "$python_target_binary"
> >  then
> >  	mkdir temp_python
> > -	PATH="$(pwd)/temp_python:$PATH" && export PATH
> > -	ln -s $python_target_binary temp_python/python
> > +	PATH="$(pwd)/temp_python:$PATH"
> > +	export PATH
> > +
> > +	write_script temp_python/git-p4-python2 <<-EOF
> > +	exec "$python_target_binary" "$(git --exec-path)/git-p4" "\$@"
> > +	EOF
> >  fi
> >  
> > -python_major_version=$(python -V 2>&1 | cut -c  8)
> > -if ! test "$python_major_version" = "$python_target_version"
> > +git p4-python2 >err
> > +if ! grep 'valid commands' err
> 
> I like this sanity check, this verifies if the command actually works:
> 
> Thus the output when the script is properly created:
> 
>     usage: /home/toon/devel/git/git-p4 <command> [options]
> 
>     valid commands: branches, clone, sync, submit, unshelve, commit, rebase
> 
>     Try /home/toon/devel/git/git-p4 <command> --help for command specific help.
> 
> 
> And when the script was not written:
> 
>     git: 'p4-python2' is not a git command. See 'git --help'.
> 
> 
> I noticed though, the stderr output isn's shallowed into /dev/null,
> resulting the output for the test to be the following if Python 2 is not found:
> 
>     make[2]: Entering directory '/home/toon/devel/git/t'
>     *** t9835-git-p4-metadata-encoding-python2.sh ***
>     which: no python2 in (/home/toon/devel/git/bin-wrappers:/home/toon/.local/bin:[snip])
>     git: 'p4-python2' is not a git command. See 'git --help'.
>     not ok 1 - start p4d
> 
> 
> I think that's totally fine though, it's giving the user proper
> information about what is wrong.

Yeah, I actually consider it a win to have it. Not that anybody ever
executes these tests outside of CI anyway.

Patrick
