Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5617DFFA
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318243; cv=none; b=babpVNl46r22A/q8DWcvxdLqMOZEw9To1NMFbDNDzm2WGV5If0yaILZaf6Y18wFFBk01Vl3+G8VHDCF9oHzOoqRpu/3HC1URwM7MZ6RE6IPdZA54AQ1a/UGGh0ecijoUwDMGbkAuX7Vusq+d94Lz0T1+WAnU2zq9K41gpaIdGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318243; c=relaxed/simple;
	bh=fuuaad+LzJ9J1ACv7inm/m10mCKweBOzjIGwHn49G1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTpvdaoL2/czyFVt28ypnB2McG5leXgbwIiSIpuctCLmQ3N8HHA9ze3weK3QQv0iNPkOXK/7io75agcRTRYX84naT/1dTq4K6KtwxEwxAy/IwcdWG69QZPHNCzGC2wEJ0ae3dPbCEQOGdGq1wlJr6v7uzDdJAPQfbd+ZpXoBq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=teCrfAA1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CZVsbe7p; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="teCrfAA1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CZVsbe7p"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3330A1151BBC;
	Thu, 22 Aug 2024 05:17:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 05:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318241; x=1724404641; bh=MCNmPwlZVK
	aOUdZLbwJsg8dSauQ89p0CarHzsRUi4qA=; b=teCrfAA1oixzAxQIKXaVPLChJ+
	U8ISILtOgHJIkVZyzq3twmP9sOQphzshKqWZe/fSja1VUtqZtKmB5qukoABtHPYo
	S3R9v+D4zCniGt/d3WJVNlVJMCimMELlxCTLf4vI0ukvKASwGS9WcJtmJpHoso7e
	Ss3iYL7f56D8C+mSEFqspGEDDOin/PhXBs8XlORg1aspZ2rQ9CjQEEGsZVz+V0u1
	/QC7SKfPpWSdixEYZ3XL5sXIOoDfADWrevu12Vb6iICQlT2zW/pAtpLIU+/8RH1T
	FZ/fWib3E2FS/Jd81DDZUmZqjLlGl2T/TyeenymZSDhz8Et753PjkRWDfZcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318241; x=1724404641; bh=MCNmPwlZVKaOUdZLbwJsg8dSauQ8
	9p0CarHzsRUi4qA=; b=CZVsbe7pK03soVn7UT13xZdUVh0zZVB/kaqs7zQZZvwe
	MZQ9Xa2g6KiNJR03r8bg8yuDdpjMr8Z1LMKK0ySDrCXuJ2gz/K50pJ5/cq9B2nYL
	LaE92EljXrJd1Fk18shshMCDBXX5kBz4k3VezLEwXuDBmq6yo1WiNPM+YYyaT1KJ
	t6qQZiBZUlj+KVzgda9ga5S3SELkgy/jFgXd/rDUlf2ZeDilHkQcrhX2V2yXOv9N
	vPW11jvXyGJkkernqCh25NcUWI1bQRQy2WJW/ntQRvxIsg/VEhsNhrtgprXQ6+Ce
	vvNzKdK4KSpupep/ylN+VZdmjYAChpQYtbYHD2x1WA==
X-ME-Sender: <xms:IQLHZn3a1mm-CVnrVxBcvcb8Jcp-01x_LJG6Qr8YQ-vxQms05s-CyQ>
    <xme:IQLHZmFx-TF25EFgKFVJlcTSb4nuEU5Lz9i-EculgdqzIFYtM4S6_wBlyfReezihl
    CjbURcajmydxNJSbg>
X-ME-Received: <xmr:IQLHZn7E3v1F4SYPS-rxSJeGi_cWdd8Aj5RI1FVzukZgWYuQlT72TXAboOCz_SZi30vKJsepKs7lhYty6yGruccj1QXAt1jEYG6o1SsokEAkTDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:IQLHZs1JbumpVGoKgDA9XoDb44bmwzXFphRN46THG_hM_UqoWLKDdw>
    <xmx:IQLHZqFeg4WD6cfF3HagvkWQtX9cApEa4d40Eg4p4mBSnQuvRH7M_g>
    <xmx:IQLHZt-MRjuaagobkG_lWGtMubHXtLJYSMsNIewEKGuJUfM3Nu9nMQ>
    <xmx:IQLHZnnmy1FL0jQ9bEugEFe380U1Xq02ZlgaBaliUeXxLRqTS9F8Tg>
    <xmx:IQLHZvQ-xTYv1mpmajdVrDVcI0rCR5Xb_GK6tyrv3PyHIhH96NqJwMV->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f348494b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:46 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/20] pretty: fix leaking key/value separator buffer
Message-ID: <1c368a4489a23e258ad66b2b10ec8721f7409b3a.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

The `format_set_trailers_options()` function is responsible for parsing
a custom pretty format for trailers. It puts the parsed options into a
`struct process_trailer_options` structure, while the allocated memory
required for this will be put into separate caller-provided arguments.
It is thus the caller's responsibility to free the memory not via the
options structure, but via the other parameters.

While we do this alright for the separator and filter keys, we do not
free the memory associated with the key/value separator. Fix this to
plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c                      | 1 +
 t/t4205-log-pretty-formats.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/pretty.c b/pretty.c
index 5e162d7204d..5e5ae452530 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1776,6 +1776,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 	trailer_out:
 		string_list_clear(&filter_list, 0);
+		strbuf_release(&kvsepbuf);
 		strbuf_release(&sepbuf);
 		return ret;
 	}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 158b49d4b60..eb63ce011fa 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -5,6 +5,8 @@
 #
 
 test_description='Test pretty formats'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Tested non-UTF-8 encoding
-- 
2.46.0.164.g477ce5ccd6.dirty

