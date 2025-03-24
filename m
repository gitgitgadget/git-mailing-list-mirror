Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11F2CA9
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742791570; cv=none; b=t17DydlK9rhGHXRmgGTQ2Yp3PzHUTIt8qSIazTEQxea4FiR5xvJAE99UDpfLFD9uxntwrDgYt8Z4PWqQaMQeOJdHqy+O4ipeIERxz7kjavSbWepO5ZT4h6MbsM3mz729lQSr0EUyEjorLlcL3N1PYGscfF6SdThs4ejcQ8ztLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742791570; c=relaxed/simple;
	bh=cTtl3aKjCl3Bvfr8um8TgoIXE0WzHA/6F0yQZXCEcqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzzKBae0QCENrL7UmKNO2lEykGqjgqTGYVOWjy1QDhqi+J0mhuH8hzPpeBdMAz9u3+GyrwDyNLpzw4Xq2QzL+RxZWV5TN3KtIuzROiMZLYkXsFjHOQ1p39DtASzbybKubC25XCnPWmhE80n1diyRGbHkyVGejhNjZBYvk8+UD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HprF4Py2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ln9mJ0FR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HprF4Py2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ln9mJ0FR"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E3121382D0B;
	Mon, 24 Mar 2025 00:46:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-13.internal (MEProxy); Mon, 24 Mar 2025 00:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742791563; x=1742877963; bh=o9sKzbn8sS
	hNpn4uBu2c3fe6Mn0WIPGn/xEwETkcUAA=; b=HprF4Py2zhkOohqtzSyZYV6In8
	GZ8EsIuRQWcxTydwlL607ggQZQI4XUxLaqIFzaYms03PgYG98tgI4dPG9MvaV/JE
	TElyuCevpkUST0E5vpmjWZywGJdNeMeW3sn1JAHWM8IEGZ7Q2cnr8AcB5eARz7MN
	TANftnNFpuA3QQ8TCs45qtS5kyT7BkfzBmr/pO1+cmBjtJq5azmFxrhyffL3qquO
	S/J509nXs8jIh6ToDAOcX2wtwmCH3G8vC+ii61k2VupAbMVFZx4KsYaioMph7qc+
	JV7g+YXzLHW+3cD6QNmDfLguv3HXBeU8z84wL3JLLuzgvXfxYcHIrYxD+WNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742791563; x=1742877963; bh=o9sKzbn8sShNpn4uBu2c3fe6Mn0WIPGn/xE
	wETkcUAA=; b=ln9mJ0FRkGZMgMhMlgYD9dovslniXi9FB4YZkjAkYkTmYC2Lhfd
	aUGOT+EU1m0IOUVj3fzd03Ec9KbRsVsOrGIWY+9sHKwtVNDpK4W6dbN9r3tVzu4l
	+Yu7fj8ZchPBD4E302kdWwU/+iVB9uIo67SKk6aSe8aTDaAtdqj9gBMD39/EGJec
	rYiiWd+5PQjBQsZ2lplBfZb3gRS8V9i5AQUCyL/RjdkJHz6RX7Y0bX/zsCyeJVwt
	vMPmOdCKJiy6GhPiTOrF+vYnHV8hmVUn5RT10FDk8kZJVZaA+9o6J7jRfJ4LEOKY
	L3vbky4e6jyTNzYRm8gOMApfYtWbCKbs0lw==
X-ME-Sender: <xms:i-PgZ28Q5unDqoX6SGQXooxJgS7hGngyXDKX-RR2sA1_OVN14f8m_A>
    <xme:i-PgZ2vVAvrnQ9NQNDkH8EknDF2J96s4NIWCJIRCFYwqINGE2s1VV30fawEGMmf2w
    MuOYluSUrXsT444sQ>
X-ME-Received: <xmr:i-PgZ8BY936pi8xo-dpw-M3qhIy8bCEC38k6LEPgwtGUagnPA8Nh9JHD6FknjluTngeDAQh_CJzUvorwPpe0Cj95ZLdYRsoqJw-tmwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjrgihrghthhgvvghrthhhkhhulhhkrghrnhhivddttdehsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:i-PgZ-e18N4P1e5k8WYnxR7xuFfit8kP1Lc92E0EAXHv6lJAJBpoag>
    <xmx:i-PgZ7PBIm_n22WZw6mYMfTd6MSmwacvelc_SSDDxV8l5nhsy07c_Q>
    <xmx:i-PgZ4nnvdcZ-44bxetsSX0baYBLuT4hKn1Pfs7yDo9oetDJJ2C9iA>
    <xmx:i-PgZ9s8yiz59Ju2NQCRnXRthlEyCLNzUC95iAAorHUopwHJE_Vp-w>
    <xmx:i-PgZwpsdofOSjmEgJpZ9TSTrzjCv11g2VEav5XUsw0e8iGVTi7_2GsF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 00:46:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [[GSOC][PATCH v3] 3/3] docs: replace git_config with repo_config
In-Reply-To: <CA+rGoLfALoTvQuAzQPx7rqd-Zy+wMiyEbF5Y8_-2Yi-yE-2qpA@mail.gmail.com>
	(JAYATHEERTH K.'s message of "Mon, 24 Mar 2025 07:12:09 +0530")
References: <xmqqa59evffd.fsf@gitster.g>
	<20250321143022.5406-1-jayatheerthkulkarni2005@gmail.com>
	<20250321143022.5406-3-jayatheerthkulkarni2005@gmail.com>
	<xmqqiknzqu2h.fsf@gitster.g>
	<CA+rGoLfALoTvQuAzQPx7rqd-Zy+wMiyEbF5Y8_-2Yi-yE-2qpA@mail.gmail.com>
Date: Sun, 23 Mar 2025 21:46:01 -0700
Message-ID: <xmqq34f3qbna.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com> writes:

>> > +#include "builtin.h"
>> > +#include "gettext.h"
>> > +#include "config.h"
>> > +#include "repository.h"  // Required for repo_config_get_string_tmp()
>>
>> I do not think we updated Coding Guidelines to allow // comments.
>>
> Since this was a tutorial I thought this was helpful, anyways I will
> remove the comments, because I get that this would be bad practice for
> newbies.

I meant that I think our guidelines frowns upon

	#include "foo.h" // for bar()

I didn't mean a comment is necessarily bad.  IOW,

	#include "foo.h" /* for bar() */

may be OK.

But real programs will evolve and API elements that are used from a
header file will change over time, so it may not be a good idea to
single out a function like that in the comment.  It would be much
better to explain _why_ each change is made in the text that
precedes the sample code.  E.g.

    Add `#include "config.h"` because you want to use X and Y,
    and `#include "repository.h"` because you want to use Z.

    Then, add the following bits to the function body:

     ----
    #include "builtin.h"
    #include "gettext.h"
    #include "config.h"
    #include "repository.h"
    ...
    int cmd_psuh(int argc, const char **argv, const char *prefix, struct repository *repo)
    {
        const char *cfg_name;

        printf(Q_("Your args (there is %d):\n",



