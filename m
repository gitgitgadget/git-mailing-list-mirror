From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Sun, 14 Dec 2008 17:20:26 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812141700330.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com>
 <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm> <gi2rej$1mn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 01:20:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC1CL-0004LY-EG
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 01:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbYLOATQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 19:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbYLOATQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 19:19:16 -0500
Received: from mail.lang.hm ([64.81.33.126]:38409 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbYLOATP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 19:19:15 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBF0JDrH003072;
	Sun, 14 Dec 2008 16:19:13 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <gi2rej$1mn$1@ger.gmane.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103114>

On Sun, 14 Dec 2008, Sitaram Chamarty wrote:

> On 2008-12-14, david@lang.hm <david@lang.hm> wrote:
>> On Sun, 14 Dec 2008, martin wrote:
>>> Why do you trust VPN more than the SSH?
>> in part it's that a VPN is a single point of control for all remote
>> access.
>>
>> If you use ssh you end up exposing all the individual machines
>
> Need not be true.  None of my internal servers aer even
> accessible from the outside world; they're all in RFC1918
> space and there's only one gateway.  This *is* my single
> point of control.
>
> I can setup different port numbers to forward to different
> internal servers (ssh, http, whatever I wish); that may
> sound like a form of "exposing" but in reality it's a lot
> *more* restrictive than setting up a VPN and granting access
> to it.

if you setup multiple inbound redirects for SSH (be they different IP 
addresses or different ports), then you have the exact same situation as 
those machines being accessed directly.

> I actually don't like VPNs; they imply that you're "inside"
> the network in some way, and I hate blurring that
> distinction.  If I'm outside, I want to be acutely aware of
> it, and the fact that I can't even ping one of the inside
> hosts or see what's on it, or do anything other than what is
> specifically allowed by the gateway, is one way of ensuring
> this.

this is the mindset about SSH that I don't like. I see allowing SSH in as 
blurring that distinction.

With a VPN you aren't blurring it, you _are_ letting the person into your 
network. it's not appropriate to do this for everyone, but in the initial 
post the desire was to have trusted company employees working remotely 
push data to the repository. In that scenerio a VPN makes sense. If you 
were doing a distributed opensource project it would probably not make 
sense to allow contributers that you only know via e-mail to VPN into a 
network to do their push (it can be agued that they shouldn't be doing a 
push at all, but that's a workflow discussion ;-)

many people who would never allow a person to VPN into a network seem to 
have no problem with that same person useing SSH to login to a machine on 
that same network (and usually without trying to setup a limited shell). 
In my opinion SSH and VPN access are both in the same category.

In both cases you can limit what the person you are granting access can 
do. with a VPN you would use a firewall to control what they can access 
after connecting to the VPN, with SSH you have to have the server they are 
connecting to configured to limit what they can do.

VPNs tend to have better tools for auditing access and doing strong 
authentication other than certificates (even certificate plus password is 
better than just certificate). cerificates are good and useful, but they 
aren't always enough by themselves.

there have been a number of breeches over the last few years that have 
resulted from one client machine with SSH being comprimized and the 
credentials then used to hop to other machines, gather other credentials 
to then use to comprimize other machines, etc. while I am sure that there 
have also been networks comprimized via VPN, I haven't heard of any 
daisy-chain type attacks involving VPN access.

SSH is a monoculture. there is essentially only one implementation that is 
used (although there are patches to it in some cases), and while it is 
pretty good, any problems with it give you no options. with VPNs there are 
many implementations, if any one has a problem it's possible to replace it 
(painful to change out clients, but possible)


David Lang
