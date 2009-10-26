From: Jeffrey Middleton <jefromi@gmail.com>
Subject: git update --prune issue
Date: Mon, 26 Oct 2009 17:08:45 -0500
Message-ID: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 23:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2XkY-0005w0-4T
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 23:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZJZWJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 18:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754026AbZJZWJD
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 18:09:03 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:46595 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbZJZWJC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 18:09:02 -0400
Received: by ewy4 with SMTP id 4so4097083ewy.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=m1e34PLkAJWTa/XCyyuJTQvo1e76yGMG8djnZ7a2Lik=;
        b=Pbf6SzU+kwadwG2042w9bDLfcBFU4wjRZC2bZVu9yccgCh8xkO/Kn7tTHJ7SFdnHEA
         OckgrFlcUChhpslOL0uJlrk+/sT57aLBGCvoqS5pQhETMyhHCochfb07ZSbvdeJthYg1
         TUJUX4UVcfYxOnd9EDYIU4XWiBV4ymhv5Q41w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=tpQ3ZaOrib3bxyHjSFInMzNrI85H8lMtLUlsBivgTU+ZXzaJiZIzW2Fn12HdklMBPX
         5ssgTRoqWZhAla7s02BrzoNYwBcs2guredXMi8+SosTWvLjpvytXgTLqHNNBlgNiBD7j
         C1TCcF6CyHH07JjS5cma8G/ugFtcA3Ydk1QTM=
Received: by 10.216.85.14 with SMTP id t14mr2270943wee.222.1256594945331; Mon, 
	26 Oct 2009 15:09:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131275>

I have an unreliable problem when using "git remote update --prune".
git claims that many refs from a particular remote do not point to a
valid object, but only after finishing another update.=A0 I've included
a shortened version of the output from one particular instance of the
issue.=A0 Note that the errors are printed for every subsequent remote
as well.=A0 However, after the update is completed, everything is fine.

It seems to only happen when there are non-fast-forward changes (new
branch, forced update, pruned branch).=A0 The issue only happens with
this particular remote, which I've tried removing and recreating, and
is the same type of remote as all my others (another user's
NFS-mounted home directory).=A0 However, my remotes are all individual
developers, and this developer is the only one who ever rebases her
working branches.=A0 (recloning the repo from origin and setting up my
config and remotes all over again has also had no effect)

Unfortunately, I have been unable to reproduce the problem in any test
repos - for example, though a forced update and a pruned branch in the
problematic remote along with an update in another remote seems to
fairly reliably produce the problem in this repo, recreating that
situation in another repo doesn't cause any problems.=A0 Sorry for the
incomplete bug report, but perhaps this will be enough to go on!

Thanks,
Jeffrey


I've seen the issue in previous versions built from git.git master, as
well as v1.6.3.3, but for this particular one:

$ git --version
git version 1.6.5.1.61.ge79999

$ git remote update --prune
Updating origin
remote: Counting objects: 42, done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 15 (delta 9), reused 12 (delta 6)
Unpacking objects: 100% (15/15), done.
=46rom /users/cxtfcm/CxTF_DB
=A0=A0 88b8613..d40f26d=A0 2009.Q4=A0=A0=A0 -> origin/2009.Q4
=A0=A0 d40f26d..56305b8=A0 dev=A0=A0=A0=A0=A0=A0=A0 -> origin/dev
Updating steph
remote: Counting objects: 299, done.
remote: Compressing objects: 100% (241/241), done.
remote: Total 276 (delta 186), reused 19 (delta 6)
Receiving objects: 100% (276/276), 41.09 KiB | 10 KiB/s, done.
Resolving deltas: 100% (186/186), completed with 17 local objects.
=46rom /users/sdewet/CxTF_DEV/CxTF_DB
=A0+ c2439dd...69cb5c3 beta_gc_dev -> steph/beta_gc_dev=A0 (forced upda=
te)
=A0+ fb25173...f0e4963 beta_veh_dev -> steph/beta_veh_dev=A0 (forced up=
date)
=A0* [new branch]=A0=A0=A0=A0=A0 beta_veh_dev_old -> steph/beta_veh_dev=
_old
Pruning steph
URL: /users/sdewet/CxTF_DEV/CxTF_DB/
=A0* [pruned] steph/beta_gc_dev_old
Updating kevin
error: refs/remotes/steph/beta_gc_dev does not point to a valid object!
error: refs/remotes/steph/beta_veh_dev does not point to a valid object=
!
Updating jose
error: refs/remotes/steph/beta_gc_dev does not point to a valid object!
error: refs/remotes/steph/beta_veh_dev does not point to a valid object=
!
### many more remotes with the same errors ###
