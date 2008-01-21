From: =?ISO-8859-1?Q?Gr=E9goire_Barbier?= <devel@gbarbier.org>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more user-friendly
Date: Tue, 22 Jan 2008 00:12:27 +0100
Message-ID: <479526DB.2050407@gbarbier.org>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org>	<7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>	<47946F67.5060601@gbarbier.org>	<7vmyqzzdhf.fsf@gitster.siamese.dyndns.org>	<47947399.3000507@gbarbier.org>	<7vabmzzbcc.fsf@gitster.siamese.dyndns.org>	<alpine.LSU.1.00.0801211212010.5731@racer.site>	<7vejcbx795.fsf@gitster.siamese.dyndns.org>	<alpine.LNX.1.00.0801211539320.13593@iabervon.org> <7v1w8aygvm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5p2-0004KX-QM
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbYAUXM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 18:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbYAUXM1
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:12:27 -0500
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:58686 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbYAUXM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 18:12:27 -0500
Received: from localhost (mfilter5-v.gandi.net [217.70.178.39])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id B6236B9FB;
	Tue, 22 Jan 2008 00:12:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter5-v.mgt.gandi.net
Received: from relay4-v.mail.gandi.net ([217.70.178.78])
	by localhost (mfilter5-v.gandi.net [217.70.178.39]) (amavisd-new, port 10024)
	with ESMTP id 1jolxAD++SI2; Tue, 22 Jan 2008 00:04:15 +0100 (CET)
Received: from [192.168.79.1] (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id 951DDBA17;
	Tue, 22 Jan 2008 00:12:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v1w8aygvm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71371>

Junio C Hamano a =E9crit > * Do we know that the current code is broken=
=20
for everybody, or just
> broken for the majority of people who do nontrivial things?

http-push without USE_CURL_MULTI is broken for everybody who uses it

> * Is the code in 1.5.3.8 any better?  IOW, did we make it worse=20
> during 1.5.4 cycle?

I think it is better, because it hurts less.

after:
- http-push with curl >=3D 7.16 works
- http-push with curl < 7.16 does not work

before
- http-push with curl >=3D 7.16 works
- http-push with curl < 7.16 does not work and in addition corrups repo=
s

In addition, the sooner we disable the repo corrupting code, the less w=
e
will have dangerous code in the wide

Junio C Hamano a =E9crit :
> Then I guess Dscho's notice (and the same notice with disabling=20
> http-push without MULTI in 1.5.3.9) would be the sane thing we should
> do in the short term.

This is my opinion.

Junio C Hamano a =E9crit :
 > The feature was added by one person who needed it, and it was
 > included because the need was satisfid with an implementation,
 > so at some point in the past, it must have worked for _somebody_
 > (I am hoping that this is not a regression during 1.5.4 cycle).
 >
 > Imagine that you are like that somebody who have been happily
 > using http-push.  Or imagine that you are starting to use git
 > and are tempted to use http-push.  With the above wording, I
 > strongly suspect that you would say "Crap --- 1.5.4 does not let
 > me run http-push, so I'll stay at 1.5.3.8 until 1.5.X lets me
 > use it again".

My experience is that 1.5.3.6 is broken too (but I did not ever try=20
1.5.3.8). Therefore I don't think it's an 1.5.4 regression.

In fact, a few weeks ago, I was that guy discovering git and trying to=20
use http-push, and said "Crap. That thing is broken." And this why I'm=20
bothering you all since a while.

--=20
Gr=E9goire Barbier - gb =E0 gbarbier.org - +33 6 21 35 73 49
