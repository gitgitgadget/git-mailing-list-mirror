From: Alexander Pepper <pepper@inf.fu-berlin.de>
Subject: Bug?: 'git log --find-copies' doesn't match 'git log --follow <rev> -- path/to/file'
Date: Fri, 30 Sep 2011 17:32:38 +0200
Message-ID: <DBC73B3F-2703-4651-AADA-233A9CC38AFD@inf.fu-berlin.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 17:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9f56-000455-Ex
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 17:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab1I3Pcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 11:32:46 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:48173 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755659Ab1I3Pcp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 11:32:45 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R9f4t-0003Xr-OK>; Fri, 30 Sep 2011 17:32:43 +0200
Received: from 91-66-162-110-dynip.superkabel.de ([91.66.162.110] helo=apepper.infopark)
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtpsa
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R9f4t-0002EQ-27>; Fri, 30 Sep 2011 17:32:43 +0200
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: 91.66.162.110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182487>

Hello Again.

I'm not really sure, if this is a bug or if I am missing something, but the following is quite annoying:

$ git version
git version 1.7.6.3
$ git clone https://github.com/voldemort/voldemort.git
$ cd voldemort
$ git log --numstat --find-copies dd4e90f9
...
3       15      contrib/ec2-testing/src/java/voldemort/utils/{StopClusterException.java => ClusterOperation.java}
$ git log --numstat dd4e90f9 -- contrib/ec2-testing/src/java/voldemort/utils/ClusterOperation.java
...
23      0       contrib/ec2-testing/src/java/voldemort/utils/ClusterOperation.java
$ git log --numstat --follow dd4e90f9 -- contrib/ec2-testing/src/java/voldemort/utils/ClusterOperation.java
...
6       10      src/java/voldemort/annotations/concurrency/Immutable.java => contrib/ec2-testing/src/java/voldemort/utils/ClusterOperation.java

So git log with copy and rename detection on (--find-copies) tells me, that the file StopClusterException.java is copied to ClusterOperation.java. But If I ask git log for that specific file with --follow git claims a copy from Immutable.java to ClusterOperation.java!

I understand, that git doesn't record renames and copies, but only detects it afterwords. But at least I would expect, that git detects the same thing consistently between to (quite) alike flags.

I also tried adding "--find-copies" and "--find-copies-harder" to 'git log --numstat --follow dd4e90f9', but they also result in claiming Immutable.java as the origin of the copy.

Is there a flag to get consistent results between the two or is this really a bug?

Greetings from Berlin
Alex