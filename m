X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 6/6] remove .keep pack lock files when done with refs update
Date: Thu, 02 Nov 2006 12:25:56 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611021218510.11384@xanadu.home>
References: <11624187853116-git-send-email-nico@cam.org>
 <11624187853865-git-send-email-nico@cam.org>
 <1162418786895-git-send-email-nico@cam.org>
 <1162418786390-git-send-email-nico@cam.org>
 <11624187871572-git-send-email-nico@cam.org>
 <11624187883225-git-send-email-nico@cam.org>
 <7vzmbav2n9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611020959410.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 2 Nov 2006 17:26:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.64.0611020959410.11384@xanadu.home>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30761>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfgKH-0002ET-GC for gcvg-git@gmane.org; Thu, 02 Nov
 2006 18:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750838AbWKBRZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWKBRZ5
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 12:25:57 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27727 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1750838AbWKBRZ5
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 12:25:57 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8400BCX5R8NIJ0@VL-MO-MR003.ip.videotron.ca> for git@vger.kernel.org; Thu,
 02 Nov 2006 12:25:56 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, 2 Nov 2006, Nicolas Pitre wrote:

> Another area of that patch I'm not really sure of is this:
> 
> @@ -408,6 +415,7 @@ fetch_main () {
>           append_fetch_head "$sha1" "$remote" \
>                   "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
>        done
> +      if [ "$pack_lockfile" ]; then rm -f "$pack_lockfile"; fi
>      ) || exit ;;
>    esac
> 
> How can I make sure to not clobber a non-zero return code with the rm 
> that would prevent the exit while still performing the rm in all cases?

OK looking at it again I think the || exit is only meant to match the 
exit 1 before that point. Since this is a subshell then the exit 1 
wouldn't exit it all on its own.  Otherwise there is no errors expected 
to trickle out of the while loop and I _think_ the above is correct.

Do you still want a new patch for the micronit quoting issue?


