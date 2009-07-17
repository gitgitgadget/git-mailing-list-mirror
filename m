From: Changsheng Jiang <jiangzuoyan@gmail.com>
Subject: Re: how to fetch a new svn branch after clone?
Date: Fri, 17 Jul 2009 10:00:22 +0800
Message-ID: <eafc0afe0907161900k35b2dff1u5a2bfc574bb93231@mail.gmail.com>
References: <eafc0afe0907160830m29e2f3d3jf5c0e9db29cace54@mail.gmail.com> 
	<4A5F8CDA.5080202@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 04:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRckt-000614-Ev
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 04:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933642AbZGQCAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 22:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933610AbZGQCAo
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 22:00:44 -0400
Received: from mail-vw0-f200.google.com ([209.85.212.200]:65208 "EHLO
	mail-vw0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234AbZGQCAn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 22:00:43 -0400
Received: by vwj38 with SMTP id 38so565421vwj.33
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0z6mT2aJWyU7akm4dBhxztfpZpUjBj0cHKj2BDrZySw=;
        b=EonY1KxNneoVdK23enQqqmEpKsPInE7h/MkZIBtEV/zXkyrkwNKLOhTu15XnOfI1sW
         /jNnVpvCQqInWxoms5zEW4Xdb/aXc7v2G24jwTTp8SGageojJ+MIit2SCglmOAh8C1kY
         gUBimJI30D8vDPQvV+zwyzonTX2NGBNMcb9dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UXJsKNV3YO09RG5m87PbVA6TF1wQdxYE3NHJt//TTlPBpCOhlFDKZBUZNeK3V2qMEQ
         R+/W/0dhTU6IzaOOdwL4BTf8dxTnmnxM7JHglRjHCTWSBki9aPEwujkIvY8iEdeY+EHn
         5TXdtP0E+jmQDHIt/KhOYB6chywFYWrRMAd1U=
Received: by 10.220.45.84 with SMTP id d20mr726260vcf.90.1247796042157; Thu, 
	16 Jul 2009 19:00:42 -0700 (PDT)
In-Reply-To: <4A5F8CDA.5080202@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123439>

Thank Marc.

You are right, it should be the latter case with url
http://www.example.com/project/branches/test

But "git svn clone" has already added these lines to .git/config

[svn-remote "svn"]
	url =3D https://xxx.xxxx.com/svn/xxx
	fetch =3D trunk:refs/remotes/trunk
	branches =3D branches/*:refs/remotes/*
	tags =3D tags/*:refs/remotes/tags/*

And it still can not fetch new branch.

                                                      Changsheng Jiang

On Fri, Jul 17, 2009 at 04:26, Marc Branchaud<marcnarc@xiplink.com> wro=
te:
> The latest 1.6.4-rc1 contains patches to git-svn for it to support mo=
re than one branch URL in an svn repository.
>
> However, before I describe that, can you confirm whether your new bra=
nch is in fact named
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://svn.example.com/project/test
>
> or is it really
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0http://svn.example.com/project/test/<branc=
hname>
>
> Because if it's the former then I'm not sure if git-svn can handle yo=
ur new branch. =C2=A0The problem is that even though the branch is name=
d 'test' it's a sibling to the 'branches' 'tags' and 'trunk' paths in t=
he repository. =C2=A0For git-svn to pick up branches, you point it at t=
he path *containing* the branch names. =C2=A0In the former case, to pic=
k up project/test as the 'test' branch you'd have to point git-svn at t=
he project directory, and that would cause it to also pick up project/t=
ags, project/branches, and project/trunk as other branches (named 'tags=
', 'branches' and 'trunk').
>
> However, in the latter (test/<branchname>) case, with 1.6.4, I *think=
* git-svn will pick up the new branches under test if you add a new 'br=
anches' line to the svn-remote's section in your .git/config file. =C2=A0=
Something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0branches =3D test/*:refs/remotes/*
>
> might let you see the new branches. =C2=A0The reason I can't be more =
certain is that if you've done a 'git svn fetch' since the branch was c=
reated then git-svn might not pick up the branch-creation commits later=
=2E =C2=A0Unfortunately I don't know git-svn well enough to say for cer=
tain.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0M.
>
>
> Changsheng Jiang wrote:
>> Hi list,
>>
>> I know how to clone a svn repository with all branches and tags at t=
he
>> initial step, but I find no answers of how to fetch a new svn branch
>> after clone.
>>
>> For example, this
>>
>> git svn clone http://svn.example.com/project -T trunk -b branches -t=
 tags
>>
>> will clone all branches. but that clone, the svn repository has a ne=
w
>> branch test with url http://svn.example.com/project/test, how to clo=
ne
>> it as the initial step?
>>
>> Thanks.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Changsheng Jiang
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
