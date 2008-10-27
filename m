From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Mon, 27 Oct 2008 02:52:22 +0100
Message-ID: <200810270252.23392.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810261955.10536.jnareb@gmail.com> <200810270147.52490.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mercurial@selenic.com, SLONIK.AZ@gmail.com, git@vger.kernel.org
To: "Arne Babenhauserheide" <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 27 02:53:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuHIk-0002mR-RE
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 02:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYJ0Bwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 21:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYJ0Bwd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 21:52:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:60906 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbYJ0Bwc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 21:52:32 -0400
Received: by ey-out-2122.google.com with SMTP id 6so737575eyi.37
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 18:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/sIPx5awONF8O6EIkF/vmHz0BX+vcG/1uEtchfJPGGY=;
        b=ZUwt6GjESO9MOWxj2B9cbNQXq4rG9RWOoALShvlQrXdr925o+di7raGbrH7MqkCFOv
         u/ULGWZTpXtExXeOKCbI+t2ed8GXM1XUmo7w1PWRmD/jm6pTbZp4adZGR14+5Pna9ihF
         K/hqv5BGL4sEf4LOtaQRsI0rZMn0vtk5cNsow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=K/V6Xd1M1H7OB2w+NLX4fdg2KjNIfQLs7IpvWpD/t5fD54RSzJEp7jLI3ARBkQyetj
         0GBHjcku4+mc3L23CryxMx8985G3+jO/ubjWG2IxjNNT75S5vPX8UaRBZBaRslv3MiFt
         3GnptMzXwLO0owNJaDAoE+51IdcNhdyR8Ij08=
Received: by 10.210.144.3 with SMTP id r3mr1654997ebd.115.1225072350703;
        Sun, 26 Oct 2008 18:52:30 -0700 (PDT)
Received: from ?192.168.1.11? (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id 34sm21448144nfu.24.2008.10.26.18.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 18:52:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200810270147.52490.arne_bab@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99196>

On Mon, 27 Oct 2008, Arne Babenhauserheide wrote:
> Am Sonntag 26 Oktober 2008 19:55:09 schrieb Jakub Narebski:
> >
> > I agree, and I think it is at least partially because of Git having
> > cleaner design, even if you have to understand more terms at first.
>=20
> What do you mean by "cleaner design"?=20

Clean _underlying_ design. Git has very nice underlying model of graph
(DAG) of commits (revisions), and branches and tags as pointers to this
graph.

> From what I see (and in my definition of "design"), Mercurial is desi=
gned as=20
> VCS with very clear and clean design, which even keeps things like st=
reaming=20
> disk access in mind.=20

I have read description of Mercurial's repository format, and it is not
very clear in my opinion. File changesets, bound using manifest, bound
using changerev / changelog.

Mercurial relies on transactions and O_TRUNC support, while Git relies
on atomic write and on updating data then updating reference to data.

I don't quite understand comment about streaming disk access...

> Also, looking at git, git users still have to garbage collect regular=
ly, which=20
> shows to me that the design wasn't really cleaner.=20

Well, they have to a lot less than they used to, and there is=20
"git gc --auto" that can be put in crontab safely.

Explicit garbage collection was a design _decision_, not a sign of not
clear design. We can argue if it was good or bad decision, but one
should consider the following issues:

 * Rolling back last commit to correct it, or equivalently amending
   last commit (for example because we forgot some last minute change,
   or forgot to signoff a commit), or backing out of changes to the
   last commit in Mercurial relies on transactions (and locking) and
   correct O_TRUNC, while in Git it leaves dangling objects to be
   garbage collected later.

 * Mercurial relies on transaction support. Git relies on atomic write
   support and on the fact that objects are immutable; those that are
   not needed are garbage collected later. Beside IIRC some of ways of
   implementing transaction in databases leads to garbage collecting.

 * Explicit packing and having two repository "formats": loose and
   packed is a bit of historical reason: at the beginning there was
   only loose format. Pack format was IIRC invented for network
   transport, and was used for on disk storage (the same format!) for
   better I/O patterns[1]. Having packs as 'rewrite to pack' instead
   of 'append to pack' allows to prefer recency order, which result in
   faster access as objects from newer commits are earlier in delta
   chain and reduction in size in usual case of size growing with time
   as recency order allows to use delete deltas. Also _choosing_ base
   object allows further reduce size, especially in presence of
   nonlinear history.

 * From what I understand Mercurial by default uses packed format for
   branches and tags; Git uses "loose" format for recent branches
   (meaning one file per branch), while packing older references.
   Using loose affects performance (and size) only for insane number of
   references, and only for some operations like listing all references=
,
   while using packed format is IMHO a bit error prone when updating.

 * Git has reflogs which are pruned (expired) during garbage collecting
   to not grow them without bounds; AFAIK Mercurial doesn't have
   equivalent of this feature.

   (Reflogs store _local_ history of branch tip, noting commits,=20
   fetches, merges, rewinding branch, switching branches, etc._

[1] You wrote about "streaming disk access". Git relies (for reading)
on good mmap implementation.

> As an example: If I want some revision in hg, my repository just read=
s the=20
> files in the store, jumps to the latest snapshots, adds the changes a=
fter=20
> these and has the data.=20

If you want to show some revision in Git, meaning commit message and
diff in patch format (result of "git show"), Git just reads the commit,
outputs commit message, reads parent, reads trees and performs diff.

If you want to checkout to specific revision, Git just reads commit,
reads tree, and writes this tree (via index) to working area.
=20
> In git is has to check all changesets which affect the file.=20

I don't understand you here... if I understand correctly above,
then you are wrong about Git.

> If you read the hgbook, you'll find one especially nice comment:=20
>=20
> "Unlike many revision control systems, the concepts upon which Mercur=
ial is=20
> built are simple enough that it=E2=80=99s easy to understand how the =
software really=20
> works. Knowing this certainly isn=E2=80=99t necessary, but I find it =
useful to have a=20
> =E2=80=9Cmental model=E2=80=9D of what=E2=80=99s going on."
> - http://hgbook.red-bean.com/hgbookch4.html
>=20
> I really like that, and in my opinion it is a great compliment to hg,=
 for two=20
> reasons:=20
>=20
> 1) Hg is easy to understand

Because it is simple... and less feature rich, c.f. multiple local
branches in single repository.

> 2) You don't have to understand it to use it

You don't have to understand details of Git design (pack format, index,
stages, refs,...) to use it either.

>=20
> And both are indications of a good design, the first of the core, the=
 second=20
> of the UI.=20

Well, Git is built around concept of DAG of commits and branches as
references to it. Without it you can use Git, but it is hard. But
if you understand it, you can understand easily most advanced Git
features.

I agree that Mercurial UI is better; as usually in "Worse is Better"
case... :-)
--=20
Jakub Narebski
Poland
