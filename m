From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Status of conflicted files resolved with rerere
Date: Sun, 15 Aug 2010 18:00:22 +0200
Message-ID: <20100815160022.GA31388@jpl.local>
References: <20100812212828.GA17825@jpl.local> <AANLkTi=tVV5gL2b2LfXALXahzabJXzVjB5z9-OSztOMJ@mail.gmail.com> <D06701C5-E581-46AA-BC7D-3DA7C4127D44@gmail.com> <7veie0gy3r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 18:27:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okg3V-00032M-Tu
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 18:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539Ab0HOQ1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 12:27:23 -0400
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:51846 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448Ab0HOQ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 12:27:22 -0400
X-Greylist: delayed 1617 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Aug 2010 12:27:22 EDT
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 06869E9CBA
	for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:00:23 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhAzAEesZ0xT46eEPGdsb2JhbACHZ5hjDAEBAQE1LbkahTsE
X-IronPort-AV: E=Sophos;i="4.55,371,1278280800"; 
   d="scan'208";a="119606436"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 15 Aug 2010 18:00:23 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 5A9AB422D0; Sun, 15 Aug 2010 18:00:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7veie0gy3r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153610>

On Sunday, August 15, 2010 at 08:59 CEST,
     Junio C Hamano <gitster@pobox.com> wrote:

> David Aguilar <davvid@gmail.com> writes:
>=20
> > Here's what we'd need in order to improve rerere and mergetool
> > interaction:  the ability to answer the question, "has this file
> > been rerere merged?"
>=20
> I do not quite understand why the user _runs_ mergetool on a file tha=
t
> has been already merged; isn't it an option not to do so in the first
> place?

You have a point, but if there are conflicts in many files where only a
subset were autoresolved I think it would be prudent to help the user.
Grepping after remaining conflict markers or keeping the "git merge"
output somewhere to see which files actually were autoresolved works
but I think we can do better.

On the other hand, hinting mergetool users about rerere.autoupdate
is perhaps good enough? Doesn't help users who want to inspect the
autoresolved results yet also want hassle-free mergetool usage, though.

> Having said that.
>=20
> I think you can use the fact that:
>=20
>  - "ls-files -u" will list paths with conflicts; and
>=20
>  - "rerere status" won't mention the ones that have been autoresolved
>=20
> if rerere is in effect (check for presense of .git/MERGE_RR).

Okay, I'll have a stab at a patch.

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
