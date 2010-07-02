From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Fri, 02 Jul 2010 11:23:50 +0200
Message-ID: <4C2DB026.9050001@drmicha.warpmail.net>
References: <1278012954-sup-3724@pimlott.net> <20100701210919.GA4283@burratino> <4C2D995D.2020708@drmicha.warpmail.net> <20100702081812.GA9219@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>,
	=?UTF-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 11:24:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUcUK-0001Ot-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 11:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120Ab0GBJYm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 05:24:42 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37717 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755326Ab0GBJYl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 05:24:41 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4252C10C3F5;
	Fri,  2 Jul 2010 05:24:40 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 02 Jul 2010 05:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Nhvbrx21SzSdhwsIJyIATVtg1VE=; b=VLQc1JoM+Yy3ijbQj24JWMEDomzIHouaHleg8EaVN2mZNZEPQvM9fc7gu9MmAba2oQChefQ4+WLhMtje1rHpTiRkDltC+S0ui62hRV5dqC93sw+Dikvb84vP0tSykvLoTwDXfmPbKANljmut3mpyN0z8hi22xxtThwHujkuFIoA=
X-Sasl-enc: PPzpofN7rWgLOXYvNbBG7eTtcC05ycT9Ta9pbWadslQh 1278062679
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3BEED4DFE9A;
	Fri,  2 Jul 2010 05:24:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100702081812.GA9219@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150119>

Jonathan Nieder venit, vidit, dixit 02.07.2010 10:18:
> Michael J Gruber wrote:
>> Jonathan Nieder venit, vidit, dixit 01.07.2010 23:09:
>=20
>>> Add a BUGS section to explain the problem.
>>
>> This is not a bug. git cherry works exactly as described.
>>
>> At worst, it is a misfeature.
>=20
> Unix man pages have a history of using BUGS sections to describe
> misfeatures and even unavoidable design constraints.
>=20
> One nice effect is to encourage people to think of programs as
> fixable.  But maybe it is bad PR. ;-)
>=20
>> git cherry would be more useful if you could specify a "limit" which=
 is
>> an ancestor of "fork-point", not only descendants.
>>
>>> Thoughts?  Improvements?
>>
>> Allow general "limit" :)
>=20
> Hmm, I am not totally sure I understand.  Conceptually =E2=80=98git c=
herry=E2=80=99
> currently does something like the following:
>=20
>  1. List all commits limit..head and find their patch ids
>     (limit defaults to upstream if not specified)
>=20
>  2. List all commits head..upstream and find their patch ids
>=20
>  3. For each commit listed in step 1, check if it is in the
>     list from step 2 and print its commit id with a + or -
>     accordingly.
>=20
> Are you suggesting that the limit should replace head in
> step 2?  Or something else?

I suggest that I was reading limit on the wrong branch :|
What I meant was specifiying a different lower limit in 2 would help:
then you could force git cherry to compare more commits, if you have a
rough idea about how far to go back. But even being able to say
"v1.6.0..upstream" here instead of head helps and is much more efficien=
t
then going for --full.

>=20
>> git-cherry(1) never speaks about upstream..head nor head..upstream. =
It
>> uses "fork-point", and a merge creates a new "fork-point", i.e.
>> merge-base.
>=20
> This explanation becomes problematic when there is more than one merg=
e-base:
> http://thread.gmane.org/gmane.comp.version-control.git/150067/focus=3D=
150093

I guess it always pays to read the full thread before jumping in... you=
r
"prefork" there is what I meant above.

Michael
