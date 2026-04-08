Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6C01F4180
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 00:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608743; cv=none; b=Dc/EWJ/XxELrH9bGrOMQdRZBHhzVIChfutLp5jg1dWcmeV3sIdRMF8VONABtkXv1LiU/YYzPg/33vL9TGhE8nVhUd+TladhmNul/AX9WuA5wLoDNtEmMswJi2QiFryrMKd4iSGCjTL7+bPu8YNdst4qWuh2/IJdPcNhE5lerm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608743; c=relaxed/simple;
	bh=+I+CIoOG4hCwzHS7xffXHCYiFfl5Tad3c+zm13gU7Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIRfXu2CH58oJByerUCKNiB+C8Coiw+2RfDR+XSRlFx0FfKdLulPxLu3DTzcN1Hv54C/LUp63aJsMcR6VMeZG8LS5Xf+vzzaO0yGnXUx20HP0tQP4mdDuOeqFqRLlUVIlm2AzMzkrLomAgQuIoR6PAF+NHHST+0QfwWMwjokD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6r2dl9x; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6r2dl9x"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso5915333f8f.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 17:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775608740; x=1776213540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2oLVw0nW7eWdFtuOFtj2iJ8Ubt2tAds4n/W1JIa8a4=;
        b=b6r2dl9xbGCiMorUCx2k/o/B4mcCzlTe6UssoF/crQjla26S4Xf20ebDQMZXm+Cmmy
         pXrV0vhPlh/VmENza2trwRVg036Dh6DZmo91dHEVWplelUQvFttvSTejdMlo1QxQ/4MG
         WROGS0VPPOfD+z3EmPBoQT3Aeq/WoeZFgMhYhOQyVDrNnceySnRMh25+AbUpM+v/LXRb
         BmYJ1BmZfKLaS6hw0/r6WbyM6GGZBDl3gEQvHVFUjReWItUaBpE6idE4IrvBxlkd+2UM
         S3tV4NAMo2u3Vdwr4W96UDdxmS70Gq/ZJrOtSmwjIRQLiYa09f29IieehYbe+smbMrWa
         iKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608740; x=1776213540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2oLVw0nW7eWdFtuOFtj2iJ8Ubt2tAds4n/W1JIa8a4=;
        b=gs/fyJWI7aKlMZKnjao9+2Hn42rkSaE765RdDQOy1ofODKeqMz76KeRd7nTYIuViTC
         VYkmvmABbGgGltUtae1NZA3sEVbx+51zW7IdhUhc3T/7pGBoKwkaV8TAmOsGd9G3j4L9
         S6OUJ/johjg/yY2231KYGaJVpcXAc8JcuTa4J0+nvBv2lhymKeaKavSv698BnB2S16Je
         fFDXZRxToifhUB3wrzJRoBtxMxSqYdxAKxCEn0Er1+ZW0VRdlSd6lCcsdrBlBoNanefw
         xYJy4iMofYkA13uYUwvxYfgycgQQsj7q/M6gBj+UGt/gMzaDJyfYzNoqbXCzuem1Hv3L
         /ghQ==
X-Gm-Message-State: AOJu0Yy45+UUenkmG/asGCAxj2p5Z/7QkjZ/QAGSoZmgmaeTyySPgxn0
	JESYEnxC20rQZ8CcmVTSEml723IpElBy4bvOBVK+5S9RlW8+UCBhO1io
X-Gm-Gg: AeBDiesaskCf63Z/MKtHIcM0omO4jYZXM63+Agukwt1M+kpJHViGeZbxdxvL5mqPAWH
	z5G+2/3TH+gbmR6T5MYoXtugcuToRPus9va5KF51/OL4c/OXqLt35ijeXDzHJfUxCV1P5Hz2v7+
	eolMttjMqBUhagfmyKWD6pRIymgQov1ypUpQjQjL78/fnrA4avE7DQhOjGpMYoWcV+HDlm53yzS
	/89tEyQhrsBT9P6VCBWcXHA/4cap4Uz9VD3M2TUHVX8X3JH/p8SlrJwk0M3uxk/e6Ms5tULXSEp
	7EVXAmzb3BtWHnA2/tUaq0P87aiXMqoWuaXh7cAkaMxHcmieOvpGw6rySsJTtsWH5zBW9CGDDKv
	oRtmvu5EijcoeJmP0Lh3NnhGRjovzve03ajdZViIDoQAGBcWcESA//IheYUxpiYRbXqdlR7LoML
	p7phLMYUiEQ49kOCp3aA8M/LBX6rO8hYsH
X-Received: by 2002:a05:6000:1446:b0:43b:3d02:7806 with SMTP id ffacd0b85a97d-43d292d4dbfmr28827065f8f.28.1775608740325;
        Tue, 07 Apr 2026 17:39:00 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d2738sm55340841f8f.24.2026.04.07.17.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:38:59 -0700 (PDT)
Date: Wed, 8 Apr 2026 02:38:56 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 4/5] t7700: test for promisor file content after
 repack
Message-ID: <adWjoIENaTDDHerq@lorenzo-VM>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <8e58c1263d15fb8dba8ce1d2866d369e938bf2b6.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <xmqqwlyi4p6t.fsf@gitster.g>
 <adWPLhGeo-4Mqfbh@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adWPLhGeo-4Mqfbh@lorenzo-VM>

On Wed, Apr 08, 2026 at 01:11:42AM +0200, Lorenzo Pegorari wrote:
> On Tue, Apr 07, 2026 at 11:10:02AM -0700, Junio C Hamano wrote:
> > LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> > 
> > > Add tests that checks if the content of ".promisor" files are correctly
> > > copied inside the ".promisor" files created by a repack.
> > >
> > > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > > ---
> > >  t/t7700-repack.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > >
> > > diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> > > index 63ef63fc50..89a2116641 100755
> > > --- a/t/t7700-repack.sh
> > > +++ b/t/t7700-repack.sh
> > > @@ -904,4 +904,67 @@ test_expect_success 'pending objects are repacked appropriately' '
> > >  	)
> > >  '
> > >  
> > > +test_expect_success 'check one .promisor file content after repack' '
> > > +	test_when_finished rm -rf prom_test &&
> > > +	git init prom_test &&
> > > +	path=prom_test/.git/objects/pack &&
> > > +
> > > +	(
> > > +		test_commit_bulk -C prom_test --start=1 1 &&
> > > +		
> > > +		# Simulate .promisor file by creating it manually
> > > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > > +		oid=$(git -C prom_test rev-parse HEAD) &&
> > > +		echo "$oid ref" >$prom &&
> > > +
> > > +		# Save the current .promisor content, repack, and check if correct
> > > +		prom_before_repack=$(cat $prom) &&
> > > +		git -C prom_test repack -a -d &&
> > > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > > +		# $prom should contain "$prom_before_repack <date>"
> > > +		test_grep "$prom_before_repack " $prom &&
> > > +
> > > +		# Save the current .promisor content, repack, and check if correct
> > > +		cat $prom >prom_before_repack &&
> > > +		git -C prom_test repack -a -d &&
> > > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > > +		# $prom should be exactly the same as prom_before_repack
> > > +		test_cmp prom_before_repack $prom
> > > +	)
> > > +'
> > > +
> > > +test_expect_success 'check multiple .promisor file content after repack' '
> > > +...
> > > +
> > > +		# Repack, and check if correct compared to previous saved .promisor content
> > > +		git -C prom_test repack -a -d &&
> > > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > > +		# $prom should contain "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
> > > +		test_grep "$prom_before_repack1 " $prom &&
> > > +		test_grep "$prom_before_repack2 " $prom &&
> > 
> > This test seems to be flakey.
> > 
> >   https://github.com/git/git/actions/runs/24095497271/job/70292906676#step:10:5274
> > 
> > shows that $prom gets two file names, and because test_grep is
> > expecting a single source to grep inside, the first test_grep
> > fails.
> 
> Uff yeah, I see.
> 
> I also saw your other mail regarding the "SQUASH???" commit you made
> (inside the `seen` branch). I'm not so sure if it is useful to solve
> this issue tho.
> 
> It looks like, for some reason, `repack -a` fails to repack everything
> into a single pack, but I believe that `repack -a -f` should force it to
> repack everything no matter what (I think??).

Ok, I think that I have fixed it. Forked the repo and tested multiple
times with the GitHub Actions-based CI. Issue doesn't appear anymore.

Thank you super much for the help Junio.

May I ask you for a tiny bit more of your time to answer the following
question that I originally asked in the cover letter:

>The "CodingGuidelines" explicitly state that:
>  "A C file must directly include the header files that declare the
>   functions and the types it uses, except for the functions and types
>   that are made available to it by including one of the header files
>   it must include by the previous rule"
> where "the previous rule" is (if I understand correctly), the one related
> to "<git-compat-util.h>". From what I understand then, I should have
> added an include for "strmap.h" (which is needed for `strset`), correct?
> And if I am correct, shouldn't "strbuf.h", "hash.h", "odb.h",
> "string-list.h" and "strvec.h" also be included?

Thank you so much in advance. Pretty sure the next patch version will be
the last one.

Lorenzo
