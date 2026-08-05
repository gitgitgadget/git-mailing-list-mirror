Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B023BD643
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948299; cv=none; b=WsUe9U55xMn38pboQqEC8sTA48SfKZiEVDnB6l4bQ292OpXqR+PPkJV03AlucXCH0TChdD/H3Ksi0I9tt2w0egqBHIXNPyKLzjWfZPiI11gnlggFEcscbgDdISWghOFaQsmWh1GNF0y81vvybwL58mWJcP2oakryFXxxHufN3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948299; c=relaxed/simple;
	bh=ks/mAXW3RdPpHYwMMKJpjAxa2toA/YVVuVCgGCmKkR0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AsEDCj62cpcioXKec8kx6cgRbCE5LlAOsLMvxs39+5NNyVGQZ3mb4oUNyZnWn271V5of97oOC5z/OTG4qFh5QF9q96B7HcPyvZFjPk0FnHF4waHRJ7XV+rmuCUaJohfw/91AtJZnUFDGkvUM+vrMxTJiboMH+8TV61WikdzHAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nYIfP6vv; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nYIfP6vv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785948294; x=1786553094;
	i=johannes.schindelin@gmx.de;
	bh=Nd09/ENWFBSYhEgaxQirFtuNjg1XDFLbaBvuxRg4Sl8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nYIfP6vviK5q3gOsmSpKEmoEeUrB6c34AKzFik+HFV645uM5WzJztGxWEbalLfsA
	 XM+xLrgakL15cqtI7pBDffS1JU4IL8jhbQDfCCsLeq98iVyHoaMF4BCGEyr7+BVJ0
	 cznb+HfKBfcN45CFChB2JnFDOl/Fby+rNpJncsUInxpk+XsueUITFVRKtWWem0Byp
	 qi1XRYxsFhtNO0Ucyl40/1xwEYi4LKsOxk1gMcFcsaNucb6NLyJsEObGrRIi4Hveo
	 1+7BBVda+KfpWWI9DPpIvqYOx2eOqluU894b4y0zoLYsxb5ra7gfGK2gadiZvJiwH
	 CMmn9vYwF9RIQTmG0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1xGnQR2BuH-00aO63; Wed, 05
 Aug 2026 18:44:54 +0200
Date: Wed, 5 Aug 2026 18:44:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 11/11] bisect: handle dup() failure when redirecting
 stdout
In-Reply-To: <alcvnm0xiOv5W0w_@pks.im>
Message-ID: <8f0e066f-c995-e47b-a3a4-709821255671@gmx.de>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com> <2da452e39cbe1bd53da9d76fa7f7615c1a453634.1784069325.git.gitgitgadget@gmail.com> <alcvnm0xiOv5W0w_@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:uIwd+7Cy5IfugdZUJjN1wPcqvM5AehVV95XN1G91161c5OHgQMu
 iRJWDLNfnHHX4Ar9JGDbFQ6BO10Np8sTf885a8JnjfwK0u5SJdijsCqutOnuDGLZKds+peL
 VJBKnvKn9g8vpdozu73bMEbMtabDrQrklaQTaA8RIuLWGQYKywMwi+HLtuK8k6jMO9mlHpP
 P+QDjnLnceAR7d5U4pAlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J1TSrGPeiyw=;pYZF7MNAuinwjCJg2WXj+NooFc8
 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
 W+3rhmPf/pZ38weX7HTorGlXEYu1Bd+ok+Y5g=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 15 Jul 2026, Patrick Steinhardt wrote:

> On Tue, Jul 14, 2026 at 10:48:44PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/builtin/bisect.c b/builtin/bisect.c
> > index 15a2a30f89..801daf8c78 100644
> > --- a/builtin/bisect.c
> > +++ b/builtin/bisect.c
> > @@ -1308,6 +1308,11 @@ static int bisect_run(struct bisect_terms *term=
s, int argc, const char **argv)
> > =20
> >  		fflush(stdout);
> >  		saved_stdout =3D dup(1);
> > +		if (saved_stdout < 0) {
> > +			res =3D error_errno(_("could not duplicate stdout"));
> > +			close(temporary_stdout_fd);
> > +			break;
> > +		}
> >  		dup2(temporary_stdout_fd, 1);
>=20
> Shouldn't we also verify the return value of `dup2()` while at it?

True. I wonder why Coverity didn't complain... funny. I changed it to also
check the return value of `dup2()`.

Thank you for your review!
Johannes
