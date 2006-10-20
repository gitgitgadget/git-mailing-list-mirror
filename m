From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 20:35:25 +0200
Message-ID: <200610202035.26227.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610201821.34712.jnareb@gmail.com> <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 20:35:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GazDV-0008B7-PH
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 20:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992516AbWJTSf2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 20 Oct 2006 14:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992682AbWJTSf1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 14:35:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19177 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2992516AbWJTSfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 14:35:23 -0400
Received: by ug-out-1314.google.com with SMTP id z34so702425ugc
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 11:35:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DmQapCqGadhYLeRr+lHTNXKr5pApOXGuUB61jOS2fQxk+6mukoqVTx0P3+9qbvX8fAMmBouqYwPNoGQx/3UK/oSkrzQ8KrI4kdGMbsbbKzujJYRDksUvPLb9zWfEasF1i7rXsmDsmXyuaxQOpL3wF3tPMSXvhlrsikn/a2yxrl0=
Received: by 10.67.105.19 with SMTP id h19mr2401698ugm;
        Fri, 20 Oct 2006 11:35:22 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 28sm1571842ugc.2006.10.20.11.35.20;
        Fri, 20 Oct 2006 11:35:21 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29518>

Jan Hudec wrote:
> On Fri, Oct 20, 2006 at 06:21:34PM +0200, Jakub Narebski wrote:
> > Aaron Bentley wrote:
> >=20
> > > =3D=3D=3D added directory =A0// file-id:TREE_ROOT
> >=20
> > Gaaah, so rename detection in bzr is done using file-ids?
> > Linus will tell you the inherent problems with that "solution".
>=20
> Ok, I tried to read
> http://permalink.gmane.org/gmane.comp.version-control.git/217
>=20
> It's all nice and well, but my question is whether the below cases wo=
rk
> in git. Yes, they are particular cases, but they are particularly
> important. If they don't, I'd rather have file-id scheme, that is
> limited to just them, but handles them, than something with big plans=
,
> but nothing working.
>=20
> Let's consider following scenario:
>=20
> (where A$ means working in branch A, B$ means working in branch B and
>  VCT stands for version control tool of choice)

1077:jnareb@roke:/tmp/jnareb> mkdir tmp
1078:jnareb@roke:/tmp/jnareb> cd tmp/
1079:jnareb@roke:/tmp/jnareb/tmp> git init-db
defaulting to local storage area

> A$ echo Hello Warld! > hello.txt
1081:jnareb@roke:/tmp/jnareb/tmp> echo 'Hello Warld!' > hello.txt

> A$ VCT add hello.txt
1082:jnareb@roke:/tmp/jnareb/tmp> git add hello.txt

> A$ VCT commit -m "Created greeting"
1083:jnareb@roke:/tmp/jnareb/tmp> git commit -a -m "Created greeting"

(we use here still default branch 'master'. Let us change it to A)
1084:jnareb@roke:/tmp/jnareb/tmp> git branch A
1088:jnareb@roke:/tmp/jnareb/tmp> git checkout A

> $ VCT branch A B
1085:jnareb@roke:/tmp/jnareb/tmp> git branch B A
(create branch B based on A)

> A$ VCT mkdir data
1089:jnareb@roke:/tmp/jnareb/tmp> mkdir data

> A$ VCT mv hello.txt data/
1090:jnareb@roke:/tmp/jnareb/tmp> git mv hello.txt data/

> A$ VCT commit -m "Moved hello.txt to data dir"
1092:jnareb@roke:/tmp/jnareb/tmp> git commit -a -m "Moved hello.txt to =
data dir"

> B$ ed hello.txt
> ? 1s/Warld/World/
> ? wq
1094:jnareb@roke:/tmp/jnareb/tmp> ed hello.txt=20
13
1s/Warld/World/
wq
13

> B$ VCT commit -m "Fixed typo in greeting"
1096:jnareb@roke:/tmp/jnareb/tmp> git commit -a -m "Fixed typo in greet=
ing"

> A$ VCT merge B
1097:jnareb@roke:/tmp/jnareb/tmp> git checkout A
1098:jnareb@roke:/tmp/jnareb/tmp> git pull . B
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with 9de7290d385ec2b0c2ade9b888f6c3a6633ac926
Merging:=20
5f0eb04467538f0f1414af85ec6481150107c0b2 Moved hello.txt to data dir=20
9de7290d385ec2b0c2ade9b888f6c3a6633ac926 Fixed typo in greeting=20
found 1 common ancestor(s):=20
f49a520e40143cb9d84b00e9728c5742897c0a22 Created greeting=20

Merge made by recursive.
 data/hello.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

> At this point, I expect the tree to look like this:
> A$ ls -R
1099:jnareb@roke:/tmp/jnareb/tmp> ls -R
=2E:
data

=2E/data:
hello.txt

> A$ cat data/hello.txt
1100:jnareb@roke:/tmp/jnareb/tmp> cat data/hello.txt=20
Hello World!



> A$ VCT mv data greetings
1102:jnareb@roke:/tmp/jnareb/tmp> git mv data greetings

> A$ VCT commit -m "Renamed the data directory to greetings"
1105:jnareb@roke:/tmp/jnareb/tmp> git commit -a -m "Renamed the data di=
rectory to greetings"

> B$ echo "Goodbye World!" > data/goodbye.txt
1106:jnareb@roke:/tmp/jnareb/tmp> git checkout B
1109:jnareb@roke:/tmp/jnareb/tmp> echo 'Goodbye World!' > data/goodbye.=
txt
bash: data/goodbye.txt: There is no such file or directory
1110:jnareb@roke:/tmp/jnareb/tmp> ls -R
=2E:
hello.txt

You need to revise your example.
--=20
Jakub Narebski
Poland
