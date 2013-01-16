From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore certain stat fields
Date: Wed, 16 Jan 2013 20:14:20 +0000
Message-ID: <50F70A1C.1000508@ramsay1.demon.co.uk>
References: <7vy5fv71ad.fsf@alter.siamese.dyndns.org> <1119893992.2134035.1358233781666.JavaMail.root@dewire.com> <7va9sa6f0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:17:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvZPv-0002AD-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 21:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab3APUQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 15:16:40 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:47552 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab3APUQj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 15:16:39 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 23041A0C080;
	Wed, 16 Jan 2013 20:16:37 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 2E5CAA0C073;	Wed, 16 Jan 2013 20:16:36 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Wed, 16 Jan 2013 20:16:34 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <7va9sa6f0h.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213808>

Junio C Hamano wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> That configurability is a slipperly slope to drag us into giving users
> more complexity that does not help them very much, I suspect.
> 
> Earlier somebody mentioned "size and mtime is often enough", so I
> think a single option core.looseStatInfo (substitute "loose" with
> short, minimum or whatever adjective that is more appropriate---I am
> not good at picking phrases, it sounds to me a way to more loosely
> define stat info cleanliness than we usually do) that makes us
> ignore all fields (regardless of their zero-ness) other than those
> two fields might not be a bad way to go.

At one point, I used to build (and test) the MSVC version of git on
cygwin, which leads to exactly the same problem. So, this is not just
an EGit/JGit vs c-git issue, although there can't be many people that
will have this problem. (Mixing the MinGW and cygwin versions on the
same repo will also have this problem).

I had a patch which, essentially, did what you suggest above; ie ignore
everything other than size and mtime, *including* ignoring the zero-ness
in the index. (I just don't understand why you would think of doing
otherwise!! ;-) ). As part of that patch, I also suppressed the "empty diff"
output that used to be shown for stat-dirty files (that's been fixed now
right?), otherwise using gitk was a pain.

[BTW, given the "schizophrenic stat" functions on cygwin, you can have
this problem with the cygwin version of git - all on it's lonesome!]

I can't help with naming, BTW, since I called the config variable
"core.ramsay-stat". :-P

> 
> I do not offhand know if such a loose mode is too simple and make it
> excessively risky, though.

I suspect it would be fine ... *however*, I never sent my patch because
I didn't think there would be many idiots^H^H^H^H^H^H pioneers like me! :-D

ATB,
Ramsay Jones
