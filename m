Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EA3B1A2
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 07:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461186; cv=none; b=GW+32L200vdfSVKP8b+S7uz1c3XSYSTpozT2AmSaljWzahye4LbbaT8tyhjEYRwUCgVVdL2HvUNMHXkx+QeSrSQU5rjH2qn1AIS9nV9bFS36TN8bKLc5ciNNM1LTLgv1CeAtot5C+ro7Z3UcyZuBSQKpCgtqxXx6WgqTIXJ6Z9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461186; c=relaxed/simple;
	bh=XfJZLyirfA3Zxb1Qdnmwz5GK1jglAmZAJf3AfIaQ/iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANx1/FUqW2Y8GcXKu120upHiiKYbb9hQU4N6RrDMh7X62RHcWlkUZV9JGvJBLQC8p/0t4RTSexdcU4YfKp3PeeT9X4OPzJq4gRyRijTKfI95bI3Nd5Er4f4Vjjo93JjGJ2l6+7BeVrXfzfHBtTUc+xTfycb1VawLXaHpS7IsKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=lf3ogmc5; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="lf3ogmc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714461171; x=1715065971; i=tboegi@web.de;
	bh=Q7gURQzP3SGdjrXHlpfprdtQ6v3ixSw9R0W7iMHAjk4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lf3ogmc5xg8VUI8+HbNdD993LoFeyyzRzPBp5bZmBKoHR7DP+pQ5TnQKpHqbbw5I
	 29XEwYUlj+yczXhoHyRa/6p6Qft3hVX6ZxhR5ZlfpMy90p1v0PAUh0EvK8jKutt8j
	 EooBpYU1xFQb7V9tiOtDRWW2beVaRxSajIXNNSj3VpgGvmB+bYOJzXawQcjrlZycS
	 OttPTzLTgmzEBC6jB5fehsfcqXto/tV0t2wUVEZyCWhryam3FPyfaCnrghC0jfrIF
	 L5+lAFE8KeDTu7X4OlKzslMY/3f+eZoTJB1t9C4DpXkmlvDOBRGbSzEgifsYcqGC0
	 oBx5jUOzpipa9InbjA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB3y-1rwmmS3kMw-0071L3; Tue, 30
 Apr 2024 09:12:50 +0200
Date: Tue, 30 Apr 2024 09:12:47 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Jun T <takimoto-j@kba.biglobe.ne.jp>
Cc: git@vger.kernel.org
Subject: Re: [BUG] 'ls-files path' fails if absolute path of workdir contains
 NFD (macOS)
Message-ID: <20240430071247.GB1504@tb-raspi4>
References: <55D75808-70E0-46FA-906D-C00CD612A262@kba.biglobe.ne.jp>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <55D75808-70E0-46FA-906D-C00CD612A262@kba.biglobe.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:zWKPN/+YSBaYRspcsJQBJ6o5jo7fLpwqKyAaNOAK+Et9+KELyzn
 XGm/agOtFhF6Ud/8R69pnN1kYJo6n5I8BVDFc5IZC4/8ZUn+1IrcnpdqngSP85gIxuqYvFU
 21Srqx5SS7K2pW/W/qUT+12Feaz+qTL8Ul5Rk62bgQ60DOaKloPozll3EP0oyMPOimrnEuv
 gHzipwFA3cY8UBRSsg5gw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lsyI4F+xAb8=;MKHDQaQ9oJiT+eK+f713ShDM+X4
 5gdDzpkwVEQdeInoVb8fSMP9FEOXX87XAnZao0slNDusuH/RPf7j1AXpjId31Zn6e8AaRzACu
 VGFfpaDBvxhuV4ghXhkFcxvjzJVo2v34Z3JdJycBRq5VCeLdK2ZELKPWW3ZHS7+SkojVclyBd
 hunlXkadf0kXfb0duQBDc9awfqgfEou1aJtOurQvdr9BHD8DLfqMApSCj4LO50F093SwsMjsB
 l8+598y27j5x8U+5yyPUkckxH3Fc/21d5T5/oMPbfG5rcfqORV+m6w3oPCbXlAOsMrmnyLxTK
 7qr6Ni/CWhFLiWsCoEhK/S19KyIk/GB9Prd6l9Hv/IKvigtzep+Qaai3SWxdITGikSfBz+M+5
 41p/K5wR4lE2qfaWfI93NOT0Ix1S9GSENz3xAy5SEEohvlFRB6ufIr5De5EzXErFD2YBBIE3r
 IOPqtfjpiUVaoOoR3dwRw+jVdoNZnDCi04xc2Ti2m9RuQ/uOoKoh6DZTBrvEO7B3/wmuQfOTC
 DjVmH6lJR7XQAMsvhFF0sUX1/OfBBL7HxZohxrzpeClBme42wwUouySwD7bHbfCMJALeXhFhr
 74ZBFw+gDm06ws/bq5h0yw8jVgYm6p6fA5v0/n/DAaVR+1clUS2Rdnhdetu8HykB3TLdB55kL
 grVf9zbsnb4H3tOP8MexusyoNfZhVJk8UH+03PbpI8/QzC+3BX0rkAfKDo1nGtiYKcxGEppcj
 9gVhUTRxcLwcl8KQCWDWdkhU3GdeJA0es5m4Xer7phQ/NeOH1S9AK/ql2vxY9mktLvXBQSn96
 ePcXwvFqaeCSbLJFvQF8TLdxPXM4gC0FILamci/rNuxco=

On Tue, Apr 30, 2024 at 12:27:02PM +0900, Jun T wrote:
> On macOS, 'git ls-files path' does not work (gives an error)
> if the absolute 'path' contains characters in NFD (decomposed).
> I guess this is a (minor) bug of git.
>
> [1] How to reproduce the problem
>
> On macOS, git 2.39.3 or 2.45.0.219.gb9fe23f5ca(next branch),
> file system can be APFS or HFS.
>
> with zsh or bash:
> % cd /somewhere         # some safe place, /tmp or ~/tmp etc.
> % mkdir $'u\xcc\x88'    # =C3=BC in NFD
> % cd =C3=BC                  # or cd $'u\xcc\x88' or cd $'\xc3\xbc'
> % git init
> % git ls-files $'/somewhere/u\xcc\x88'   # NFD
> fatal: /somewhere/=C3=BC: '/somewhere/=C3=BC' is outside repository at '=
/somewhere/u=CC=88'
> % git ls-files $'/somewhere/\xc3\xbc'    # NFC
> (the same error as above)
>
> In the 'fatal:' error message, there are three =C3=BC;
> the 1st and 2nd are in NFC, the 3rd is in NFD.
>
> [2] Some analysis
>
> The path on the command line $'/somewhere/u\xcc\x88'
> is converted to NFC by precompose_argv_prefix(),
> called at git.c:451 in run_builtin().
>
> But get_git_work_tree() (called at setup.c:50, in
> abspath_part_inside_repo()) returns the work_tree in NFD,
> and comparing it with the path in NFC (setup.c:92) fails.
>
> I'm not familiar with git internals, but maybe
> get_git_work_tree() should return NFC (on macoS)?
>
> --
> Jun (Jun-ichi Takimoto)

Thanks for an excellent bug report and analyzes.
I am familar with the NFC/NFD stuff, but not with get_git_work_tree(),
at least not yet.

If you have a suggestion for a patch, would you like to share it ?
A 'git diff' may be a good start, I am happy to review things.

/Torsten



