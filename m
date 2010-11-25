From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Hint at "checkout -p" in the "reset --patch <type>" error
 message
Date: Thu, 25 Nov 2010 09:55:14 +0100
Message-ID: <4CEE2472.5020901@drmicha.warpmail.net>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>	<AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>	<AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>	<AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>	<AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>	<AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>	<87mxp086k5.fsf_-_@gmail.com>	<20101123145921.GB3145@sigill.intra.peff.net> <87ipzo83o9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jeenu V <jeenuv@gmail.com>,
	knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 09:57:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLXdt-0000pT-GJ
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 09:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab0KYI5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 03:57:20 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43466 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799Ab0KYI5T (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 03:57:19 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6CEF2479;
	Thu, 25 Nov 2010 03:57:19 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 25 Nov 2010 03:57:19 -0500
X-Sasl-enc: XrIqmfxcC6GX2Wh7JXR1EiMr2PCw51kxIElkCg/xqAWo 1290675439
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 95D04403FF7;
	Thu, 25 Nov 2010 03:57:18 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <87ipzo83o9.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162118>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec venit, vidit, dixit 23.11.2010 16:23:
> Jeff King <peff@peff.net> writes:
>=20
>> On Tue, Nov 23, 2010 at 03:20:58PM +0100, =C5=A0t=C4=9Bp=C3=A1n N=C4=
=9Bmec wrote:
>>
>>> diff --git a/builtin/reset.c b/builtin/reset.c
>>> index 0037be4..fc530d2 100644
>>> --- a/builtin/reset.c
>>> +++ b/builtin/reset.c
>>> @@ -309,7 +309,8 @@ int cmd_reset(int argc, const char **argv, cons=
t char *prefix)
>>> =20
>>>  	if (patch_mode) {
>>>  		if (reset_type !=3D NONE)
>>> -			die("--patch is incompatible with --{hard,mixed,soft}");
>>> +			die("--patch is incompatible with --{hard,mixed,soft}\n"
>>> +			    "(use \"git checkout -p\" to selectively discard changes in=
 working directory)");
>>>  		return interactive_reset(rev, argv + i, prefix);
>>>  	}
>>
>> Should this actually print something different for --hard versus --m=
ixed
>> versus --soft?
>>
>> For --soft, "-p" simply makes no sense as you are not changing the i=
ndex
>> or the working directory.
>>
>> For --mixed, shouldn't we support "-p" already, as that is the defau=
lt
>> mode?
>>
>> For --hard, suggesting "checkout -p" does make sense.
>>
>> Also, what about "--merge" and "--keep" modes?
>=20
> All good questions, most of which occured to me, too. What I was goin=
g
> to do based on the outcome of (the discussion of) this patch was at
> least fix the currently out-of-date "--{hard,mixed,soft}", as the
> error is signalled with the newer options (--keep and --merge) as wel=
l.
> I'm not sure I could cope with anything much more complicated than th=
at,
> esp. if it involved adding some new reset functionality. :-)

The man page for git-reset points at git-checkout already.

Until we have a "verbosity level" config across all commands, I don't
favor adding a lot of hints to command error messages.

Michael
