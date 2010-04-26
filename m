From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: No way to have global diff settings? (global .gitattributes feature
 request)
Date: Mon, 26 Apr 2010 16:48:53 +0200
Message-ID: <4BD5A7D5.3060203@drmicha.warpmail.net>
References: <87zl0wd9ce.fsf@gmail.com> <87och6ib0r.fsf@gmail.com> <vpqoch6fhoz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 26 16:49:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Pcp-00020M-Ef
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 16:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab0DZOs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 10:48:56 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60571 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752293Ab0DZOsz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 10:48:55 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2B73FEBE7E;
	Mon, 26 Apr 2010 10:48:55 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 26 Apr 2010 10:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=7oZWqa9NV/2+k6xVGoRASLjDTJ8=; b=TZzdSgnpXvlV4yVOXYGFKWWdrvGBRy/mas6CB6cGNzz9FBNvDLgowG/s5v67fykpVXPE+2hiJ+tuqmUyRz/E0t9pfvuV1PK1LAGAZgQDHIUvYzPEdvU0YVTS9QswIXziPwnj0vAQkYS3iOqRbWXj6RloNot4BDcqVUnMUDWRDLk=
X-Sasl-enc: +AY1Zq9VscqM/q2P81BadXQZfXcfkC2PcWKNgNXunNe3 1272293334
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 72202499B3;
	Mon, 26 Apr 2010 10:48:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100426 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <vpqoch6fhoz.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145822>

Matthieu Moy venit, vidit, dixit 26.04.2010 15:48:
> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
>=20
>>> Hello,
>>>
>>> it seems there is no global .gitattribute equivalent to .gitignore =
or
>>> .gitconfig. Wouldn't it make much sense to have one? Failing that, =
there
>>> really should be a way to specify some global diff options at least=
=2E
>=20
> I'd like this feature too. My use-case is to have antiword and odt2tx=
t
> as textconv filters for .doc and .odt files, which I always want to
> do. But probably the feature won't get implemented until one of us
> writes a patch ;-) (I may have time later, but not before a few
> days/weeks).

I leave it up to you to do the (re)search, but there's some preexisting
patches and discussion around this topic. The upshot is that currently:

SYSTEM                  | GLOBAL             | VERSIONED             | =
LOCAL

$(prefix)/etc/gitconfig | $(HOME)/.gitconfig | N/A                   |
$(GIT_DIR)/config

N/A                     | N/A                | .gitattributes (rec.) |
$GIT_DIR/info/attributes

N/A                     | N/A                | .gitignore (rec.)     |
$GIT_DIR/info/exclude

There's also GIT_CONFIG overriding the defaults, and core.exludesfiles
(yes, with s!); and of course command line parameters.

There's been requests for versioned config, for multiple sources of
system config (think config.d/*), for global and system versions of
attributes and exclude/ignore, for saner naming of exclude(s) vs.
ignore, and, finally, for stopping all this madness, or rather: putting
all of it in a subdir, aptly named gitconfig... no-no, no-go... or
following the XDG conventions, or...

So, you see: You may suggest something simple like core.attributesfile.
I have a prediction how that goes.

But now, right after 1.7.1, it might be a good time to really settle
this in a future-proof yet backwards-compatible way.

Michael
