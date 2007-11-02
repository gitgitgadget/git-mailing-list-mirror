From: Miles Bader <miles@gnu.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 03 Nov 2007 00:13:36 +0900
Message-ID: <87d4usaden.fsf@catnip.gol.com>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
	<buofxzp18qp.fsf@dhapc248.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 16:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InyDj-0005iJ-6m
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbXKBPNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753964AbXKBPNt
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:13:49 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:51721 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbXKBPNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:13:48 -0400
Received: from 203-216-97-240.dsl.gol.ne.jp ([203.216.97.240] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1InyDL-0002zy-3D; Sat, 03 Nov 2007 00:13:39 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 369822F4C; Sat,  3 Nov 2007 00:13:36 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <buofxzp18qp.fsf@dhapc248.dev.necel.com> (Miles Bader's message of "Fri\, 02 Nov 2007 15\:06\:54 +0900")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63128>

I previously wrote:
> Indeed... but for my personal shell scripts I like to use a construct
> like the following for parsing args:

In a little more detail, the arg-splitting case:

>        -[!-]?*)
>          # split concatenated single-letter options apart
>          FIRST="$1"; shift
>          set -- `echo $FIRST | $SED 's/-\(.\)\(.*\)/-\1 -\2/'` "$@"
>          ;;

Just strips off the first short option and stuffs it back into the list
of args to parse, so "-xyz" becomes "-x -yz".  That way short args get
split by default, but short-args with an appended value still work
correctly.

So, for instance, if in the above example, "-y" takes an argument, then
there'd be a switch case case for "-y*") which would consume the "-yz"
before it reached the arg-splitting case; if "-y" _doesn't_ take an
argument, then "-yz" would get split in turn, becoming "-y -z".

-Miles

-- 
/\ /\
(^.^)
(")")
*This is the cute kitty virus, please copy this into your sig so it can spread.
