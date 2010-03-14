From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Sun, 14 Mar 2010 18:57:22 -0300
Message-ID: <55bacdd31003141457t7d2cebe3u9854d3c0a55b7da0@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> 
	<7vr5nqrpyg.fsf@alter.siamese.dyndns.org> <55bacdd31003120845kc980d16s1e6006d56d6f923a@mail.gmail.com> 
	<7v8w9whd3g.fsf@alter.siamese.dyndns.org> <7v4okkegdy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 22:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqvop-0001t8-0h
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 22:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934145Ab0CNV5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 17:57:43 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:38722 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934132Ab0CNV5m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Mar 2010 17:57:42 -0400
Received: by yxe29 with SMTP id 29so1136203yxe.4
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KjZuPg/83qutTfjwVVeC/n9XG9ke+pyZjukuefd+Mgw=;
        b=PJu9lHrx85jFK3W+hhzof2dS+pIJixVbN0oA4R1EO5lDwlir+tFN71ns5jnXeXmgup
         5YvSLTf2P+L72oBMTU92Ntv6t/AX+uw4vnWS6Jw379oTWh/E/C1vuRSKuQNWeMaam+0H
         hgA2xEorjs72tSqzNjoBbFDmKbqg1GB6+VP/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kDVh9enZGFhUE/KXSKOviURQ+zICIQTUMxKQsw5njQhTAJtcFgoEKXeeN4PU6vjstM
         10/YvZMOye4/48BPUauUjJ8iV0n5OE73EGS0+NyNRN/C9CCMXBUHD4RPtddR7RjNbPTS
         6DACu2IpCy8sG+0EDf9XokPmOE47pzXqPzRNg=
Received: by 10.101.155.38 with SMTP id h38mr2974884ano.131.1268603862113; 
	Sun, 14 Mar 2010 14:57:42 -0700 (PDT)
In-Reply-To: <7v4okkegdy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142157>

Hi

As I see you have found a very good example under your common work
flow.  Nice. :-)

Regards

2010/3/13 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> As I already said, I do not think "mostly common paths" case should =
be
>> encouraged to begin with. =C2=A0As far as I know (and you can guess =
by now that
>> I know reasonably well about git), you do not gain anything by not h=
aving
>> the ancestry link between '?' and 'B', except that it would make con=
flict
>> resolution at '*' extremely difficult. =C2=A0There is only downside =
without any
>> upside in "mostly common paths" disjoint merge.
>
> There is one case "mostly common paths" disjoint history can be usefu=
l.
>
> Imagine you have a hitherto proprietary software project and want to =
go
> open source. =C2=A0Perhaps your intention is to have an open source v=
ersion and
> an enhanced commercial version. =C2=A0The project contains some third=
-party
> vendor software outside your control, and you have replaced them with=
 open
> source equivalents or disabled features that depend on them.
>
> Your history may look like this:
>
> =C2=A0 =C2=A0 =C2=A0o---o---A oss-base
> =C2=A0 =C2=A0 /
> =C2=A0---o---o---o---o master
>
> where master is the primary version you will continue shipping to you=
r
> paying customers, with proprietary third-party components and feature=
s
> that depend on them. =C2=A0Commits on oss-base were your work to prep=
are the
> tree into a releasable shape, removing these proprietary stuff along =
with
> some features.
>
> But you cannot publish oss-base (commit A) to the public. =C2=A0"git =
log" will
> show all the history that leads to it, with all the third-party stuff=
 you
> do not have license to distribute in the source form. =C2=A0The older=
 parts of
> the history may even have site password at customer installation you =
have
> committed by mistake and eradicated long time ago.
>
> If you run this three command sequence (in this message, I am assumin=
g
> that you keep the index and the working tree files intact in an updat=
ed
> implementation of --orphan, which is different from the suggestion to
> support "no common paths" case I mentioned in the previous message):
>
> =C2=A0 =C2=A0$ git checkout --orphan oss oss-base
> =C2=A0 =C2=A0$ git checkout oss-base
> =C2=A0 =C2=A0$ git merge -s ours oss
>
> you will get a history of this shape:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X oss
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0o---o---A---B oss-base
> =C2=A0 =C2=A0 /
> =C2=A0---o---o---o---o master
>
> with commits X, A and B all recording an identical tree. =C2=A0The os=
s branch
> (commit X) is now safe to publish.
>
> Once you have done this, further you can:
>
> =C2=A0 =C2=A0$ git checkout master
> =C2=A0 =C2=A0$ git merge oss-base
>
> which gives you a history of this shape:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X oss
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0o---o---A---B oss-base
> =C2=A0 =C2=A0 / =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0---o---o---o---o---Y master
>
> This merge Y has to be done carefully. =C2=A0It inherently has to be =
an evil
> merge because oss-base wants to replace some proprietary stuff with o=
pen
> source counterparts while you may want to keep using the proprietary =
ones
> you have support contract for in your paying customer release you wil=
l
> make from the master branch. =C2=A0So at Y, you will most likely be r=
everting
> some work you did on oss-base branch since it forked from master.
>
> After setting it up, this arrangement allows you to:
>
> =C2=A0- accept changes from public, and/or build changes for public, =
to advance
> =C2=A0 "community version" on the oss branch on top of X;
>
> =C2=A0- from time to time, merge oss to oss-base;
>
> =C2=A0- from time to time, merge oss-base to master.
>
> and the histories will continue like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0X---C---C---C-=
--C oss
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0o---o---A---B-----------* oss-base
> =C2=A0 =C2=A0 / =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0---o---o---o---o---Y---P---P---*---P---P master
>
> with community commits C (either contributed from the public or you
> developed yourself and gave to the community) on oss branch, with
> proprietary commits P that record your own proprietary work on master
> branch. =C2=A0Note that oss-base branch is not used to produce nor re=
cord any
> commit on its own---it is merely to ease the merging from oss and mas=
ter
> by providing X-B link to serve as a convenient common ancestor to mak=
e
> later merges easier.
>
> Note also that it would be the most convenient if you kept both the i=
ndex
> and the working tree intact, if "checkout --orphan" is to be used as =
an
> ingredient for this workflow. =C2=A0It _might_ actually make sense no=
t to make
> the "git checkout --orphan" an independent feature that can be random=
ly
> abused or misused, but package the three-command sequence to create t=
he
> A-B-X open triangle above into a separate command, i.e.
>
> =C2=A0 =C2=A0$ git branch --orphan oss
>
> would create a new branch "oss" with its own root commit X that recor=
ds
> the same tree as the current HEAD A, and immediately merge X back int=
o A
> to produce B, again recording the same tree, and advance the current =
HEAD
> to point at B, like so:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 X oss
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0---o---A HEAD =C2=A0 =C2=A0 =C2=A0 --> =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ---o---A---B HEAD
>
