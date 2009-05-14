From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cross-Platform Version Control
Date: Thu, 14 May 2009 22:21:09 +0200
Message-ID: <4A0C7D35.7090404@op5.se>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <alpine.DEB.2.00.0905141441200.20117@perkele.intern.softwolves.pp.se> <4A0C77D9.5050402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 22:21:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4hQi-0003Zz-Pw
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 22:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbZENUVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 16:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbZENUVM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 16:21:12 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:47156 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbZENUVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 16:21:11 -0400
Received: by ewy24 with SMTP id 24so1956753ewy.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 13:21:11 -0700 (PDT)
Received: by 10.210.128.10 with SMTP id a10mr8869662ebd.61.1242332471169;
        Thu, 14 May 2009 13:21:11 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 5sm593655eyf.58.2009.05.14.13.21.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 13:21:10 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A0C77D9.5050402@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119220>

Esko Luontola wrote:
> Peter Krefting wrote on 14.5.2009 16:48:
>> Is it really necessary to store the encoding for every single file=20
>> name, should it not be enough to just store encoding information for=
=20
>> all file names at once (i.e., for the object that contains the list =
of=20
>> file names and their associated blobs)?
>=20
> What about if some disorganized project has people committing with ma=
ny=20
> different encodings? Should we allow it, that a directory has the nam=
es=20
> of some files using one encoding, and the names of other files using=20
> another encoding? Or should we force the whole repository to use the=20
> same encoding?
>=20

If encodings are on a per-tree basis, we could add a special mode-flag =
for
it without breaking backwards incompatibility (I think, anyways). Older
gits just won't know how to handle it and will treat it as a byte-strea=
m.

>> The best way would be to define this in the Git core once and for al=
l,=20
>> and add support to it for all the platforms in the same go, instead =
of=20
>> trying to hack around the issue whenever it pops up on the various=20
>> platforms.
>=20
> +1
>=20

There's still the problem that noone's stepped forward to do all that
work yet, so apparently this isn't important enough for people to put
their patches where their mouths are. Often when issues generate long
discussions and no code, it's of high academic interest and of little
real-world value.

I believe the "little real-world value" here comes from the fact that
cross-platform projects often enforce 7-bit ascii compatible filenames
from the start, because they *know* they may run into problems on other
filesystems otherwise. Remember it's not only git that has to get
things right. It's also build-systems and compilers that have to locate
the correct files (the Makefile and the filesystem may use different
encodings), so in the real world, people really do stay away from
filenames with =E5=E4=F6 or other non-ascii chars in them.

It's fun to discuss, but I won't spend any time on it. Good luck to
those who do though. I'd quite like to see if someone could pull it
off without breaking backwards compatibility or impacting performance
too much.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
