From: David Kastrup <dak@gnu.org>
Subject: Re: Corner case bug caused by shell dependent behavior
Date: Fri, 14 Mar 2014 07:08:36 +0100
Message-ID: <87d2hpgvmj.fsf@fencepost.gnu.org>
References: <20140314000213.GA3739@ibr.ch>
	<20140314022845.GA19757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Uwe Storbeck <uwe@ibr.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 07:09:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOLIs-0003D2-Ri
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 07:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbaCNGIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 02:08:39 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:47836 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbaCNGIi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 02:08:38 -0400
Received: from localhost ([127.0.0.1]:46877 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WOLIK-0002d6-Kr; Fri, 14 Mar 2014 02:08:36 -0400
Received: by lola (Postfix, from userid 1000)
	id 4CC9AE9463; Fri, 14 Mar 2014 07:08:36 +0100 (CET)
In-Reply-To: <20140314022845.GA19757@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2014 22:28:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244082>

Jeff King <peff@peff.net> writes:

> Hmph. We ran into this before and fixed all of the sites (e.g., d1c3b10
> and 938791c). This one appears to have been added a few months later
> (by 68d5d03).
>
>> Maybe there are more places where it would be more robust to use
>> printf instead of echo.
>
> FWIW, I just looked through the other uses of "echo" in git-rebase*.sh,
> and I think this is the only problematic case.
>
>> -			echo "$sha1 $action $prefix $rest"
>> +			printf "%s %s %s %s\n" "$sha1" "$action" "$prefix" "$rest"
>
> Looks obviously correct. The echo just below here does not need the same
> treatment, as "$rest" is the problematic bit ("$prefix" is always
> "fixup" or "squash").

I'd not rationalize this away by deep analysis.  Copy&paste is a thing,
so to just use printf whenever _any_ seriously variable strings (source
not immediately the shell script itself, perhaps even _any_ nonconstant
strings) are involved keeps people from introducing bugs by following
apparent practice.

-- 
David Kastrup
