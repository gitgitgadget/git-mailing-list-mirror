Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7E2DECA5
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924974; cv=none; b=DuXHIVjX6Gplihw1evELX9aU73sG21mQt78KA0eVjHSIBNxQ8LbyUV4cn7m5zoI6aRObKtaHPE0Q3T0GsqvW8qHn6GRrV965cxwvDNbuKSMNpR7TYBU1Ki+4tzHtG+8OKQyJXuxousJEBp173iWu21tO8m+xs5EjuSyzEHeUBlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924974; c=relaxed/simple;
	bh=aqWP0ou24qpaedYbT0drc0Nlm/idtOlR1ex1XRcpC40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sY0FcL2zxaycSJXyKad7qVzhQTU27KFpSRELYRiVJ73PdL/Erg00ITDFFcqlk/isRP+LJwwb2wa52ZZE3uLCNCwfMakO3hgHls7vHThmEM1od1ozoVTQoumkoKXnFjqRmir4PUSW0aPsl5sZkipeq9Bjs9wKSP4sUXUMO5AMk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WVu4jhr+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoFeQD7j; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WVu4jhr+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoFeQD7j"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 114FB1D00033;
	Mon, 11 Aug 2025 11:09:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 11:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754924969; x=1755011369; bh=JDs7OAs7pT
	nAefoTrTIzJ+aEC29Qw0cdaZMdr55X1CI=; b=WVu4jhr+65LvhO6hvUTwHxtBPL
	XJApdsg5ergw+QMBBjPNUs5mQpRi1l9CXxwu5yMrj1Pqyb5AylNzV9cDdvGFJ6Up
	irKjonH6T8ZD3sD2xT3T9ha2wrlDzd0AgFg7XPQpISrtD+Czj2EwT6BJ9Th6yiBE
	waN0GImjZwcwCDVbAN/Z03qW+PjDPG+/hpvsjo22POdkeccbU3CASwr6XjfzKKop
	TwiRYUmest2z9jy7ni2bQUU+05CptKL1e7xiDHruy5FuKeDiNZ6BIzMUWsZHvZFM
	JNOxM+CHnqCDTvsd3iBL2v1HM+DQYKFjM/2Wx0kslFFUMlfdDukedNcguOrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754924969; x=1755011369; bh=JDs7OAs7pTnAefoTrTIzJ+aEC29Qw0cdaZM
	dr55X1CI=; b=KoFeQD7jhHVCxXA1kpdTXoh4F2s2GDp5/DfFtO5j4gzg1CPmhp4
	wb/feljVVs3ynEIBaKMejW8rSRc2heL6LcosADTR/0iR9LHq/A80JtM8SQ1qbJn0
	0UE0TK6G1OQoVc458skn3r3qYjbxEloIA2nhaFlnRNJk4Xc2YYT2eOJFs7ESQj1Y
	Ic5DpDXF8EX3E8vuEOJ667+bvV0wpN8Q36uBxXUGzDWtUKSxNloJQqy3mIHZKGTK
	tBdFXWOhmU5S14s8lJ4HCE1mDUrLx9QKYbTqdRH8kepmU4WRdPRTg93YeaBB6D/+
	u2HgOIXeJSWJWQBa632zQg1nyBj3tmnjtFw==
X-ME-Sender: <xms:qQeaaBo2u5R4-HzIr305lR04KdEypXihkv9fn7wcbzdSNSTtGfLq4Q>
    <xme:qQeaaLboE9u1OxWmduSdd45YBKnMwqhekHVm_OACTkjsXwPqkYd__qjgx0hGmKzK9
    xxIOZOlhrZsW1Cw8Q>
X-ME-Received: <xmr:qQeaaBQVt_BTMgw0UqZxD9pKKYOxTPnCPBpgP4lnx_4plcgZFoZ3kp84xQqCUqeIW8wFh95v7xTPvCQKLhqxr5pbr-BrtOyjmFIm3w4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelkeehhfevtddvffeghfegkeehgf
    ektdfhtedvgeetleduvedvvefftdehkeehteenucffohhmrghinhepohgsjhgvtghtqdhn
    rghmvgdrtgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhosghoiihosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qQeaaK5y5cuCwOeYe2Gau98zEw2-KGZVmmttt_wSZA7eBEg82cz3xg>
    <xmx:qQeaaOwx9f9e0uHqXKYawVk4KGZgTrDH0TOchg3IgqGO5wyb90PpaQ>
    <xmx:qQeaaBQK_1Z7nV40Rp_OEWPomSK23fe4OXSgEwOUm1EAwLR6KOu97g>
    <xmx:qQeaaFVQ_z0CwT9KIhH5C_-pvMgp3ER7RTxqAAuZdTEBYJdxeaSSPA>
    <xmx:qQeaaNWpNr66TsL_-w93QgSQ5U3GM6EXmeId6VyMesDwLtaPYI4aSMaZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 11:09:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Forrest <nobozo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Minor Bug in git cat-file (git 2.50)?
In-Reply-To: <b37629c6-b730-45ce-b839-e782aafe238d@gmail.com> (Jon Forrest's
	message of "Sun, 10 Aug 2025 07:52:42 -0700")
References: <b37629c6-b730-45ce-b839-e782aafe238d@gmail.com>
Date: Mon, 11 Aug 2025 08:09:28 -0700
Message-ID: <xmqqtt2d51zr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jon Forrest <nobozo@gmail.com> writes:

> % ls
> 981922613b2afb6025042ff6bd878ac1994e85
> 981922613b2afb6025042ff6bd878ac1994e86
> % popd
> # use an ambiguous SHA1 prefix
> # why does the next command produce two identical hints, both of which
> # are incorrect?
> % git cat-file -t 78981922613b2afb6025042ff6bd878ac1994e8
> error: short object ID 78981922613b2afb6025042ff6bd878ac1994e8 is
> ambiguous  # this is correct
> hint: The candidates are:
> hint:   7898192 blob
> hint:   7898192 blob
> fatal: Not a valid object name 78981922613b2afb6025042ff6bd878ac1994e8
> # I would have expected:
> hint:   78981922613b2afb6025042ff6bd878ac1994e85 blob
> hint:   78981922613b2afb6025042ff6bd878ac1994e86 blob
> # using the supplied hint doesn't work, which is no surprise
> % git cat-file -t 7898192
> fatal: Not a valid object name 7898192

Fun.

I do not think disambiguation code inspects object validity to
filter out invalid one when computing the shortened object name when
giving hints, so one of these two being a corrupt object should not
have anything to do with this outcome.

Perhaps something like this would help?

 object-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/object-name.c w/object-name.c
index 11aa0e6afc..13e8a4e47d 100644
--- c/object-name.c
+++ w/object-name.c
@@ -704,7 +704,7 @@ static int extend_abbrev_len(const struct object_id *oid, void *cb_data)
 	while (mad->hex[i] && mad->hex[i] == get_hex_char_from_oid(oid, i))
 		i++;
 
-	if (i < GIT_MAX_RAWSZ && i >= mad->cur_len)
+	if (i < GIT_MAX_HEXSZ && i >= mad->cur_len)
 		mad->cur_len = i + 1;
 
 	return 0;















