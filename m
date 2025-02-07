Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CA19EEC2
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738951513; cv=none; b=sTc0rAMlR7a4h8b4evMCLWVVLTzGzzMMfLrRMhU116tPQe833hsizj1yMAaUcLL8p5oDu2NZAdTvjxyn12t3ddl1PqHZ/7TZwgexK8lo9cjOLpGwkZ5Z3hH+t2mtHxw8b9vu3OHEJL8I41dujsw8sYcMP8na+aCKfrYZdZ0FRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738951513; c=relaxed/simple;
	bh=qalDj1sBcoh2ukvSwbfhwjWcR2BCdSia+c5hcBlhKRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VaYcACPNF/JVWjdrzW5Dnxla2zxDjQaUKSzK9420un+Ei6uX6ZiDFooJhOyTX0QHgmEepYYAXVPpRPjQk232K5kmF16DlBlkY7lRajgkdFtA5w7vOjpyzICplV3uo3DTUzXsOHe5B3DUjhyfpQHn5t1a5IvGeiwTMSfqepcY9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k7nWByfU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpoiTnQK; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k7nWByfU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpoiTnQK"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 17C3F1380166;
	Fri,  7 Feb 2025 13:05:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 07 Feb 2025 13:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738951511; x=1739037911; bh=iFtUsa9xKH
	8g7i6vNTjhdMRyjy2hO0C/ka89Tg3KBog=; b=k7nWByfUddmd83JT0w4+FBHBR2
	o3szlY3tHUb+GoA+pu7RSQz1UebNB2ucrFyW/hYICmjKSWxCotNX+ZVv1LDNer0b
	fi/CQbkVckJay+/wxewWyqYqHzODsSK/OkgSdlpV5WCXTLTVCAEm+xakYXyL7obd
	6u7Skpaj7RNPnZi5AcXYGvElP4HsjjoxBmJmRPB8ixlgcaPolE4gmquhD+gr5wi4
	Hx8LuOZpVWCXUNJzKZOYn5BJBHktErtJZdm6Y3jMNzw7zghMFAxDoyzoyOT/RrJb
	gKcbbgxztlY6MGe4bEC1gE9j1nDdqiaUtN/55LHEOX1fJqPKqP5FY/7nquVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738951511; x=1739037911; bh=iFtUsa9xKH8g7i6vNTjhdMRyjy2hO0C/ka8
	9Tg3KBog=; b=GpoiTnQKHpgCjz1SZ2FPmZFLSZBGjVQ+ktKVhKtja59bkNsqIk7
	sczCvcSSSalsGFx7HMJcqhA2pgaAcph+zB+WLekWR1AkXhScZlIeJBnPDbP0UY6f
	cuCLf4Lkr73zleLwnfVoIE1BlkEkhaE/J8YDAxdQzybeRFqdZsLR7IiVRrhfzYX2
	3Tk0pa8uVdo3eBpo1wLJ6sUPYyJbz8tqje3kBGO1cZZbSsWSlz2huo9lngwD2Hxm
	eSIUrUEPYLjSrwOL7kGtizZouGqjR4RNCRZcju9p18N+sYLCX8q7X8IAsptJI72F
	Pqaz7SEzPHZsapHQKGwjmcoT9ghihSeAszw==
X-ME-Sender: <xms:VkumZ0yBfT_PVONcVdi0-h1NH8ywjHzGd8MH-C571A8b2fa3QvCFxA>
    <xme:VkumZ4RxoCyLp-73Ncp9YgbiOJVaqPocT6obgyR802CrkwDR0sbkdZWcg28TMzvfT
    gBwQ6_8JgM0JIsC-g>
X-ME-Received: <xmr:VkumZ2VFXTu5RDbGBVxvB0jl9fAT1c40gsS9sk5PkH0kRiATYPh-xw2ck4RWPpdCX1F8bpD-YNT5GWPvQg3is_61HW6-cX9Wv2qH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhruges
    ghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhoth
    hhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VkumZyi2DudiG293K0sR66mWzfvk4THFe8eBaJrvItKJ4ZLwFc_yZA>
    <xmx:VkumZ2BDD3LF5IR7NkOaiVdZWolqXCNP-33RgJKfPFNXvTgaDKVQFA>
    <xmx:VkumZzKMbiT-RjvDqJW7ccJx_Hmpphi2pJJp_tf3yiGcUPVdW_R48Q>
    <xmx:VkumZ9AuvOHJsjcUSohhubLyYtz6lMRs8b6-FIQWbemH0AAaBfiGRg>
    <xmx:VkumZ97OKMB_Z2m2QD14xRxZVjYVYfySOFWkfVp17ocrw9b5oncTHCbH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 13:05:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: M Hickford <mirth.hickford@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
In-Reply-To: <CALnO6CAa+6xx885TdKFrpruxHbN80S3RE=STaswnaUz_3QZQ=Q@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 7 Feb 2025 12:51:48 -0500")
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
	<20250120015603.1980991-5-sandals@crustytoothpaste.net>
	<CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
	<xmqqo6zeixnk.fsf@gitster.g>
	<CALnO6CAa+6xx885TdKFrpruxHbN80S3RE=STaswnaUz_3QZQ=Q@mail.gmail.com>
Date: Fri, 07 Feb 2025 10:05:09 -0800
Message-ID: <xmqqtt95fx62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> Do we pass SubmittingPatches (and CodingGuidelines for that matter)
>> through AsciiDoc?  They do not even have .txt suffix, so I suspect
>> it is not.
>
> I don't know how (I didn't dig), but we do build and package
> HTML-ified SubmittingPatches as both $(git
> --html-path)/SubmittingPatches.{html,txt}. I don't see a build output

I was wondering why we remove SubmittingPatches.txt with "make
clean" there the other day.  There is a Documentation/Makefile
target to create %.txt from % applied for SubmittingPatches.

> for CodingGuidelines, though. (We also package
> ReviewingGuidelines.{html,txt}, but it has a .txt extension.)

Thanks for noticing an annoying inconsistency that must be rectified
independent of brian's topic to help it easier for Editors to
identify the files that are written in AsciiDoc.  If we are shipping
documents that are exclusively meant for Git developers, we should
be shipping all of them together.

Thanks.


