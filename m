Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B81DA21
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880407; cv=none; b=ACwKy+PA4aEuGY6K5Gdtr02CPHT2VIAVScp/Xx3OpXmpKEM7vw7Cetw6vxm+7PD6wv+hYcQAOaXCGIU+Nrtyuk717HCAW21EUFyhOXNJ+Gko35kZ8dovr+X65g5h6E3ZQ+zeIKrC7vBCZeYNjXfhVABJA0vP2Vw9nBx4q2aSnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880407; c=relaxed/simple;
	bh=6ZOnRhOqgCVIRn5Xve/py3YNhA6t7Q7WvD/X7o+obs8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q0N+lsQ64+tuBfsWUGpgMAY9U303LcnC/buyhjAzSadT8HnmQtL7AdJQuXC4G7fDVOlVqRz5kjjrZBbPZ4P0bEMtKIUAk37+Vs+NF47i88uKjzTjLROp5qjPK+J+FmkP3G2VnljA1fUdgPRYQQl3UJgwCxjOp8OD749L5DFcisM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=PIhklTOx; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="PIhklTOx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748880402; x=1749485202;
	i=johannes.schindelin@gmx.de;
	bh=eqwr90UYzOR/ZwE0H9UpHarC3YAG+Sa0DYlqZ7ngHcU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PIhklTOxRFB8PU1bx+pEBLBwrodewip+zS8kEcvrZMVZT+UkElp500EIAm4dUFyi
	 otei5eGRkhT9hE/Hv1Rw0RKhWTTt9nIx8nXYqEzaAKz4vlNE/c2iMHAzUoByQU6eN
	 EBRRtC6kPOS177lBJ8dznkEJ2l+aiNDtpwzoKHwYAkLIuhCMPiQky9pzNlYLkT9pV
	 qK0e+GicPp14A9Xy3If42ZXMh519o97TpdkKt6D/dj7NdxALIXo9UrISOZM+MY1I3
	 PVg7KSQ+3yoyJoRhuWhMVffZsV4cJphPvCxAz4KV5/l/b6gXid9T2KpeVX2bHmXZh
	 FDI0tfpNiaSFYlFc9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.83]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1usyWw0PXc-00aHmI; Mon, 02
 Jun 2025 18:06:42 +0200
Date: Mon, 2 Jun 2025 18:06:40 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Justin Tobler <jltobler@gmail.com>
cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com
Subject: Re: [PATCH v2 2/2] builtin/receive-pack: add option to skip connectivity
 check
In-Reply-To: <gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>
Message-ID: <2e17bd1a-aa4e-70c5-3bea-eb4d95e66756@gmx.de>
References: <20250520014920.201736-1-jltobler@gmail.com> <20250520163218.263921-1-jltobler@gmail.com> <20250520163218.263921-3-jltobler@gmail.com> <74668a00-5b90-2450-52c5-d9f00dcb42b9@gmx.de>
 <gw6j5enpzcit2zquafoaiujreoa4kbv3n6feq6yeqylcfynqim@s53ctnlg7tmm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:clTa91wNNGExIDf28VRLlqKeVrCvAoJNyEAFRfkwVb7PzTDAz0u
 qAl14vQiVGWOSkFgWJ92ispM7w3hdT/Edx55qk+Op8OUkrB8eibBZ8N8wFb2/cRhVInhkCt
 zFfQbU9JonvoLao6yThMjIcbY5CnT+GN6ffYyIY2EuKMWV/hdVxdokefHdWT9hlq+hgKh3M
 JdGay6iWyr1wDE+8lT2uA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+G+4xghOCDg=;J6QFnREdkvEcfc4bOV+Qfj2cIMY
 K6ri+r77ujR7Di8uU+S1hTT3bNoKaKNUbmW/Q4704TvxWwzRJCibbAZe01y88kYQNs7wqdj0b
 8oXOFIDt7yoA3SAMmGNs9/cee8mKE1F2kyKV41wqeI/dIddcana/DlkVwVx6qYINBtx5x/jdI
 6xkeUlLqRB97pl5wKpg0x+zfjiSnLQ10jEFU72wZ4E9qGeN7u+rP0tvCyh3No5QC0ezgTGrh3
 tMvAdDgtG+mpKTKI7mJ8qdsjCnl9usbdLYzpVcAjp9EUcOSn+TqNkbmQcS7j6mYDL/kLMJsXI
 F4fRrtrs3oKpqYD7s7W4TaACQ3ePhKXWD48pBkRC4uumbkQIqoBub1DKL3/ipi5T0dIREP+nv
 H4b2JJAbDemCOshppfVkQg5lE7ukPtXqKcUjBXwdTSnqrTnhFj5bpGPXx9356JTw40Rl6m2UK
 DwXlLOX/g93Azh4cwFLeYBWBQ2AyNXm+zKEdOh5UjIupNtASmsj1r7E2Q2sl8Q9P2dA1IXmPp
 MFiJRtI37KlUNvO4+xzVetVcOhTw7CRmDS16hkFMmFcyhHaNlYF81b+nPN4L9LtfzNCV11uzz
 jMkboZl6zWpiFyTXn6Ks/vd0WcDWnPn/pSqFVTvVMIcWfuhciCM66lpda1XCsQahTrYzIhjNe
 wW4BFBXBF2+6BKw61Y95qoHb/PJdU2RQnoKLP2bZMTCZBSpj/dv8ztD1K3eQENk3jm8Nz51nH
 9jlVFQDM5UY1Xl5WiNrPkzlchWHRWGtJwtB1QABUppmcNj2G9x/JUWKhGBYLtsWzCABNMObnW
 T6584nGMWBHIFdDkljL7gDuS+n+/GUKt8lfDVbnkLBqPby4+ERXgFEBrduU3I3UWRcsEiJ2Jw
 GyAlH8U2EDH/DolSm4dXAyGlpUAdtloQrQ5RiFdW9e+wcqC7eU++q0GMfkZqcTthv7bL5US9z
 tcY9r37ZzcJXpuiF/CRnLmtAQTc+8JJblkeyycJtitBkcI6Js2e+Ji8vw5UyTNuWQXp2tfN0B
 XRMDzB5OmBjPfGymVoUJxMlfkYLTVThNGIt6zBUOoitF+iMVW75kcHS1m9iWsylPMbq/FT9xH
 Hf76olDUFeiIrMV0bUt9QSAd42EdsBQmcGQsN/QVMuGJf8z9TWoZvu3T++ElYSpPisnVbDjTA
 /6SWPH8w8iGCbRqrsTBbGZgmSqoMWC9IMEs+i8mVMTkHFiqYnIhfQL+XMn8VoEM7FXteXEX3z
 lIJpc9/bnlLG7psw3mrWCzqJlla1yeuYGUmoKDE1JKwyHRnOT7s4EUAtILVRZfO6ckLQWxm7M
 Vh2RS4EGVHe/7CAZBFdICUHJpz43DRW9LJbjHGgixMfQUOhifWoZx6eI+fiMDzGxF9OzK+lEt
 VfMCU3aZWDXLJXiqMuOSnC3BrC80SzBTSi7AahjJK1UyUuFlrL+iI22BjenmZbrhcv94cfUHp
 xJ8kT2EkgtffCjdI3HaHI2zyj/+URadPErXhPqHuk0xG6hcF7npw6//8Ve/+Ppp/Yz2PZ9tMk
 mv4XZlDntsvYcbAEMCn3Dc7bo4zsn/MJfhdrRaD7Ag7Jck6+F63OFkz4Qj/ZxfS14CaeQDg+W
 kvZo3BBDm3ERTGEtCedfpDCZRr8dCxzHrSz5CR+KYSa33XsAfK9zwueQz/OUqCLskyLGPgeEp
 dWD+SDLD3uQCeS/2JmCmfMT6lfjubwLdpgAuvJIiMK6m7+McFXyPVqlVKtPbnpITVrr6zq6x/
 ej/sHYxeVWfFrWE+6Qfcgzxz5Dc7PU6DO0s2yWn8ilzERIOoaBFaXkPejChVnzFzFby85u2YO
 yntbDF2yqnUHpnGl48beB8AWiyiTTdvU1dLD9SiEkVOgszjaQwMg+cqhNkQIKOxTBw5FpUpBK
 wJYoJuH9gtLI49G1QSUVOzwfrpw5BH6QbblFfA4Azj21wKbXiPBTLBQh0DvxcqjzIdFw1k9I0
 EGmJ9NzK+6jtYJ4wLbHkb09uqyBTn3oZZ8bIOX5Q7MZATq5pSk3CPtA180ELZXASAcLA4og84
 bONCo0oStF0uQ4FbqN0nC9MeGs3rNtw7bZZCwlXwXWRHviCQrZR+K1ZDQUZ1ndPc1gQS7D+4X
 +DAQle3kkQbOxCmurGcjD5cDlZ87LCZyCz/UYqFmuOplwcx7xd/sEXFFUAarJoVaRW1G1qdpr
 4EA5GpCFnixHAlUhepJch1jfM8wHhpJ5dy/TcdZ2bJKABJNlzcH26AKASdewimpdRET3d0zjZ
 MZk6Drb8h9ypKYlaQiPOW/ElKHWiSL4Sxx39a5k41UyhczE3u76LTMRUGgJc7DAoTlcTmaXET
 GsgubNwkL9VLWG6NIrAqljZaMvWr4Rg8v9rTcHnKkH+5Itw/lonovxbz+PKt+rpoqOi762kJr
 g1qjzqpXALWU/r4m9WtzAcwgsyNFmUeePTWcE8ISR2navEhYB3fs88c6oLC36rntFvpoSmEHL
 ZgGlVg2yPI7h0QMqFFzMHfcn4bk0pgDsUYtbW3Qs5Ogxq5CiDnKt4W0IAeGOIps8BhPBywWoH
 VznxMJNx8tYgoDHxMRIK+t0cQP25yMAPoyG/ybdOYUnDaKDnp5NjcKLoI+0+TEi/ObRvy0RyI
 Su+sGsarPuTdSL9rkl4H5qnyK5KVtaJUQm0ZkuH5ik4/zongpk1PlYBgcDTT76PRAJVMjenJC
 0HNADeQ2WtrYf1AZiC38Ca5K4OKek8/hnA+HTCj60a+dy3O5yB/Y97aqU3eWluybY4RKuVcy1
 0P16noXmEPgBe9N8A2woCje6xVPc8Dx19RHL6XaoPY0t60woriq/5m42pW2Bj/UvAhvCXijX0
 H4yKcnMUzOxM042Xb8GWpIoQ0Lsl8woE9Fh+2XznqhIHclq6dhfZiFtMf58pD4pVJMYMJw72S
 LvOUno+wIkvqtCwQyKgRzHr/izbXv3bEkRXc/U24ofXUSrUWsnqQvvQNMdm2ZTXmYGSml2Gkz
 dv3XEf6RB7U1F42QjTQ7VIOr+PJxiDfuO4JEBzQrJIhuU97Su3aWFHcxP3UEZdwHR13uCY+GS
 cXfCv7wCJMXeIk7Fe1A0fGHBPps2mwZ/cF2gzzMNS/P5HmmeeH/vX/i2K8P32/d4xVV6d5y6K
 65+RrxPdh3lZ6z7ZJNm/2rQtvP6zlKBC9cMQzKaJfcYFjMP5s4DoQ79Nj68f9s9ob7ifYlEM0
 Kpi4oFksCH8DKHAJj9nm2pKulVWsujOoz58pHwk9moyQZ9pwCI39Gy75cl43umPsS/0YqaO+Z
 F+FnlebBGklMhmq8+kqM2AXDiq4gjVqQa6cwdHtb+jQRiGKoaqRHrsbV0Mk=
Content-Transfer-Encoding: quoted-printable

Hi Justin,

On Mon, 2 Jun 2025, Justin Tobler wrote:

> On 25/06/02 05:01PM, Johannes Schindelin wrote:
>=20
> > On Tue, 20 May 2025, Justin Tobler wrote:
> >=20
> > > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > > index 9afea54a26..f76a22943e 100755
> > > --- a/t/t5410-receive-pack.sh
> > > +++ b/t/t5410-receive-pack.sh
> > > @@ -62,4 +62,26 @@ test_expect_success 'receive-pack missing objects=
 fails connectivity check' '
> > >  	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-par=
se HEAD)
> > >  '
> > > =20
> > > +test_expect_success 'receive-pack missing objects bypasses connecti=
vity check' '
> > > +	test_when_finished rm -rf repo remote.git setup.git &&
> > > +
> > > +	git init repo &&
> > > +	git -C repo commit --allow-empty -m 1 &&
> > > +	git clone --bare repo setup.git &&
> > > +	git -C repo commit --allow-empty -m 2 &&
> > > +
> > > +	# Capture git-send-pack(1) output sent to git-receive-pack(1).
> > > +	git -C repo send-pack ../setup.git --all \
> > > +		--receive-pack=3D"tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
> > > +
> > > +	# Replay captured git-send-pack(1) output on new empty repository.
> > > +	git init --bare remote.git &&
> > > +	git receive-pack --skip-connectivity-check remote.git <out >actual=
 2>err &&
> > > +
> > > +	test_grep ! "missing necessary objects" actual &&
> > > +	test_must_be_empty err &&
> > > +	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
> > > +	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse =
HEAD)
> > > +'
> > > +
> > >  test_done
> >=20
> > This test case seems to hang occasionally in the "win+Meson test" jobs=
 on
> > GitHub (I tried to find the same failure at
> > https://gitlab.com/gitlab-org/git/-/pipelines but couldn't find any). =
See
> > for example
> > https://github.com/gitgitgadget/git/actions/runs/15383915635/job/43279=
134837#step:6:627
> >=20
> > Note that this problem afflicts only the "win+Meson test" jobs; The
> > corresponding "win test" job seems not to hang.
> >=20
> > Even in the Git for Windows project, where the `win+VS test` jobs are =
run,
> > the t5410 test passes within a dozen seconds or so, see e.g.
> > https://github.com/git-for-windows/git/actions/runs/15383945895/job/43=
279689086#step:5:143
> > (confusingly, the subset of tests run in the matrix jobs differs betwe=
en
> > the `win+Meson test` jobs and the `win+VS test` jobs, but if you click
> > through all of the `win+Meson test` jobs, expand the `test` step,
> > patiently wait a few seconds for the log to be lazy loaded "enough" fo=
r
> > the search to work, you will notice that t5410 is not mentioned in any=
 of
> > them, and the only one that times out after 4h37m11s is
> > https://github.com/git-for-windows/git/actions/runs/15383945895/job/43=
279753911,
> > likely while running 5410, too).
> >=20
> > Do you have any idea why this particular test case, in conjunction wit=
h
> > Windows and Meson (and only on GitHub) acts up like this?
>=20
> Thanks Johannes for the report. I'm not quite sure yet what is going on
> here, but I'll dig into this a bit and see what I can figure out. :)

Thank you so much!
Johannes
