From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not going beyond symbolic links
Date: Mon, 04 Aug 2008 17:54:14 -0700
Message-ID: <7v8wvc2seh.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
 <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 02:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQAq4-00082Z-Lw
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 02:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763619AbYHEAy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763611AbYHEAy2
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 20:54:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763601AbYHEAy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 20:54:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 716644BEFF;
	Mon,  4 Aug 2008 20:54:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A53994BEFE; Mon,  4 Aug 2008 20:54:17 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Mon, 4 Aug 2008 17:21:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0C215F1C-6289-11DD-AAEC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91395>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 4 Aug 2008, Junio C Hamano wrote:
>> 
>> I started to revisit this issue and patched "git update-index --add"
>> and "git add" so far.  Patches follow.
>
> Patches look good to me, but did you check the performance impact?
>
> The rewritten 'has_symlink_leading_path()' should do ok, but it migth 
> still be a huge performance downside to check all the paths for things 
> like "git add -u".

Not yet.

I think this is a necessary "correctness" thing to do regardless of the
performance impact, and adding the logic to stop at submodule boundary
(aka gitlinks) should come before optimization.
