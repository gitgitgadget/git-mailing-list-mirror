From: Sam Vilain <sam@vilain.net>
Subject: Re: [Survey] Signed push
Date: Tue, 13 Sep 2011 17:31:21 -0700
Message-ID: <4E6FF5D9.3080709@vilain.net>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 02:31:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3dO0-0007x4-Ce
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 02:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab1INAb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 20:31:27 -0400
Received: from uk.vilain.net ([92.48.122.123]:40154 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab1INAb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 20:31:26 -0400
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 78E16824C; Wed, 14 Sep 2011 01:31:25 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [192.168.112.205] (unknown [64.125.143.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uk.vilain.net (Postfix) with ESMTPSA id 2C0D3820E;
	Wed, 14 Sep 2011 01:31:23 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181331>

On 9/13/11 9:45 AM, Junio C Hamano wrote:
>   * You push out your work with "git push -s";
>
>   * "git push" prepares a "push certificate" (it is meant to certify "these
>     are the commits I place at the tips of these refs"), which is a human
>     and machine readable text file in core, that may look like this:
>
>          Push-Certificate-Version: 0
>          Pusher: Junio C Hamano<gitster@pobox.com>
>          Update: 3793ac56b4c4f9bf0bddc306a0cec21118683728 refs/heads/master
>          Update: 12850bec0c24b529c9a9df6a95ad4bdeea39373e refs/heads/next
>
>     and asks you to GPG sign it. You only unlock your GPG key and the
>     command internally runs GPG, just like "tag -s".
>
>   * When "git push" finishes, the receiving end has this record in its
>     refs/notes/signed-push notes tree, together with your previous pushes
>     (as this is not a shared repository, it will record only your pushes).
>     The notes annnotate the commits named on the "Update:" lines above.

If the push certificate also has the previous commit IDs for the changed 
refs, then you actually have an audit log.  Otherwise, it does not 
certify the commit range they pushed.

This is an important prerequisite for a fully distributed, peer to peer 
git.  For this case it would also need something to distinguish which 
repository is to be updated; such as a canonical repository URL (or list 
of URLs), or just a short project name.  A P2P protocol can then know 
projects as (KEYID, projectname).

Sam
