From: Bill Lear <rael@zopyra.com>
Subject: git protocol over port-forwarding
Date: Wed, 14 Mar 2007 12:37:20 -0600
Message-ID: <17912.16608.852664.321837@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 19:37:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRYMC-0003x4-7m
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 19:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbXCNShY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 14:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbXCNShY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 14:37:24 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60376 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932487AbXCNShX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 14:37:23 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2EIbM008579;
	Wed, 14 Mar 2007 12:37:22 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42220>

We are attempting to use the git protocol throughout our company, as
it saves ssh-related problems of permissions and umasks for a our
poorly-administered community of developers, engineers, and others.

This fails, and I was wondering if anyone has any experience using
port-forwarding and the git protocol, or if it is not presently
possible.

Here's how we set things up ("source" is where git-daemon runs,
and "xiphi" is a client machine):

On the source machine, which is running the git daemon, and listening
on port 9418, I set up this ssh config entry in my ~/.ssh/config file:

Host xiphi-git
     Protocol 2
     ForwardX11 yes
     Hostname xiphi.lsscorp.com
     RemoteForward 5700 localhost:9418
     HostKeyAlias xiphi-git

Then on source, I ssh to xiphi-git, which connects to xiphi and sets up
a portforwarding from xiphi:9418 back to source:9418.  Then, on xiphi:

xiphi:~/y % git clone git://localhost:5700/fusion
Initialized empty Git repository in /home/furnish/y/fusion/.git/
fatal: The remote end hung up unexpectedly
fetch-pack from 'git://localhost:5700/fusion' failed.

So, we are wondering if perhaps the git daemon could be jiggered to
work somehow, or if there are other options for us.


Bill
