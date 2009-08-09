From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hash algorithm choice
Date: Sun, 09 Aug 2009 11:03:08 -0700
Message-ID: <7vljls986b.fsf@alter.siamese.dyndns.org>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com>
 <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>
 <alpine.LFD.2.01.0908091038300.3288@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jerome Baum <jerome@jeromebaum.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:03:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaCkB-0004NA-4x
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbZHISDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbZHISDR
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:03:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZHISDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 14:03:16 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7245D23EB1;
	Sun,  9 Aug 2009 14:03:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6950D23EAF; Sun,  9 Aug 2009
 14:03:11 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0908091038300.3288@localhost.localdomain>
 (Linus Torvalds's message of "Sun\, 9 Aug 2009 10\:46\:25 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA4877C8-850E-11DE-B1D3-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125357>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> If youlimit the hash size to 20 bytes, there are almost no changes 
> necessary.
>
> You'd need to hijack the 'SHA1_Init/SHA1_Update/SHA1_Final' functions, of 
> course, and you'd likely want to rename them (and eventually a lot of 
> other functions too), but that renaming is mechanical and isn't even 
> needed for proper working.
>
> Now, if you would ever want to extend the _size_ of the hash, that's a 
> much much bigger problem, but if you're ok with just changing the hash and 
> then truncating the result to 20 bytes (ie kind of like sha-512-160), or 
> you're ok with limiting yourself to 20-byte hashes like REIPMD-160, the 
> size of the changes should be minimal.

Just in case Jerome really wants to go further, "almost no changes" and
"minimal" refers to the fact that we have a few hard-coded hash values
known to the code, such as the object name for an empty blob and an empty
tree.
