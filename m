From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Repository corruption
Date: Sun, 16 Mar 2008 16:14:10 -0700
Message-ID: <7v7ig2feil.fsf@gitster.siamese.dyndns.org>
References: <20070903165255.6CEC78B8B2@rover.dkm.cz>
 <20070903174142.GK10749@pasky.or.cz>
 <20070910212550.GN1935@nan92-1-81-57-214-146.fbx.proxad.net>
 <20080315121903.GY10335@machine.or.cz>
 <20080315130441.GF4079@nan92-1-81-57-214-146.fbx.proxad.net>
 <20080316230151.GB6803@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, GIT list <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 17 00:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb24K-0007xQ-An
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 00:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbYCPXO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 19:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYCPXO3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 19:14:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbYCPXO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 19:14:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E9E42E6D;
	Sun, 16 Mar 2008 19:14:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 063922E6C; Sun, 16 Mar 2008 19:14:20 -0400 (EDT)
In-Reply-To: <20080316230151.GB6803@machine.or.cz> (Petr Baudis's message of
 "Mon, 17 Mar 2008 00:01:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77402>

Petr Baudis <pasky@suse.cz> writes:

> My idea I got few days ago when looking at the borken repositories is
> that it was caused by interrupted git-repack, since there were stale
> tmp_pack* files left in the repository - it seems like it removed old
> "redundant" packs even though the new one weren't properly completed.
> But that is just a speculation, and I did not get around to look at the
> script yet whether this could really happen, or if something like this
> got fixed recently.

Hmm, unless you are talking about ef07618 (git-repack: Properly abort in
corrupt repository, 2005-11-21) as "recent", I do not see anything
suspicious.

We may want to refine the first comment in the remove-redundant loop to
clarify, though.  We do check if elements of $existing are actually
redundant or not in the loop against $fullbases these days, since ce85907
(Only repack active packs by skipping over kept packs., 2006-10-29).
