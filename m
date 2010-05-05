From: Dan Loewenherz <dloewenherz@gmail.com>
Subject: Bizarre behavior on git commit
Date: Tue, 4 May 2010 22:46:07 -0700
Message-ID: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 07:46:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9XRL-0003aP-4E
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 07:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab0EEFq3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 01:46:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40645 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab0EEFq3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 May 2010 01:46:29 -0400
Received: by wyb35 with SMTP id 35so60330wyb.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=F9qpoNNTK19XVWUUqc7UdhKtB/0Rk1/03Mhr5aCHxzQ=;
        b=DBAXsKts67MeKOZIy1nTCTrXNFIqSMfgILdHldWf6j/f2v2WqdmNOy+0jjUNz/tgm6
         stsOA1CeUtQGdfjJaovmT+kaxUKpMTwazYQdOZTrfieYQmc52YzMPJb56x+bwF00sWUC
         SirL4IeF6BvmIHggL27KPTgAFMNV8Lle46WkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=SXOgLdh9dayAgOqVwFYsiCyYS1k054YXVO77/c4J5/+rZ9yR+RMKci+ZXByEtltvCd
         h7IR8xvKmICVHnuWAFdmP/ivVqf5ClRAKACG4LOjcJoMojnCB6L5S19+/DdPsQ/Cw236
         FxNlzDH23OqaZwqcBfQVZLW/0yUxYNSRa2nPs=
Received: by 10.216.163.67 with SMTP id z45mr635828wek.26.1273038387540; Tue, 
	04 May 2010 22:46:27 -0700 (PDT)
Received: by 10.216.52.83 with HTTP; Tue, 4 May 2010 22:46:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146376>

I'm running into a weird issue in a specific repo where "git show-ref"
usage is being displayed after invocating "git commit".

E.g.
$ git commit -m "my commit message"
usage: git show-ref [-q|--quiet] [--verify] [--head]
[-d|--dereference] [-s|--hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags]
[--heads] [--] [pattern*]
=C2=A0=C2=A0 or: git show-ref --exclude-existing[=3Dpattern] < ref-list

=C2=A0=C2=A0 =C2=A0--tags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0only show tags (can be combined with heads)
=C2=A0=C2=A0 =C2=A0--heads =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 only show heads (can be combined with tags)
=C2=A0=C2=A0 =C2=A0--verify =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0stricter reference checking, requires exact ref path
=C2=A0=C2=A0 =C2=A0--head =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0show the HEAD reference
=C2=A0=C2=A0 =C2=A0-d, --dereference =C2=A0 =C2=A0 dereference tags int=
o object IDs
=C2=A0=C2=A0 =C2=A0-s, --hash[=3D<n>] =C2=A0 =C2=A0 =C2=A0only show SHA=
1 hash using <n> digits
=C2=A0=C2=A0 =C2=A0--abbrev[=3D<n>] =C2=A0 =C2=A0 =C2=A0 =C2=A0use <n> =
digits to display SHA-1s
=C2=A0=C2=A0 =C2=A0-q, --quiet =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be qu=
iet
=C2=A0=C2=A0 =C2=A0--exclude-existing[=3D<pattern>]
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0show refs from stdin that aren't in local repos=
itory

[master 28a735f] my commit message
=C2=A01 files changed, 2 insertions(+), 0 deletions(-)
$

This happens for every commit in this repository. I looked through the
git source and failed to find any reference to git show-ref (or
anything related to it) in buildin/commit.c. I gave up my search in
hope that someone on the git list would have a better idea. I'm
running version 1.7.0.3.311.g6a6955.

-Dan
