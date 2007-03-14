From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git protocol over port-forwarding
Date: Wed, 14 Mar 2007 21:05:37 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
References: <17912.16608.852664.321837@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRafG-0006zv-KD
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbXCNVFk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbXCNVFk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:05:40 -0400
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:38770 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422660AbXCNVFj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:05:39 -0400
Received: (qmail 26576 invoked by uid 103); 14 Mar 2007 21:05:37 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2833. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.033599 secs); 14 Mar 2007 21:05:37 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 14 Mar 2007 21:05:37 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <17912.16608.852664.321837@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42228>

On Wed, 14 Mar 2007, Bill Lear wrote:

> We are attempting to use the git protocol throughout our company, as
> it saves ssh-related problems of permissions and umasks for a our
> poorly-administered community of developers, engineers, and others.
>
> This fails, and I was wondering if anyone has any experience using
> port-forwarding and the git protocol, or if it is not presently
> possible.
>
> Here's how we set things up ("source" is where git-daemon runs,
> and "xiphi" is a client machine):
>
> On the source machine, which is running the git daemon, and listening
> on port 9418, I set up this ssh config entry in my ~/.ssh/config file:
>
> Host xiphi-git
>     Protocol 2
>     ForwardX11 yes
>     Hostname xiphi.lsscorp.com
>     RemoteForward 5700 localhost:9418
>     HostKeyAlias xiphi-git
>
> Then on source, I ssh to xiphi-git, which connects to xiphi and sets up
> a portforwarding from xiphi:9418 back to source:9418.  Then, on xiphi:
>
> xiphi:~/y % git clone git://localhost:5700/fusion
> Initialized empty Git repository in /home/furnish/y/fusion/.git/
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'git://localhost:5700/fusion' failed.
>
> So, we are wondering if perhaps the git daemon could be jiggered to
> work somehow, or if there are other options for us.

I don't think there is anything that needs changing with the git daemon 
... or at least I was able to successfully clone over an SSH port forward.

I did get the same error as you originally, but this was due to SSH 
failing to setup the tunnel connection (checking the logs showed that I 
had got the hostname in the forward wrong).

-- 
Julian

  ---
<rac> separated by irc networks...i sense a meg ryan movie coming on
