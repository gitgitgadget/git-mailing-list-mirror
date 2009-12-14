From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command
 given is junk
Date: Mon, 14 Dec 2009 13:47:28 -0800
Message-ID: <7vocm1grdb.fsf@alter.siamese.dyndns.org>
References: <4B263797.5070808@viscovery.net>
 <7v7hspjp3q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0912142146590.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKIlk-00080j-UA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbZLNVrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 16:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbZLNVrs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:47:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbZLNVrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:47:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E3E488156;
	Mon, 14 Dec 2009 16:47:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0shbufa+AZnHemJ+l08BV1mGfVg=; b=i4/VQf
	a+hygkVREA6QYf+q+NsAvKXbc6EKotQAjh+UzLy7nv8et4LUL1CdLDL0Mv2K+IQz
	f38XHOS14Crmry4eN2Lffo2TAQzJlRSGauC/UanjCaflU1W6iKB/Bto+A/435PPV
	fyRTla+K72Oq0copBgBjUUBxC4kMu7fkfgjqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mdIlYgYhIltmrphAXtZpNyDSyNYzlY1q
	RMJ21AUEfrWJWojV+YVwCtV2xljAHdyM49Bm9+mVzrgoIH8Kd1/ESkXWl8o7a5Cp
	JkhtA8dvKcsRkQKjGEh4buunJZrIKcFZH1+Im9mY7uEVTSnbhtFhUl6K+b6GBE4V
	WWu0rCx0KgA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C677A88153;
	Mon, 14 Dec 2009 16:47:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C74588152; Mon, 14 Dec
 2009 16:47:29 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0912142146590.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Mon\, 14 Dec 2009 22\:09\:11 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CEA86CE-E8FA-11DE-86D3-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135244>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Satisfied?

Very much.

    FWIW almost the same procedure led to the weights 0, 2, 1 and 4 that you 
    see in help.c.  The weights are basically factors with which mistakes are 
    punished: if you just confuse two adjacent letters, such as "psuh" instead 
    of "push" (which can be quite common if you use two hands, one on the left 
    side, and one on the right side of the keyboard, with an en-US layout so 
    many of us use, myself included) it costs 0.

    If you write a different character than what you intended, the cost is 2.  
    The idea behind it is that you're more likely to miss a key than to hit 
    the wrong key.  With the laptop I am typing this email on, it is 
    particularly likely that I miss a key, because there are certain 
    key combinations where only the first key triggers an input event, but the 
    second only triggers an input event when it is _released_ after the first 
    one.  So when I type "er" real fast and happen to release the "e" key 
    after the "r" key, no "r" appears on my screen.

    Okay, so the weight for adding a character must be smaller than 
    substituting a character, but why is the cost for deletion so high?  
    Well, I really rarely type unnecessary characters (except when writing to 
    the Git mailing list, arguably) so those costs must be substantially 
    higher than for typing the wrong character.

These are actually very good justifications in the sense that people who
might want to tweak the heuristics can see the reason behind the current
choice and agree or disagree with it.

I somehow suspect that a good mathematician can come up with a rationale
for 6 after the fact that sounds convincing, along the lines of "the
average length of commands being N, and levenshtein penalties being
<0,2,1,4>, you can insert X mistaken keystroke and/or omit Y mistaken
keystroke per every correct keystroke without exceeding this value 6, and
the percentage X and/or Y represents is not too low to be practical but low
enough to reject false positives".

In any case, I'll further squash in the following.  Thanks for an amusing
explanation ;-).

diff --git a/help.c b/help.c
index fbf80d9..de1e2ea 100644
--- a/help.c
+++ b/help.c
@@ -297,7 +297,7 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 	old->names = NULL;
 }
 
-/* how did we decide this is a good cutoff??? */
+/* An empirically derived magic number */
 #define SIMILAR_ENOUGH(x) ((x) < 6)
 
 const char *help_unknown_cmd(const char *cmd)
