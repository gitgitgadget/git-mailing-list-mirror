Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC8EC0
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741996989; cv=none; b=XCJ8KSKg8n5CA+GJfQ4jpc+3yPUTJSaSbJ9yLthCrMTDHxx8ayv45UQ6EkOATNw/mmz8JceodXyIwxe0AkZk3viZiZ2MUwHNc68+EXtX+kjwjY+jYuyn2p6O26IQto2Qb1yRO8gnEloVs2d33wv5E483O1lXokDDtdoOnGPojj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741996989; c=relaxed/simple;
	bh=HUxRg4doIoQC3wMIkFN2HDcAPwESQlC4IXiz4kdzXpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otdPJeRs737nDfMjsYBeVyP4Ztl0nK9f8tAdl2Zk1DDuJQp5EBkVJFKLWKFZxerGp8RMawtlR8r1g8iTX2e3TYDNu1Rsq0j/avGv75YbIMwc4dTfSJaYVZKTutq6cK7UEswdVtROUQUjvxZPFObMOOwfxEJs10DTcorGV+qB6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HYqFwPnc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cbs3IKz/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HYqFwPnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cbs3IKz/"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 075D011400C4;
	Fri, 14 Mar 2025 20:02:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 14 Mar 2025 20:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741996974; x=1742083374; bh=KO0HQUd4p9
	ZH/vMIFZYSh4nAUL4IKlsRjNR7oEkF8fQ=; b=HYqFwPncSnmyKbhvHDxeBGUVH+
	c9d7kcjjqiey8CFNp98HMjrfnE/+p1AQ2QMzQ0laXk2b6m+Kih/Vd3XR3SyMap6D
	j7Qoi4NwPMt2bo/P9nSj8twnRUD/3Q2/vkPlZmSUF1HRUAkBz1ai8kGmZuaHuXdX
	cgKc0srsBq3CPOQB1HTFleyAj3DGAXzdxh9qAuUHo6hPZjt7Ha8YO1xdIyLzd0dJ
	u5D0jfcwYhvY8EZhD6Tsg9sSWg4q64ZuBDV2P6PmNyiXdqYW2AVJT6sDtS/c5Wz3
	+kvdChZVLQwfJinlRxjU9+eDfamwNHDRWMDyPqjILDyNhEj07tpKMAZ1klXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741996974; x=1742083374; bh=KO0HQUd4p9ZH/vMIFZYSh4nAUL4IKlsRjNR
	7oEkF8fQ=; b=Cbs3IKz/qJ6+De/KSRUQgtnatNcFTLAPYoxzBda7SIF4heJMg1M
	KhzWr/xIV7kAH+SlDHiKg5+9TeWmriI3NY6eUJRUGLbYXmKcy1kmBZl9wHuQVMCS
	So2oE7b0ZTtl5QI7GEUcUgNwiQNdPTJkF7zs2yFIh9x4j76bnwcMMY0zCqpvOSq6
	HEyi+Jx9d2rt4lde8vvBeoZThYO+PWJ7SYQbtObFaXQ7TBYTJX4MRBkaPazXNOMk
	uF6/HUhrLtEbZP9NYvMXHk++FU7MSteU/OSdvgKFVUpIvOpXV2LYdZ2zy9eykwxt
	KYu6E9BwVY58mx4oNfhm2YLFlgRVAhSK8qQ==
X-ME-Sender: <xms:rMPUZ6ge1bsmVm8iS8zdbD-7BnDlvFW89P40cX5CLBtoYPczEVLmuw>
    <xme:rMPUZ7AZH66NRqGgdnz5ExCkKc8n4-Jgi2JQjWswua1gJonDI-gTC_quYmo8xGmnF
    5iFcd3Qw0OygIfDuQ>
X-ME-Received: <xmr:rMPUZyFo8lnd693ZtRHSQ9L55zhIq7RkTMgOzF8biWHt1ICOo7JTrauCyUPIFUcOTwznX1e-GiHgVsh3riNQIPkM2T6CFGhuEkq-6Xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rMPUZzRoE_dr4fk5q1old1trgCVYNHCu73TxRfEduCw4yJtOD8VfxQ>
    <xmx:rMPUZ3zaFQcVBf9yT8VhzEWiR6sjWGKQggGrYGn7DIu9sPAFVQJbDg>
    <xmx:rMPUZx4L0Bm02hNDe84PMm3_7MDTKc9ZPpk7g33oAdIdK2fFLBcUmg>
    <xmx:rMPUZ0xB152JxR_nYz4TfLbL_DTdlbHVERZ-6EBNB7XCPfgokWbQbA>
    <xmx:rcPUZ5stOwNWyElyoVU3GsHbDNdyrLLnEvNbKdyAdq_eB6ZWMLCU_GGo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 20:02:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2025, #04; Fri, 14)
In-Reply-To: <20250314184130.GA578421@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 14 Mar 2025 14:41:30 -0400")
References: <xmqqv7sbfra0.fsf@gitster.g>
	<20250314184130.GA578421@coredump.intra.peff.net>
Date: Fri, 14 Mar 2025 17:02:50 -0700
Message-ID: <xmqqy0x7cg9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Fri, Mar 14, 2025 at 10:36:39AM -0700, Junio C Hamano wrote:
>
>> * ps/ci-meson-check-build-docs (2025-03-12) 1 commit
>>  - ci: perform build and smoke tests for Meson docs
>> 
>>  CI update.
>> 
>>  Will merge to 'next'.
>>  source: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>
>
> I didn't dig into it, but I'd imagine this topic is the source of CI
> failures on the "documentation" job like this:
>
>   2025-03-14T17:50:13.8749066Z + meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
>   2025-03-14T17:50:13.8752287Z ci/test-documentation.sh: line 50: meson: command not found
>   2025-03-14T17:50:13.8769502Z ##[error]Process completed with exit code 127.
>
> that I'm seeing in jch (and looks like you have a similar one in the
> latest build of 'seen')
>
> -Peff

Somebody more clueful than me about how the CI dependency set-up is
supposed to happen should rewrite the proposed log message
altogether.  The install-dependencies script pretends as if two
case..esac blocks are orthogonal (the former switches on $distro,
the latter that we see in the patch switches on $jobname), but I
somehow do not get the feeling that we can move Documentation job
from ubuntu-latest to alpine-latest for example.

In any case, the change seems to "fix" the issue for me

(bad)
https://github.com/git/git/actions/runs/13867157977/job/38808418127

(good)
https://github.com/git/git/actions/runs/13867208725/job/38808554478


Thanks.

--- >8 ---
Subject: [PATCH] install meson for Documentation job

Why should we even do this?  Doesn't it run on ubuntu-latest which
has its own apt--get install for meson in the $distro specific
set-up before this part?


---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0df74610d0..fdeeaabaca 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -123,7 +123,7 @@ sparse)
 	;;
 Documentation)
 	sudo apt-get -q update
-	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
+	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make meson
 
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
-- 
2.49.0-205-gbb947d5b2d

