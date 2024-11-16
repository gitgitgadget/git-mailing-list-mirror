Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044EE5C96
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731767330; cv=none; b=vBJeGo+kdM55YFDnBZ5XRd3fBxQQEB47WjdSwxeZqKFKM40KQN+WLovzAkULU7CpxdHC0Rz1JykC8eLlcaiX11rNuHyfo/PX7oYxUleA94Q+kx717uJb25BE+AddmD/AV6Wekb3wiCboXYbDLCMw2ekNrnfm5DGxEM/ISHtnORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731767330; c=relaxed/simple;
	bh=Yd0SwY7YBmUF+Utk0/T3y3kcxaQtHPS2ccYwnvKIfJs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a6BrTGcFasxMvTODLTyxrTlIAONBvWTqCc0GAEM4RPVyXDbijTcmW6p1zMrPn4dKIl32zprc8NfwPzAFFf6YUiJ6pKxIUpaVHLgxiC/HDmnMI1BxWpm+9SKSqT9Bel3vtGH8taicD3FeRBKw4JvXpywoEOnbxPKyvQPmRLaDeos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Sx0k+r1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCdgyxU7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Sx0k+r1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCdgyxU7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1C6C11400E9;
	Sat, 16 Nov 2024 09:28:46 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 16 Nov 2024 09:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731767326;
	 x=1731853726; bh=ZSMPQvVLwXCwokzHMRfVKfz1CCABOJT7hK8Is/TdaJc=; b=
	Sx0k+r1ubpClmnc0cOJ+1aFx9f5lAWRA9mujlzi3CNnhBQm+ny7PfEgem+Cyvjej
	HdvW4yU4mJZC4FDyoN0X6NXCKWNfVRiz0sT9Bl0G8xLnPb8SN5My99QM/1EZ3fvk
	Z2l8tkvGnJSOmbgnCxhDMO0443E7+WRUViQhzv5JwNOdOnf/gFeaqBces/o4kXJz
	/Lrz61LIz8Yp7xjmeAohv45P6wUmnWq0Bi0CUhQizRo80DXWqyq+RLlaa1Ao0lJ+
	uj6CkR2S1gQpKdpdC0JUIdwZG3IyDe6Ncm7qrt6M1R+oqMSYKmEXmhY4hljyh91V
	d9MpJb1oLDRad3p1uXS+nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731767326; x=
	1731853726; bh=ZSMPQvVLwXCwokzHMRfVKfz1CCABOJT7hK8Is/TdaJc=; b=g
	CdgyxU7/F/HbR+YwHJNpmaDCNWXDumQYgiiS6ZqxfShmn1LF/P8UgHvjMOYbM0Jm
	ehI9qYqZw0t73/QWcZGAYArKXcKYrLWVmEb8ZqWDGhNEEYNwmm9seP8Ct0N/zRmn
	HMpMeGaa8hRfhVVa5RY8zCRZ/V74Ql25mNEYuTCOwNdzoptrnht6Y8qxCTLr4+sm
	7hodHVhoxIO9VtvoPfcJYrU4CXVJfVXea0o1dv0ym9R7lQqZAWvknqUlezuGggJ0
	w2D2kihMCoVEheLj2BoGTgeY5560SxrtCMs3NCJoagm2JGuW6DW0/4q+BY90rvIB
	jXxMSvaVNF0N31M9NpYWQ==
X-ME-Sender: <xms:Hqw4Z4nNCCT0LxjeyLc82mspECEe48ZXVj_kjLbBpr-Aq_tMGHSm-BQ>
    <xme:Hqw4Z321qtCTyKM9V_MgWFSR8uff-4eyt4JuIxrFUc3G623pJWrYMfpPuWJFpZ3AA
    BaPCiLWiTLMiP1Wsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    evkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfj
    rghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeek
    leeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Hqw4Z2rsWeTgZHKB-9GS0pFMIfclANRe91y2l7WbkNCA5g7ql3R0yg>
    <xmx:Hqw4Z0lRTCcOln3V1h9-ubfE09iii6H7Fl4w9Ak9gYiHd4-JdOt2Jg>
    <xmx:Hqw4Z232FcZ6-6acLUgB9__WyU9tvAKJ8465QqtiwStvgrNJvy4TOg>
    <xmx:Hqw4Z7t2IkZwFjdxw3L-tsRpcqiaztarZ2mQfxswrAEHBxZ3HzqepA>
    <xmx:Hqw4Z5TPfoTp67NZ2zu5EpsqPm0mSI_HeqCrr-oQHnffHACGcixxpFpp>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8E2A780068; Sat, 16 Nov 2024 09:28:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 16 Nov 2024 15:28:26 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
Message-Id: <31492b4b-e8fa-4598-a975-fef2ec861b80@app.fastmail.com>
In-Reply-To: <xmqqh68c3vr8.fsf@gitster.g>
References: <cover.1730234365.git.code@khaugsbakk.name>
 <cover.1730979849.git.code@khaugsbakk.name>
 <b222c6787a79c852442969721dadc629ca84cd5b.1730979849.git.code@khaugsbakk.name>
 <xmqq1pzmqy97.fsf@gitster.g>
 <d9b1dac0-5b30-47c8-af47-190f4ed96748@app.fastmail.com>
 <aeb7acb2-792d-4ec5-bcdf-da2eceb49c4e@app.fastmail.com>
 <xmqqh68c3vr8.fsf@gitster.g>
Subject: Re: [PATCH v3 1/4] Documentation/git-bundle.txt: mention full backup example
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024, at 23:58, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> Maybe it=E2=80=99s possible but I kind of want to say =E2=80=9Cokay j=
ust pop your
>> stashes and make regular commits/branches=E2=80=9D.
>
> That requires _more_ than recording the value of the ref for stash,
> as data for the Nth stash is recorded as the Nth reflog entry for
> that ref, and the reflog data is not what fetch/push/clone/bundle
> commands make available.
>
>> I=E2=80=99m not sure how to formulate that.  Seems clumsy:
>>
>>      refs are included in the bundle (also `refs/stash` but that
>>      particular one won't be included in e.g. a clone):
>>
>> Would it be too drastic to use a footnote?
>
> I am not sure what you want to refer to with "that particular one",
> but the value of refs/stash does get recorded, and making a mirror
> clone out of the resulting bundle does give refs/stash with the
> value of the refs/stash in the original repository where the bundle
> was taken from.  So refs/stash _does_ get included.  What is not
> included is the reflog data for that ref (or any other ref, for that
> matter).
>
> Because the ref value is transferred via fetch/push/clone/bundle but
> the reflog (i.e. past values of a ref) data is *not*, "git stash
> show stash@{4}" is not something you can recreate in the copy of a
> repository, whether you create the copy with "clone" or "bundle +
> clone".  The story is the same for other refs, and stash is not that
> special in this regard.  "git show master@{yesterday}" in a freshly
> created copy would give something entirely different from what you
> would get in the original repository you mirror-cloned or took a
> bundle from.
>
> You'd need "cp -r" for that.

Thanks.  I get it now.

I always forget that the stash uses the reflog.
