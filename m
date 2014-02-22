From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] sha1_file: fix delta_stack memory leak in unpack_entry
Date: Sat, 22 Feb 2014 16:44:05 +0100
Message-ID: <87ob1zrw3e.fsf@thomasrast.ch>
References: <1392940067-4830-1-git-send-email-pclouds@gmail.com>
	<20140221054148.GA24882@sigill.intra.peff.net>
	<xmqqmwhk49sy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 16:44:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHEkd-00033J-A8
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 16:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbaBVPoV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Feb 2014 10:44:21 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:35386 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbaBVPoV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Feb 2014 10:44:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id D807F4D6590;
	Sat, 22 Feb 2014 16:44:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eTk4NCRolPfe; Sat, 22 Feb 2014 16:44:06 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id E616B4D64BD;
	Sat, 22 Feb 2014 16:44:05 +0100 (CET)
In-Reply-To: <xmqqmwhk49sy.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 21 Feb 2014 10:09:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242527>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Feb 21, 2014 at 06:47:47AM +0700, Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy wrote:
>>
>>> This delta_stack array can grow to any length depending on the actu=
al
>>> delta chain, but we forget to free it. Normally it does not matter
>>> because we use small_delta_stack[] from stack and small_delta_stack
>>> can hold 64-delta chains, more than standard --depth=3D50 in pack-o=
bjects.
>>>=20
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  Found when trying to see if making some objects loose at this phas=
e
>>>  could help git-blame and how many objects will be loosened. Gotta =
go
>>>  soon, didn't really test it, but I bet it'll work.
>>
>> This looks correct to me.
>
> This comes from abe601bb, right?  The change looks correct to me, too=
=2E

Ow, sorry about that.  Thanks for the fix!

--=20
Thomas Rast
tr@thomasrast.ch
