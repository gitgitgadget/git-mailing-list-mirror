From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: [git-p4] Cannot submit to perforce
Date: Tue, 8 Jul 2008 16:30:44 -0700
Message-ID: <1621f9fa0807081630o5308d035o49a2b2dd60cceffe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 01:32:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGMfD-0003F8-28
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 01:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760594AbYGHXau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 19:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760546AbYGHXau
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 19:30:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:8155 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760549AbYGHXas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 19:30:48 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1982953wri.5
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 16:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=yp2bANCE/+4fstmi1q3IFwCw3jpkDDYSa0QE+9Lfyf0=;
        b=NNaQdoUnobrC/A6h2FHkGnrpaQO8J3gKmtY9DhcHwzzLOXa2QHbHgHmRGlEeFTkoCY
         NxolMq0+O5ea1kGTwOjCAnpu8nb0bikwIs15Xc81xLFyCx4q7ylFE+bJ/vuuSQPXOU9I
         3QLdI2s9Et51VhI77hi7jC8G6c1ioM8/rfz6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=VwU87rGqMkauihK1P9jj+2ZEvngJtDy8WfvePOk9RjDwVpFDXOAJzuM3kxwgfC02Hd
         BfLf0DOvFzGYIiansUP8Xvk1ET4lmjxXf3X2GDmW+0Bb3OJB51/C8zn4ua84IKSkylxG
         o401+AVnBVz/faO7wrh3ivJ9yP55VKSoRXGMA=
Received: by 10.150.12.3 with SMTP id 3mr11294411ybl.14.1215559844554;
        Tue, 08 Jul 2008 16:30:44 -0700 (PDT)
Received: by 10.151.155.8 with HTTP; Tue, 8 Jul 2008 16:30:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87810>

With today's git:

I'm trying to reproduce the git commands git-p4 execute.

$ git branch -r
  p4/HEAD
  p4/master

$ git diff-tree -r
"0a41bb5b8387517ca5c45c56544e978b2f82f021^".."0a41bb5b8387517ca5c45c56544e978b2f82f021"
:000000 100755 0000000000000000000000000000000000000000
67406438a99bb212502eb3f3581527f046a96964 A
r3d/Viewer/qtgui/tools/buildrss.py
...
...
...

$ git format-patch -k --stdout
"0a41bb5b8387517ca5c45c56544e978b2f82f021^".."0a41bb5b8387517ca5c45c56544e978b2f82f021"
| git apply --check -
<stdin>:225: trailing whitespace.
#
<stdin>:233: trailing whitespace.
#
<stdin>:273: trailing whitespace.

<stdin>:275: trailing whitespace.

<stdin>:295: trailing whitespace.

error: r3d/Viewer/qtgui/tools/buildrss.py: already exists in working directory
...
...
...

For me the "already exists in working directory" means we are not in
the right branch, and that we are trying to apply the same commit on
the master branch ?

If I issue git-p4 submit I have basically the same output, I say
"[s]kip this patch" and it ends with:
"""
Some files in your working directory are modified and different than
what is in your index. You can use git update-index <filename> to
bring the index up-to-date or stash away all your changes with git
stash.
"""
If I retry git-p4 submit with doing the stash, sometimes the perforce
submit goes fine, sometimes not... ???

Thanks for any help,
Benjamin.
