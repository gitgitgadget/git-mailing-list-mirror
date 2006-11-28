X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicholas Allen <nick.allen@onlinehome.de>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 22:26:25 +0100
Message-ID: <456CA981.4010808@onlinehome.de>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C7592.6020700@ableton.com>	<ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 21:26:57 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <456C9DFF.1040407@onlinehome.de>
X-Enigmail-Version: 0.94.0.0
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8f68dfdb39f9894a8a7411e7c5df1048
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32580>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpATL-0001NM-Nr for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755706AbWK1V0c (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756297AbWK1V0c
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:26:32 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:36068 "EHLO
 moutng.kundenserver.de") by vger.kernel.org with ESMTP id S1755706AbWK1V0b
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:26:31 -0500
Received: from [84.190.155.117] (helo=[192.168.1.100]) by
 mrelayeu.kundenserver.de (node=mrelayeu2) with ESMTP (Nemesis), id
 0MKwtQ-1GpATC2pKk-0007ZP; Tue, 28 Nov 2006 22:26:27 +0100
To: Nicholas Allen <nick.allen@onlinehome.de>
Sender: git-owner@vger.kernel.org

> 
> Just out of curiosity: How does git handle the case where one file is
> renamed differently in 2 branches and then the branches are repeatably
> merged? I know that bzr handles this very well and in various tests I
> did there were absolutely no repeated conflicts. Would git behave as
> well in this scenario?
> 

Ok - I got curious and decided to install git and try this myself.

In this test I had a file hello.txt that got renamed to hello1.txt in
one branch and hello2.txt in another. Then I merged the changes between
the 2 branches.

Here is how it looked after the merge in bzr:

 bzr status
renamed:
  hello2.txt => hello1.txt
conflicts:
  Path conflict: hello2.txt / hello1.txt
pending merges:
  Nicholas Allen 2006-11-28 Renamed hello to hello1


and here's how it looked in git:
git status
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       unmerged: hello.txt
#       unmerged: hello1.txt
#       unmerged: hello2.txt
#       modified: hello2.txt
#
nothing to commit

So git is not telling me that I have a conflict due to the same file
being renamed differently in 2 branches - well at least not in a way I
can comprehend anyway! Whereas bzr made this very clear. Also, in git I
ended up with 2 files:

 ls
hello1.txt  hello2.txt

whereas in bzr there was only one file and I just had to decide which
name it was to be given to resolve the conflict.

I'm not sure how I should resolve the conflict in git but that's
probably just because I am not familiar with it yet and the message it
gave was not comprehensible or helpful to me in the slightest. In bzr it
was very easy and repeatably merging caused no trouble at all - the name
conflict had to be resolved only once.

While it was good that git detected my file rename (although this was
not hard as the contents did not change at all) the process in bzr was
*much* smoother and more user friendly than it was it git. When you have
conflicts I think it's especially important that the RCS inform you of
what is really happening so you do not make mistakes. Bzr was much more
informative than git was and told me exactly why there was a conflict
and made it easy to resolve it.

This situation is a pretty common one and it seems to me that git's
content based approach is not as useful in this case as the file
identity approach that bzr uses.


Nick
