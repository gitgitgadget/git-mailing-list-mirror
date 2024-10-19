Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03C3C24
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729335856; cv=none; b=DTs7wE5w/heSK2Zr00m4tzpp/uSWbWbNiZcgqHrQvKV6zg+IFWkTQctkGkUf+Vnl2kZEghVzeGFt3AIKeuHtcoIapfusCeYJHCkmFcZ9fb5dLZpKoVRMy4v/yAcK3qq8YbK4/XmNY24ybkkteTAZkSMzBqkFRu9B9d0L2/+N8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729335856; c=relaxed/simple;
	bh=3yOuZzUNa9sS0ioBJyijRMBBH0ZkWRxF0JkUfSyngjw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Th9C//QzDRSMgVvtvUKx1i+tEQucVPDZMyYJL/Lx9uv2PpGh5icZuURyCxz642GdO1rJsEx6k84T0grfoz50n1wRbz3vMwCIW6a3zvmzeaqo1qI0PVyXtfiMupnoCHAPLMk4xeZIGD4RD/IV2CCj1/6P6fI9/S5dk41cPiobbac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=H1oESI6n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhgJcLEv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="H1oESI6n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhgJcLEv"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94F1711401D8;
	Sat, 19 Oct 2024 07:04:12 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 19 Oct 2024 07:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729335852;
	 x=1729422252; bh=4yNjHkU3R5g+JZTpI0ThimFSSYhQYxWURAgqFQceEEs=; b=
	H1oESI6nl3YSO/w/+e1Mn/FNxHkg7B0rEYF47wSJ9dC76V3xQ4Ny/hb/wYo/1Puw
	qBOVhbX9zLVQpCEoZCnIZSLN6haKJAiA4E2hBuvoxDyczgZhs3GS8+ajUFN84L4z
	cU9/Ydka4J3eYKUXlVYtPdp5lNhhZT2RcL9TUUq1HkFYXVagIWNGeYc/GCm7sqmw
	nE7dtwT0n4pB9+EUb0obTc6lDFkNL6n5LGYz9fNonmR7y2cs/WFqpuO+0g0mBeSY
	r4XPhlA1JO27Ozws+rLT72qrT6skIcB0RKqIlL6XVaWBZKpjvrbri9grg749ej3T
	mOIYBjN6jZTVbj9M5YKlpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729335852; x=
	1729422252; bh=4yNjHkU3R5g+JZTpI0ThimFSSYhQYxWURAgqFQceEEs=; b=R
	hgJcLEv3tt/5xE+OOrKYwb9ql2JxeRGq9kiNytGILcpta/YJ3DYodf3K12YQx2W1
	YziuwsEBUV0nPKYhbn3Co3e/ua6HE35ewKxNP8JdwM0xfjgBp/YbcJrkmcjWgQ6w
	7kRUOfVqMjNOplWgi+cZ7VEjDrKOpWa2LhythJ+ETSf0zxK4YLBKq7PK7T/sbz/f
	EhCBN82FYnYM26my8LrVnNUuQTSaut3RiFGZHXIR0n6ZIz6nig7HaxtAtUxiWyqS
	2Dwue9Busi1cK641uMLnc2gCFRuX4WEwH0pEi+oo+/i5Zx9h6vdb19757hQaOd4E
	dZRsn42D7iOIrnemjaj1Q==
X-ME-Sender: <xms:LJITZ1wBhQTt6eHLXTVRXzBq_eMJDjmT6SAf7m4QXMrgb_gSkn4U5wo>
    <xme:LJITZ1RYoLzUvWgr_avUVNA89L6fBEGd99sLEy7Uric4GU8r0IknrQ8yg-nNzZFFo
    ZePW9eh3K2b06OH9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegrsghrrg
    hhrghmrgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LJITZ_VrcZzuj12B1zZ2HzA8L64Jx1R9uT8O2syZ7vc7NgDDMSXiPg>
    <xmx:LJITZ3iBCMS_Lse_BtzuN6iD4VN9n9jxx3dH0gfsK88_gM7SzKVU3g>
    <xmx:LJITZ3C01MJCz8CQdLwlJz5_Xjati3uGQikB--zREQvDDO7FrlYRTQ>
    <xmx:LJITZwIQ1AYrBgdoTwofnifXN8S-kWwuIIpfbryvMiQRiq00e-ta5A>
    <xmx:LJITZ-OzOQspL94skGKiCcYuFuz7TXbjFEYqGZLV7tjH9a4Li9yw9VUL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3CE4C780068; Sat, 19 Oct 2024 07:04:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 13:03:51 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Josh Soref" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Samuel Adekunle Abraham" <abrahamadekunle50@gmail.com>
Message-Id: <55176c6e-7ac1-46e6-affa-184307a0edf4@app.fastmail.com>
In-Reply-To: <ZxL_oAXN5KQ4FVMc@tapette.crustytoothpaste.net>
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
 <ZxL_oAXN5KQ4FVMc@tapette.crustytoothpaste.net>
Subject: Re: [PATCH] notes: teach the -e option to edit messages in editor
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi brian and Samuel

On Sat, Oct 19, 2024, at 02:38, brian m. carlson wrote:
> On 2024-10-19 at 00:14:13, Samuel Adekunle Abraham via GitGitGadget wr=
ote:
>> +test_expect_success '"git notes add" with -m/-F invokes the editor w=
ith -e' '
>> +	test_commit 19th &&
>> +	GIT_EDITOR=3D"true" git notes add -m "note message" -e &&
>> +	git notes remove HEAD &&
>> +	echo "message from file" >file_1 &&
>> +	GIT_EDITOR=3D"true" git notes add -F file_1 -e &&
>> +	git notes remove HEAD
>> +'
>
> Maybe I don't understand what this is supposed to be testing (and if s=
o,
> please correct me), but how are we verifying that the editor is being
> invoked?  If we're invoking `true`, then that doesn't change the messa=
ge
> in any way, so if we suddenly stopped invoking the editor, I don't thi=
nk
> this would fail.

I also didn=E2=80=99t understand these tests.

There is this test in this file/test suite which tests the negative
case:

    test_expect_success 'empty notes do not invoke the editor' '
            test_commit 18th &&
            GIT_EDITOR=3D"false" git notes add -C "$empty_blob" --allow-=
empty &&
            git notes remove HEAD &&
            GIT_EDITOR=3D"false" git notes add -m "" --allow-empty &&
            git notes remove HEAD &&
            GIT_EDITOR=3D"false" git notes add -F /dev/null --allow-empt=
y &&
            git notes remove HEAD
    '

And this works because the commands would fail if the editor was invoked:

    error: there was a problem with the editor 'false'

But this doesn=E2=80=99t work for `true`.

> Maybe we could use something else as `GIT_EDITOR` instead.  For exampl=
e,
> if we did `GIT_EDITOR=3D"perl -pi -e s/file/editor/" git notes add -F =
file_1 -e`
> (with an appropriate PERL prerequisite), then we could test that the
> message after the fact was "message from editor", which would help us
> verify that both the `-F` and `-e` options were being honoured.
> (Similar things can be said about the tests you added below this as
> well.)

This file defines a `fake_editor`:[1]

    write_script fake_editor <<\EOF
    echo "$MSG" >"$1"
    echo "$MSG" >&2
    EOF
    GIT_EDITOR=3D./fake_editor
    export GIT_EDITOR

And it looks like this is how it is used:

    test_expect_success 'create notes' '
            MSG=3Db4 git notes add &&
            test_path_is_missing .git/NOTES_EDITMSG &&
            git ls-tree -r refs/notes/commits >actual &&
            test_line_count =3D 1 actual &&
            echo b4 >expect &&
            git notes show >actual &&
            test_cmp expect actual &&
            git show HEAD^ &&
            test_must_fail git notes show HEAD^
    '

So it seems that the new tests here should use the `test_cmp expect
actual` style.

=E2=80=A0 1: The different test files use both `fake_editor`, `fake-edit=
or`,
    and `fakeeditor`.

> Do you think there are any cases where testing the `--no-edit`
> functionality might be helpful?  For example, is `git notes edit` ever
> useful to invoke with such an option, like one might do with `git comm=
it
> amend`?  (This isn't rhetorical, since the notes code is one of the ar=
eas
> of Git I'm least familiar with, so I ask both because I'm curious and =
if
> you think it's a useful thing to do, then tests might be a good idea.)

Yes, that is useful (both as a use-case and as a regression test[2]).
git-notes(1) is often used to programmatically add metadata:

    git show todo:post-applypatch | grep -C5 refs/notes/amlog

(And this non-interactive example is not affected by this change since
`-e` is required in order to invoke the editor)

=E2=80=A0 2: I seem to recall a regression in how git-notes(1) chose to =
invoke
   the editor or not
