Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446AB24466C
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372972; cv=none; b=sXN8V9pqoinaktrHcZAkYZJ0lagEHxq0sQk2VfwRVSzvbZFXkj4bxLXqFT4AiwwXnLx6cmzHZ/I/+TeZeL1mp5FpLD4US/5nboOEyZKPLGcLk7NFQl3Qlc5vdB5p8sxU+q8AU/upDsF9jLgYvrBR1SuZrPrpG56rRgK1kuHa5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372972; c=relaxed/simple;
	bh=Tvrv1Uoiq1cqiw0L+l98y0925ekEvpquhOjwRf366gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MGJUGLNUfsfKunk3AFX3SYDY548/+126ItNtQMJIc1SI25eufM7whSw/812vmixbb+bgjXnl6kqSQX6dz/g18GKYtUUpMxcQV08FGqHNnhHRg3aIRUJX0B+8beMrYYnGrzrtp7E76FH1yS8sN7NiU3WSwGPZudD484gl3NOzULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IKYfdPIG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UT1caYyX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IKYfdPIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UT1caYyX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3B95814000F4;
	Mon, 13 Oct 2025 12:29:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 13 Oct 2025 12:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760372969; x=1760459369; bh=ZL9mPzliAL
	633acenbdekWWgGcmfDqlCeY4toKGCVb8=; b=IKYfdPIGG9kg1LwLCANXKJnmwF
	oeibZwCtZfI4AS/XWk5mJwdAhtZkhPFRS2HsJvDj0+iN7Sp2T7r1RW83US8zd0TY
	QytqzMujHX9O3/j9y/E4sVdJZGNeNgr+zZq5KJYXrhDZBnJ1/WDzarj8qwvdJMQU
	uRej2nqhC3kOM9+XTOjWgCP9q14VkMQ9SZHQZB8i7tXn1iMtu2yDkNi4HLPyfdIC
	bsBcOOD5C/Xb8V7gblgJIoDUDFPILEGy+1ZUBFPg/E5LTxv+nugYk8cGIMP5V/OV
	EdAyJxZ0aGdpnMKXWIMT+MDzvxpcjTe99W4v8lX24mB1akxUsb15dDCL9/FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760372969; x=1760459369; bh=ZL9mPzliAL633acenbdekWWgGcmfDqlCeY4
	toKGCVb8=; b=UT1caYyXK25R3lVf5T8NSGFYLA8sd+dGZ78WlqKMWbdBY/Q026L
	3hL/6k1iiDdCLuA4rdItmDGlfzmTTr9gjv+iBo68lsG9qMzI29vkaGzaY3xNbyhj
	bH9jxs18fWeVWw7NttEYbGrXxwfAr+RcQjGNibhE5SKdCKFGABzTV0KQrWdvHvLD
	IPeCS4NV0/OdHKB4UUo8RCtZS+u7K9dCGDYSnQHkNxp0ZNb3hGBF4mE1JMhKpLDr
	DzwU2dOpEd7dmBMIcStXkR8hdtejcGTQAmQXKjCC/0NiT4dLHnTkqEel7DkSAqUm
	94vFcJte4Dmaqn92zZTEWAygS8qPvvV8v8A==
X-ME-Sender: <xms:6CjtaF_1fytwqOL0RWPFN1NS1CaswJBuhITS570PdlEloe5QmnxLvg>
    <xme:6CjtaAm6ryx-MreNig_U8pZ3v3xemrmWMSfYSlHy_YCPcqb_y9fIsksVCDsQUWvL1
    yXwEo7-C90P29YIFUiXgZOhXPalLXhNmFbxnm7ABkhdrUWtSSfSow>
X-ME-Received: <xmr:6CjtaLXeVNl9dpZwFA0oQVZLSmb5uVUUzO1kYc2jzqO3GVFMEy6gW06BMhwhNsTYH_2eu6rUT3dpliOgtBFQQEhh4YlZVSst5oWN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhn
    vghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:6CjtaFGbtpMQnoXYJvL5WsrYHroXYHUlNNYARtFX-h5XuSxwqVN6gA>
    <xmx:6CjtaHekDJaZ0gTVW7wet2S-r6ZqBe8qBtxDpQwovCVa6KsS6w_00A>
    <xmx:6CjtaGJK1RL_gmITEHFAlqy_Hn5H5Iifq_IYpCe6wBCNr0KYEqLu9Q>
    <xmx:6CjtaMH_NYoW08R4Y8yQKVvszP3JZr12LM27NJcY2mUME4UZR403vg>
    <xmx:6SjtaKak9AluePh7TLwhmQVkjRgjHHy2q6zpRTXU7q06hrzDoSgPIfTo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 12:29:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 1/2] mingw: avoid relative `#include`s
In-Reply-To: <e593886e-eeb4-440f-a317-a2959577e1e3@kdbg.org> (Johannes Sixt's
	message of "Sun, 12 Oct 2025 13:45:50 +0200")
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
	<484ef8b825e5d1d68a61f0f8cc2520457e8f4f3a.1759995961.git.gitgitgadget@gmail.com>
	<e593886e-eeb4-440f-a317-a2959577e1e3@kdbg.org>
Date: Mon, 13 Oct 2025 09:29:27 -0700
Message-ID: <xmqqa51u3guw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Why is this needed?

;-)

As pointed out by Matthias, the changes in the posted patch are not
complete/comprehensive.

> With #include "foo" it is quite clear that the file is first looked up
> from the directory of the file being processed. The changed code
> requires that the top-level directory is among the -I directives of the
> command lines. Then it would be much more logical to use #include <foo>
> instead.

I actually prefer that, but that is a taste thing I do not want to
impose on this project.

> So, IMO, the status quo is perfect and does not need this change.

I tend to agree, but it would be a waste of time to further discuss
on this.  As long as it does not break compilation, I'll just let
the patch graduate.

My preference is to 

 * always name custom headers using the path from the top-level (we
   use -I in BASIC_CFLAGS exactly for this purpose), 
   e.g.

	#include "compat/win32.h" (good)
	#include "win32.h" (not good)

 * compat header that aims to replace system supplied headers like
   <regex.h> should use -I appropriately and appear as if they are
   from the system, e.g.

	#include <regex.h> (good)
	#include "compat/regex/regex.h" (not good)

If somebody truly wants to improve things once the dust settles from
these patches, I would appreciate they keep the above in mind.

THanks.
