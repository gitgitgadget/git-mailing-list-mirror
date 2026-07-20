Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1285414A32
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549758; cv=none; b=XUwjy8uoml8t1+DEYbqITg7GIBpNhCA/Q5OFnOCx/uHjStZ+LWoi0ZDCTKqL91tfm+lLGUZUjpqzXCK+wUiNdyZ96d4bVRz3R8oF1rzPs/p5mEDNrn+v9iS4MFaZuVqad8ZPIWhOW8S16yP3p/JihznpUzf85qsnAkM55Ll8bTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549758; c=relaxed/simple;
	bh=K7QIEbPjTj1cFB5DYwYUWTNpJyf8j++kdE/mS0NVae4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biEyxe0sHxaWuM2C8+GOrntaTiMyRInFv9NpiWu3FCdkzAI4ABoVccClxLj4niJzh9JhCGuv3JuEkoUulUfhEREyS7ti7/rXlbEzIbkU+/CRxcwO02/U1WoGSWd4nHjnfiNW5tbYMmHxoLu56VhREpR64yO9WQnTyB9KjQ4HZlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=ACBv2vh4; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="ACBv2vh4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784549731; x=1785154531;
	i=oswald.buddenhagen@gmx.de;
	bh=wr0t0rRIIKQUgDdv8IJuTCz3b8np6qeFbceOKzAsUBY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ACBv2vh464HR/AlAAnY4uzlbfSa9rJ7J7F5j1uq7l9r2FFxhCmFrczgNdeD/BSSY
	 B4aiYAKSqP5z/RKiuAEIl1lpYhqKlTKZqzPxEOZLsbReRHio7LKaKgVgHUfqa+F+O
	 UkH2KKxWFYpTO3NG+jRc4m+LIEE//7ZXBTHBcLTYqwZ0v/g165rNXkuF3K875ulGA
	 f59Sek4fR0CbZ9VYZ2Eq3epdqcgutFvObcfAVfX1RlR8lUxOPNx0KBP1t4jWACMSk
	 B38VdNGM4LJZE+sFW05f+KgJDRlDMTlg48jKrcDTECThr2Ngh4TLhZLWGmEvoj36I
	 4tacx23y1K+nmOxLHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1wvcE801Fv-012Zew; Mon, 20
 Jul 2026 14:15:31 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1wlmuA-t99-00; Mon, 20 Jul 2026 14:15:30 +0200
Date: Mon, 20 Jul 2026 14:15:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/9] sequencer: do not record dropped commits as
 rewritten
Message-ID: <al4RYuWKqAr-IlFC@ugly.lan>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
 <cover.1784128921.git.phillip.wood@dunelm.org.uk>
 <xmqqecgyn5gk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqecgyn5gk.fsf@gitster.g>
X-Provags-ID: V03:K1:IvX+suT66g/uH0pTRBNREUAdMJkra6xf8peXpddxPw6aQ+SjB3H
 iN1N3WL1nFXr1zU0xsIUpOM0jBHkXFjzubX6cCPlVEs9N+kfn/qjTVVLAwg3/CPJjUIVGh5
 uJls5pg+go/S3BGOhtslpdFBfehAC0pN+UkJ2kWuKUOjQcwjeX8Rd450h5AfdQhUv39GlFx
 PNv7+uifT8DDT6mLtA4NQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XVFfuqMN0Nw=;65uhemgcXbwmBhriAFdBTbwId3k
 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
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 12:29:31PM -0700, Junio C Hamano wrote:
>It looks like this is now ready to go?  Any further comments?
>
you can add whatever footer is appropriate for "i read it, it seems to=20
make sense, but i didn't double-check" for me.

(same for phillip's new 2-patch series.)

(it feels silly to "spam" the list with such low-value verdicts. i=20
really miss gerrit code review here, where i'd leave a +1 in passing.)
