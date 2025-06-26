Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A532F1FFE
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750898016; cv=none; b=XHdEOaalq/B12BxsGYdl1Fj3BAXeNnx5tSFjabp/kJeXvsG/EmZTTSf9Zjk552YrIswviQaB32Uvlk15KCFzNc8Qc7/2WT2FEbhw43plMKwFeGBC2+s17qE8FYAG97DG+sNv1mEEBMlL3pNQI0PKwCULAFKaAGEMY4XdNCD3z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750898016; c=relaxed/simple;
	bh=a3NUclX+CRpJIBhPgomhVpDGAqmyddGeBmA5O0go9ns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CzCoeuSC//JB0GGCw/imHnpk8IHO8L5RZapcUyGuCXoIwYF+sJXR+ohkPdJ1Z/QMeJjYKq+Q+2xRBx6uwxrA31rUdz7dyTfaZsmGKrig+TzMXGDVBomroYWSUsVxBeOt5bWBakT+jOlPoZTU+7IdMifdIitC+DOhFeuxdynXt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FomI9llz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g+w5pPWs; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FomI9llz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g+w5pPWs"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3994D1D00272;
	Wed, 25 Jun 2025 20:33:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 25 Jun 2025 20:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750898012;
	 x=1750984412; bh=98shu98UmiOwmmkYtqrWVsiqIelgf6ITTm6LuCf0W3M=; b=
	FomI9llzdRUJ0CSYeC6h7OMiy4cLsZ7VSM9rovzofLhIrGvO6nos2lfjFJc+UBJC
	JdxnSQpnRcK5ApFhHB42BbBGKbdgogpiiZkcR1/QBeW77dzOvGgzdx5fVBUTXite
	P3EZD0ATdt6j4hqBjWA142Wy1pZdv5Zf/sHVPnXin8xl4e2RQP+lVZZKhIMusNo/
	l3V1iDB21aws58WOAUYH1KSf/4nJ86UFCbFYofa0Kp4ppHG/ltsnLRrfhebWAGoK
	jJRt/xIyjy2U6bAhSBdJM6dNK6dRZ1efAIC21S7oTnRGCznPwGwllmyIBC3ryBYH
	ucVMjDz+iCGvVTNKM8++NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750898012; x=
	1750984412; bh=98shu98UmiOwmmkYtqrWVsiqIelgf6ITTm6LuCf0W3M=; b=g
	+w5pPWsZmSfdbE2WMAxdVpjEwM7G4gsa6PtlL1ptTCEJqy59hxgZHOp8qH9k5uKB
	xl1HdZbzkDIU4AkSYA39dL1wdJ15RjbS0u2IH1rKHfR7qFaalzpsfr7sX8GiEYf6
	cMnsh1bz+BHgB5iN5ZmuoRAoOT6RPqfgWowzharB+YgNO3FQ20TvsAeC2xJ/eXyn
	j6C7DVIVn5KHxRpOW9XIt5s53UB1LVMT+PIFSdovluRVuzbmdBspZxTwNIxAVfe/
	XZ4/XkVaBqOnlfgNtBF3RdXtpBR7MwJ79AVFUeznJRJZ2ArEOLvwUgqHcZueSmgt
	C6AD5YgdQCA0Y/L2opa/w==
X-ME-Sender: <xms:W5VcaHVUKjxWnvojT6wOd3E-wycYPPft7DQDcI6yFWz-cc7HZsTr9Q>
    <xme:W5VcaPkvuT-Sw1wHhShMUS8aKFuBeYYwKvAL48eGkFltx_PkRPkn0dD0uNy01uNrR
    9uNua27MCe4_Tcddw>
X-ME-Received: <xmr:W5VcaDZ736Gf2zvszWL6Pa-pyh5DFq314nz8xgwSGMenI9ljLmEdLQgzS_7OT_1SM0_8tMLZjCZJkbmoOSbQErVn1X1SrEvt2v0rHFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvgedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:W5VcaCVmhWM-Rymm8_W5FCVsyBG4DHDjJscS3CMSv0MMkrDOLRAJ1w>
    <xmx:W5VcaBmA8bUAOlj0Df1hFjpI8LIlrurJWwd5esow3htK3Ya3wUHDeQ>
    <xmx:W5VcaPec3LYSms28LGWe6ZDcSO7tZ3sxygXc49xx2-se-IiedPWjfg>
    <xmx:W5VcaLFQRmlbSjk4eFY0YnZBFUpEERRP-72nUXqDOL5NkBxdyYVH8Q>
    <xmx:XJVcaC0TxkS7NODAh_8shz-fNL0t2EFNyg3bi_gt2sdLJDnceFDjE4kP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 20:33:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/3] compat/posix.h: track SA_RESTART fallback
In-Reply-To: <4oh4eatsp4wo4ur6rluy6ickfy5jfpuarg435vplrqzvk3eaiz@jbtnnwqnz2yi>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 25 Jun
 2025 15:24:55
	-0700")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
	<xmqq4iw3yfd8.fsf@gitster.g>
	<4oh4eatsp4wo4ur6rluy6ickfy5jfpuarg435vplrqzvk3eaiz@jbtnnwqnz2yi>
Date: Wed, 25 Jun 2025 17:33:29 -0700
Message-ID: <xmqqzfdvqr3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> On Wed, Jun 25, 2025 at 09:07:15AM -0800, Junio C Hamano wrote:
>> "Carlo Marcelo Arenas Belón via GitGitGadget"
>> <gitgitgadget@gmail.com> writes:
>> 
>> > +# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
>> > +# prefer using ANSI C signal() over POSIX sigaction()
>> > +
>> > +AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
>> > +	AC_COMPILE_IFELSE(
>> > +		[AC_LANG_PROGRAM([#include <signal.h>], [[
>> > +		#ifdef SA_RESTART
>> > +		#endif
>> > +		siginterrupt(SIGCHLD, 1)
>> 
>> This is curious.  What is this #ifdef/#endif doing that does not
>> have anything in it?
>
> It checks that `SA_RESTART` is defined in `signal.h`, which should
> fail at least in QNX, NonStop and Windows.

The above roughly expands to

        #include <signal.h>
        int main(void)
        {
                #ifdef SA_RESTART
                #endif
                siginterrupt(SIGCHLD, 1);
                return 0;
        }

Are you saying that a preprocessor macro SA_RESTART, which may or
may not be defined, when asked by "#ifdef", causes what is left in
the preprocessed source change in any meaningful way to cause the
compilation to fail?

I understand that these platforms may fail to compile the above due
to siginterrupt() not declared in <signal.h>, but I cannot quite see
how the empty #ifdef NO_SUCH_SYMBOL/#endif block that comes before
it changes anything.

On a debian-derived host I happen to have access to, compiling the
above fails, with or without "s/SA_RESTART/NO_SUCH_SYMBOL/", not
because of the empty #ifdef/#endif block, but because use of
siginterrupt() gets deprecation warning.
