X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: jgit performance update
Date: Mon, 04 Dec 2006 00:58:17 +0100
Organization: At home
Message-ID: <ekvoan$lst$1@sea.gmane.org>
References: <20061203045953.GE26668@spearce.org> <ekv34g$mck$1@sea.gmane.org> <874psceh4z.fsf@freitag.home.jstuber.net> <200612040039.00315.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 23:58:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 52
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33155>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr1EF-0004b9-47 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 00:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760022AbWLCX6g convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 18:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760026AbWLCX6g
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 18:58:36 -0500
Received: from main.gmane.org ([80.91.229.2]:50842 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1760022AbWLCX6f (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 18:58:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gr1E2-0004aS-0h for git@vger.kernel.org; Mon, 04 Dec 2006 00:58:26 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 00:58:26 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 00:58:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Robin Rosenberg wrote:

> s=F6ndag 03 december 2006 23:42 skrev Juergen Stuber:
>>
>> Jakub Narebski <jnareb@gmail.com> writes:
>>>
>>> GitWiki tells us about egit/jgit repository at
>>>   http://www.spearce.org/projects/scm/egit.git
>>
>> I tried to access that with git 1.4.4.1 from Debian but
>>
>> % git clone http://www.spearce.org/projects/scm/egit.git
>>
>> hangs, the first time after "walk
>> e339766abc2b919e7bb396cae22ddef065821381", the second time after "wa=
lk
>> 9eec90ec5da239e063eaff6305d77294dc03396e" which is the "walk" line j=
ust
>> before it.
>
> Works fine here. (git 1.4.4.gf05d).
Works fine here. (git 1.4.4.1)

>> There's also the following error shortly after the start:
>>
>> error: File bc01ab9e5fcd26918d7a334207183fa57ff1ce50
>> (http://www.spearce.org/projects/scm/egit.git/objects/75/1c8f2e504c4=
0d1c41e
>>bbd87d8f8968529e9c30) corrupt
>=20
> Unfortunately, messages about corrupt objects are "normal" with clone=
 over=20
> http. I'm not sure it has to be that way though. Run git-fsck-objects=
 to make=20
> sure there are no errors. The hangs aren't normal.

I got:
$ git clone http://www.spearce.org/projects/scm/egit.git
[...]
 got 73ed47b2bb1fa5978f7368775979e5c85d354c5a
 error: File 2332eacf114debb7a27d138811197f06eb262551=20
 (http://www.spearce.org/projects/scm/egit.git/objects/75/1c8f2e504c40d=
1c41ebbd87d8f8968529e9c30) corrupt
 Getting pack list for http://www.spearce.org/projects/scm/egit.git/
 got afefbe09bacc08adb75fb46200a973001c6b02de
[...]
 walk c1f287cb19b9910af19756cf29c08b1fda75da8c
 Some loose object were found to be corrupt, but they might be just
 a false '404 Not Found' error message sent with incorrect HTTP
 status code.  Suggest running git fsck-objects.
 got eab86de8ac23e2e77878835007724146fdd83796
$ git fsck-objects --unreachable --full --strict   ;# returns no errors

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

