Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C50449991
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303405; cv=none; b=O/mlsWhyuVrOHRv+Z8FS0tin396laFiO8C3ck3uRtThF4MpnlcejMRksM1UlZSiJNehCF+AX+1PKja1cXgkNuMOFUx8hRecbvlKoSRPK/FaFIjt96UXjrPjApqzD7Tt04Ab/JMFZ+YDofwQsVYD0kj7jHeY4Lr6R181fnlvZEUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303405; c=relaxed/simple;
	bh=BAsZUrFuoknlEUwG/pt5vtVn7PmtOVzEZZvPk7vfNZo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q61HmnHJ3L2QFyl2ali5cBESA9wQpcA1KFDLKnWpOGoK/B7tI0pIeIMluXbViKQK+p35eh5zLitalR5dFHpUgFxq2Wfh09y39pd8qi8S0meEDnTiHHU+UQRBNMoZMpo8CGzBDhHBhOwNUqFuCGHzgMRe8fzvJ5b/Ikiq9HD43Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GlYNjVkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SJqnf779; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GlYNjVkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SJqnf779"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 197211D00073;
	Fri, 21 Aug 2026 05:09:48 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 21 Aug 2026 05:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787303388;
	 x=1787389788; bh=TJ2sYEgz8eXytjmszpvETajvE0lu13X7EKgtfM19//4=; b=
	GlYNjVkfOcom6qCkttsyzcrCQ7HX1MrP47bdq4bc1OjhKtU+Sy7UbbNIPDuNhxBe
	HFOtBGt7gIw0qqvI6B59Do6dbZzPyjjfO4Wwgzlr9SsuG9/6nIHBQUVK0MpctcMt
	JFR5hg9G3ND2492PwhHMpotnchstF4gDcp+TGkRyiaem8CAoLj2LU+pBmWMYrWRG
	0w1/wQjasC3qbpE17ffmmSV5nWEhsZn1ren6TjXRSK06E3X+zZo9G1/Vroogbyg4
	NV0vjvHmhD36KYdr/pCOVFDwjWmV+Qf0ppB4WzN/lAucQRx5etpTy/4/ZKO1Ir/k
	51WhlrIY/2j3/jkDn+zepQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787303388; x=1787389788; bh=T
	J2sYEgz8eXytjmszpvETajvE0lu13X7EKgtfM19//4=; b=SJqnf779yxl93lkLY
	EbxLC/5PWUaDWPSTdH6PQwCgUdFM/G0UIFnnbVbWfdCHprDYGfGZxsU1Lcnwdnr0
	Amn7Ox8A1XIHrBtQJ6cH0eomKe0KvoLcczz1a89i2R4TMDEUBN7VnKgXTWSMerp9
	1BiCqvQqoal22BM07KcxTWsv2kvhXLf1h9rnxHiC1zQ3p+6TZr/sM3Y+j7UyrQmv
	JR8FFLMF6bkUV0xXlN4RQlQw+36cXWXmcBdtV1+LFIELvm3kUgXUiW+y+WbAOcO0
	FXSvJkToJV7IXElk7WaCY7qXD1I7/eLR/Uu+dGXFtGuY0xxvjTRFdqHgyRBCfgoQ
	RtUyw==
X-ME-Sender: <xms:2RWIai7MMC5sZPcWCBfvuBYBFJ88vDqPpEFjIL3geajn-nPt59depxg>
    <xme:2RWIamsXL3xxPy36k7F2C24pdaybOm5MFyJccIQOXb1rsU6TC5nrTvg3D1ase5pmI
    kqabaw2WfbZE9bTF8jFZbMJE2RswhkTdkyZdihuJYEfKUhXzLDUUZU>
X-ME-Proxy-Cause: dmFkZTGtfi3m0gj180tbwYPcCEVWHzTTJPsOFDgjSy7q+BQWXoEw08CBXV/5gulVOK88ZT
    ppvt0cuOp+PfJBs7+6FM0CTkmS7VFa7RrS5sActr5XgDcvIEAsFFDBRwJuebyj8E2JoN/f
    6cG3k+rR/rxK3tWfvXtvVl6CpmL8E8mEHbDklh4fvZJzEx4+VoVf80Rspie2HKkPu6ahIl
    s1+M2LmHYFzar4GIJ9ECBaCfCDj0WDy73FJMTJRzMnmuOIoLK2ZKFI768xLkVvYYIhhBrZ
    J54QoGRGc2FMkjuZ1z9nbnjjsP1fitsw9pzlC1iZeBTtGK20j/0nCzFskStRpzdy7Yquia
    5rNTtfmzBWEs3VYMpKZHKa0oHQFUV6BZLq0+kyLupwSk5tHy0QKjDr+OHfLypcMpC52elI
    gyDLE2ZilS9FvrdvwCWwsegvE46xxLRguxetx/N8udNCp/eED76nAJCilInuoN9LqdhWpT
    +LXpmWtiYjeTqJAQkNWRs0bImmhSdbaoCFlw9ZRvrvCGAziDdbEpkr0WLi0nHxADleEs8N
    PuHz4LsI9TOtIwqhOrX7jKA1YIY/cjbnI/A1ippV/x22CLkMYWoAC/7dhkXjJrXjv9v9NG
    vJT6BrepcgcITXDmPG7ffVHcOPS0ECCj0U1Jrm5/aagvyEI6LTpW2B8jIFzg
X-ME-Proxy: <xmx:2hWIatmaHtyoD_FteiFyWwpiYF3wumffNqVK2CuYLjJ1jNLnN8QXqg>
    <xmx:2hWIamwtDU41Zo-wi07TQnJu2t_Q43qh4FG8R7w9X09Tn52d9pGXww>
    <xmx:2hWIarPcwYPaV4aBarrHRdOtw0gOoQ5Zz6cmOXD4xHwIBVisBuz5dA>
    <xmx:2hWIaqS1b5LjcBzZ2dh9kXdIdPk7rkOqOumpe87QdqosjbB8uQWIwA>
    <xmx:3BWIagzmugybCN4ZEW4Dk2tW2VrcMUBuXiG33HjBAcqcRpJatl-C26wp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 75F0F22C007A; Fri, 21 Aug 2026 05:09:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsP0z-S4Wazw
Date: Fri, 21 Aug 2026 11:09:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <76e81149-4aff-47cf-8ae7-1e781ec2a228@app.fastmail.com>
In-Reply-To: <xmqq5x14tg5t.fsf@gitster.g>
References: <xmqq5x14tg5t.fsf@gitster.g>
Subject: kh/doc-trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026, at 03:29, Junio C Hamano wrote:
> * kh/doc-trailers (2026-08-09) 11 commits
>   (merged to 'next' on 2026-08-13 at 2966f0265a)
>  + doc: interpret-trailers: document comment line treatment
>  + doc: interpret-trailers: rewrite new-trailers paragraphs
>  + doc: interpret-trailers: commit to =E2=80=9Ctrailer block=E2=80=9D =
term
>  + doc: interpret-trailers: join new-trailers again
>  + doc: interpret-trailers: add key format example
>  + doc: interpret-trailers: explain key format
>  + doc: interpret-trailers: explain the format after the intro
>  + doc: interpret-trailers: not just for commit messages
>  + doc: interpret-trailers: use =E2=80=9Cmetadata=E2=80=9D in Name as =
well
>  + doc: interpret-trailers: replace =E2=80=9Clines=E2=80=9D with =E2=80=
=9Cmetadata=E2=80=9D
>  + doc: interpret-trailers: stop fixating on RFC 822
>  (this branch is used by kh/trailers-no-urls.)
>
>  Documentation for 'git interpret-trailers' has been updated to explain
>  the format of trailer keys (alphanumeric characters and hyphens),
>  replace outdated terminology, define key terms upfront, and document
>  how comment lines in the input are treated.

Thanks for improving the topic summary by the way. I feel like after I
added more changes on top of explaining the trailer keys format, it just
got bunched into =E2=80=9CAlso replace some terms [and a bunch of stuff]=
=E2=80=9D... ;)

>
>  Graduated to 'master'.
>  cf. <0687D60D-DF6B-4547-868C-FCFC5B27ECAF@gmail.com>
>  source: <V5_CV_doc_int-tr_key_format.b26@msgid.xyz>

Kris
