Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053923C8706
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420253; cv=none; b=GIQFgolz0I4TQ5umDu1pWL0ugumpfz/cfzpCnN0c16vAyCLLUBiBSA49rzOqgdoz00XzNpCpgT5nE2BUJ8vU3oSg8UirNQflH2skfg0zbBI3UFxUudZ+M8UzVwEVFngUqrJb/M/53efZ5S+lcpfqM7YET440ZV+YbJciMqeKqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420253; c=relaxed/simple;
	bh=L+evoBMa1LXozoL44ZxaIt3+eR18UlCsqbtVTnt3OVA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fi7AhJAxpIryEfE7KAVIrrDlZn7O+hpskOkAKawJVwn3879ySMYmOoigM11cr/eFh3Jhg4FYVU6ew/pY+SKvOp7N0gfGP3Iy9F97Kn0GApyEBBIWQhY2HgKvIEWxhZw4bkpOppsrIhV9MPwbUGIb6GwNeZ78jIMABAEvh/Yolx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jq8DJLjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ec5Ak+M5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jq8DJLjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ec5Ak+M5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1232D7A01E2;
	Fri, 13 Mar 2026 12:44:10 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 12:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773420250;
	 x=1773506650; bh=pVvdYCcNnAjyON3BEkTw8q/jT+u/ii8IX9yyu7Zs99c=; b=
	jq8DJLjIkMnhowahRogJUbqmO6Zel9tg4+chYV65b8dJ9ak3Hn3t7bRMX6eLivoC
	eurkms2Kl0cjRnKovEAOqrtvKbrcJOzbCUezNu9F8YqWhUg1WkezPsiJRtcJwRow
	/Vkm4HWeG5BLAD0jWGWvCEb6xWgpzUhuL8llgUz+PsHkKP2mRMTzq41pCAgY897Y
	4af4PW7VzNYOELIHXzkArLFeRvt8MFuxREiDGe1dtmKXtKLyZxByJBDWjbqFDO9R
	TCdrzRqRrSpXzYd7Pn+COCkl/UIVZ9I7ukOnk6TEn9vwKaxYnpsOJPfehDTcaRI1
	wya5QFUot5tia2Di56fMYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773420250; x=
	1773506650; bh=pVvdYCcNnAjyON3BEkTw8q/jT+u/ii8IX9yyu7Zs99c=; b=E
	c5Ak+M52XcQK2VQXle+bYz9wK11d9urlqCWaPLc9xZJXD3+EkYAtZEPKiuIzH4xS
	JkkL4xYlRXXkqYBhQl6QraE2WyiFwf/69I/PkyFj2A2CiuovjDtLbMrhITCBaAV/
	xcHLfjXStSh09Z64Oi8sjyUGAb31nmXFRf3Otz27NotXQoM3dtxRh7uiWstKmtac
	FOcEW2iPCJ7DY2a6hEV/ENnaKzOj6E4EG2uV4uOdTV14NMrwr7cb84NVmXVrIXEw
	zatYeTDYCDc6IXtnEs4ZT+4xDsnpN1YarJFoHPHxeEXgNJJJUoJMHuZlH/22nPo+
	wb8NmAUIA9HwkO34JBPsw==
X-ME-Sender: <xms:2j60aTCzCvARTQ8xYk5fI_p8ws8bYq0M6ZS8FUW--gn6vmwHmbFDgnI>
    <xme:2j60aUU_Wn2EVkOplUIMj9oXiEzSP3xhgZyYJr5La_1qZSYVueD7lM89Vcf2Q0RAu
    CjHCOKanreEikfjiBHXksMqXnhEHGARnc2oUxQuN3Ppt0HppWr_aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2j60aQfTegOcltPygr_3y8jh77eHqrb3wH4ZcyOQuGnDfbGtbmc68Q>
    <xmx:2j60aZ-nIlpSZFnXQVezud1AlQW45Tr9rBmIp2kViBI9B8qa_h7T0A>
    <xmx:2j60aUm0T1Yq0xuKpb9h4naSQSaPyc6Lhh9pvV2kZDudjykFR3t4OA>
    <xmx:2j60aT_axud4yrTfo4sPRy7us63YY8fh_Kng9do34GkNkXMBg-NfEg>
    <xmx:2j60aeiGj-q3C_AL2JhDkKTkXAdrQgg6fZIC6mO4Bx6FgXcSXhGQ4jeS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 838971EA006B; Fri, 13 Mar 2026 12:44:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhQ9kH8f3u8V
Date: Fri, 13 Mar 2026 17:43:38 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <aa0664a5-09fe-4dee-b243-b3b5dff41b68@app.fastmail.com>
In-Reply-To: <xmqq8qbxkes4.fsf@gitster.g>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
 <doc_interpret-tr_synopsis.48b@msgid.xyz> <xmqq8qbxkes4.fsf@gitster.g>
Subject: Re: [PATCH 1/3] doc: interpret-trailers: convert to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026, at 02:38, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> ...s. The only thing is that `": "` is
>> used instead of `': '` ...
>
> The description says that a pair of dqs inside `verbatim` replaces a
> pair of sqs inside `verbatim` in the original.
>
> Does this refer to this change?
>
>> -This means that the trimmed <key> and <value> will be separated by
>> -`': '` (one colon followed by one space).
>> +This means that the trimmed _<key>_ and _<value>_ will be separated =
by
>> +": " (one colon followed by one space).
>
> We seem to have lost the `backticks` around the thing.  Intended?

Yes it is intended. It seems to be the current approach to =E2=80=9Cverb=
atim=E2=80=9D
(in spirit) that ends in a space is to use "<verbatim> ".

I had this arrow from `Documentation/pretty-formats.adoc` in the back of
my mind when editing this part:[1]

    `pointer=3D<value>`;; Shown between HEAD and the branch it points to=
, if any.
                  Defaults to "{nbsp}->{nbsp}".

So (finally looking back at this) maybe I need to use the no-break space
expression here.

=E2=80=A0 1: This part was recently changed although this `{nbsp}->{nbsp=
}` part
     did not change: a34d1d53 (doc: convert git-show to synopsis style,
     2026-02-06)

> Does the thing still typeset as verbatim in the manpages?

No. It=E2=80=99s just regular text.

For that matter: my setup (perhaps flawed[2]) also renders ': ' in the
preimage as regular text in the HTML output.

=F0=9F=94=97 2: https://lore.kernel.org/git/9570525.CDJkKcVGEf@piment-oi=
seau/
