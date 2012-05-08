From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Does content provenance matter?
Date: Mon, 07 May 2012 17:11:11 -0700
Message-ID: <7v62c73528.fsf@alter.siamese.dyndns.org>
References: <1336250956.54413.YahooMailClassic@web121505.mail.ne1.yahoo.com>
 <878vh4flh1.fsf@thomas.inf.ethz.ch> <7vaa1j357a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>,
	Kelly Dean <kellydeanch@yahoo.com>
X-From: git-owner@vger.kernel.org Tue May 08 02:11:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRY1O-0006bQ-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 02:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183Ab2EHALO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 20:11:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486Ab2EHALN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 20:11:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A67D6466;
	Mon,  7 May 2012 20:11:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c33ab4ernR6HnMj5ARx+Dxfb5LE=; b=rjH+Cq
	noTQKqwKw0hlqt0DJzOkiXr4EO5Fa2C3eC1XwMM5buUPnMkWd3JbmBhvPe6mtKcF
	s4GMslvLwE61dAvasfp5OYZRPcZTsWbUWExgh9e1U1Q0i0iSoMGLLuJ8F0tkNFwf
	HyfuPl5vGsXr/R9sWj2HnL4KvLkXwPSvIrZzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JItIpClEnpUN58L+aA6U5DpogQcUfFPp
	j3tbYeg0J64h6bhkhKUGuCuccGl5H6eQxxBwWE9E4FaIu8So9zgyvb4qeLtu97aT
	D/mo9MoYZVoUKQruTRINVWB9V5hOrhkrscmtRSPC2Gd/AbseDeMWmmwS37Bwf9s0
	hwB2OjW7cdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 914866465;
	Mon,  7 May 2012 20:11:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECEDA6464; Mon,  7 May 2012
 20:11:12 -0400 (EDT)
In-Reply-To: <7vaa1j357a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 May 2012 17:08:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 523EE638-98A2-11E1-806D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197331>

Junio C Hamano <gitster@pobox.com> writes:

> But a more illustrative situation to consider is this.  What if the change
> were not just "copy B/X to C/X", but was "concatenate the first half of
> B/X and the second half of C/X to create a new D/X".

A crucial question to the original poster was missing here:

    If "a system that tracks provenance better than Git" wanted to record
    something in such a situation, what does it record and how is the
    recorded information used?
    
> As it happens, because our commit records the whole tree state and its
> parent commit, the "content provenance" of what is in D/X is precisely
> tracked.  Look at the tree of the parent commit and look at the result,
> and you will notice the first half of D/X is identical to the first half
> of B/X before the commit and the second half of D/X is identical to the
> second half of C/X before the commit.
>
> In a situation where "provenance" is disputed, it does not matter if D/X
> was created by mechanically running
>
> 	head -n $n B/X >D/X
> 	tail -n $n C/X >C/X

Typo: "tail -n $n C/X >>D/x"

>         
> or if you typed the file afresh.  You could try to argue "No, your honour,
> I did not copy from these two files.  I typed it myself from scratch and
> there is no plagiarism involved.  They are all my words."  But in the end,
> by comparing the tree state before your change and after your change, it
> would be very clear to any sane person that D/X is identical to the first
> half of B/X and the second half of C/X.
>
> Also see http://article.gmane.org/gmane.comp.version-control.git/217 aka
> one of the most important messages in the history of the Git mailing list
> for inspirations.
