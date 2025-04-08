Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB022DFA9
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133829; cv=none; b=jiHVbCc7QtQVe0fY1DLBc98vzWRjOudjLo1x4gauGWGya1bzSRbaEK1FJz+0YqXSBGw6EMG3tomNltOiBZmpEqSYI3wi9s/FSEjo84IFtaOf1YROHHUwuEWQcwzpbi4Ym9hAKnAC1eMiOZPjFb2hf8gBeNc/z55I6S5w9pwvv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133829; c=relaxed/simple;
	bh=6tzxcHWPkQZ8miSg/q3XwAtEieNBUW9bvqTkcbEgDiU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qN3gpgTcpm/jnefsqQuQQMGtf1akI9TsKhPRp0LX2oZvBozmjvprqFMrjdo08ntIah3+7V1US0H6c1BLM/SflpHgYkXcnusLKKIkGztIWS3Iohw0hy7Be89yHHk1FUcK1d3wWUKBM2kEwwUn78TjMI7TijvrAVXXhKqS68qZ978=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mbZMHZkH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R5D3doF9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mbZMHZkH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R5D3doF9"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 074D511401C6;
	Tue,  8 Apr 2025 13:37:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 08 Apr 2025 13:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744133826; x=1744220226; bh=YI9RXD4abI
	lmk+CNsRR7sO7a9uQLbrtF3yoQRK+xmGA=; b=mbZMHZkHFQ+fz1ip5RpYMKLiM7
	skYBXGuyt4Cwq6ivyRj1ZNyck5MWMgBQyA/I92VFEpj3AxX3YDBfb2Z0emF3kwxd
	AD47IaUwZcy3fJUtZTp0S+3qsP+TPkYsqYoRmgI0d8FpdZtqG4orq8H/eAE5QzNk
	YnfcCaHK3KgVtKR9FbM+jVJqlkykoLghn8Pmo08reyniCBX9cMPEZDmi/vpC7l6Q
	m3W+JV/+/NT4uLt7OkIePCn9NdxJHxLj+1KmZOC8BwS25aphx5O9WUEFUY70jATo
	iXNE5XUvnw+8BgmiVo2VGjBl6Wzrr/UIQPXM/SUA10AlxL20glGb2gDNNn8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744133826; x=1744220226; bh=YI9RXD4abIlmk+CNsRR7sO7a9uQLbrtF3yo
	QRK+xmGA=; b=R5D3doF9ldmQ/RR0QBEVA3HFg4Lw2d9oWHBJeWiG+/66OuRRpD/
	uX7rrq3hmUqMMIIOxW8sJS5PNoijRmiRIXnWRSHeuhc8j55YzGEd/pl+PFMW1RSI
	3jliS5drFvwAJaQjlV1BRa7Y4aX2+yJ4PPc2f4PntY98TcezAsAFlCeO8cA7iw7B
	qnoDFdJRGYcqoXYTE/hAuPlr9I3qPHLu+MKF9+bm1526y7+aBPsPxdK2G8gLdsdr
	x26K9ZKd7fqH4mQZV2vPPiaWhQh66ME1+28eYgF5g96543QlpZtl4jOZXuMSz7yv
	Vg8xIiKk4iRvbZMtScCsh4sMSyMdmJKG8Lw==
X-ME-Sender: <xms:wV71Z7V2KGDFWKS4ZYZUwbsvUL1HGmc35aQuzGDcM_EkgqZc58Jekg>
    <xme:wV71ZzlFs_gplqtx4DAkF-0y9acT2DNatDLOvOmUtcRGJMZoMn-B912roUx_WoswD
    pBFAHQ2kEjKyet2wQ>
X-ME-Received: <xmr:wV71Z3YHcirVFE2DjsaeyflzVtvumwIgD5jj3k3iqXickOeJYf5eNX3e9GipXS-Q4On_8BoKPboVfSKAwhiiPi10hdfjimFTuShK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdefjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggv
    rdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wV71Z2Wd7P7S_PNTnGmJjr34hXoyRSINGGGHaP8DPcW6YKTccK3jrg>
    <xmx:wV71Z1mGhwtNfAw39gSle7D1XxYkjleldOLO_9tt99iXPuM-vcDgTA>
    <xmx:wV71ZzfGWjRFP_dI1QzCurK8Y5EQlbxf2sEty11cD0CZL9MyvrpngQ>
    <xmx:wV71Z_FgDbhnz6zPVqSsChoGLBB29p2V8iz6vC7mIjkoX76yo-69EA>
    <xmx:wV71Z1IUsh9xbDe0WlDRmiy_hNcJpI1_1TQb_QAdHVu-NhDvnbmx1gna>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 13:37:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im,  jn.avila@free.fr
Subject: Re: [PATCH v6 8/8] update-ref: add --batch-updates flag for stdin mode
In-Reply-To: <CAOLa=ZT4fOz1sd31EhyLGeyQzS6GO0aSYN0L4fdPALRixkD6xQ@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 8 Apr 2025 15:26:28 +0000")
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
	<20250408085120.614893-1-karthik.188@gmail.com>
	<20250408085120.614893-9-karthik.188@gmail.com>
	<xmqqfriiy9vh.fsf@gitster.g>
	<CAOLa=ZT4fOz1sd31EhyLGeyQzS6GO0aSYN0L4fdPALRixkD6xQ@mail.gmail.com>
Date: Tue, 08 Apr 2025 10:37:03 -0700
Message-ID: <xmqq7c3uy2ps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Content-Type: text/plain; charset=y
>>
>> Please don't ;-).
>>
>> More practically, is there something we can do to avoid this
>> happening in send-email?  It may be a not-so-uncommon end user
>> mistake that we would rather help our users avoid.
>>
>
> This seems like this was in response to the following question:
>      Which 8bit encoding should I declare [UTF-8]?
>
> Which I should have just clicked 'Enter' on, but typed 'y' as 'yes
> please pick UTF-8'. Which again confirms the encoding, which I
> presumably didn't read. So I guess the problem Exists Between Keyboard
> and Chair.

OK, we have seen enough people got burned by 'y', and made 852a15d7
(send-email: ask confirmation if given encoding name is very short,
2015-02-13) as a response exactly for that problem, but it is not
effective as we wished X-<.

If there were a better validation method than "4 bytes or longer" we
currently use for valid values for "charset=$auto_8bit_encoding", we
could lose confirm_only from the call to ask() that asks the
question, but I do not know if that is feasible.

Another more obvious alternative is to do something ugly like this
patch, I suppose?  Just like <ENTER> is taken as "I take the default
value presented", this makes yes<ENTER> mean the same thing.

There is one question that asks yes/no question with default set to
'n', which would be broken by the patch below, so it needs a bit
more thought, though.

 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/git-send-email.perl w/git-send-email.perl
index 798d59b84f..8b942e5bcf 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -986,7 +986,8 @@ sub ask {
 			print "\n";
 			return defined $default ? $default : undef;
 		}
-		if ($resp eq '' and defined $default) {
+		if (defined $default &&
+		    ($resp eq '' || $resp =~ /^y(?:es)$/i)) {
 			return $default;
 		}
 		if (!defined $valid_re or $resp =~ /$valid_re/) {


