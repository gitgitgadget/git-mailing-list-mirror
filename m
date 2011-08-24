From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Problem with S_IFGITLINK
Date: Wed, 24 Aug 2011 16:43:15 +0200
Message-ID: <4E550E03.3080104@drmicha.warpmail.net>
References: <4E54F364.7000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?QWRhbSBLxYJvYnVrb3dza2k=?= <adamklobukowski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 16:43:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwEfs-0002wd-1o
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 16:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab1HXOnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 10:43:19 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54607 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751477Ab1HXOnS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 10:43:18 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7BE26205AF;
	Wed, 24 Aug 2011 10:43:17 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 24 Aug 2011 10:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=i8UMWwkukyyIo3sOv6vjNZ
	q1U0s=; b=iDOFPvdcxLjWivaY309TiMZ8124uvLd335q79EejD4GuXZyZUZQO9M
	Y77AE784SvDP5B8ygoIVPw+vhIdNBX9nARandvVglUtrFICYr/GKy8iXATxiELkg
	w1FnIpnTYMkQCv+4ZU5umUgQD5CZegqhGpKd1DR1HocyJgr9jARyc=
X-Sasl-enc: I5w0s0tKTiPO9MqYbBLGzlH1DPHRkXpN/1aVMOYJIMAw 1314196997
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0299AA2017D;
	Wed, 24 Aug 2011 10:43:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E54F364.7000503@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180005>

Adam K=C5=82obukowski venit, vidit, dixit 24.08.2011 14:49:
> Hello
>=20
> I'm trying to compile git on some very exotic u*ix flavor (FreeMiNT=20
> anyone? :)) and I encountered problem with S_IFGITLINK.
>=20
> Unfortunately, on my system S_IFGITLINK =3D S_IFLNK, and it breaks bu=
ild=20
> in entry.c write_entry.
>=20
> Should I report a bug? (where?, I could not find any reference to=20
> bugtracker on git pages)

Yes. Here.

A short log of the build break would be nice.

> Can I fix it somehow? Can I change value of S_IFGITLINK to something =
else?

=46rom git's cache.h:

/*
 * A "directory link" is a link to another git directory.
 *
 * The value 0160000 is not normally a valid mode, and
 * also just happens to be S_IFDIR + S_IFLNK
 *
 * NOTE! We *really* shouldn't depend on the S_IFxxx macros
 * always having the same values everywhere. We should use
 * our internal git values for these things, and then we can
 * translate that to the OS-specific value. It just so
 * happens that everybody shares the same bit representation
 * in the UNIX world (and apparently wider too..)
 */

Time to implement that translation :|

Michael
