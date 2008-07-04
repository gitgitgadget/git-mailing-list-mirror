From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Fri, 04 Jul 2008 09:49:31 -0400
Message-ID: <486E2A6B.7040905@verizon.net>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com>
 <c376da900806301549r6044cd35r5a23baa405570808@mail.gmail.com>
 <7vzlp1jh1o.fsf@gitster.siamese.dyndns.org> <486AC8E0.60002@verizon.net>
 <c376da900807031613pc63639du356946f8daeabb29@mail.gmail.com>
 <486E2245.6040404@gmail.com> <alpine.DEB.1.00.0807041420330.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Adam Brewster <adambrewster@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 15:50:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElgV-0000PZ-Sc
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759195AbYGDNtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755501AbYGDNtw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:49:52 -0400
Received: from vms173001pub.verizon.net ([206.46.173.1]:60156 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759195AbYGDNtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:49:49 -0400
Received: from [192.168.1.117] ([71.246.235.165]) by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3H00FWTIEPAVJ6@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 04 Jul 2008 08:49:38 -0500 (CDT)
In-reply-to: <alpine.DEB.1.00.0807041420330.9925@racer>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87392>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 4 Jul 2008, Mark Levedahl wrote:
> 
> 
> /me wonders if it would not make sense to support "git push <bundle>", 
> then.  Maybe with a running counter, i.e.
> 
> 	$ git push the-bundle-5.bundle master
> 
> would create the-bundle-6.bundle with everything needed in addition to 
> the-bundle-5.bundle to have the current "master".
> 
> Just an idea,
> Dscho
> 

I think the trouble here is that the-bundle-5.bundle does not necessarily 
contain the basis. Consider the general case of pushing master, next, pu, and 
only pu has updated since the last push. Now, the-bundle-6.bundle will only 
contain pu, not master nor next as there is nothing new, and thus is not a good 
basis for creating the-bundle-7.bundle. This leads to a need for a meta-storage 
of basis or a redefinition of how git-bundle deals with refs that are equal to 
the given basis (currently, it excludes such refs).

Mark
