From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v3 23/23] untracked cache: guard and disable on system
 changes
Date: Wed, 10 Dec 2014 06:08:19 +0100
Message-ID: <5487D543.7060801@web.de>
References: <1418047507-22892-1-git-send-email-pclouds@gmail.com> <1418047507-22892-25-git-send-email-pclouds@gmail.com> <20141209100430.GC76457@vauxhall.crustytoothpaste.net> <CACsJy8A5-smRXN0k5TK8uPg4-j-Z83KWLNSO_w-eFivTNB_www@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 06:10:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyZXE-0005Bi-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 06:10:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbaLJFJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 00:09:55 -0500
Received: from mout.web.de ([212.227.15.4]:58305 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaLJFJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 00:09:55 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MbQLE-1YEzxM2oAW-00IoOS; Wed, 10 Dec 2014 06:09:52
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CACsJy8A5-smRXN0k5TK8uPg4-j-Z83KWLNSO_w-eFivTNB_www@mail.gmail.com>
X-Provags-ID: V03:K0:OJTwsMs5LROzNZ/sbS/GGaGvhpnos2Ot7OG+kIxQsnLXrLnNLij
 G08px6zqdXQRFoOaY9iJXPtjgicXoFUP42QcjB8tmd5mjD84QUUMxFgVRiNBNaM9s5dYGIj
 KASfTF37SpyWw40pRp3Raop1MysK6qHrCcs8LwBxYHlIP8Ds+sxXTdchyYUHWBGK73rLBcI
 AlH/sWq0oZBTEMo7Bb4MQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261188>

On 12/09/2014 11:53 PM, Duy Nguyen wrote:
> On Tue, Dec 9, 2014 at 5:04 PM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On Mon, Dec 08, 2014 at 09:05:07PM +0700, Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy wrote:
>>> If the user enables untracked cache, then
>>>
>>>   - move worktree to an unsupported filesystem
>>>   - or simply upgrade OS
>>>   - or move the whole (portable) disk from one machine to another
>>>   - or access a shared fs from another machine
>>>
>>> there's no guarantee that untracked cache can still function proper=
ly.
>>> Record the worktree location and OS footprint in the cache. If it
>>> changes, err on the safe side and disable the cache. The user can
>>> 'update-index --untracked-cache' again to make sure all conditions =
are
>>> met.
>> My use case for untracked cache is where I have one machine with a
>> repository and which is also mounted via sshfs on another machine.  =
It
>> looks like this will disable the cache every time I change the machi=
ne I
>> access it on.  Would you be willing to accept a patch for a configur=
ation
>> option to disable this?
> Torsten also does not like this patch. Maybe I'm just too paranoid.
> Maybe we can drop this patch.
That opens another question:
How flexible/extensible/self-describing is the format of the UNTR=20
extension ?
If we drop the OS name & root dir check because it disallows network us=
e,
but later add a better method to verify that the underlying chain
local OS - network - remote OS-remote FS is OK,
do we need to change the file format of UNTR ?
If yes, can old clients read the new format and vice versa?
Do we need a version information of some kind, or does the
old client skip unknown entries like we do with extensions in the index=
 ?
