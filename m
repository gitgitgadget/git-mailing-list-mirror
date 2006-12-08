X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Light-weight checkouts via ".gitlink"
Date: Sat, 9 Dec 2006 00:24:16 +0100
Message-ID: <200612090024.17065.jnareb@gmail.com>
References: <200612082252.31245.Josef.Weidendorfer@gmx.de> <elco6p$uku$1@sea.gmane.org> <200612082354.34488.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 23:22:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dvzZPiXjE9FFipSifKOgF7aGO1G/lXVB4L0/zsuRrf+i9TE1uPuHq/CC5ZT6iabcB/177v4IrxlBAVAyMSleU6RlhhzTaAcX3xu8y62j1K/Iot9knmDLSmDuCINyQKXiQsZWpkBMB5Ehk68xan9M2pgwYi45FcZOsXd84t+4+EA=
User-Agent: KMail/1.9.3
In-Reply-To: <200612082354.34488.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33766>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsp2d-0004zO-3i for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761273AbWLHXWE convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 18:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761257AbWLHXWD
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:22:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:20858 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1761273AbWLHXWB (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 18:22:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so890242uga for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 15:22:00 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr6131927ugm.1165620120379; Fri, 08
 Dec 2006 15:22:00 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id u1sm3635501uge.2006.12.08.15.21.59; Fri, 08 Dec
 2006 15:21:59 -0800 (PST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Dnia pi=B1tek 8. grudnia 2006 23:54, Josef Weidendorfer napisa=B3:
> On Friday 08 December 2006 23:18, Jakub Narebski wrote:
>> A few (very few) comments:
>>=20
>> Josef Weidendorfer wrote:
>>=20
>>> This can be implemented by enhancing git to ignore any subdirectory=
 which
>>> has a file .gitlink in it.
>>=20
>> If I remember correctly, while git ignores .git, it does not ignore
>> by default (i.e. without entry in either GIT_DIR/info/excludes, or
>> .gitignore) the directory which has .git directory in it.
>=20
> I know. But this is essential. We _have_ to ignore all the files and
> subdirectories in the directory which contains the .gitlink file,
> as these files/subdirectories belong to the submodule.
>=20
> There is no other way. You could try to use a special name for the
> whole directory with the light-weight checkout, e.g. ".checkout".
>=20
> But then, this is useless for submodules, as for submodules, we want =
to
> be able to specify the root directory name of the submodule, as that
> is the name which will end up in the tree object of the supermodule.
>=20
>> And that should not change for .gitlink. You can always add
>> .gitignore file with * .* patterns in it (ignore all).
>=20
> That is not possible:
> .gitignore file has its own meaning inside of the light-weight
> checkout aka submodule, as this directory is the root directory of
> a git checkout.

I have forgot about that. Right.

The only possibility would be to use GIT_DIR/info/excludes with path
to submodule, and this conflict with the ability to rename and move
submodules.

> AFAIK, Martin's submodule support does it the same, only for director=
ies
> with .git, as he stores the GITDIR directly in the submodule
> checkout.

Ah.=20

[...]
>> GIT_DIR =3D path to base git repository
>> it is equivalent to setting the following:
>>=20
>> GIT_INDEX_FILE =3D path to index file
>> GIT_OBJECT_DIRECTORY =3D path to object directory
>> GIT_HEAD_FILE =3D path to HEAD file
>> GIT_REFS_DIRECTORY =3D path to refs directory
>=20
> AFAIK the latter two do not exist yet, or do they?

They do not exist; perhaps they should for completeness.

[...]=20
> It is enough if GITDIR and NAME is given. With GITDIR_REAL after the
> smart lookup, e.g. GIT_INDEX_FILE would default to $GITDIR_REAL/exter=
nal/$NAME
> and so on.

Not $GITDIR_REAL/submodules/<name>/index (or modules instead of
submodules)?

>> NAME =3D name
>> should match "name subdirectory" entry in modules file in superproje=
ct.
>=20
> Yes.
> This would be in my next proposal about how to build the submodule su=
pport
> on light-checkouts ;-)

I have thought that with "each submodule as separate repository" approa=
ch
to submodules the modules file would have module name and either
subdirectory in which submodule resides, or GIT_DIR of submodule. And
this file could be generated on checkout... which doesn't survive close=
r
scrutiny.

But this would work well with submodules, that's a fact.
 =20
>> Perhaps instead of adding arbitrary number of .. in front of relativ=
e
>> path, we better use some magic, like ... for finding somewhere up?
>=20
> I thought about it. But why whould you need it?
> If the value of GITDIR in .gitlink begins with "/", it is an absolute=
 path.
> If not, I think you always want the smart lookup the go upwards, i.e.
> looking for
>=20
>   ../<relpath>.git
>   ../../<relpath>.git
>   ../../../<relpath>.git
>=20
> So there is no need to add "..." in front of the relative path.
> Or do you see a usecase for
>  rel/path/start/.../rel/path/end
>=20
> Ah, yes, I see. Perhaps this makes sense with absolute paths:
>=20
> 	/home/user/repos/.../linux

You mean that the above means to check the following paths:

  /home/user/repos/linux
  /home/user/linux
  /home/linux
  /linux

not the searching subdirectories of /home/user/repos for linux
directory (there can be many)? BTW web2c implementation of TeX,
namely kpathsea(rch) uses // for that, i.e. a//b means b which
is somwehere in subdirectories of a.
--=20
Jakub Narebski
