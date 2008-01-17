From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 12:51:12 +0100
Message-ID: <16D4755D-EAEC-4F4A-B6B4-F262A6841F66@wincent.com>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com> <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> <7vejchkp6o.fsf@gitster.siamese.dyndns.org> <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com> <alpine.LSU.1.00.0801171106510.17650@racer.site> <C7439732-3B79-4F2B-9D0C-679C1EC8EA0E@simplicidade.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 12:53:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFTIy-0001Kr-7u
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 12:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbYAQLwj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 06:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYAQLwj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 06:52:39 -0500
Received: from wincent.com ([72.3.236.74]:35625 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbYAQLwi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 06:52:38 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0HBpEpK020360;
	Thu, 17 Jan 2008 05:51:14 -0600
In-Reply-To: <C7439732-3B79-4F2B-9D0C-679C1EC8EA0E@simplicidade.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70851>

El 17/1/2008, a las 12:23, Pedro Melo escribi=F3:

> On Jan 17, 2008, at 11:10 AM, Johannes Schindelin wrote:
>> [Jay, don't cull Cc: lists on vger.kernel.org.  I consider it rude.]
>>
>> On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
>>
>>> El 17/1/2008, a las 6:15, Junio C Hamano escribi=F3:
>>>
>>>> "Jay Soffian" <jaysoffian+git@gmail.com> writes:
>>>>
>>>>> So here's what I can see as being useful additions to git:
>>>>> ...
>>>>> Thoughts (besides "patches welcomed")?
>>>>
>>>> I think we already discussed a plan to store normalization =20
>>>> mapping in
>>>> the index extension section and use it to avoid getting confused b=
y
>>>> readdir(3) that lies to us.  Is there any more thing that need to =
=20
>>>> be
>>>> discussed?
>>
>> Yes, and I think that a lot of time would have more wisely spent on
>> reading that, and trying to implement it, than writing a number of =20
>> long
>> mails, repeating the _same_ (refuted) points over and over again.
>
> I searched the archives for the posts about normalization and I =20
> could not find them, sorry.
>
> Is stringprep (RFC 3454) being proposed as an optional normalization =
=20
> step before lookups in the index?

If this is really just a platform-specific hack, can we use platform-=20
specific code to do the normalization?

On Mac OS X we have (unfortunately only 10.4 and up):

CFStringCreateWithFileSystemRepresentation()
CFStringGetFileSystemRepresentation()
CFStringGetMaximumSizeOfFileSystemRepresentation()

If we were to use those you'd at least know that you're getting the =20
true normalized form as the system defines it.

> The terms used in this Q&A, decomposed and precomposed, roughly =20
> correspond to Unicode Normal Forms D and C, respectively. However, =20
> most volume formats do not follow the exact specification for these =20
> normal forms. For example, HFS Plus uses a variant of Normal Form D =20
> in which U+2000 through U+2FFF, U+F900 through U+FAFF, and U+2F800 =20
> through U+2FAFF are not decomposed (this avoids problems with round =20
> trip conversions from old Mac text encodings). It's likely that your =
=20
> volume format has similar oddities.


http://developer.apple.com/qa/qa2001/qa1173.html

Cheers,
Wincent
