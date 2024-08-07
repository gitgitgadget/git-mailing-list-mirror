Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3B18EBF
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054781; cv=none; b=gb9594SR7YMKNtB22PaZwJBDGOCVYDo8mr+gPAjo4/oxH+i2TdG2jHdbpEUaPpT/GXX0m8Rguygm6mgVXvleVyzCqcsQ6v691AUi0XldYSSLV6TxR90J6PsTOEqMS1j8dX8rQzX4mDDjDRuUf/xvtyd9OMBtxMgfFi9v59zU71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054781; c=relaxed/simple;
	bh=82x541HpMPO8JBTDtwTcVN2brXqDBg0CsPNXqSdZgV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yep75lPLp6XeZE5fftpdJyiGTMkL7mLuYS8ZQhDzZ5IhSV9D7095KOAjxjKfo78y3VhxkYFXYl2T0PgwKEnCOitR3k7Q6ToXoJIGLli1L2U1jvbVz1c3iJ+84JHm2+JGV5cmbzUMopGcoK1D8SXKmsmHqqFfVm6QN2RCGPEnVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=W+jCoHh7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="W+jCoHh7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723054773; x=1723659573;
	i=oswald.buddenhagen@gmx.de;
	bh=BQa4azcWO7M/+HJz4HaeGOljDyNe9GFJVbI1wLqzDnI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W+jCoHh7gcndvIXXBj56j6ukr2kPGuY9NonHg1kTyWBP4xHI+WACOhrdNhO2SSl7
	 t5bu/F71WiDmpRRsMNIZ2SZg4rnAGliqrHRHGvyH5lEfcV7rFoVPauvjC104nV/HM
	 SVsR5mSvSkQhmD4bo7HJr6eF5MCk7/7HwcS9duWjXm5xALWlgmyv8pxF7Gm2857WJ
	 2OmcM6dkrKXnKWQyjvgJaAgQw0ykkhFQIz/y8uKR+RJKjvJBUhkFG/Caa87v8iYgq
	 PT0O6nKkrODHoCmgZfWUWrZ4MnqdzrF+Hd6XXH1JsLYHcdDlCQmZX2vdIGXUXt6wC
	 FZ8nkLwskVRE64/POg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.110]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJhU-1ruhCC3sai-00mKSW; Wed, 07
 Aug 2024 20:19:32 +0200
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1sblG0-hm5-00; Wed, 07 Aug 2024 20:19:32 +0200
Date: Wed, 7 Aug 2024 20:19:32 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Brian Lyles <brianmlyles@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Sean Allred <allred.sean@gmail.com>
Subject: Re: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
Message-ID: <ZrO6tM0fZLly1bPA@ugly>
References: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
 <CAPig+cRQPrtGBTxM49nUeHvsVr0qEOnKZ5W_4by=A9mXEsR3DA@mail.gmail.com>
 <m034onpng4.fsf@epic96565.epic.com>
 <CAPig+cS2r-b22ikZZ6QHpzfneQ07n6s=E40Sb+QYmCnezVFAww@mail.gmail.com>
 <752d41f9-6ce3-4c31-a0a2-4960c7dc1b2b@kdbg.org>
 <xmqqtth2petz.fsf@gitster.g>
 <028ae5d6-b587-4ffe-b837-38f2c13992ae@kdbg.org>
 <CAHPHrSfVLLn_djR1eo06fr5OPaz2RAChv8dBJ8eJKB6b6snWnA@mail.gmail.com>
 <ab9824ee-65e1-4e4b-b739-205f2c5d24fe@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab9824ee-65e1-4e4b-b739-205f2c5d24fe@kdbg.org>
X-Provags-ID: V03:K1:HITxZWehIdFzv/QeKH3NpHp9PDelQyyjBAbFmdd9haDqKm1hqKr
 Mhx78Ot9Q63qZi3AYK0sm2Yv0qjKDcdbOHC+gd+F4yHTPjpQ0AwMZfvjc/GsvlEQSSqyZSZ
 Ze8cdku7pqn2WzcKdeaMz6hxg7T2lDToRRgm4VuJh6XLE/MYd4Ffe8fxlQYq0ysB+I4e4Ih
 nFf2dflV8m9hiN5ZN2zBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m6NApR+u+YA=;Vaw231YOpyYqWT5AT6M8r3u2iOc
 BX1sxcZL5DBx31dPYnmr9+oiuc2jHPjtC9JhtHOLHgoBqUJgeF1Tm7uZPwX/GNyHZX67/29tD
 RhwNgtlwUP755vXpp7RA8IaWTn6+9rBUqhgkBG5ggjiIQ5u7bEZcgF6tf9UFCRUEAMxkcvU01
 4RfkMO955zDDXqgZl+uvn3lMwjcAMSp7Mz1xwJjWVziFU3BbtN/EYq00DZjRcJHcNQ9fcuYxB
 mC3AvyvSfiRbkskM+wEB+4fBzOk5S9X786T7/ItNRZQB3P0RKfuWAyUBzwelwZaPV245mhYOL
 ULXh7dxSEsBa7WPHODOgHL5sLpFgz2nd8h/wIxmP1UTyLXVLdCv6oH8hkcceV+g4hhqA16fwd
 EHqZxXFmgR97B0tJpoAotEidWi9plwIynFSRtVd0DzL5+/M9IphuBsY5CkVi3HjD82Xg/w1oW
 PpDqlLjQhMqBpW7LRvQilMg4++p0Tgj3d8sPxFP2Xn2R0sJTSlvQhWTf7u35s+ktjOFUjee10
 GXdKys8zjNIldJn671UI+z0SC4AFqPGIW/MI1t69xYLFqyRxeNAOXIFPCjiAE8EtJie/TwxIT
 7v/ATiH++g75UWXnJ+yezZiKJA4or/migAIJiLwUf8JnN5A/9mCFC8oAZQdhk73OqQ80fpj4S
 gD1jBjXO96xTjCP5Z4f1ZJk68GywxKJDS5l3Hs8TjHmi/weM/3SQ+l9rROnq+dARyBg1QIm1m
 BeFt/GsOYZbNpssS71QOSKiu0NrVjPvCzOY5uzwoiYxtr8hn4Atg1ux7gGG1RQEzSzRmfG1pG
 GGp9WsxnLa36bKo5vfxY4Vew==
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 10:40:19PM +0200, Johannes Sixt wrote:
>Am 08.07.24 um 21:29 schrieb Brian Lyles:
>> Could you elaborate on why git-gui's commit message edit box should
>> behave differently than any other commit message editor? Why is there n=
o
>> concept as "comment lines" in git-gui?
>
>First of all, Git GUI is not a commit message editor, not even in its
>git citool incarnation. You cannot instruct git commit to use it as
>message editor.
>
nobody suggested that.

>Consider the commit message that git commit presents in the editor. It
>contains the message text, instructions about how to use the tool, a
>list of files, and sometimes even patch text.
>
>Git GUI does that, too: There is the part where the message is entered,
>there is a list or two of files, and there is patch text. (OK, there are
>no instructions.) What the user writes into the part for the message
>text must go into the commit. Except that the git commit's message
>editor has a limitation: it can't tell the subsequent post processing
>with absolute certainty which text is message text due to the possible
>comment lines.
>
>Git GUI can offer this certainty because its
>corresponding section is a dedicated text edit box.
>
no, it can't, as others already pointed out. the attempt to structure
the info is woefully incomplete, pretty much inherently. the text-based
workflow is just "too core" to have interactive frontends deviate from
it. not presenting and interpreting the text as "real" git would will
always be a source of problems, regardless of how many workarounds are
added.

i'll note that the qt creator ide as an example of a git frontend does
strip the message.

>> I think that whatever path forward is taken, it needs to be predictable
>> and consistent with normal `git commit` behaviors. I think that's the
>> root problem here in my mind: From the perspective of the
>> prepare-commit-msg hook, it's impossible to do the right thing because
>> git-gui is invoking the hook consistent with normal `git commit`
>> behaviors, but then creating the commit with `git commit -F` behaviors.
>> This is an inconsistency with git-gui specifically.
>
>Good that you point that out. Git GUI does the wrong thing here. It
>should really request the form corresponding to git commit -F. The
>second option that you suggest looks correct to me:
>
firstly, there is no parameter which would actually tell it whether the
message will be stripped. the 'message' token is unreliable for this
purpose, as -F merely imposes a default on [-no]-edit and thereby
=2D-cleanup.

secondly, it seems a bit optimistic to expect that the hook would
actually implement different output modes.

>> So it still seems like we have two real options:
>>
>> - Start washing the message, allowing the prepare-commit-msg hook to
>>   provide template-like guidance to the user regardless of if they are
>>   using git-gui or some other editor, or
>> - Pass the "message" argument along to the prepare-commit-msg hook so
>>   that it can at least avoid adding template-like content (but of cours=
e
>>   then lose the value added by that template).
>
i'm strongly in favor of the first option.
it also seems to be the much easier one to implement.

