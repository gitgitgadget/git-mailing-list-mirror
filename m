Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073F365A0F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101371; cv=none; b=gFRbHlyHuOTgoH8kXpSXegQynLarTDXkDNje7R9KGPX5huGFip8QDOq4JQ9NRkkYzinIPKpWDf3LIUVjxJHRAeg8IkAi7eLEU5O5qWo4/cz7CJvj2LIYbs6fzY6jN7HpVKnwsR6u1zSYsyWpoQQAM87YZKW+EQi7wrLV8wm/y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101371; c=relaxed/simple;
	bh=unq9M0XOM/SMr+O3yHmcENeKwtDkJG8OKzdJWx7cB14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ba84Rax/fEtijOQMh6BBnNOGO3zZp/mlKVwbLY0X1+xmNrSXar3aCc2mVkBA8aTcIhMDeYdVinNbjwKrWMBFma73L1sJ9zPrH/llGCUTJvfGfedlSzM8/RNnmJA+9LxUH4errXImOBVSE91l3MEbScRF/mmsTn9K19uqwuAQ8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c3tZHycf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tNS4ApLL; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c3tZHycf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNS4ApLL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C8E87A0271;
	Mon, 13 Apr 2026 13:29:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 13:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776101368; x=1776187768; bh=mvEF+axHjU
	n5wTVqHvv+FZBUiQh+nNpfMwZeDMn1P6o=; b=c3tZHycfP/a2IBBBqT3Qwa0eZH
	AO/xD+Kt+RAVYXbo7HrHTNJ1RBQT/Axz9PoJolhdjRj0IQ8wFOmHaqS1+z0OEDoJ
	C4YcvCj2NighwccEt93zLDhJcOOI4dV04vkOArmffPavy3Gl47Or5/TWP1ZaSHWo
	9BzGMFh8rdp3rjsQWCO+uJ88NEOY6s1Uhm0UuYw0Nip3Y9Ne8wMV/Rf7pv8dlDRV
	xDm1bzGSnBOFF4kp7GY1TB1U8jpwmtT3xkSG0fsNIZKp8CZ/8evv8MyiuoycyNGQ
	G/endAj9t1wI8ckBGplY6Zd8xGs4wajx/wD4Qk3D4YI0ALEe0AHz+enRYoZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776101368; x=1776187768; bh=mvEF+axHjUn5wTVqHvv+FZBUiQh+nNpfMwZ
	eDMn1P6o=; b=tNS4ApLLg5BE2+teWkRYGPnOH8uLguePM8XuRawESnRjyJw9bso
	VtEpeLhxn7yOE5jltzhCUe1n+Wj8zR5L5YX+xTVreXtyXs0PO9/43YTpG9wqEDpT
	SBzMOd+kdd5yA4KMJipWHcjdyqYmeIEVUtbd/3D6mUM2GAUb+AiaLa7I3l8QNR3y
	LufwZJ4LzS2mDDHE2tknuwECjEMrB4ueUhFNlzDKYn8AvRUV8Ut2mJbsBnGkwgmS
	QGUkMLxX6BXTDJX90T3bRt7GiE2XXjZMbz8Tbl3jmCZ14puJNPScOnbzZt9nwciW
	ahiUoGmRLnVqcerA06Hu2Xk3BML68GHrC9A==
X-ME-Sender: <xms:9yfdaVBMmXVu4bRpiRrS-afOTfblF_WC6_FXpQ6BaUmAYxIDYX4xQQ>
    <xme:9yfdaa9VZzj3CIlt-JxBCnXpFFY1i-UAzlaZMXF-Y7rGaoN5dxQa4Fb5jKuL6Luv7
    MYVGYsFbGOWRcp0vkzkrXdbzztd-HcFZajJMIfGbSca8ZehlarwQg>
X-ME-Received: <xmr:9yfdad-9zM5csJJsyaUJ5WtIyMwhwoQQXTYuuclCmL3i4fGUPKqKohWU34zUjhqAa_R3fV1ycoOxLPpE73aqWp8S259BNMLTJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeiueelffehudduffffgeejleffieelhfelgeehledttdfglefhjeeukeehtdek
    gfenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9yfdaZe1IVTI86nXpWoN5s2V_-KOQ4KfXG9f7sNzQCnDhKkknqHFIA>
    <xmx:-CfdaeF2Fd9sB-2-B0-UPXzVsKxbsHwabAypzbYQAvG0fq2pzVVhkw>
    <xmx:-CfdafdE7wSnnv-M4qnCJAhy-BmtE4jZ7r9HtTWkICFU5Eo2yemEgQ>
    <xmx:-CfdaQFRXUUKTGy2JIlJXzxaJ_HaCmOnInvRXwne_wxA_FhtqrQzeg>
    <xmx:-CfdaTFHAowXiVOdU8cGWhALcxcaxFFIMFKdnxn_uJnsnEVRjwcmpdIc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:29:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/12] t: detect errors outside of test cases
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-12-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:33 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-12-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 10:29:26 -0700
Message-ID: <xmqqfr4yixah.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have recently merged a patch series that had a simple misspelling of
> `test_expect_success`. Instead of making our tests fail though, this
> typo went completely undetected and all of our tests passed, which is of
> course unfortunate. This is a more general issue with our test suite:
> all commands that run outside of a specific test case can fail, and if
> we don't explicitly check for such failure then this failure will be
> silently ignored.
>
> Improve the status quo by enabling the errexit option so that any such
> unchecked failures will cause us to abort immediately.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/test-lib.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 81380fe978..c493e3c768 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -15,6 +15,10 @@
>  # You should have received a copy of the GNU General Public License
>  # along with this program.  If not, see https://www.gnu.org/licenses/ .
>  
> +# Enable the use of errexit so that any unexpected failures will cause us to
> +# abort tests, even when outside of a specific test case.
> +set -e

Yay.  Very nice.

>  # Test the binaries we have just built.  The tests are kept in
>  # t/ subdirectory and are run in 'trash directory' subdirectory.
>  if test -z "$TEST_DIRECTORY"
