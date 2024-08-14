Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9274B6F30C
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618318; cv=none; b=azg6BEtLEe3SuJy1r/29u7aj+IrPwZ3o0GxOY3OsrhmDr60KHLfaWVbnf7ySkGNkf0g62KzaTnxeQlPaBUyjdi6yM1iL+ZkvME0mpNtzjIWineRZ37tVi9Nf2utumuw741FJdJFvmUCS9S5MZiKf6/APQvnWaYOT3pKYsER+WfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618318; c=relaxed/simple;
	bh=libDPasjwERHGMXBJcJ0Dh5QJzvBfdxylv8HNoT6a+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4nBKzMDlVkPFCx7ln1COpZ7/Tp7DPyv191sNvVjrGJTUiJ1G6rAXYFge9oW6N+KRJAJcAVA3vlCOglzWAAticE68BzCgZIUd++WucYYiszrhkUfjR0bsJWVG9TxCZw0cIquwwFrcdeqsDd3fKpX/k+WEdAwM3I0sDn2g/+Ucgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K4mG9QfT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exH97ssQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K4mG9QfT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exH97ssQ"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AB86C115173A;
	Wed, 14 Aug 2024 02:51:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 02:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618315; x=1723704715; bh=vWD7zvYfuB
	lMluFTJnwI+L7GOLzXt6QD1KyiY7vDzFY=; b=K4mG9QfThn9+vc3mO9Nh/6rPZP
	8N1W36t39oDyjvq2kd6ceOZBb77KDqwHzx6d1cPfJZFhyFFpEn9bn4hXshu/Qz3M
	HE9l0aYHlsTVzhTRvokOPKyxxYloEHgohV6tyXS8DM7fSe7YfqAJAEvpSKjqMmkP
	uQTuKlEiN3bkg4yhU2LuCjc+e7FkDn1g6opRL76im3tYJPM81Slz6/sidaPywpzt
	TihQthGF8CTRG5eLcl+xopFu+PXhvmjYHxA+X/ysuaObeA9OtWYaVIvy8QkcKNLO
	AfsKDWpnF1eRA8cCO1ZeZr9cPntfUDMeVBK5BoHQT845A+/atGpsX2BzAOoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618315; x=1723704715; bh=vWD7zvYfuBlMluFTJnwI+L7GOLzX
	t6QD1KyiY7vDzFY=; b=exH97ssQ0j41oN0joi4ww6PW6A5et0UhTciICEWnZEFY
	WZ9uU3mDmusXdHhZFEm5cYQ3kXJ7oAZrCUwblnMRHKli5epdgBkgf5S2ku9CZWMP
	9LtfEvE3iFYLegyd0GRw7/tBcbcW/6s0LXh1EaAaAwQt9fN547upwNrOAZlLYrKv
	+3U6b+2OPxqH2ijediue+9eNPbQYNQ9UgRV3/MdEfJnIPbIWurcKiQgCOaOOEhvP
	NlbENnuODCJ6xWlEYMWEMNCYJEthGHu+wC9FsGOiC0xd5kiN10H/jIwvc8xhHZ0B
	pJafZUJzJB3s2olyWQQBpdMAcNSVY1g1anoeqW0ZkA==
X-ME-Sender: <xms:C1S8Zkx1Avfbv7WkKntNqVKCz3Agfy5y23lVym4xV3ELefnnTNrEJA>
    <xme:C1S8ZoRVdLN_T8sUIwsym6vHyNdWwSY2M4IMi14Fz5lr1yEPvr8Qn4O4NWMIpL8ao
    pO2BvCUHvlDdc1SEA>
X-ME-Received: <xmr:C1S8ZmVZbTJD-Mejvnxin_ZLIa9_CQl_J6yCDCk5D6m0GhHkFsWUM_dL71lLJyumm7BDwZ6NjzqLBQK8HaMbR083e2-eStMO76kjIiCnlgZQjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:C1S8Zig63_oLo2hwenOLlb_wk_ccnxAOADYxfH_IvCnHlpTL4T_JJQ>
    <xmx:C1S8ZmB3b-iGVy4rGIFyNXOc6SayrtU-oNmgxmn_459bOEl_f7o7Eg>
    <xmx:C1S8ZjKwHOqwVgPLCkrzAC0qqBBHiTcT6mwsQoGFF8oMYQqodmGj7Q>
    <xmx:C1S8ZtCCObGxe4biGRjmI9hg0a671d6jEJU0mRQFeKSFepPzvcSEuw>
    <xmx:C1S8Zo3FZw5DPNJStKV2jgiytRIppnqThuuHikRuyV_-l0EU01L5ALfE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:51:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95373df9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:51:35 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:51:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 01/22] remote: plug memory leak when aliasing URLs
Message-ID: <02f6da020f083b3cedcdff192595438ecf82bf56.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

When we have a `url.*.insteadOf` configuration, then we end up aliasing
URLs when populating remotes. One place where this happens is in
`alias_all_urls()`, where we loop through all remotes and then alias
each of their URLs. The actual aliasing logic is then contained in
`alias_url()`, which returns an allocated string that contains the new
URL. This URL replaces the old URL that we have in the strvec that
contains all remote URLs.

We replace the remote URLs via `strvec_replace()`, which does not hand
over ownership of the new string to the vector. Still, we didn't free
the aliased URL and thus have a memory leak here. Fix it by freeing the
aliased string.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c                 | 2 ++
 t/t0210-trace2-normal.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index f43cf5e7a4..3b898edd23 100644
--- a/remote.c
+++ b/remote.c
@@ -499,6 +499,7 @@ static void alias_all_urls(struct remote_state *remote_state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->pushurl,
 					       j, alias);
+			free(alias);
 		}
 		add_pushurl_aliases = remote_state->remotes[i]->pushurl.nr == 0;
 		for (j = 0; j < remote_state->remotes[i]->url.nr; j++) {
@@ -512,6 +513,7 @@ static void alias_all_urls(struct remote_state *remote_state)
 			if (alias)
 				strvec_replace(&remote_state->remotes[i]->url,
 					       j, alias);
+			free(alias);
 		}
 	}
 }
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index c312657a12..b9adc94aab 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,7 @@
 
 test_description='test trace2 facility (normal target)'
 
-TEST_PASSES_SANITIZE_LEAK=false
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-- 
2.46.0.46.g406f326d27.dirty

