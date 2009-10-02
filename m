From: Nils Homer <nilshomer@gmail.com>
Subject: How to delete large files
Date: Fri, 02 Oct 2009 03:03:44 -0700
Message-ID: <C6EB1E10.D7AB%nilshomer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 02 12:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtezX-0001ol-9y
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 12:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbZJBKDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 06:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757487AbZJBKDs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 06:03:48 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:33006 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461AbZJBKDr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 06:03:47 -0400
Received: by qyk4 with SMTP id 4so808900qyk.33
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from
         :to:message-id:thread-topic:thread-index:mime-version:content-type
         :content-transfer-encoding;
        bh=FfyJQ0YZ3m51x35Mbc5q+JEMkxiASdfoerXg4VLlaMg=;
        b=BClSCrO9buJGzfnbnEAgivnYJeZZI6emEksrIuPjWllnljg6wbbRps2XUQ80dXidso
         +9rANLRtLh2okyMPG7IHOELIS0YlcCwfut2MweXJVofZAuRgoZnQQOKeKRP0NZOJ/i0z
         hLBh2roZeXGzuH364hc1Kki7lhhCjRuK+ht5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:message-id:thread-topic
         :thread-index:mime-version:content-type:content-transfer-encoding;
        b=c082ORXrRff3w1n/nMXeIIUoYFAWtgIh8EC4WKeTcS8mWyClZjkjccPeXERNghJx4l
         VLLg2q7jnjOkMxC873ssgc4f+p9HeLpZJLdEzsXeMZtukTqJTgsaWm6KDp9jMD+X9Dra
         HVHzWqr2WcKMpPcvdZXYxePW2UGS/p0DV//zY=
Received: by 10.224.103.12 with SMTP id i12mr740351qao.120.1254477831004;
        Fri, 02 Oct 2009 03:03:51 -0700 (PDT)
Received: from ?192.168.1.100? (cpe-76-172-154-28.socal.res.rr.com [76.172.154.28])
        by mx.google.com with ESMTPS id 8sm841062qwj.34.2009.10.02.03.03.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 03:03:50 -0700 (PDT)
User-Agent: Microsoft-Entourage/12.20.0.090605
Thread-Topic: How to delete large files
Thread-Index: AcpDR6AGFNwAaUrpmkaexEDPe7ADCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129438>

I wish to delete some large offending files (10MB to >100MB each) from =
my
git repository (git://bfast.git.sourceforge.net/gitroot/bfast/bfast).  =
The
current size of the repo is 656MB.

I created a backup of my repository and then searched for such offendin=
g
files using a script found here:
http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-pa=
ck-ob
jects-and-trim-your-waist-line/
where I modified the script to output in MB instead of KB.

This gave me a list of files that I wanted to delete:
-e   size  pack                                      SHA
location
113  113   f9f2faab597d4f8ccbfac2864347dbc256353fbf
tests.long/save/save.tar.gz
113  113   926b1ba880a26354c4a6b9391985f57fbc9a1174
tests.long/save/save.tar.gz
113  113   e568480bcb8239e6d1ed8d2da86c309c0d3d101b
tests.long/save/save.tar.gz
113  113   e3c0ee53f20e8ebfb60eaefcd7b405168c26a565
tests.long/save/save.tar.gz
103  103   ee2ee50c5075d05d29764c8d4b9acc2acedda919
tests.long/save/save.tar.gz
35   35    319c75945c27096093dbab5a0bf6a9a08089bc2d
tests.long/data/data.tar.gz
11   11    805193c74ceeffca9da3a2788545e701d77e1caf  tests/save/save.ta=
r.gz
11   11    658e4a78c1028875ab597d6bde5823cd6a1694b9  tests/save/save.ta=
r.gz

So I decided to remove these files using:
git filter-branch --index-filter "git rm -rf --cached --ignore-unmatch
tests.long/save/save.tar.gz tests.long/data/data.tar.gz
tests/save/save.tar.gz" HEAD

I then ran:
rm -rf .git/refs/original
git reflog expire --expire=3Dnow =8Ball
git gc --prune=3Dnow

Still (using du =ADh) the repository is 656MB and I can see the above f=
iles in
the revision list:
git rev-list --all --objects | grep tests.long/save/save.tar.gz
ee2ee50c5075d05d29764c8d4b9acc2acedda919 tests.long/save/save.tar.gz
e568480bcb8239e6d1ed8d2da86c309c0d3d101b tests.long/save/save.tar.gz
f9f2faab597d4f8ccbfac2864347dbc256353fbf tests.long/save/save.tar.gz
926b1ba880a26354c4a6b9391985f57fbc9a1174 tests.long/save/save.tar.gz
e3c0ee53f20e8ebfb60eaefcd7b405168c26a565 tests.long/save/save.tar.gz

Could this be because of tags that I had previously created?

I am running git version 1.6.3.3.  I appreciate any help in advance,

Nils Homer
