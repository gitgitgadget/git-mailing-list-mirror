Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9017570
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515635; cv=none; b=SlHGZlgfFYKlP9i/iAm2WnOAk+FOwKTW45n+foLWBdLZ9djTocYzxVrly55qfgz2rMytJK3w9i8KmbCDpjRnbKuC7Lj7M2TSSUa5IZI2wZsbZyt7vc4BaTH3AwvUzKaNx2OsUqPlGSfz0qvG/HPwtWimCRx3DJhU1f0qO68XRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515635; c=relaxed/simple;
	bh=++0/vdYIou8nGM6Zrn1GU+IJAdQ8lW+lrCQFCso+4og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3ZDdokY09l0xU8cm9rj8FeGfQH4Z/bsk4ANjqUGWFbIhR9qsRX+y6B7I4HuU+nxUXhppK7awTFYi23wQpIRZXrLXszbGyZ4yPsq8NRATIV3v4tKtnt2eLEVGKftf2oVLBv5RFKZE6JeiAENTl2cmsxRKQ5ovNmVzG/NEP5JTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qmMYwERy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qmMYwERy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F8511DC26B;
	Fri,  9 Feb 2024 16:53:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=++0/vdYIou8nGM6Zrn1GU+IJAdQ8lW+lrCQFCs
	o+4og=; b=qmMYwERyo6riCCwCfGLxvsteNbKJXM4FuzjFXoKcewnq5na2I6TdIC
	xgaw3H0EKDJjXIjBOclSwWMttn5ZH0saDmrSARtbR0V67UScROSpMFcOvgLxiAFM
	LKAlikZifMsqfdWib+WoxhiF/TbbWsMexP6NTi4viXxgtxrCuxWc4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 35DB31DC26A;
	Fri,  9 Feb 2024 16:53:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 781EF1DC269;
	Fri,  9 Feb 2024 16:53:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v4 19/28] trailer: make trailer_info struct private
In-Reply-To: <f5f0d06613f2701af9bd3a1a9274aae232e03d8f.1707196348.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Tue, 06 Feb 2024 05:12:19
	+0000")
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<f5f0d06613f2701af9bd3a1a9274aae232e03d8f.1707196348.git.gitgitgadget@gmail.com>
Date: Fri, 09 Feb 2024 13:53:50 -0800
Message-ID: <xmqqjznde235.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B626A166-C795-11EE-87E9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch believes that the benefits outweight the advantages for
> designing APIs, as explained below.

"outweigh the disadvantages"?

