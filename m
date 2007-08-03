From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 08:13:13 +0200
Message-ID: <85d4y5w3gm.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
	<85vebxy47e.fsf@lola.goethe.zz>
	<7vwswdsfjp.fsf@assigned-by-dhcp.cox.net>
	<85ps25y1ac.fsf@lola.goethe.zz>
	<7vk5sdscfr.fsf@assigned-by-dhcp.cox.net>
	<85wswdwjll.fsf@lola.goethe.zz>
	<7vabt9sasl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGqPd-0003wL-0n
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbXHCGNW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbXHCGNW
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:13:22 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:39745 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755160AbXHCGNV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 02:13:21 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 5CA0927AC76;
	Fri,  3 Aug 2007 08:13:20 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 4B6AC100C2;
	Fri,  3 Aug 2007 08:13:20 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-000-210.pools.arcor-ip.net [84.61.0.210])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 2184E35E5AB;
	Fri,  3 Aug 2007 08:13:20 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 635761C4F931; Fri,  3 Aug 2007 08:13:13 +0200 (CEST)
In-Reply-To: <7vabt9sasl.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu\, 02 Aug 2007 17\:48\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54673>

Junio C Hamano <gitster@pobox.com> writes:

>  (1) that shell does not even grok $(cmd) substitution.
>
>      I won't accept a half-baked patch that replaces "$(" with a
>      backtick and matching ")" with another backtick.  You need
>      to at least make sure your interpolated variables within
>      the backtick pair work sensibly, and you haven't broken
>      existing nesting of command interpolations, if any.  I do
>      not even want to inspect, comment on and reject that kind
>      of changes.  Quite frankly, it's not worth my time.

And that's actually not even _half_ of the deal: we are talking about
pandering to legacy shells here, and the amount of variance of just
what level of quoting/backslashing is needed on the inside of `...` in
order to get stuff through with just the right level of quoting is
actually stunning.

I've had my fair share of bad surprises with portable scripts.
Getting a backquote mechanism running on one shell does not mean it
will work on another.  Basically, you have to forego nesting stuff and
split it out into small units in separate commands.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
