From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the replaced one
Date: Mon, 2 Aug 2010 09:42:57 +0200
Message-ID: <201008020942.58137.chriscool@tuxfamily.org>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 09:43:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofpg3-0000Lt-L0
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 09:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0HBHnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 03:43:09 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:52328 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab0HBHnH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 03:43:07 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 33B918180A3;
	Mon,  2 Aug 2010 09:43:00 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152399>

On Saturday 31 July 2010 14:36:42 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy wrote:
> Commit 0e87c36 (object: call "check_sha1_signature" with the
> replacement sha1) did this. I'm not sure if it's should be done this
> way.
>=20
> With "repl" as the first argument to parse_object_buffer, the returne=
d
> obj pointer will have the replaced SHA1 in obj->sha1, not the origina=
l
> one. I sort of expect that, no matter the object is replaced,
> obj->sha1 should stay the same.
>=20
> This was observed by replacing commit tip. git log would show the
> replaced sha1, not the original one.

I am not sure I understand what you are saying. Do you mean that git lo=
g=20
should show the original sha1 but the content of the replacement commit=
,=20
instead of both the sha1 and the content of the replacement commit?

I just tested your patch and indeed with it it seems to me that the res=
ult=20
shown by git log is not consistent, as for example the commit message i=
s the=20
one of the replacement commit but the commit sha1 is the one of the ori=
ginal=20
commit.

The idea with replaced object was that as much as possible everything e=
xcept=20
some very low levels commands and transport commands should use the=20
replacement objects (except if the --no-replace-objects option or=20
NO_REPLACE_OBJECTS_ENVIRONMENT is used).

Could you explain why you need the object returned by parse_object_buff=
er to=20
not have the replacement SHA1 in obj->sha1 when it is parsing the buffe=
r from=20
the replacement object?

Best regards,
Christian.
