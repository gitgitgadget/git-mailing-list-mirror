From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 11:54:14 -0500
Message-ID: <482481B6.5010106@nrlssc.navy.mil>
References: <20080508210125.GC32762@sigill.intra.peff.net> <alpine.LFD.1.10.0805081712270.23581@xanadu.home> <20080508211734.GA819@sigill.intra.peff.net> <48236F69.2060900@nrlssc.navy.mil> <20080508213107.GA1016@sigill.intra.peff.net> <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil> <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri May 09 18:55:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuVsd-0001qk-Co
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 18:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757236AbYEIQyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 12:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756966AbYEIQyp
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 12:54:45 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33084 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756430AbYEIQyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 12:54:45 -0400
Received: from starfish.gems.nrlssc.navy.mil (starfish.nrlssc.navy.mil [128.160.50.76])
	by mail.nrlssc.navy.mil (8.13.8/8.13.8) with ESMTP id m49GsESt007633;
	Fri, 9 May 2008 11:54:14 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 9 May 2008 11:54:14 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <alpine.LFD.1.10.0805091205580.23581@xanadu.home>
X-OriginalArrivalTime: 09 May 2008 16:54:14.0857 (UTC) FILETIME=[5012C390:01C8B1F5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81623>

Nicolas Pitre wrote:
> On Fri, 9 May 2008, Brandon Casey wrote:
> 
>> Geert Bosch wrote:
>>> On May 9, 2008, at 00:19, Jeff King wrote:
>>>
>>>> I like it. It makes an easy rule to say "packed objects _never_ get
>>>> pruned, they only get demoted to loose objects." And then of course
>>>> we have sane rules for pruning loose objects.
>>> Isn't there an issue with the "git gc" triggering because there
>>> may be too many loose unreferenced objects?
>>> Still, I do like the approach.
>> This would be an argument for going the extra mile and having the loose
>> objects adopt the timestamp of their pack file. In the normal case they
>> would probably be pruned immediately during the same git-gc run.
> 
> Well, not necessarily.  If you created a large branch yesterday and you 
> are deleting it today, then if you repacked in between means that those 
> loose objects won't be more than one day old.  Yet there could be enough 
> of them to trigger auto gc.  But that auto gc won't pack those objects 
> since they are unreferenced.  Hence auto gc will trigger all the time 
> without making any progress.

That's true, but the intermediate repack is not the cause here. You'd be
in the same situation if a large branch was created yesterday and then
deleted today even if packing had never occurred.

I do see your point, but you should have said a large branch created a month
ago, deleted today, but repacked yesterday. :)

-brandon
