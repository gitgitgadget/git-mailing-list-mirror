From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 06 Feb 2008 13:02:00 +0100
Message-ID: <47A9A1B8.5090501@users.sourceforge.net>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org> <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com> <47A98092.2070509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>, srp@srparish.netq
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 13:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMj7y-0005GU-Mu
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 13:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762004AbYBFMLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 07:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762003AbYBFMLN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 07:11:13 -0500
Received: from ananke.et.put.poznan.pl ([150.254.29.121]:45370 "EHLO
	ananke.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761254AbYBFMLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 07:11:12 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by ananke.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m16C5306011750;
	Wed, 6 Feb 2008 13:05:31 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.70] (pc1070.et.put.poznan.pl [150.254.11.70])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m16C20D18083;
	Wed, 6 Feb 2008 13:02:00 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <47A98092.2070509@viscovery.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.2.6.34845
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72805>

* Johannes Sixt [6 II 2008 10:40]:
> When I run git-daemon with a reduced path similar to this:
> 
>    PATH=/bin:/usr/bin /usr/local/bin/git-daemon ...
> 
> i.e. git is installed in /usr/local/bin, but it is not in PATH, then I
> also get "hung up unexpectedly" from a client that connects to this server.
> 
> Which makes me think that you xinetd doesn't pass a PATH to git-daemon
> that includes /usr/local/bin. Add this to your /etc/xinetd.d/git:
> 
>     env = PATH=/bin:/usr/bin:/usr/local/bin

You can also run "git daemon" passing --exec-path as a git argument. 
This should help.  For instance, I use the following configuration in 
inetd.conf (SunOS 5.9):

   git   stream   tcp   nowait   gituser   /usr/local/bin/git \
     git --exec-path=/usr/local/bin daemon --inetd \
     --base-path=/export/home/gituser/git /export/home/gituser/git

BR,
/Adam


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
