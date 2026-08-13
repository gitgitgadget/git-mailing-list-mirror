Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E643CEED
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657979; cv=none; b=qWWFkUFiaFZNI6kVs7uQZfUaJFO/O4M63UuA+rYa2MdKshk5bkl4kucnJBbl1uNURY44lHhYyzIekXzX0ij3FAhplQytgNE8vmHTiTkoJp1l2MOmrHcmAL0M2lw3B1f+V5r8ArGkt7WO6ktAm4PKdbOkXoQfPJp35h4B8onXXXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657979; c=relaxed/simple;
	bh=zJLRLCRg+tFs/hw+8fpGgCdEpqSM7yA3ebl8KlkDgR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qDRdwjuCRqmtPaqobNJi0IhN5GNWeoUat0aFilP+fE70NyA+EOAYyi6e1+6M5m3Rh5F+yFIwxp8+i1pWhSLoIoO344XIWzEnIkD595t5ZpgNv7OWsj56MUX9N/8IqAYWOFtpKpWf8jcFAlPMxmy6LoPqueLw1iCOpFHXDtCfes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wt6ydXOg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N0bxyGJU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wt6ydXOg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N0bxyGJU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41EE3140020F;
	Thu, 13 Aug 2026 17:52:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 13 Aug 2026 17:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786657976; x=1786744376; bh=THkR4ldXyX
	9vf23t2snv6PROZbbUsPlY1qF1THUVfJY=; b=wt6ydXOgv7Qry/1c39c5+y6pCQ
	eFHKKloVrEGM0x+foJtbJ11+80BjRrGSlClG2H3F8uAWb4GblLTl7wVgSsqJUayL
	UniJHBGGQturuiIg5yqlZi06PucRJlnRb7ElrnNWgNYW/Wkf9pMxW16Dugx8DRHQ
	KE5iazxITIiSbHYggncpqAhZRJvxoB96wna/X/xLSZ1dYi98WyNWkvYUX/AOOdFJ
	PoeVe6N2cXBEHBmLi+SuG4WAWYw84DZIHzmbWFCcTXUMkS7Nuug5DuXM1U9a2zRM
	RIzPs2ceousHDL37i+rkA6oH7OLwb+mTeZ7u4JrkZJ2ytOAC19VUVRdtIh4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786657976; x=1786744376; bh=THkR4ldXyX9vf23t2snv6PROZbbUsPlY1qF
	1THUVfJY=; b=N0bxyGJUY0VBFJDLjG4bztBJkYabwbAypJrL55Nw2iBDJvd8NJn
	oEHxXCNWQRe2OJkSX7KLDNLmS9mNzBdF7yZyldkVkjeXuPRpkbnr8iQmRSY2NHwQ
	34iW7t1V1IH0GhDGvNdm6M+K0PIeV+Wx+qYkMxcN4SqiArctCUqNVZltIRAkgoy9
	kD5fePV1H6MtGHUGwH1CDnZDx+jIhSUCzVL3pbSw62EM1fT+YCF53CnnqvKNNEKy
	YiRays79yOkNqOH1/sZA03HryhXVZ/yuxhALTwPfDjbDRpeFg5yQlTj2D+0x3Evt
	X+VUbJxk4hlcEeEY0TPyuCL6w9zCJ4lHmag==
X-ME-Sender: <xms:tzx-asPYS7r1ebhaSEEkRAoB7vmY1IcV7kFabOK8NXunqAOXGjVT0w>
    <xme:tzx-alhdgpfdieDuTvtVJGdtUco8T9kHKii8DcGLe2GMdCS3J31KpQgRL5-xfu83d
    m7m3F9HiJ8ASMiHfyphkcfam44AjFj1LLeA9JnfbOOLG4Lp16iSzg>
X-ME-Received: <xmr:tzx-am6jnIYQCJ5u8INVO5tONrH-QCKNSCwzjdq48hwt3gfQRbM2AtkixC-Vx3zgSK1PlIvPyGkvkxdM41twiqEA3HwOYaTaEA>
X-ME-Proxy-Cause: dmFkZTFALtHIAsK9ZrcjBpq9CoA44B896D1E2oOnMsdvpnOuBlnoM2d0V7EpwJbILzjf31
    Ax+7cgptr4TyFNbarpOCThcN2S6U041qeeJBHBPWtHHfs6bpa38y6vmUEpofmJA/0UfsLi
    fG2kFuIkffi/HrS72b0DiCaUqJtOcP678Cr2jVHDpNy0M2HgHuDo8p9+F1aD9rT2bv9jU/
    VULZGr+EL01QkmJDa9Gydw7fWmCnaBq9mwMfroP4pu5MOWfpfXe2DS9lwl8xlRc4CwddqX
    DVVWTEHVMecnmiKVs9BgD6Uf7tiW2PXMUX4yv9nJXpfTMtiVtyyYnXSwqQqNjjB8Qb5zso
    SRrVJfuoVHs9zG3dzW24FFt/tbSJkWGrJAZhvJLU3ORhdkU/BM6d8ZFhWOPoL3Bljn8e2K
    Ha5DeTBvol0ahBRozbwK0H8EcSQEvT4mZHwawyIh2H/T3tusq3cWkxJYm0/nPrDHs4qvkw
    vYrNENHHuBMYbCOT2aSoHjbhTXITZwHcYeaYMJIz7mX2XGgJM1ln1+vi49iPPfgra2PlXj
    4EP5v3DvbUIsli3jBySJsLW1Z+Zc6kCg0vfl5uSOBKvnmBOazEkhTzbB7NNZZZEgaaFBv3
    uQ1y0bQXwVoAZ/X/Q9Ocp0iUtSiy4X2U8lcDu+NNlRcdF7giih2wOfNb4DCA
X-ME-Proxy: <xmx:tzx-ak0feybJDnYoA-Fd3gqj4tAJZF6t9lJsjTKxqk2CEdHuY6HHgQ>
    <xmx:tzx-apuxByNDMA-dPnGjNrBeb92D3sHzVDjd7gcjV5lyPfXqHRYBaA>
    <xmx:tzx-ai6XXQpxg02Mlxm0od1vOoaw0UIrFE1A3XZgItxdoeRcIbEjcA>
    <xmx:tzx-ateuG4szMqSpOcFsU-3zehOIOeFsI9V_30ZRlSq5AIWsGROpEQ>
    <xmx:uDx-anE5r9lscOp4gTY7kGO48McXGZnQArFedclDkdQ9YYfMuc21FO-J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 17:52:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Matt
 Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
In-Reply-To: <xmqq4igyszeb.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	13 Aug 2026 10:28:44 -0700")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
	<8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
	<xmqq4igyszeb.fsf@gitster.g>
Date: Thu, 13 Aug 2026 14:52:53 -0700
Message-ID: <xmqqtsoxr8lm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +test_expect_success '--no-edit uses last "amend!" message without an editor' '
>> +	git reset --hard three &&
>> +	write_script editor <<-\EOF &&
>> +	exit 1
>> +	EOF
>> +	test_set_editor "$(pwd)/editor" &&
>> +	echo fix >file &&
>> +	git commit --author="Fix Me <fix.me@example.com>" --fixup=HEAD -a &&
>> +	git commit --allow-empty -F - <<-EOF &&
>> +	amend! $(git rev-parse --short HEAD)
>> +
>> +	The first reword
>> +
>> +	More detail
>> +	EOF
>> +
>> +	git commit --allow-empty -F - <<-\EOF &&
>> +	amend! three
>> +
>> +	The second reword
>> +
>> +	Extra detail
>> +	EOF
>> +
>> +	test_commit WIP &&
>> +
>> +	cat >msg <<-EOF &&
>> +	amend! $(git rev-parse HEAD^ | tr a-f A-F)
>> +
>> +	The third reword
>> +
>> +	Excruciating detail
>> +	EOF
>
> Care to explain why you need to (1) eat the exit status of the 'git
> rev-parse' command and (2) munge the commit object name by piping it
> into "tr"?
>
> When another in-flight topic is in effect, this test will break due
> to "amend!" followed by a string that is *not* an object name, as
> the other topic declares that uppercase letters are not valid in a
> hexadecimal string.

In the meantime, I've queued the following on top of the series
before rebuilding 'seen'.


diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index 591463cb86..d21e9d9fc4 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -309,7 +309,7 @@ test_expect_success '--no-edit uses last "amend!" message without an editor' '
 	test_commit WIP &&
 
 	cat >msg <<-EOF &&
-	amend! $(git rev-parse HEAD^ | tr a-f A-F)
+	amend! $(git rev-parse --short HEAD^)
 
 	The third reword
 
-- 
2.55.0-758-g31b934252d

