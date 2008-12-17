From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/5] combine-diff.c: use strbuf_readlink()
Date: Wed, 17 Dec 2008 13:34:34 -0800
Message-ID: <7vmyeujxjp.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171044110.14014@localhost.localdomain>
 <7v63lileqh.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0812171300070.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 22:36:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD43l-0007XN-EJ
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbYLQVem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYLQVem
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:34:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbYLQVel (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 16:34:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D54FE1A80A;
	Wed, 17 Dec 2008 16:34:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8D23B1A809; Wed,
 17 Dec 2008 16:34:36 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812171300070.14014@localhost.localdomain>
 (Linus Torvalds's message of "Wed, 17 Dec 2008 13:02:42 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8285D67A-CC82-11DD-8378-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103395>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 17 Dec 2008, Junio C Hamano wrote:
>> -			result[len] = 0;
>> +			result_size = buf.len;
>> +			result = strbuf_detach(&buf, NULL);
>
> If result_size was made size_t, this would be
>
> 	result = strbuf_detach(&buf, &result_size);
>
> But whether it makes any difference, I dunno.

Yeah, use of "unsigned long" where "size_t" could be more appropriate
stems from the very initial commit e83c516 (Initial revision of "git", the
information manager from hell, 2005-04-07) and it is everywhere, and
updating them one by one like you suggest would take forever ;-)

Perhaps libgit2 would settle with a better typing system.  The original
draft by Shawn looked a bit too overengineered in its use of typedefs, but
if I recall correctly later revisions were made saner.  I haven't checked
its current status.
