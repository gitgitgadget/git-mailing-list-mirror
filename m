From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] git-mailinfo: Fix getting the subject from the body
Date: Fri, 11 Jul 2008 00:37:36 +0200
Organization: Chalmers
Message-ID: <48768F30.8070409@etek.chalmers.se>
References: <4876820D.4070806@etek.chalmers.se> <7vod55o0tx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2?= =?UTF-8?B?bQ==?= 
	<lukass@etek.chalmers.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:38:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4ma-0001ZD-Cr
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbYGJWhi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 18:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbYGJWhi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:37:38 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:36450 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbYGJWhh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:37:37 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id A65B1831F;
	Fri, 11 Jul 2008 00:37:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vod55o0tx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88020>

Junio C Hamano wrote:
> Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se> writes:
>=20
>> "Subject: " isn't in the static array "header", and thus
>> memcmp("Subject: ", header[i], 7) will never match.
>>
>> Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
>> ---
>>
>> This has been broken since 2007-03-12, with commit
>> 87ab799234639c26ea10de74782fa511cb3ca606
>> so it might not be very important.
>=20
> Wow, thanks.  Perhaps we would want some additional test scripts?

Yes, apparently.

After looking at this part some more, I see that there is no guarantee
that hdr_data[i] !=3D NULL in this codepath, and then we won't use the
subject anyway.

I'm currently working on rewriting git-mailinfo to use strbuf's insted
of the preallocated buffers currently used. Do you want me to send a
patch allocating hdr_data[i], or can you wait for my strbuf-conversion
patch? It'll propably be ready for review tonight.

/Lukas
