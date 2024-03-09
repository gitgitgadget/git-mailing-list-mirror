Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06954EB47
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710017200; cv=none; b=Bx0cuf2I9sNwhFPKaDaeSRT3pyqrPaa+i+cm3VFlesUuZRxc194+79dabhdw4Yz2A4eJoha52yxqW6YkxynAHygQY9Gwc303ZzfQ31mQ04H9JYR80Z3nOn3B6qsEPc8ch617OlkV9cLSCsNC1xnrhiBkR7V2JetdHyW5iwiWUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710017200; c=relaxed/simple;
	bh=XSRyRYLazTtMWdP1O1HT4kF5V1hbrW1WRUwIO1o2JDw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tHOGDdxKIl45V2B8hhrKXujHMc8lREgTG0NmaKJv33vzwePJLOMiuF2v9vxd5ppJy+EfqbaS9vRM/7JO9awsXthqJRt0ZO/ccBbWpU98gMO/s0kyF1BgOjabFiscyRG/zLsFk55jf9HYSS6Nd2FOlw5QlqVn00uLq5jd6QPXaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=atz4IFlh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="atz4IFlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710017166; x=1710621966; i=johannes.schindelin@gmx.de;
	bh=XSRyRYLazTtMWdP1O1HT4kF5V1hbrW1WRUwIO1o2JDw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=atz4IFlhl7u7JcrmkkYCXQMqwiTQ1l169Z3EdjYuM9xPGU67AO/9p4Ss7LX0Mk8G
	 SVlydNu8dgtQGvHP/wTRjE/qOlHcaKk0NWiKMODtohVD76yO1/+iJ5I1YdXmwCzrw
	 uc1BdRqVWPslrmvc4Gx0hZAf76ujz6ItLxborme0SZDDjnVAlWK/rkheKuG4eAa76
	 CCOxRtkks+RKzVclKxBpqzD42YcxYekTKyegyJj9OfrkqU3IYNr5L8WmJTHUnN2rC
	 oBkXy2+/OKTbnd++NLx4kSRe6T27knsfpK9fiJBURT4RC/VwHsJFddcrCJbLk6mft
	 E+WCtJWF36eCoPaoJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.100]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1rTb8A2T3w-00OH0P; Sat, 09
 Mar 2024 21:46:06 +0100
Date: Sat, 9 Mar 2024 21:46:04 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
    Dirk Gouders <dirk@gouders.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] merge-ort/merge-recursive: do report errors in
 `merge_submodule()`
In-Reply-To: <xmqqwmqbcmrz.fsf@gitster.g>
Message-ID: <a0af1155-59d9-0c35-f3e9-c0fe1ba0e11b@gmx.de>
References: <pull.1686.git.1709993397.gitgitgadget@gmail.com> <50fe1a26515c06afec5ac7fb723727e1365a14fc.1709993397.git.gitgitgadget@gmail.com> <xmqqwmqbcmrz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PIkKvRuN0FrtuRetlBJTsnm/zp5ZFXw11JZSbQOSp+3e8u69DcT
 rryLpM1QkFMiWTELnQvr6+ZLWYxUnPzANVLRbIQYoBRvaPlY/2r8RqRk9K5bh/J18W7+Y5p
 mIpoKOsDR1ErPd3USgGOqshOQKsKD1jSfTh0zYaMjp3dgxjPKEr9p5EuiA7ianjxZcdmk/5
 torX3GaXVEQzouiEWlm8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pJyYwtOEzA8=;Gqg6nybPWJpB19uPzCgBD+ET6eh
 VwpYH95r9MOwi9+BuWVJTmeMoz3v7ysdFLNw9HU416rO/FKjpHaRYXE1PBdXyyIwHNnfyNNxJ
 Uxp51IP/yR5NPs1uXmR3WvC2e7KKqt3KnrUlAp5prKUGFylHOMMkI5OW9RN41Rc0eN6EuyBDX
 a5S2PA08rjGCD6fUss64hrEEaBnNHZMTXWm5KBoNOxQpaohPi8l6DowRB0SPKeNaZ9IbrORU+
 Bh7WPjxfb7gSGwCqPFrPxjVAbA8XVeyRpkl0mTP/ypqx/iQgJ2RJNNJK2uioj0moe1hiJVtLP
 Qarwvz62XHBy95BQPxgQyrSdkQRcTZjtuq8lSeGFFih0mvFY/MZD7caXDrt+FFEzsQDi8plsW
 VL7SAdNLr6u+MJZuBMD+9B2Elr2rT2pFW0dL+TDMUpE2ENsp3UkioTn+FUj7oiCtz61lYtDtE
 wIqFmMpTY/EgqInOEABEWk+/HmOSZ7Ha2AdLrXDByaaV9Xgp1hHpo+VCFwjvOg8qguhYXVWob
 q9mk9dizp6wsh0/Gta7ZxRhHf7OB3MHLs579oS0An8fkD4rmIhVGN/W5zlj6GW13y8tgzIdhm
 kKoEfOqEvTF2z9D7KatzE6TGMYBoi8Zt8UaGYUowJHi/m/6mf6lmeQcg+4tEBbOFBYzwZZ/vK
 XCgA6uoKblVhEOh3vEDN0kyLXGSseMCk3Q0DbtrMSqrrJ1czEIcqa8hj3ZNxm4P8/2FnHMRCv
 3VKRoIIJI6XBjtYi4+eiVKPp8V62yJuscy9wTeLhyAYX5PoZu3ZkPugqbv0XY8f8M9b/qjy/B
 AgIyxtmBnV58u/yn56EYbElBnbSH2BAjUPqhG6XZOJWd8=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 9 Mar 2024, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 24876ebf68b (commit-reach(repo_in_merge_bases_many): report missing
> > commits, 2024-02-28), I taught `merge_submodule()` to handle errors
> > reported by `repo_in_merge_bases_many()`.
> >
> > However, those errors were not passed through to the callers. That was
> > unintentional, and this commit remedies that.
> >
> > Note that `find_first_merges()` can now also return -1 (because it
> > passes through that return value from `repo_in_merge_bases()`), and th=
is
> > commit also adds the forgotten handling for that scenario.
>
> Good clean-up.  But this "oops, we did not check for errors" makes
> me wonder if we are better off adopting "by default we assume an
> error, until we are sure we are good" pattern, i.e.
>
>         func()
>         {
>                 int ret =3D -1; /* assume worst */
>
>                 do stuff;
>                 if (...) {
>                         error(_("this is bad"));
>                         goto cleanup;
>                 }
>                 do stuff;
>                 if (...) {
>                         error(_("this is bad, too"));
>                         goto cleanup;
>                 }
>
>                 /* ok we are happy */
>                 ret =3D 0;
>
>         cleanup:
>                 release resources;
>                 return ret;
>         }
>
> The patch to both functions do make it appear that they are good
> candidates for application of the pattern to me.

This is a very fitting pattern here, and it is in fact used already! It is
used with `ret =3D 0`, though, to indicate unclean merges.

This makes sense, as most of the specifically-handled cases have that
outcome. By my counting, 5 of the handled cases result in ret =3D -1, i.e.
non-recoverable errors, but 8 of the cases result in ret =3D 0, i.e. uncle=
an
merges, whereas only 2 cases return 1, i.e. clean merges.

Those numbers are for the `merge_submodule()` variant in `merge-ort.c`. In
`merge-recursive.c`, by my counting there are 10 instead of 8 `ret =3D 0`
cases, the other two numbers are the same.

Ciao,
Johannes
