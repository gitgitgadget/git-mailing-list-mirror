Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF534EF02
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422944; cv=none; b=LHbkujrsBdAIUWXq7yJMF+l1JBW64umglX3fIv5k+NPd1Bdtm1OnUDAAeBo8pzfrTjXZFnHGZb54aAD5Iw19w8gyZa6fZ9+YPzk2lXd/v+hXdXCbXCzd1iryMjxzkIMxv3n9ayOBYQf4gw639/ePOfKiWusYDPdd1Kf6aOiyBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422944; c=relaxed/simple;
	bh=hH8CM0fyYoFvVR5HxroxA9IvVkcoa8j9FU2buICQ9Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/X7SiKTKQiWmBQnc+CrDx2AfjWxiHtM2yDEhEw7WCLqDxI4tjpnGATT6NyHkoPOgP1jNnpf+2KZZX1YDd0VvACL1QoLy14HJeJHmWcdS1irnAZpKjhq/8Y9pnS2bPQI7fsiTRn5LnLLJDp5X1WcW8wFoxFypUyZvKKBVleCmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SuS26brQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=27Z8HrD7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SuS26brQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="27Z8HrD7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 65B2FEC0242;
	Wed, 25 Mar 2026 03:15:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 03:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422942; x=1774509342; bh=Duirg2W2WV
	aI5gjZXwCmczIqen5mHyFDP+fzn8Xd7mw=; b=SuS26brQhFv0RH1GYgThaR2epj
	4+t9BQEeiLJqo36l4MUGDp6mII2EV8a7hdyXp9S0iNKRrZ0TtP1Dkf7on5H/3n+G
	oUAA3QFi4KG0qt8dqvkIMz5vpjPeXwiefGw2HT4WlyzeiGvQTb9Ws+mDCd40OIlr
	8RuCC9CGUmCJCWTppthzISpKjYF87+M8zK032hNbN9Aun2ClVqNZo90nvzALhQoR
	KqEnVmjHhTikNYhTcxpJLTCw+Cx8E1wgCywZhU6GwL0gwmeNfQgeiBdsu9F8uXu6
	qx89hjCSMfo2lC7B0UCMuZzmC9WuAMrX12Po5PAkYJvBfDQg+pm8wPLDo/fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422942; x=1774509342; bh=Duirg2W2WVaI5gjZXwCmczIqen5mHyFDP+f
	zn8Xd7mw=; b=27Z8HrD7KER82NjYUPkaZTk60uTff2uJIDGZkz09MKwztmUtnAK
	EF1j66zCKpfgLFS77zHufnelOvLn+HyuLELcG/Qulqf+PLspILnXRPuWUVmh1cz5
	6LCHyeLyg9sJsrF3C8nxTrc6W7c+whtFnwoxxM8cqLW86kHJnpRT5nlCt3M/aG3P
	QGHTOMi1gIg9iTQRnZMUbMCNONjt1m6BN8fKozmKRMQL4/r102N3SKvYMQW1UGMM
	pIOEve6f34DMLla2dqqfSEJmjrKIMmVNBFtbrTYhale4RFdK51PTrOUqRx7/fp7f
	KGwlRwAxsvg6EXIzxbmoHZ1w8TRRUZpTQdA==
X-ME-Sender: <xms:novDaUlP934Gr1HSJ6yhKHUEtqz_mMx7mqw9UHmtzRV9TmFxf7B3qA>
    <xme:novDaZ33Z34Ke2u77gNyWEFOwi1apW3UnOqLQtigamtEzIU0jBXQgz0OJqnij2bHp
    2XYwjRVR69PtnLH2WMAAbG_c8MCGVzNIwpOeHlmt_DE7GQGugE>
X-ME-Received: <xmr:novDaQRywNktFkp1CFg4SG2AEjrN232N5DPwzu_Hepo-8ApMZRzyQ9-bTid7Kl2w2nrch2JYkysBwQVoHF55YSrrdGpJjvdjHq8TQUU6pZI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:novDabts6lguqS5bggs1_2r3JvU78rRjyXF0ECS4zw8ohlVSpL0CTw>
    <xmx:novDaVbLqskNzcwMZlr2mrLRtSLc6yxjtSm3WmdfYD9rG2OAquYl_g>
    <xmx:novDaQvDR_XeyUVhfG1Bb-DLJBlRMpcMeJSEi05f0X7UbhJt3EbYfQ>
    <xmx:novDaXGgghw8VaJVTOb5rxQXHLNFK9yGljhZppEFmRsgPCOcoJ_x-w>
    <xmx:novDaf-1uvPc6RQ-CfUoxbmyqfmAj6RABSiYNwe1u-GfoQZhgNe8dcCz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:15:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a0fa501 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:15:40 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:15:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/11] t4032: make test "set -e" clean
Message-ID: <acOLmU891XXsTcre@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-5-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-5-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:07PM -0700, Junio C Hamano wrote:
> diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
> index bada0cbd32..efcd863126 100755
> --- a/t/t4032-diff-inter-hunk-context.sh
> +++ b/t/t4032-diff-inter-hunk-context.sh
> @@ -40,7 +40,7 @@ t() {
>  		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
>  	"
>  
> -	test -f $expected &&
> +	test ! -f $expected ||
>  	test_expect_success "$label: check output" "
>  		git $cmd $file | grep -v '^index ' >actual &&
>  		test_cmp $expected actual

I fixed this by applying this change:

@@ -40,11 +40,13 @@ t() {
                test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
        "

-       test -f $expected &&
-       test_expect_success "$label: check output" "
-               git $cmd $file | grep -v '^index ' >actual &&
-               test_cmp $expected actual
-       "
+       if test -f $expected
+       then
+               test_expect_success "$label: check output" "
+                       git $cmd $file | grep -v '^index ' >actual &&
+                       test_cmp $expected actual
+               "
+       fi
 }

More churn, but the intent is easier to reason about, if you ask me.

Patrick
