From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Tue, 18 Mar 2014 09:02:09 +0100
Message-ID: <5327FD81.4040508@viscovery.net>
References: <20140305003639.GA9474@sigill.intra.peff.net> <5316D922.9010501@viscovery.net> <20140306212835.GA11743@sigill.intra.peff.net> <531973D9.9070803@viscovery.net> <20140314035457.GA31906@sigill.intra.peff.net> <5322A82E.9060808@viscovery.net> <20140318052456.GA17454@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
	=?UTF-8?B?UmVuw6k=?= =?UTF-8?B?IFNjaGFyZmU=?= 
	<rene.scharfe@lsrfire.ath.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 09:02:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPoye-0002xS-Gm
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 09:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbaCRICR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Mar 2014 04:02:17 -0400
Received: from so.liwest.at ([212.33.55.23]:56406 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752040AbaCRICO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 04:02:14 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WPoyP-0004wN-Vz; Tue, 18 Mar 2014 09:02:10 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9B3E616613;
	Tue, 18 Mar 2014 09:02:09 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20140318052456.GA17454@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244338>

Cc Ren=C3=A9; do you have any comments regarding grep --function-contex=
t?

Am 3/18/2014 6:24, schrieb Jeff King:
> On Fri, Mar 14, 2014 at 07:56:46AM +0100, Johannes Sixt wrote:
>=20
>> Consider this code:
>>
>>   void above()
>>   {}
>>   static int Y;
>>   static int A;
>>   int bar()
>>   {
>>     return X;
>>   }
>>   void below()
>>   {}
>=20
> Thanks, this example is very helpful.
>=20
>> When you 'git grep --function-context X', then you get this output w=
ith
>> the current pattern, you proposal, and my proposal (file name etc om=
itted
>> for brevity):
>>
>>   int bar()
>>   {
>>     return X;
>>   }
>=20
> Right, that makes sense to me.
>=20
>> When you 'git grep --function-context Y', what do you want to see? W=
ith
>> the current pattern, and with your pattern that forbids semicolon we=
 get:
>>
>>   void above()
>>   {}
>>   static int Y;
>>   static int A;
>>
>> and with my simple pattern, which allows semicolon, we get merely
>>
>>   static int Y;
>>
>> because the line itself is a hunk header (and we do not look back an=
y
>> further) and the next line is as well. That is not exactly "function
>> context", and that is what I'm a bit worried about.
>=20
> Hmm. To be honest, I do not see yours as all that bad. Is "above()" o=
r
> "A" actually interesting here? I'm not sure that they are. But then I=
 do
> not use --function-context myself.
>=20
> I guess it violates the "show things that are vaguely nearby, rather
> than a container" view of context that we discussed earlier. But some=
how
> that seems less important to me with "--function-context".
>=20
> So I dunno. I kind of like your version.

Then I'll polish my patch series (it also rewrites the test framework) =
and
post it.

-- Hannes
