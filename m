From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 14:19:07 +0200
Message-ID: <4860E63B.6040709@dawes.za.net>
References: <200806241322.14224.jnareb@gmail.com>	<willow-jeske-01l5PFjPFEDjCfzf-01l5p7eVFEDjCZRD> <28156.2147582465$1214307807@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:21:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7Wv-0003ks-N4
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYFXMUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYFXMUx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:20:53 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:56908 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbYFXMUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:20:52 -0400
Received: from spunkymail-a8.g.dreamhost.com (sd-green-bigip-207.dreamhost.com [208.97.132.207])
	by hapkido.dreamhost.com (Postfix) with ESMTP id CD30617A1D7
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 05:20:51 -0700 (PDT)
Received: from [192.168.201.100] (unknown [41.247.117.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a8.g.dreamhost.com (Postfix) with ESMTP id 6D42C10BD91;
	Tue, 24 Jun 2008 05:19:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <28156.2147582465$1214307807@news.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86043>

David Jeske wrote:
> -- Jakub Narebski wrote:
>> If they are using '-f', i.e. force, they should know and be sure what
>> they are doing; it is not much different from 'rm -f *'.
> 
> Sure, no problem. I don't want the ability to "rm -f *". I'm raising my hand
> and saying "I don't want the power to do these things, so just turn off all the
> git commands that could be destructive and give me an alternate way to do the
> workflows I need to do". Just like a normal user on a unix machine doesn't run
> around with the power to rm -f /etc all the time, even though they may be able
> to su to root.
> 
> Let me guess, you're always running euid==0. :)

Do you also ask the gnu coreutils folks to remove the -f option from 
their utilities?

There is a basic assumption that folks that are using tools have at 
least made an attempt to understand what it is that they are doing, 
before e.g. waving a chainsaw around.

One thing that I haven't seen addressed in this thread is the fact that 
if you have a dirty working directory, and you "git reset --hard", 
whatever was dirty (not yet in the index, or committed) will be blown 
away, and no amount of reflog archeology will help you get it back.

Any changes that had been staged in the index WILL exist in the object 
directories as dangling objects, and can be retrieved through judicious 
use of "git fsck" and "git show", but will certainly be a painful 
exercise if there was an extensive set of changes.

Rogan
