Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97217A2FC
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782570972; cv=none; b=IAlnFJaWk6dmc/wfcRxE0fcHyVDaJgDu3MOkdWcX9bBRaKYrIVdS34HBhw0pElsqlHSznJt4ECW2aLQ6GtVqhF2dPDKNmedvQyd1MsJgwGGyr0FMAn+eq8sTLPhNS9lPm0fSVeMQaNjU3rZVu7IL1FTdd8nsPEU1NHYLobUzy30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782570972; c=relaxed/simple;
	bh=1uSWCYQWvcBIhl1KpyeY5WporWkQufTEW7FjBu77zZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGWZjg2RLiUpB4Sn6iiS+SxWJc0jRrN0UcjBUVXk0EIHOkpMJYaexqjSgTAvh2gMoZ2TVPGvEWMGPjGptnWOTR/LOj1I19RrRjjT312+a55XV+dD7LxqD+iCiJnxtAh5hUV0SrCy3sR6o6rA+iwGWkzkbNctIbmNfD+syU+IYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OOA79MeF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bPKYONGa; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OOA79MeF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bPKYONGa"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FB1B1400144;
	Sat, 27 Jun 2026 10:36:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 27 Jun 2026 10:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782570970;
	 x=1782657370; bh=VcTb09NQCGQULB5Azlt0nY1IGU73Pbm4hl0J6oySK/M=; b=
	OOA79MeFP4OskqDPbXzrlvOX0tn65keyURf43F36omj0KSXTRAHYaNWwRfjv0R5b
	doWOWHDF68Y+mcE4f+nsm82LKgQ8GB7gMDFd/zo0BNVGjmqNo9ymc5os+SVPylGY
	o43oWaXPs1Evopj2v36biKWqfD7VdFYyhBHYuGq1Ruqn8v4A+exBL6bfA74jfCKl
	g6fgHxtW7MqEMfOE14JXBK8QeSjzTKzOy1uc+VPLmx0P3FnbBACGDvqP5bbvWff/
	38Nl4ubHZzHeMDBIz4VttQCBvgb2BFblokb/BeQ3E6DKjjTyjX4mfv5Vao3Wwntf
	3z8+tlVyh27kqPb5G+Up/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782570970; x=
	1782657370; bh=VcTb09NQCGQULB5Azlt0nY1IGU73Pbm4hl0J6oySK/M=; b=b
	PKYONGakfoNsZFwN/PQx4EC31qnwsOD/SNkfvmQW1W0CV875TtzV1n+U+UmE5VJl
	tCEMdy1b42paTMEY4VpsK8W7B9swBBXNzNHecAwAbVBCwd9+YtUyX9Q/NZZzUSaK
	HkWw7oIEBrDfE4qf4lkno6P0TOI/8rWxdecxd8zjaba6MzpLeboyBhSfe1wwiOyW
	RX32w3gW68hslMJjCRVvVz5dy7PIO1y3bSUU3kUcgDBIg7EdEt8Ol0BcFXqOFCui
	hzkEkavmISCN/ELnbJqaYP1nL4SvU33W6mN+3dvgi94aIj+cbnlCFY4lqi7j1/Mb
	B+hkemvq8GmlU+NQ26Qyw==
X-ME-Sender: <xms:2d8_am_NQ7r6wUQJ-lO_XJlKNDVK02IEWelvKVlWKIX5cCZ3UlOfMw>
    <xme:2d8_ao82ktw_QAovVwO4F73gvHRE9FJ-6hasqVv0G0vLMXKYOLkadZXNU_wQYZ2uK
    OFMlu-zI9q5VSdb2URbvC-Q0XXY52IBs5uoHjTO071xjtD9WpZGahk>
X-ME-Received: <xmr:2d8_auSQXYDsP-N2M4UTUYZGttlTaDgN_Vpp8E_8tKJqbeBaq4qbl61Ykwrp9MSvpYEG9FWb-R8g78tq8DytRorq9S6FvTlS001-DO4>
X-ME-Proxy-Cause: dmFkZTE04eO5ZVSqX85yxPffXuYvcChhTPV+xuiOiqtcuLgCgRzVa1phuZepcO8HoR9u99
    GfZGnIMiLraf4gYpWnvW8HYkSo9Df87TSG6Y1nN090DIdDqxU4bbLgZ50CNav8eYXIhcTj
    /OWEwdumTSrRuY79xx87mgiBuk/B93IaOC/8B8BCAoFTh5q9eqA+ba4TnB5/t5DvkoJMcc
    NFMw9QCbEmaRy48d1KhRWqO0eknienBGBuiqKji6AN/M4RgxixdtOwJt0BNALR9XBYzypC
    B7nZ3k6lM3pV+ygfnxwe8SxgOLEDJGTPZ1gQzanDhwC1YfD1xVquVwvc7yiuYUT1YAtubg
    VRYYUXU/rfgJBj0KJLRxv53cCCPF/0Up8kX/hKe9ZqH5eQ1RPWWgZlef0+dIm7iBn73fUR
    JiUrLN3mMfpp2cKn2dPJx2RxmczRrCoRXVkzetZTJz59OK4JBGwiiZ/bP3+KDOeGQZsqfi
    xbenlbhXcak7rkHG5Ot8wqSnhd9o0Q7RTzqU9vl9PvO282lA5lV6ej4mYd/bzKEbOnbBTO
    8qsICbmCHhVVnWaqcaSbKtk3oqgkjynpvXod5I57EnXNkV25oNulNfTYuCdU6tUhJ8oKjJ
    39zhuW+sZWMtHWXaIOg5070OVsJr4okcdL5jYp2Rft7XZOcssB0aEygz5pBw
X-ME-Proxy: <xmx:2d8_akf34pB7HyBk09WPiMaf7a4SO3VKdUq_7nPljF7LWmMD1samkA>
    <xmx:2d8_aqDn9WmFWE-dj-6BvTpcGw9KKAUQ9IA8jna6reGBYAOWzLuwrg>
    <xmx:2d8_aum-mqVeboymH9vu3rtEEMASw-ekB5WH7vvU-PbuZngRiY8SCw>
    <xmx:2d8_atf6Dgtf585iDxlj0xflQQovroBBVLGFRNC7yRLaMyo-9jHvbA>
    <xmx:2t8_aqKHn6kSESPu3HF7kh7y2-Qhh6DKjvhrGqKRqMdAceuDkCsw8nTH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 10:36:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Michael Montalbo
 <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 5/6] t: convert grep assertions to test_grep
In-Reply-To: <aj93BE8MYatQAjoy@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Sat,
	27 Jun 2026 09:08:52 +0200")
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
	<pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<3a589ef7386303075413f388e61c203c4e325d44.1781323575.git.gitgitgadget@gmail.com>
	<aj93BE8MYatQAjoy@szeder.dev>
Date: Sat, 27 Jun 2026 07:36:08 -0700
Message-ID: <xmqq4iio59uv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> The conversion was generated using a grep-assertion linter
>> (greplint.pl, added in the following commit) to identify bare
>> grep calls at command position.  To reproduce:
>> 
>>     # Step 1: mark bare greps that should not be converted
>>     sed -i '/! grep "$m" \.git\/packed-refs/s/$/ # lint-ok: file may not exist (reftable)/' \
>>         t/t1400-update-ref.sh
>>     sed -i '/! grep dirty file3 &&/{/lint-ok/!s/$/ # lint-ok: file may not exist after --quit/}' \
>>         t/t3420-rebase-autostash.sh
>
> I think in this case checking the file3's contents is wrong, because
> at this point file3 should not exist in the first place.  I've sent a
> patch to fix this long ago, but apparently didn't manage to follow
> through back then.
>
>   https://lore.kernel.org/git/20211010172809.1472914-1-szeder.dev@gmail.com/

Thanks.  I guess the test_grep can be extended to catch this case,
where 

    test_grep ! -e pattern1 -e pattern2 file

does not find any hits, but only because 'file' is missing, as an
error, just like "test_must_fail git foo" that segfaults is flagged
as "yes, it fails but that is not the kind of failure we expect".

