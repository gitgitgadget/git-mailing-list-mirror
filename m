Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49821FF23
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780535359; cv=none; b=ldCP4zgSGxSyuy7+plhUfMLTUnEkgRKxvIGv1HjEMfXDp0KLjqmC9huq3y/LFv/kz/7yqf6ylkWFtAamjmhQLOPewXjlGEJrFnM0YvvJhMeQf5v2BB0L4TSB5gkXf74Rm+1NIx/hJUFjw7X1IYzAInKKgu1kd70aBiya+kEU3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780535359; c=relaxed/simple;
	bh=+RFJrw2fGY44sYTpIPj67z0ycRaNvDVgoGESMvUmHZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L+RzZE6JM9IrWOFCJ75Zu8Uyp0XvT9q18QeMfqvwkLG7WNyxvpk5POiM7gMhKuOufnLcJQdbfUHXohvUVLt85EVew0v3zTwNPcFFtK8EH/+U0TPmqCskhaaVtg07+vv8waockWSgmUZzsFr3SClMfGRThYfm1k58ZRHKCrYk0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gnm8c5++; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxLgyLFc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gnm8c5++";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxLgyLFc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 096DDEC0009;
	Wed,  3 Jun 2026 21:09:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 21:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780535357; x=1780621757; bh=7fg0LafB3/
	njV/xGhCSfkm97bgVNZYZjhm5igRCU+f4=; b=gnm8c5++FYWzEY1L73BDJHLVnA
	a9IIM51bA76KXqaXgkx75ozEtp52n83E5imsc/cNHN/82eIEcIZK4hzgCZivFNQ0
	UrwTsalpRA5Eh4MpuADvChPj/d4wKRgjhFrxbanvnnaaA38wLGnhrUiG/6Asu93S
	sJHumMVClZpAChbctzrsnGWW7p+meYTbMlGCRETOpMBuuBneL1g7SbB2XERjpcc5
	QiSIJ5GSVdIy5WYiqqAdrOwfb3MxKx9JjrbhR58Ede9xoBOc2E4JV9UyYC+Lpvht
	fnnUbfzEDdVe0M3fLaSg0ytLJMERi/fXAwVBjkmWAhR5vgMLMc2tFC/ykfuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780535357; x=1780621757; bh=7fg0LafB3/njV/xGhCSfkm97bgVNZYZjhm5
	igRCU+f4=; b=jxLgyLFcZnLbDajtqPqpkcrAWBleZzihSXVeUDCFYsjdIvXW1OL
	ovKmifZ/fwWgl6Gigyxo2j2O3K1maXzPr2CwKze7zuc61Ccp6ZiheV1OM/+2FKIl
	ciKrxZzFm+ZnuMd4KsOkW1UeYyinBhpvOkJ8r3OYqvj7XqUvnHY3y486neCG1ubp
	tFGF/8XjQ2sbfeq1U6C2psWZR47V3WseZaQ9SB9GjU6R3ZT25HsJLyCDes+D3Uj6
	3lFu2+HUhCZisQtHs8JLK/tM1l+wC0oFEJDbdVHzzfMh82Zo7m5pffXuLLVHcA5f
	NnoXBFdd8IY/IBveE01myat+UW1Gi7Gg9OA==
X-ME-Sender: <xms:PNAgaoW9hNKooDx4zDlwdGIwwrX9Ljsk3XaPE_IWoXlLzJHX3GSoDQ>
    <xme:PNAgav035CXa9Ss6Ee7q_3oh3_UVQpvSHfi6as3LW2x4rObCMCOgRqxdsYUGcwPgJ
    fxgmUMAVqyKrtY0-yRixQ0GipqeBMeSYU71S8mEXnr1GR4Je8v8IQ>
X-ME-Received: <xmr:PNAgal2ofxjmFSmYW-wiLrF6SSyxlPSbVW5Vf_hJkMx8tYcAW16gX0X94xOx2M7cFT6Np_XUmapIEtD5YiUZa0aH3tdg5yDfEH2_>
X-ME-Proxy-Cause: dmFkZTEf5jOQN56N+PrC68+68EuVO2CQzF7pUqcSYNt5BhvbaKy9mv5I/xZ0U5LQgiOFAx
    y4vdv6u6jNaCM0PKlnFP3Y10WiVciN2rhgu/o5VB6NT+N3F9ZWF9u2mhTklNOpSFe1XzsW
    Lg2huv7ZXlF3oYM8rQOKQ2ZDcZviOHRRTLS7lT9L4eSlMGcMdkURdljWqE6vPYPhLYza6N
    5FwomSrfGGXvBn/CpC6E+vLK0HqOclsYLaYUZlCyhYeZU2QZhqD9PrZFgcFhrm6A4kMz4Q
    PtISmyAzDaF9uiz8S7yjewSD7mxViYVEc2ngJVywOYjhwVkVLUbodwen+Gi2ayJtKQHoQR
    RleY8q1yHPqeQcaoLDYIixchC1zJ9W7A7DpnOVKo+gQMdffFNFGmYFUzpReIgpr/v26Qbu
    nGCJHKPOFQSqoUKMyhvl75Jb6Qbr5T0eimn4kFLhBZgfkYKu16NLwnllp0J7h20f65zhv4
    Unq5TMkbQ2nSeayMBf/Ps1xiRbj41Nfjs3kknPJ7USU41HClVbW8/nU3CScDvAGcvhZFQD
    fCrZJrE9s5D00Lh274+/CAg4zdD5W46BEVT2frdb+6z8qnxcELqYnzgM7US5WPutSaoveq
    wbbI0sRx2uXY9p9KkHCNzsxw3Nwl8GY9bNI7flNG6RWohRaTh7urjUcD99JA
X-ME-Proxy: <xmx:PNAgai-5u2V8PJvJHTp2r9WGKosgwk7GZX78tc2nSxuaLJEdGuVm3A>
    <xmx:PNAgai2UM331lBT4Hw180zgEz1CgJydXwblcrPD3xD2urh5Y2MvkQg>
    <xmx:PNAgav-OZbMzu2ff1DCdZwx1LghXxKiH1DdOMAJcMs_LL6TLMAB8kA>
    <xmx:PNAgaiu9-fitkCSXbLjQWsBpZKVQlkhSfMW0Jf8LR8e5sZw5Le7TuA>
    <xmx:PdAganbFfWLe8mcgx3VqZvKclUxG-dFHyYiWbmrPtaFxKFDLSIVMpA43>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 21:09:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Benson Muite <benson_muite@emailplus.org>
Cc: git@vger.kernel.org
Subject: Re: Mirror repositories for submodules
In-Reply-To: <875x42vlgv.fsf@emailplus.org> (Benson Muite's message of "Mon,
	01 Jun 2026 09:11:28 +0300")
References: <875x42vlgv.fsf@emailplus.org>
Date: Thu, 04 Jun 2026 10:09:15 +0900
Message-ID: <xmqqcxy7qfgk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benson Muite <benson_muite@emailplus.org> writes:

> Would a contribution to add mirror repositories as alternate submodule
> sources be considered for inclusion?  Some projects have mirror
> repositories on other hosting services, and may have bandwidth limits on
> their primary hosting service.  Being able to indicate mirror
> repositories for where to check for updates and sources for submodules
> when doing `git clone --recurse-submodules https://my.repo ` or `git
> submodule update --init --recursive` would be helpful when there is a
> timeout.

I do not see why such a "oh, the repository at $URL1 seems to be
down, but we know $URL2 serves the equivalent information, so let's
go there instead" feature has to be limited to submodule use case.

So, no, I do not think a contribution to add mirror repositories as
alternate submodule sources should be considered for inclusion, as
it artificially limits usefulness of the feature.  A feature to add
mirror repositories as alternate sources might be worth considering,
though.
