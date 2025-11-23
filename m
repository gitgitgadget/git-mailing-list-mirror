Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF71FDA92
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763865322; cv=none; b=WRushP2fg+rdNWPx9TQQartxN1Ga7lLUTal/RDwMwonnBCvRlsN1k8AYZO3KfFNd7nnodkQmRkEuf5Qxphk8JourcsCu4l/wVcjP/iI7wUtcgPR9mnv3p3fPN/1NLEOVZfRW74QQKScPMD/NRYXx/gd4jAz83NCOgj9u7TFsXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763865322; c=relaxed/simple;
	bh=azFTwQEn1dLHbthV2e+y8l8dvgmb7xe4HD7lNuWK7VI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5IUafbqVwnYyidiyNyVISbXmQJVLx6ZrfE4CZE74YiEmarWiLAxKGgNVMthJD6Ik/XPt3FSZuJ39T/c34M0b7XfsWjgGN/UHnKd8wmfwC+theiye5J8dlkk9JsJbigNXFG0JllJuyAmMI/pWaWKDgEmPHqrPzuPPTOE5R8vsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V4ya9dq8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZrmwT3Ap; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V4ya9dq8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrmwT3Ap"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 15290EC010D;
	Sat, 22 Nov 2025 21:35:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 22 Nov 2025 21:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763865319; x=1763951719; bh=HwREYzSyhS
	aYQicWr3PZA1PFwtE4kr9GfZsSS8HVYeE=; b=V4ya9dq85+BtZJwg6Q3MIzGVL9
	xc3TPoFbfYzMMdGK/5gD1AoLCfqhv4N+lw9TmRyOxMgqKQTsvVDx2Hf+81ZfhBIC
	MINsCg/SUTn1z3TvtRUUQilRpmw/eNsKTnHct/3w+IZYDIx8/6NO79bqwgmLRgCJ
	5oASFwYkHvT1tsISgwNwh6AxWyFVWQlK05T+dj0l1vEh1P/gplxOS3HwV/spLu0V
	HHJCtSgTkl6liry7jFc1sNjwwllv1Xqjd8yxcN642k9AER94FZ1DVuaRREMBnOEP
	GP6E5RLxCBmln1HmqZLjiDpcjtwOyqTt3yeNRYw5b1J+8cS2nxeq23cx4gRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763865319; x=1763951719; bh=HwREYzSyhSaYQicWr3PZA1PFwtE4kr9GfZs
	SS8HVYeE=; b=ZrmwT3Ap5P61eO9JgpZIR2MHo7qWL95t7FVcP1zbGT21K2h4Wdb
	6KWrcYb/qIRigpg1aFNWBjoLrFD18z2syr4sG94YgZAqyFQhkj9z5UNmhvej5+ce
	yayjwp55v3Du1pc7v18vRecxsOe0AHrp/ScRCDMj3+e3xAt/kNbXZtJoYr2VoRBZ
	DRPdy7vWEJybbE752vexjWOCDC3jQmAjcpUj7iWHOVSWXSdR7a2oxvtlYZXCeNEQ
	Oej2qI0DerFWKq8DujQzXLjk9kWOPoj1Cx0pYbxJXnti1qHIc3Wdk9zOnJ68YKGu
	N2HV59qxtgIebdXRqnjSe4tiDkfsRu/NHOw==
X-ME-Sender: <xms:5nIiaa4oeMmQyfkNq5qoohCJTWfQYkpCQbaHTdLDC5LbIJK2XDxb2w>
    <xme:5nIiabWd79K0OfIGFHTuwYKOo-43LfFNWPHkOKi5ucWFcmkH66Fngc18I9-_1qCKa
    Y9vu2cJfhOwankPup-WwFW4SUlvPagHGFjMIgWanX_rqJh_8O6MvA>
X-ME-Received: <xmr:5nIiaW3MEKWPPkFC-MW6Nm6Utk-WebAjad8Nolhr33tvb73G7jTpvPUS8ONrVKW0V1gMV1K1GaD9ErXcE3_mf3mJN6ofehcwOpIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5nIiaQ18F0NnetwyypqfQswBpK1BArRNANy4CZffjvD8dK5AnfOjgg>
    <xmx:5nIiaR_70Lb58L5IKHdxISwICcEJTdM9xo-m4k-lPMF9EU7S7iEWRw>
    <xmx:5nIiaV1HvgWRQ8idTCbpeS_1VLexfLwOzbXZsE3qub8h1Ro5JxNGqQ>
    <xmx:5nIiaW_6sEOA-9E97XgNF9HcLMEK-Hlor-j5HATaHyVP4wS0INHSFw>
    <xmx:53IiaTWc0lhLP10T1Kp2qqCCd1pcMUUFOp3Pbr0B5L8l_X-IV_ipSfXo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 21:35:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 00/12] Incomplete lines
In-Reply-To: <xmqqikfck2e2.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Nov 2025 08:25:09 -0800")
References: <20251111000451.2243195-1-gitster@pobox.com>
	<20251112220258.1009253-1-gitster@pobox.com>
	<dfdbfb71-2d3f-450e-bbcf-95ecbead3292@gmail.com>
	<xmqqikfck2e2.fsf@gitster.g>
Date: Sat, 22 Nov 2025 18:35:17 -0800
Message-ID: <xmqqzf8d1noa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> On 12/11/2025 22:02, Junio C Hamano wrote:
>>> Changes in v4:
>>> 
>>>   - The preliminary clean-up for "git diff" in [04/12] no longer
>>>     "corrects" the code that updates the line number upon seeing
>>>     "\ No newline" marker, and leaves it for later series to clean
>>>     it up as #leftoverbits.
>>
>> I agree it makes sense to leave the existing increment alone as it's not 
>> really related to this series.
>>>   - Our house rule updates in [12/12] now forbids the documentation
>>>     sources *.adoc to end in an incomplete line.
>>> 12:  068229790d ! 12:  cb86d9b45f attr: enable incomplete-line whitespace error for this project
>>>      +-/Documentation/**/*.adoc text eol=lf
>>>      ++/Documentation/**/*.adoc text eol=lf whitespace=!indent,trail,space,incomplete
>>
>> Should that be "-indent" c.f. 358e94dc705 (.gitattributes: remove 
>> misspelled no-op whitespace attribute, 2025-11-11)
>
> Oops.  Thanks for spotting.

This has been locally corrected.  We saw no other comments on this
iteration, and hopefully it is not due to lack of interest.  Let me
mark the topic for 'next' and merge it down.

----- >8 -----
Subject: [PATCH v3bis 12/12] attr: enable incomplete-line whitespace error for this project

Now "git diff --check" and "git apply --whitespace=warn/fix" learned
incomplete line is a whitespace error, enable them for this project
to prevent patches to add new incomplete lines to our source to both
code and documentation files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitattributes | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 32583149c2..a8e2950a73 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,13 +1,13 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace=indent,trail,space diff=cpp
-*.sh whitespace=indent,trail,space text eol=lf
+*.[ch] whitespace=indent,trail,space,incomplete diff=cpp
+*.sh whitespace=indent,trail,space,incomplete text eol=lf
 *.perl text eol=lf diff=perl
 *.pl text eof=lf diff=perl
 *.pm text eol=lf diff=perl
 *.py text eol=lf diff=python
 *.bat text eol=crlf
 CODE_OF_CONDUCT.md -whitespace
-/Documentation/**/*.adoc text eol=lf
+/Documentation/**/*.adoc text eol=lf whitespace=trail,space,incomplete
 /command-list.txt text eol=lf
 /GIT-VERSION-GEN text eol=lf
 /mergetools/* text eol=lf
-- 
2.52.0-168-g07aa2ddc22

