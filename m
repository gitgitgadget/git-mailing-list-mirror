From: "Joe Casadonte" <jcasadonte@northbound-train.com>
Subject: git clone - failing on cygwin with git:// but not with ssh://
Date: Sat, 27 Dec 2008 17:37:59 -0500
Organization: Llama Fresh Farms, Neare Paraguay
Message-ID: <ud4fdxn08.fsf@terrapin.northbound-train.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 00:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGiFw-0000e8-6W
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 00:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179AbYL0XGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 18:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbYL0XGT
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 18:06:19 -0500
Received: from dsl092-238-209.phl1.dsl.speakeasy.net ([66.92.238.209]:57003
	"EHLO headlight.northbound-train.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751186AbYL0XGS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Dec 2008 18:06:18 -0500
X-Greylist: delayed 1691 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Dec 2008 18:06:17 EST
Received: from jcasadon-us (localhost.localdomain [127.0.0.1])
	by headlight.northbound-train.com (8.13.8/8.13.8) with ESMTP id mBRMc2xE019714
	for <git@vger.kernel.org>; Sat, 27 Dec 2008 17:38:04 -0500
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104030>

Hi,

I'm new to git, so my apologies if I'm missing something pretty
basic.  Here's my setup:

"Public" server
---------------
OS: RedHat clone, 2.6.9 kernel
git version: self-compiled, 1.6.0.6

Test client #1 (works)
----------------------
OS: RedHat clone, 2.6.9 kernel
git version: self-compiled, 1.6.0.6

Test client #2 (fails)
----------------------
OS: Win XP Pro
git version: cygwin compiled, 1.6.0.4

I have a new repository on the "public" server, and have cloned it on
test client #1 with:

$ git clone git://foobar/myproj.git
Initialized empty Git repository in /opt/myproj/.git/
remote: Counting objects: 104, done.
remote: Compressing objects: 100% (72/72), done.
remote: Total 104 (delta 22), reused 104 (delta 22)
Receiving objects: 100% (104/104), 76.97 KiB, done.
Resolving deltas: 100% (22/22), done.


I try the same thing on test box #2 and receive:


D:\temp>git clone git://foobar/otminfmyproj.git
Initialized empty Git repository in /cygdrive/d/temp/foobar/.git/
fatal: read error (Socket operation on non-socket)
fatal: early EOF
fatal: index-pack failed


I've turned on verbose logging in the daemon and I see the following
messages:

Dec 27 17:31:53 foobar git-daemon: [30327] Connection from 192.168.1.102:2598
Dec 27 17:31:53 foobar git-daemon: [30327] Extended attributes (16 bytes) exist <host=foobar>
Dec 27 17:31:53 foobar git-daemon: [30327] Request upload-pack for '/myproj.git'
Dec 27 17:31:55 foobar git-daemon: [30327] Disconnected (with error)

A successful log (from test client #1) shows practically the same
thing:

Dec 27 17:33:22 foobar git-daemon: [30338] Connection from 192.168.2.101:44832
Dec 27 17:33:22 foobar git-daemon: [30338] Extended attributes (16 bytes) exist <host=foobar>
Dec 27 17:33:22 foobar git-daemon: [30338] Request upload-pack for '/myproj.git'
Dec 27 17:33:22 foobar git-daemon: [30338] Disconnected


Running the clone via ssh protocol from test client #2 works, though:


D:\temp>git clone ssh://root@foobar/nfs02/git/myproj
Initialized empty Git repository in /cygdrive/d/temp/myproj/.git/
remote: Counting objects: 104, done.
remote: Compressing objects: 100% (72/72), done.
remote: Total 104 (delta 22), reused 104 (delta 22)
Receiving objects: 100% (104/104), 76.97 KiB | 9 KiB/s, done.
Resolving deltas: 100% (22/22), done.


The same test machine has cloned from a different linux server via the
git protocol just fine.

Any ideas?  Thanks for the help!

--
Regards,


joe
Joe Casadonte
jcasadonte@northbound-train.com

------------------------------------------------------------------------------
         Llama Fresh Farms => http://www.northbound-train.com
    Ramblings of a Gay Man => http://www.northbound-train.com/ramblings
               Emacs Stuff => http://www.northbound-train.com/emacs.html
          Music CD Trading => http://www.northbound-train.com/cdr.html
------------------------------------------------------------------------------
                       Live Free, that's the message!
------------------------------------------------------------------------------
