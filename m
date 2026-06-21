Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E74F1D88D7
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782014285; cv=none; b=VoO/iyCibtbkHBmrhrqo86GGtilk3JAtlz2ZstY9ahHwcy+ajgo6RbzBlr3SLTngsXs6kD41g4Q2F982P8V8HVLJv9GhpHEJFdRtvgBR6QSHXwWkgKZBlvgflXU+Yq1SJYbx8lZlFU4OysBKTy8GahrcQ8A4YoIw+ZQravmWgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782014285; c=relaxed/simple;
	bh=FthS78ez1RGxKmR7yLrKsF4xVNUz955Con2BFUkwrek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5veqjV32O6mE08TpOr5r8SyldXxoceT4ybeLUXECluOvhQJC9MAXEsxDm90SI/jRMmsTr9P5f+w2JgzLwL6PAYIYgpVx+gyVT1CEo1/7B8U0QGEI8+QmLtKbxpTFrX4yNL7ssah5L2k5/kGCvkApbwPpt/+sKUDY70/cASRC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HAWuQqdR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYRM7JXC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAWuQqdR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYRM7JXC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D1CBEC02D9;
	Sat, 20 Jun 2026 23:58:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 20 Jun 2026 23:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782014282; x=1782100682; bh=YxxldZWeOz
	AU0/TY6YU4rdifn48FkrvI48XYxIWkG0k=; b=HAWuQqdRBMiHP6oS801enKYsQ3
	LCnmM7LJoML64g53spDz1uXR+OO8o4bfn3uON1VCK8aG/DL4ViVDS2wfGJwCOCe5
	2qRDn/3AL8P6IIEbdlJeEGc7WrJbUoiuX1v5RKrhh0YJLhXkzXwZl7q21jrNcr63
	Qm993WJp/uYJgTkJCYj6sVnGNkVwaGIxk361Ade2V8shi4ZuIm7bCuwx1yql9i/7
	fhC+B30c57MRrLHWy9Uigfod+m7f6EHMe+DiJSfs0UQ9qhCIZ5bVyHRIIsdI0xjs
	nKW+bIHZ3K1nwrhwAT4I+Wjpgw6HLnJiknIjLGILoBZRKOxCK0kcdzO50bcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782014282; x=1782100682; bh=YxxldZWeOzAU0/TY6YU4rdifn48FkrvI48X
	YxIWkG0k=; b=XYRM7JXCEoqa42dghXBZ4QIBiZB/OZGZruVHSani2D3jV3pmjU5
	fBm5pXtQDNbmq+7whF7rS7Stp7U0Jf43KoK6gtLAOSWddUQXMfsCUH2qvEU+gua7
	IdvucnCRq6BDP1Opxb8uS2neiPTusgBBlPQ8AKisIuVGxVthsZbIf2R5x66RLcaF
	okz8q//pbJtvk08xMJYFwQGGudY11EP5S59hSnXTVNtKSaDuBkDlqcttQfuu38M6
	7EYTpi6rS5P206JuLHl8+TluKad6mQt3nebYj1QGpdDXOD8onNTiO+mnewiIk7Dc
	weToVaav7Lds4rJY3goUoaHRHg1FWb2foQw==
X-ME-Sender: <xms:SmE3apQsON2k5djIl7vq5BMbg9GiXLxkHInTIv_hIBEH32cNnox-cQ>
    <xme:SmE3apyzlnwmNp-OAPt4vkpgTdippt9DOXd7nvyaxLe3RGypAcufjBV7bxadj2Ros
    9bsDxGyI4Kv19Pt6mFDfZocO1ZJ84GIC8ghy5FFSN3nUxP-InEpTQs>
X-ME-Received: <xmr:SmE3aj2vQrtMfPD1KR3oqGNYJObNZPzkccVMYwbidqzuPVyidV0tsT_J7g8lH59EtFsqRkhYOiOLA5NSoKLAL7ssG84j4x8r6Pvs1gs>
X-ME-Proxy-Cause: dmFkZTFle4VsYJ7FG7Ri0LdA+GFuXv0UQHctdVtocGsfPwxs3gW2RaLDaimv2XlTWHzRKV
    7FMFC/J4Xm5V8TmliZBxjwvRr896gZv16DEcO74QYwKAORMVR/ogLtUQmNVtTPR1PYEBfa
    yydXRL2PG9z5qWWX9Eg+MbKYtnnFYsHJ10MjseUmYaWZFmNYYjowPl9S9GcIOMq76aMWdH
    VxaWPqb5sDY7hAjooLZKp7zbqwdSikQXxszvdWfPoL9zQ/CGT+c4Ukv/kJv3j6gXVnW7mr
    Dwy8BwkytnJ+cO7fWJJUPnoNuwNXODas8b15fsgVoePubazRqNSWOk8v6vzwAIXsytmjBQ
    Ztbi3bxe9xjQJGvyY+vMyQQkqOyj2VWWqfNStbLtElARDsJlh2IpYvj7cnyQJw2eeeo30x
    cc96QfjYYn8trL++rbo5rY0cyiSkhc1o4A7Kb60Cx8+fNMF/61vNB047PQbmmzHtoitNDB
    Bd2gJhEmfKhgfMYmqcdGbQ7sH8K+UDobDwu7IM1NA/owbbirX9l3rPigpEzkM5RUCXoUft
    /4k7icZHsVJt44IGgJu96IY9ME6JyokehA6SJ+lKS5F1Fc6cPHKOn1hKAH9zr/584Rq5MD
    uZocWrhVqq4Cv937JiLlqU3TFtBwHVM+vs6AnqkeIDXz5zCNl6GHnWd8QrPg
X-ME-Proxy: <xmx:SmE3av54MfDYJRgJfpexXmSOCp9uBl9pwWIwJ8I3Ho-4SZjNaJdpNQ>
    <xmx:SmE3auXtLTN1Qusbkq6s452fJKi21-qFzNhJL3XlOAFqxhmRg5doEQ>
    <xmx:SmE3amBW_EEmvPSp-iVDQhl90Yhc9SOtbHB0T2YVcsuZ3ctPLIx3tw>
    <xmx:SmE3al4adjamdxl2lY8QRpfMkuRpqrbGD2GmsJCiCjKtTD1O8MH28Q>
    <xmx:SmE3aly3JoaQzI3Wi6njCiwm2fpZ-QyJi-LHhxlteJ6Ss9h85pBmgt5f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 23:58:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Jeff King <peff@peff.net>,  Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
In-Reply-To: <xmqqa4sog1e9.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	20 Jun 2026 17:53:02 -0700")
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
	<20260609001134.GD358144@coredump.intra.peff.net>
	<CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
	<20260611085526.GL2191159@coredump.intra.peff.net>
	<CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
	<xmqqa4sog1e9.fsf@gitster.g>
Date: Sat, 20 Jun 2026 20:58:00 -0700
Message-ID: <xmqqse6gee9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I initially thought it was an embarrassing thinko, but after seeing
> how .skip_stat_unmatch is used as a 1-based counter (i.e., if the
> member says 42, it means it saw 41 paths that were stat-dirty but
> without actual content change), I do not think so.
>
> Now, it is a different matter if such a "dual" purpose "more than a
> simple boolean" counter is a good idea.  Apparently it confused both
> of us in this case ;-).

FWIW the patch was done as part of this discussion thread:

  https://lore.kernel.org/git/20070830063810.GD16312@mellanox.co.il/

