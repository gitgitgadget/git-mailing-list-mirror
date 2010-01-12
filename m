From: David Reitter <david.reitter@gmail.com>
Subject: Re: git-log - hide parent (was: merging two equivalent branches)
Date: Tue, 12 Jan 2010 11:59:38 -0500
Message-ID: <1386C58D-CA57-4B32-8174-E7983AF2F520@gmail.com>
References: <B0543B3C-C139-4BD3-B028-58B4DA132422@gmail.com> <46d6db661001071022t79ca65foac249d948a20c328@mail.gmail.com> <DF05F91F-CBFD-458A-A99F-79E98ACA5146@gmail.com> <201001080600.26088.chriscool@tuxfamily.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-49--606946602"
Content-Transfer-Encoding: 7bit
Cc: Christian MICHON <christian.michon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 17:59:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUk5v-0001jA-PA
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab0ALQ7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 11:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657Ab0ALQ7u
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:59:50 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:51145 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab0ALQ7t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:59:49 -0500
Received: by ywh6 with SMTP id 6so22625258ywh.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:message-id:references:to
         :content-transfer-encoding:x-pgp-agent:x-mailer;
        bh=7B4EBcAiK/t33U6gm1BVAfhG8aYBjCK6DYh8RKODtgY=;
        b=qzzzwr3DQMoVIck54m/odm0YDyhRwIprtavrw4D9usXAuKEEtp21HTihjKRsUVpQzz
         Xyb23tipvTc/O/y/L8rV3Ckd+GBqCeRbaT5TCyeZPuCqagzgSy3Un8S+1P2QSy80Zgx8
         W2sksrY1CGgX8u/nRjWIyK8JJjttZY10wULSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to:content-transfer-encoding:x-pgp-agent
         :x-mailer;
        b=GT9IFzlKbeAWuQDqrnP35Aeevb81SHMfulPdQ85PbKa5AYb4dq7OwyC4Whi/k/qF+z
         Bqz0WReUvkvunpa+Cf1T+LL6cHcFz4Uuzg621k2M7TOSbKyIoETorcKlw19iNFd9Ehwi
         jUjtrrlnDHbzaMLOiEW/Whbrc4oNqQ21AmSIo=
Received: by 10.150.74.8 with SMTP id w8mr2742691yba.52.1263315588488;
        Tue, 12 Jan 2010 08:59:48 -0800 (PST)
Received: from scarlett.psy.cmu.edu (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id 20sm9378114ywh.2.2010.01.12.08.59.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Jan 2010 08:59:44 -0800 (PST)
In-Reply-To: <201001080600.26088.chriscool@tuxfamily.org>
X-Pgp-Agent: GPGMail 1.2.3
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136740>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-49--606946602
Content-Type: multipart/mixed; boundary=Apple-Mail-48--606946622


--Apple-Mail-48--606946622
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 8, 2010, at 12:00 AM, Christian Couder wrote:
> What you could perhaps do with "git replace" or a graft is to change =
the=20
> merge commit so that it has only one parent instead of 2.

Thanks, also to Avery for his idea with "git .", which works well for =
me.=20

For the benefit of others, here's what I've done in the end in order to =
get rid of the extra 100,000 commits in the old upstream branch.

A very simple little script takes care of remapping the merges of the =
old upstream branch to the new one.
It takes the output of this

git log --since=3D2009-01-01  --format=3D"%H %f"

on each of the two upstream branches and finds corresponding commits =
using the first commit line.  With this alignment in place, we then need =
the list of merge commits that need to be redirected:

export BRANCHES=3D'b1 b2 b3'
git log --since=3D2009-01-01 --author=3D"my name" --format=3D"%H %P" =
$BRANCHES

This can be fairly broad, but I didn't want BRANCHES to contain the =
upstream branches (even then it probably doesn't matter).

I then used a little piece of trivial code to apply the alignment to the =
parents of potential merge commits, to generate the grafts.
This is what's attached, in case anyone will find it useful.





--Apple-Mail-48--606946622
Content-Disposition: attachment;
	filename=make-grafts.py
Content-Type: text/x-python-script;
	name="make-grafts.py"
Content-Transfer-Encoding: 7bit

#!/usr/bin/python

# This will output a Git "grafts" file to use when a (set of) downstream branch(es)
# is to switch from merging with one upstream branch to another upstream branch, without
# keeping the full history of both upstream branches in the repository.
# If the upstream branches contain the same history information (semantically speaking),
# such as when they represent different conversions from an old CVS/SVN repository, then
# this script will find an alignment between them.
# The resulting grafts file will map past merges in the downstream branch to the new
# upstream branch, as if the old upstream branch never existed.
# If this works well, a "git filter-branch" should burn in the grafts so that they can
# be removed.  (This is a history-changing operation.)

# See also:
# http://thread.gmane.org/gmane.comp.version-control.git/136377


# recommended usage:
#./make-grafts.py | sort | uniq > .git/info/grafts

# set input file names
upstream1 = "em-log"
upstream2 = "em-new-log"
mergecommits = "aq-merges"


# produce files:
# git checkout upstream1
# git log --since=2009-01-01  --format="%H %f">../emc/em-log
# git checkout upstream2
# git log --since=2009-01-01  --format="%H %f">../emc/em-new-log
# export BRANCHES='topic/b1 topic/b2 john jane master'
# git log --since=2009-01-01 --author="David Reitter" --format="%H %P" $BRANCHES >../emc/aq-merges; git log --since=2009-01-01 --merges --format="%H %P" $BRANCHES >>../emc/aq-merges

#################

import re
import sys

r1msgs = {}
r1revids = {}
# checkout emacs
# git log --since=2009-01-01  --format="%H %f">../emc/em-log
file = open(upstream1, 'r')
for l in file:
    m =    re.match("([a-f0-9]*) (.*)", l)
    if m:
       r1msgs[m.group(1)] = m.group(2)
       r1revids[m.group(2)] = m.group(1)
file.close()


r2msgs = {}
r2revids = {}
# checkout emacs23
# git log --since=2009-01-01  --format="%H %f" >../emc/em-new-log
file = open(upstream2, 'r')
for l in file:
    m = re.match("([a-f0-9]*) (.*)", l)
    if m:
       r2msgs[m.group(1)] = m.group(2)
       r2revids[m.group(2)] = m.group(1)
file.close()

# checkout master
# export BRANCHES='23.1.undone  Aquamacs22  dr-after-merge  dr/dev  dr/experimental  dr/suedit master topic/NSAlertDialogs  topic/dialogs  topic/face-remapping  topic/mac-support  topic/menu-bar  topic/minibuffer  topic/option-key-remap  topic/printing  topic/python-mode  topic/reconf  topic/smart-spacing  topic/spelling  topic/tabbar  topic/tmm  topic/toolbar'
# git log --since=2009-01-01 --author="David Reitter" --merges --format="%H %P" $BRANCHES >../emc/aq-merges
# it's better to use all commits so we don't miss anything
# git log --since=2009-01-01 --author="David Reitter" --format="%H %P" $BRANCHES >../emc/aq-merges; git log --since=2009-01-01 --merges --format="%H %P" $BRANCHES >>../emc/aq-merges
def replace (revid):
   if revid in r1msgs:
      r1m = r1msgs[revid]
      if r1m in r2revids:
         r2r = r2revids[r1m]
         if r2r:
            return r2r
         else:
            print >> sys.stderr, "can't get mapping for revid "+revid+ r1m
            
      else:
         print >> sys.stderr, "can't find message of revid "+revid
   return revid
      

# checkout master
# 

file = open(mergecommits, 'r')
for l in file:
    revids = l.rstrip().split(" ")
    if revids:

        # test:
        # revids2 = revids
        # for r in revids[1:]:
        #     r2 = replace(r)
        #     if r != r2:
        #         revids2 = revids2 + [r2]
        # correct alternative
        revids2 = [revids[0]] + map(replace, revids[1:])
        if revids != revids2:
            # make graft entry to write the merge such that it
            # looks like the merge came from the other branch
            print " ".join(revids2)
        else:
            print >> sys.stderr, "no remappings found for parents of merge revid "+" ".join(revids)

file.close()



--Apple-Mail-48--606946622--

--Apple-Mail-49--606946602
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.12 (Darwin)

iEYEARECAAYFAktMqn4ACgkQYotoJUVQB4IjxgCfUorZDSiUPSDho5CQefA5+vuS
UlAAoKgrIPWw8ck5hS0j2MP3n8tJq3vG
=j/Qo
-----END PGP SIGNATURE-----

--Apple-Mail-49--606946602--
