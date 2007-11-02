From: Miles Bader <miles.bader@necel.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 02 Nov 2007 15:06:54 +0900
Message-ID: <buofxzp18qp.fsf@dhapc248.dev.necel.com>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 07:08:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InphF-0002Vj-4J
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 07:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbXKBGHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 02:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbXKBGHk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 02:07:40 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:63621 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbXKBGHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 02:07:39 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lA266tHm001765;
	Fri, 2 Nov 2007 15:06:55 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay21.aps.necel.com with ESMTP; Fri, 2 Nov 2007 15:06:55 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Fri, 2 Nov 2007 15:06:54 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id A3C61437; Fri,  2 Nov 2007 15:06:54 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> (Linus Torvalds's message of "Thu\, 1 Nov 2007 11\:33\:13 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63065>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> So while you can combine flags for *most* programs, you still won't 
> be able to say things like
>
> 	git clean -qdx
>
> just because that's still a shellscript, and doing any fancy argument 
> parsing in shell is just painful.

Indeed... but for my personal shell scripts I like to use a construct
like the following for parsing args:

   while :; do
     case "$1" in
        ... lots of cases to handle normal args ...

       -[!-]?*)
         # split concatenated single-letter options apart
         FIRST="$1"; shift
         set -- `echo $FIRST | $SED 's/-\(.\)\(.*\)/-\1 -\2/'` "$@"
         ;;

       -*)
         # unrecognized option
         unrec_opt "$1"; exit 1;;
       *)
         # non-option
         break;
     esac
   done

I'm sure there are problems with it, but it generally seems to work
pretty reasonably for short options.

-Miles
-- 
97% of everything is grunge
