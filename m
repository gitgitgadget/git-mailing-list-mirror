X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/6] remove .keep pack lock files when done with refs update
Date: Fri, 03 Nov 2006 01:35:23 -0800
Message-ID: <7vslh0euuc.fsf@assigned-by-dhcp.cox.net>
References: <11624187853116-git-send-email-nico@cam.org>
	<11624187853865-git-send-email-nico@cam.org>
	<1162418786895-git-send-email-nico@cam.org>
	<1162418786390-git-send-email-nico@cam.org>
	<11624187871572-git-send-email-nico@cam.org>
	<11624187883225-git-send-email-nico@cam.org>
	<7vzmbav2n9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611020959410.11384@xanadu.home>
	<Pine.LNX.4.64.0611021218510.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 09:36:00 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30805>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfvST-0006Dn-RU for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752701AbWKCJfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 04:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbWKCJfZ
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:35:25 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55531 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1752701AbWKCJfY
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:35:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103093523.GAQR6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 04:35:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id i9bU1V00E1kojtg0000000 Fri, 03 Nov 2006
 04:35:28 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 2 Nov 2006, Nicolas Pitre wrote:
>
>> Another area of that patch I'm not really sure of is this:
>> 
>> @@ -408,6 +415,7 @@ fetch_main () {
>>           append_fetch_head "$sha1" "$remote" \
>>                   "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
>>        done
>> +      if [ "$pack_lockfile" ]; then rm -f "$pack_lockfile"; fi
>>      ) || exit ;;
>>    esac
>> 
>> How can I make sure to not clobber a non-zero return code with the rm 
>> that would prevent the exit while still performing the rm in all cases?
>
> OK looking at it again I think the || exit is only meant to match the 
> exit 1 before that point. Since this is a subshell then the exit 1 
> wouldn't exit it all on its own.  Otherwise there is no errors expected 
> to trickle out of the while loop and I _think_ the above is correct.

I think so too.

> Do you still want a new patch for the micronit quoting issue?

Not needed, will park them in "pu" and play with them --
hopefully in "next" by the end of the week.

Thanks.
