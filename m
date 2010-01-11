From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Use $(git rev-parse --show-toplevel) in
 cd_to_toplevel()
Date: Mon, 11 Jan 2010 01:58:13 -0800
Message-ID: <7vhbqtt13e.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1001102016380.2560@vqena.qenxr.bet.am>
 <alpine.LNX.2.00.1001112022190.8842@vqena.qenxr.bet.am>
 <7viqb9w0c8.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1001112114140.9352@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Mon Jan 11 10:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUH2X-0000BY-18
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 10:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab0AKJ6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051Ab0AKJ6V
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 04:58:21 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0AKJ6U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 04:58:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53E0A90591;
	Mon, 11 Jan 2010 04:58:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=GKhl3CQWp35udt/sGVWteKN1V2A=; b=GpsPVIagu7dDQyYYNxikwGC
	giEI+Urw43HE2/T29CMhaAm6RpybrXbzJWKk/ouAx5X0uEkaVGZbkaW+PsHCvhjU
	Mp9uCsZPpVD2i9rjvr/9TL63hEYe/gurpdTRu6oEFsEZhN1FRlDAvlO6IPnG4Y8l
	WAl+3JoNAkXCncmqvJnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=G4rLKPSVd0t5vwzfg/YUNH6lpYmDK4aJacFZqVfngAvuP8DSL
	B3qaxfHpDkmyx8/7YUQXwxwIw9rPaOvRh2GqtvIP0bB1PV46GUUthxN6WOxq1jbh
	rMhvDDJdOvLWr00gS37gVDDHZdkAMdBwLuvgCST0U7wuLmzgaGwoLAb9SE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31DB690590;
	Mon, 11 Jan 2010 04:58:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64C619058F; Mon, 11 Jan
 2010 04:58:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7CD0CB4-FE97-11DE-BEA0-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136628>

Steven Drake <sdrake@xnet.co.nz> writes:

>>  (4) Sign your patch, before the three-dash line.
>
> Opps forgot '--signoff', I've put format.signoff=ture in .gitconfig to solve
> that problem. 
>
> Perhaps a warning message from format-patch of the form:
> WARNING: You have not added a "Signed-off-by:" line did you mean to!

1. It is usually a good idea to make it a habit of running "commit -s",
   iow, record your sign-off at _commit time_, when working on a project
   that uses the convention.  You may start contributing by sending a
   pull-request instead of patches later.

2. scripts/checkpatch.pl script in the Linux kernel project is a good tool
   to check your patch before submission; you run it as:

   $ perl checkpatch.pl --no-tree 0001-my-changes.patch
   
>> Please line-break immediately after &&; it makes it easier to read in
>> general, and it would make "cd" stand out in this particular case, as it
>> is the most important part of this particular function.
>
> Good point, althought did you mean as a general shell script coding rule or
> just in this particular case.

"In general" as a general style suggestion, and "show 'cd' at the
beginning on its own line" as a more reason to do so for this specific
case.

> Thanks for the feedback.  Did you want me to resend the signed and cleaned up
> patches direct to you?  

Or to the list.

I could actually have fixed them up and commit myself, instead of
responding with comments that can be seen as if I were nitpicking.

The reason why I chose not to was because I hoped you would keep
contributing to this project more in the future (I see you have already
another commit in our history, and you seem to be reasonably competent,
judging from the patch description and the way you communicate in the
discussion).  And I wanted to make sure your future patches are easier to
handle for me ;-).

Thanks.
