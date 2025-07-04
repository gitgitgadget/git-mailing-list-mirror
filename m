Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E81D54FA
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641068; cv=none; b=aK6ZhOpepxkw+0p4oGgFGqlg2OgXUx5ksvZ7rrj/35IU1EA77gXnxKTqFncVCf7FnMxoxUyRfMCMCs4U2khzcuLL3q3khD4L+NfAUUDDuNGQItbkWLrXA4W7IQjTcLkIFx0aba/TNZi+RVpPyGM1ZhkTwjWS842AhlV+A+dVlvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641068; c=relaxed/simple;
	bh=3lkA4d7cLHu01kKpQNOYRlkunhdRCAjcdxeBEpavUgc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qxwV3Gk6U4OerXW/sFnK1et84UAHueDOsU0/wnZf+lg/kSWOSVD2vxsaqQHGqvuu8Pa1nxPfj2GUIJF/VIbgPy657S2jCs9ug6LmwncEfWt7+XsAv4isT7J9TUuY06hvm1kvTPTwkrohknVaBgrcYrtHa5B+BbO5sq3w7ScuI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BsGW0aFM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oH9iWx/E; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BsGW0aFM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oH9iWx/E"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5C1F1400A2C;
	Fri,  4 Jul 2025 10:57:45 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 04 Jul 2025 10:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751641065;
	 x=1751727465; bh=T5RERw0tZ9su2qIoayikRQ+1rWxd3rEmqlyCLbgW/Gw=; b=
	BsGW0aFMni0G0kPvrgQmmKQulGDcA8+IFjsa9cZc9rBAVguy1+GKbRdlAuhLfMPV
	ADBwt4+pEUtJNfnMd/DxPEORMusnn1FTjpntBOJgvWUkqoOkEXhWTycU3qi5HIHV
	yHa+ZP/WONtDmQkVju0o9QyUM15O816V9Rxed/LdPX2X1CxY7zsq/qltA5cjHwRK
	zjY5Epzyn3s6T6qdoYOUiV0QMNWFO0CfHZRv/PgGnJIIUgvmWt76D3QBJW2JwFPP
	FN5amGfZhR0ZVnKBOW5ZkZ3249YjePmtfkbc2YCeMwGGQ3VdYH9itPOKIkKOMlRo
	PEqwFcPimSIvvHEX+Oc72w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751641065; x=
	1751727465; bh=T5RERw0tZ9su2qIoayikRQ+1rWxd3rEmqlyCLbgW/Gw=; b=o
	H9iWx/Egcp2irewfuAGuEuODKRvpiGAMMhsDjGkjIy3VByD3NZ049KnOXOB2U5o7
	6DdkFp5igu6Lx3iCaRgZSImdBJMoKLcI+TlHcdFxbZ5mL82RCcQ/jpEwxAzdlbCm
	iMawHGl62mTv4r7e3SmeFT4U+Mx5faqfnZarl43fFUeYVN3QNxlHCsEb352L7kqw
	vOzKMP+fP/WmBljOula8fOgtKiz81aZH0Cm6vqlA+y3wnRe5tCJcVW+0ZcDTeapf
	ibSktpe7xm0vJ9m1jCS6PoY+p/JLUbcCjMUhiBR0jZW2lXd04VVqElKUhA4MH0gc
	KR7Ba2ngxNutYPgklaMkw==
X-ME-Sender: <xms:6etnaBuoaLKkRTaxMhOMYMI92YBOsT-JQDZP4Ah31HhgR8lH6yeRB7M>
    <xme:6etnaKfxcahOODaYtSP1iiuDVcD9XWkN8T1sORV3TaD9KnWVODCiYyHyXSOJkh5VS
    1QakgLHYQ06J5M8dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegtdejieetgefh
    uedtuedttdeigfdvgeetkedtuedtudfgkeeluefgleetffejffenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepsghorhhishestghouggvshihnhhthhgvshhi
    shdrtghomhdprhgtphhtthhopehkrghrvghnsegtohguvghshihnthhhvghsihhsrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6etnaExG9KZbwOIM037Fd_1pive0Ax6C4QGqOzRylbiISGkeQaejCA>
    <xmx:6etnaIOiHYiboZVQZjKHKKqTxvq-o6s6yf3U7dE1egNyCdBDUxgQeQ>
    <xmx:6etnaB-opzsoDeqzfT0Y7jgE_3OgXKljJanqY2Fj_TpruHe7r7HLEA>
    <xmx:6etnaIUL6WbZYt9gWQ6goGMu9Nb_DMB_NvNOAjDTF-PZXmwdEVbNJg>
    <xmx:6etnaFXZGzEis5aFIxljynVsW2gQNKUe5pXvYqLAyuvrhMGoG_T2hlto>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 629621EA0068; Fri,  4 Jul 2025 10:57:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Td4c5bef4314aafce
Date: Fri, 04 Jul 2025 16:57:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Boris Kolpackov" <boris@codesynthesis.com>, git@vger.kernel.org
Cc: karen@codesynthesis.com
Message-Id: <c20e2e7b-8471-4398-9bfb-6534f8ad2b39@app.fastmail.com>
In-Reply-To: <boris.20250703161436@codesynthesis.com>
References: <boris.20250703161436@codesynthesis.com>
Subject: Re: Document ability to disable template directory in git-init
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 3, 2025, at 16:40, Boris Kolpackov wrote:
> Hello,
>
> Looking at the git-init(1) man page, there doesn't appear to be a way
> to disable copying the contents of the default template directory, other
> than passing a path pointing to an empty directory.
>
> However, if one passes an empty path, for example with the --template
> option, then git does not complain and does not copy anything:
>
> git init --template=
>
> Looking at the code, this undocumented (AFAICS) behavior appears to
> be there at least from git 2.1:
>
>
> static void copy_templates(const char *template_dir)
> {
> 	...
>
> 	if (!template_dir)
> 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
> 	if (!template_dir)
> 		template_dir = init_db_template_dir;
> 	if (!template_dir)
> 		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
> 	if (!template_dir[0])
> 		return;
>
>
> For reference, the corresponding code in 2.50:
>
>
> static void copy_templates(const char *option_template)
> {
> 	const char *template_dir = get_template_dir(option_template);
>	
> 	...
>
> 	if (!template_dir || !*template_dir)
> 		return;
>
>
> I would like to suggest that we document this behavior so that it can
> be relied upon. The motivation for omitting the default template are
> repositories created by tools, such as package managers, for the sole
> purpose of fetching some information from remotes. In this case all
> the stuff copied from the template (such as hooks) is an unnecessary
> waste of time and space.
>
> Looking at the git-init(1) man page, the TEMPLATE DIRECTORY section
> seems like the natural place to document this semantics. For example,
> we could add the following sentence after the list of all the places
> where the template directory can be specified:
>
> "If the specified template directory is an empty path (for example,
> --template=), then no template will be copied."
>
> Let me know what you think.
>
>
> Thanks,
> Boris

You can apparently pass `--no-templates`

```
git init --template=$HOME/git-template --no-templates
```

I had a distinct `description` in the template directory.  That was not
used in the above.
