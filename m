Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6F4A204E
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106120; cv=none; b=gD4Qcz5j3RYXam4VXzjsOlsbeulpcUCGDr8bG37pKDFsblHRRYU3B6+X2g1XhfA2BJ5hwTFmI4yNxkGFhsi904vtPWDzCrwzWo2swHfkJ04tUvIWfnaPXJIOEPbnvPh9CSsAt1NsORtbD0dtrkKyX4bKJQ8CNuT6oXoanrLSflg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106120; c=relaxed/simple;
	bh=wr9Ay48VKOfO3UJAoELY+W0+Ni39WHzphSHqC6mlHPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ezRcNhJxZ73LHHUGbx0rhTXrpMJKIJCO1jUEVPwyPPgCwWGtsNqjG3epX7u+KRc4+LWdzV5uivRj8CIXE9cGx/OhkaLIzmxPs6/n1Efh4r5RdG1vrqZB2L35WiZeyVyjjPQPc6I53U128wXtOfOsyNg17LCmS0Ef6mxbYokpxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jUQS8OAt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYMLuZds; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jUQS8OAt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYMLuZds"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25BA9140008F;
	Tue, 22 Sep 2026 15:41:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 22 Sep 2026 15:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790106118; x=1790192518; bh=x09MOoxD40
	5bd67vixtxouzFJALSNvgELJ7hX+PUjwc=; b=jUQS8OAtdZsRaSWfwnv/tREtRC
	Ff9iGaY5w+gwDt/6c610j3FoUBgjbk4pgsKLe4ZxGNfQzYZG589YT6TU0Y2ndW8D
	1BtP2O5rtJgKpU1Fd0en44xZgTctaQfTDCRqsXkBOjL0zXcp2v8NwoWjiFl8TBh0
	EPsMu7ORm5vlZeB3TM5X70O6NTUfAAdR6JCZe7YJwnM5HZfj2o5gVQhgwQpTGvYm
	7TtWJ4hj6No9XRNW03yW1DC0B2Zy2ijHFjAIPQUlRPiCkPFImCMPVCgc1lj0gExW
	fe/LP0cVfWMi2A7A5Hl32TNWJo/xOcUEIMgW32cCXt2feDGMBm7dx9jtH1zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790106118; x=1790192518; bh=x09MOoxD405bd67vixtxouzFJALSNvgELJ7
	hX+PUjwc=; b=XYMLuZdsg8DoxSza4mdRxBStFjIX3fDce5yxQP/NuXu0+8BqEP1
	xJ06qQh0FqqrrQAyAlT1uOh564plmADA9XGe4twzFQ17ZvYRE5cMaAMK5Kw/xYcv
	daiXhGi1q+geAHt8723D+ZGWCInOXSxN5Bvu1RUayBM/TpDblGKHbPvFG3yIlaT3
	+GcTbF8E+XUeCaVAiU7MPg1NpbRHSSssRcqYF82pCBTEKnEMTi2lYO6bwTdFWqr7
	oSs7AkOzQcIbgIWTHF4FORc8HrUGJMvrJ6bqMO5sVHdWYTuou/N8RZt1RpRcUGfi
	zLODH2RXknjdyXMNsNwToIf0vd9FlR67gRw==
X-ME-Sender: <xms:BtqyaoGGsVU-U6ARvkl0Av1h-VTFgo5uiTwJChQs9UAnn635_RVl0A>
    <xme:BtqyaowiLIoa4OxdQQi-Z_gqCLOFkJxIZdy37uElqgIGZP6u3Fosn1THI3MxYReRg
    zf4EjcMWQXyhcWB2MocFawKSw5922mGZg0V_Yeinu54ZvwiXS-cOLI>
X-ME-Received: <xmr:BtqyaviFYvG32Us6Pw3tIS9G3QhMuztQdkiDfQx4IyFSCEUyf2xtKYN0HDZxidF9BZRQec3PruOhEFguiz2bmYxFU614k0xyLuZZ>
X-ME-Proxy-Cause: dmFkZTEpZFYsfDo1QPVcfflGjA+ZNQ+eAUwcXFEv5HfhuZJsAWqTS4duU+2ncVp7rVjMhk
    abjQ/dQneZeGPbTdUPntZqMqdZVcV3Y/uzWLeHyucXPWsoRlEdiiAl2is58SLciCBeVbwf
    iJhLGx4LjQ/PKpyhuNnqjWHo8LpmVnlqtGB4cUSjh7AupBIdnJHkFDvcxngYq+VNbkFYs6
    JRUJuF3wyLzvqVWLv8yL3otmLdjqGR+86yiqt+9mGwtxjWOzJGbDOkdCP0ElOplk9uWGUv
    zBrqLuZMOdR3ERGpfuKEJmPycdFI/93qDe7N1I8vqg9DIGs8LoMS3m87rQRmogBwrWfsdN
    Sizic7w5X2TeCCKNsFiZwex5bnaYJSrVPE2bVvkqr0GJZR8Vcv3byF8eQTlbMMSdmyoAFv
    mnz52KfWVnKKTECrObByLYD57EGPCVMvLDytHmokiaMjLXjOfs4ALPQKm0HOCZg8qiJ3p9
    J+XrqIWyq9dSVZq7pcpXk6V6JA5e/w4PBFOIxupC23gwt4kINI0EBD9WW4w1tgXy3Z9LL1
    70iYLhAd6002tmP/P6qgJnOvUWoQSyMXxjSk5L1WMn5tdr/oYuxjc5A+MljKcI9EkHWP3i
    o6ObCY35zInIEu66Q1mUkTNKaA/wbWyqDLf1/qxEmDcObZpynBuFZAgOK/6w
X-ME-Proxy: <xmx:BtqyajxeusSZOO_eNe1HHGYmmSL9eFWbgp2U5vrz-fEY1w9odg6RMw>
    <xmx:BtqyaiKDtYW4Hl5fE56nhbEaHRYjbrdnzxZyArJHjoQT62zgnB7S6Q>
    <xmx:BtqyaqTiAmzUqosrF1rgkFvjX54g1U1LRBWbGmT_BVDc2UXvw21hhQ>
    <xmx:Btqyaqrh3Cm2EXub0-6F2RXolWfd9XQismrZKEC53MxajvAkvr2vJw>
    <xmx:Btqyao7GxypaaRI2ylVbiqQ_HkpUlg7-YUfTO987Xi8KEUhe42fIgOvZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 15:41:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] t4001: modernize
In-Reply-To: <20260922143119.3313620-2-markchucarroll@fastmail.com> (Mark
	C. Chu-Carroll's message of "Tue, 22 Sep 2026 10:31:17 -0400")
References: <20260922143119.3313620-1-markchucarroll@fastmail.com>
	<20260922143119.3313620-2-markchucarroll@fastmail.com>
Date: Tue, 22 Sep 2026 12:41:56 -0700
Message-ID: <xmqqa4p9dqez.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> Old tests were written in a different style than modern
> ones; for better readability and test error messages,
> update t4001 to the modern style.
>
> * run everything inside of a test_expect_success block.
> * write title line on the same line as test_expect_success,
>   end that line with a single quote that opens the body of the test,
>   and end the test with a single quote that closes the body.
> * write expected output of a test to a file named "expect",
>   and actual output to a file named "actual".
> * write here-docs using "<<-" syntax, so that they're indented
>   uniformly with the rest of the test.
> * make test names more clearly reflect the functionality that
>   they test.
>
> Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
> ---
>  t/t4001-diff-rename.sh   | 91 +++++++++++++++++-----------------------
>  t/t4009-diff-rename-4.sh | 54 ++++++++++++------------
>  2 files changed, 66 insertions(+), 79 deletions(-)

Rebase glitch?  The claim above is that this is about updating t4001
but it seems that a half of t4009 updates are mixed in.
