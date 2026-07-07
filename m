Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF83E7BC2
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435917; cv=none; b=d6aIMmCx5qsfoKSkhV/afqVhhSDOjsdirlFS+nr2gqg5LfPUe9ziXvBMclIqAcYs+w1TDsAf9XIPyivNC9GU83OpmJFOgxWBgXDgWyKsvAl47DB00VbkUbn7F7xP96otwC8ffqOXFW5WwsUeHXdVwKxVCEt0Sd3pfZBwGwk2WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435917; c=relaxed/simple;
	bh=KqIQxMJvkleLx9/OW2gu3UcyOHG7sTlXUgF0kVJYm20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXZRpcHPKtpAa/bXEbKtrFOCo4RCVoE3H8++78pmyDjQF/ZImRObL9nQldALrYwAMcNVO79kdb5GB5mf5h0N4whHAzmjD3Jvzwy2Sa5dG7iK+mTUcFLE1oZl4edRcc8m4PyMaARKoEXG9mrCPL4Oxl+zjGdopbSW54hpcZpZYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LNGNlpNz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMfyCC95; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LNGNlpNz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMfyCC95"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D55DEC0200;
	Tue,  7 Jul 2026 10:51:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 10:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783435914;
	 x=1783522314; bh=IE98o9E6LkYIXLkOZuTU60WPTH9ez0lZ/nu5OfoWmis=; b=
	LNGNlpNzktiC7+dEdKyLtbKKJOP0CGPS0fE1IPDg0vtVCT+1eAeHLlK38HDJm6re
	QT/yB/reLzprI07JM7kQrE9Me1HJkJV97K3DBudQVZz62a6z9qCBMwD8oGL0lPd7
	lDBS+8cwrfI4++uZbTgzrBok87XVjKPMri1AKCFijpkQuPeRoKIyGslw+DbPGeaB
	w36AJoyTEqY6zdzna7Qihc4fmrJLvQ0nBC6RFh7gx06ZJPTC5VgYUoZ141msq+3P
	1MDJNOOK23vLdmgo7zIP3Dn2QoO0p0sbeSmJJb/anu9ysS1If5q6oiDbwW6xWTTt
	Sp8sQ6L4AFuD31cOoC4wRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783435914; x=
	1783522314; bh=IE98o9E6LkYIXLkOZuTU60WPTH9ez0lZ/nu5OfoWmis=; b=N
	MfyCC95h15rfmnnGKTya9Y1GnekKg4HAHAZTbdlm/N2K+LXMiyyh4o0kkUZS9zJP
	bvv2436aIjkRQ6vmLhLXVmkdEY+bUtFFiVIDbbpTTfkCczxtG1KfGDUKroslYt+M
	a1yHKazIhh/A90dGzV7/jLzpwuoEFPubnHSicGRyh7kHg5DNkdgwv/f4Q8O3oB4H
	sNShjQlNeCWhWNbm/mmpkr+Y6Q784L2Kmofh/7bLDqHSkx2O1I7xRkP6AWCMAQGo
	shxfKS00QrUbetCajL4KpUjZ7ThlwTsCxhC3kVHXnocDArUavbuS0XlzQ51a48Q0
	356Tp0Im0KV1+9tbJOUGA==
X-ME-Sender: <xms:iRJNauHP1lMDfUcDDAgy2liDFNLl4DQDjX4ydmcX22UkSyF6CXLsFw>
    <xme:iRJNamVp1dVhei8ixGQ9Jsf5M12PpnvWaZS9EIPWLCf_PdxD5Aw-c3m_L-48owBdN
    8u6nRVcpJFBuzx4FEufvjJVXNwWpPuARqPiSfRD2PuZi-n7ioqM>
X-ME-Received: <xmr:iRJNatKrlPXUQfSlIhfuKMHuBRrmlODku9wQ10VkotbBNC-3ED_9K__aGeQJba0GE4JD9BX4TlDFpwCxBdJEVXqHFQGPoqyRECzUGrdgUg>
X-ME-Proxy-Cause: dmFkZTGuIFcRqiEXmm8ZPEUcb0VzKNA0DBExzFfwTQvetU+Eyc2ZeGm8KAZQRCAeQcLbGa
    1TgKXPKKNjeFF/2RYNzWANwJLKiWXl8i/tlu57qhgq9SNmPwkJuC4gGgx2/uwis18vYEPO
    bzZ33o1prVi+CFlxm6bsvGVgqfvrWEuQovNN3C54QIh7/kITV1zfJOn7Np5TBGALCLgWEM
    mZqPLLstFG6G3X3taCSflNwWL4WltFMg7B1ER8Oit64oeQnz8Q6UawcFH7kNNVcfVktmbx
    FrvmM8++PD6Zk9Kmo+tfCGCEQEFR4+MLOmWNCTj6wZ/KTfBQYncIx0FQHUWjKzeWc/OzcI
    Z8HA9npMZiz2zAme/8oz1Xn0t8jMCvLDzoxUQHOEeo06wWLW2ry8O8+QDv+dKMJGw8YRra
    7xukPeH4O5/WrXC31eaAGkuw53ExGXHgCykfj0PH/zg8Mijxo+eKSk4dbap/RiQPdekSD8
    Q3zjdsMKp8esOrN56OR0Jx1zmMBsYlp65Ju1T4+anOEia3TbIn5C/PmiauwMQEV9hOuE/a
    afqBOQa+HSlisbkQYxiPakYXVCfKcYLdMtsRZ0doZ0M932g/qFG8ly/pTD+cpy+sfQBpFk
    jn5CR6Hs0NzJgW96JDSzYaPO829PlHCt2hfybNQac3K0CWhJF2b5gYf4ZzjQ
X-ME-Proxy: <xmx:iRJNam_iY30ayrshTeOejldd6oR_Dj-KwH5g0UfkcPKmKlkDLa1gzg>
    <xmx:iRJNagJZjM7qzcq6T5gR1mD4e9ZjWI5AMsxO9R_Sxakc-s57y2l34w>
    <xmx:iRJNarn_JyLBbfZAghEEsY5EzLETPiGZdGFLp1Xz605TuQHyfi9WXg>
    <xmx:iRJNakMrPy_eUDfKOuZb1B9BMTWHMuwEi5zbQqXJCyn9QoX_RCkqow>
    <xmx:ihJNaooMROVXFwFi_boyquVkj_2hclOJxqhiS3ThqbT3lubn4JjVlQhF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 10:51:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 62781866 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 14:51:51 +0000 (UTC)
Date: Tue, 7 Jul 2026 16:51:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: git@vger.kernel.org, Vinicius Lira de Freitas <vinilira@usp.br>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9811: replace 'test -f' and '! test -f' with
 'test_path_*'
Message-ID: <ak0ShAvpvnGh1569@pks.im>
References: <20260702140704.65805-1-marcelomlage@usp.br>
 <akdwp_a2EuhVoGVW@pks.im>
 <CAO=vGZpMe3dxyzFVwR7BWBxaAZ-z9Kw3CqQ0kAe5ZZGSQszkzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO=vGZpMe3dxyzFVwR7BWBxaAZ-z9Kw3CqQ0kAe5ZZGSQszkzw@mail.gmail.com>

On Mon, Jul 06, 2026 at 12:00:00PM -0300, Marcelo Machado Lage wrote:
> Em sex., 3 de jul. de 2026 às 05:20, Patrick Steinhardt <ps@pks.im> escreveu:
> > On Thu, Jul 02, 2026 at 11:07:04AM -0300, Marcelo Machado Lage wrote:
> > > diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> > > index 7614dfbd95..93d6b4c479 100755
> > > --- a/t/t9811-git-p4-label-import.sh
> > > +++ b/t/t9811-git-p4-label-import.sh
> > > @@ -62,9 +62,9 @@ test_expect_success 'basic p4 labels' '
> > >
> > >               cd main &&
> > >               git checkout TAG_F1_ONLY &&
> > > -             ! test -f f2 &&
> > > +             test_path_is_missing f2 &&
> > >               git checkout TAG_WITH\$_SHELL_CHAR &&
> > > -             test -f f1 && test -f f2 && test -f file_with_\$metachar &&
> > > +             test_path_is_file f1 && test_path_is_file f2 && test_path_is_file file_with_\$metachar &&
> >
> > While at it we could split this line into three lines -- it's getting
> > overly long, and we typically don't chain multiple commands on one line
> > nowadays.
> 
> We'll do this for v2 as well and make it into a patch series to
> separate test interface modernization from formatting changes.
> 
> While on this, there are some other places in the file where multiple
> commands in a && chain appear in a single line, e.g. in line 244:
> > p4 edit f2 && date >f2 && p4 submit -d "change" f2 &&
> Should we split these into multiple lines as well, even though they
> are under the 80 characters limit?

Sure, if you want to convert this into a patch series anyway then I
think it makes sense to adapt all such locations in this test suite.

Patrick
