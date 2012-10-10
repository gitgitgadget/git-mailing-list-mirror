From: Drew Northup <drew.northup@maine.edu>
Subject: rm and add, but not rename, of identical files
Date: Wed, 10 Oct 2012 14:39:07 -0400
Message-ID: <1349894347.32696.10.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 20:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM1DK-0007LJ-7D
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 20:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab2JJSkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 14:40:52 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:34811 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654Ab2JJSkv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 14:40:51 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id q9AId9BE029289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 14:39:14 -0400
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-URT-Metrics: basalt.its.maine.edu 1060; Body=1 Fuz1=1 Fuz2=1
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: q9AId9BE029289
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1350499171.00397@gqz9duFmbC97Tno9l7T87A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207425>

I use etckeeper on some of my systems, backed by Git. On a system still
using a SYSV style init I recently modified my iptables settings,
changing which runlevels would stop/start the firewall.

[root@drew-northup ~]# etckeeper vcs status
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   inittab
#       deleted:    rc.d/rc2.d/K92iptables
#       deleted:    rc.d/rc3.d/K92iptables
#       deleted:    rc.d/rc4.d/K92iptables
#       deleted:    rc.d/rc5.d/K92ip6tables
#       modified:   sysconfig/ip6tables
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       rc.d/rc2.d/S08iptables
#       rc.d/rc3.d/S08iptables
#       rc.d/rc4.d/S08iptables
#       rc.d/rc5.d/S08ip6tables
no changes added to commit (use "git add" and/or "git commit -a")

It detects the changes as renames however=E2=80=94which in this case is=
n't
appropriate:

[root@drew-northup ~]# etckeeper vcs status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       renamed:    rc.d/rc2.d/K92iptables -> rc.d/rc2.d/S08iptables
#       renamed:    rc.d/rc3.d/K92iptables -> rc.d/rc3.d/S08iptables
#       renamed:    rc.d/rc4.d/K92iptables -> rc.d/rc4.d/S08iptables
#       renamed:    rc.d/rc5.d/K92ip6tables -> rc.d/rc5.d/S08ip6tables
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       modified:   inittab
#       modified:   sysconfig/ip6tables
#

Is there something I should be doing to suppress rename detection in
this case? (I presume changing the default=E2=80=94detecting as a renam=
e=E2=80=94isn't
such a bright idea.)

[root@drew-northup ~]# etckeeper vcs --version
git version 1.7.11.3

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
