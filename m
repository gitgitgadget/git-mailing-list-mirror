From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Missing trailing newline with git log --pretty=format
Date: Wed, 18 Mar 2009 15:27:39 -0700
Message-ID: <7vzlfibh5w.fsf@gitster.siamese.dyndns.org>
References: <200903182223.58800.agruen@suse.de>
 <200903182256.43817.markus.heidelberg@web.de>
 <200903182304.51387.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:29:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4GE-000243-Vt
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbZCRW1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbZCRW1t
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:27:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbZCRW1s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:27:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E4802A3117;
	Wed, 18 Mar 2009 18:27:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9B450A3116; Wed,
 18 Mar 2009 18:27:41 -0400 (EDT)
In-Reply-To: <200903182304.51387.agruen@suse.de> (Andreas Gruenbacher's
 message of "Wed, 18 Mar 2009 23:04:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0125F2C8-140C-11DE-834B-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113691>

Andreas Gruenbacher <agruen@suse.de> writes:

> On Wednesday, 18 March 2009 22:56:43 Markus Heidelberg wrote:
>> Use tformat instead of format.
>
> Hmm ... didn't know that, thanks. Now I wonder why anyone would ever want 
> format instead of tformat ;)

If your payload is multi-line, you would want to see a separating empty
line in between entries, but not after the last one:

	$ command with --format
        The first line of first entry.
        The second line of first entry.
        ...
        The last line of first entry.

        The first line of second entry.
        ...
        ...
        The last line of last entry.
        $ notice there is no extra newline after that

That is what --format does.  One-line-per-entry is a special case.  You do
not want a "separating LF in between entries", but a "terminating LF after
each entry".  T in --tformat stands for this "terminating" aspect, as
opposed to the "separator" behaviour --format gives you.
