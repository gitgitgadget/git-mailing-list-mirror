From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] reset: use "unpack_trees()" directly instead of "git
 read-tree"
Date: Thu, 10 Sep 2009 22:20:24 -0700
Message-ID: <7v1vme2h2f.fsf@alter.siamese.dyndns.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org>
 <20090910202333.3722.58409.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 07:20:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlyZ3-00066g-J1
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 07:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbZIKFUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 01:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbZIKFUn
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 01:20:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZIKFUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 01:20:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F7CA2D76E;
	Fri, 11 Sep 2009 01:20:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cuAwzkAW8c8jeM243mF8Fky0Y+g=; b=RyBdwC
	ARZPNhgnOsQVldlBK9cZlt/NxbqNtYiZPe7pTSPwo3UA9H7e6z1O81reg2ErO4dZ
	bf7pUZcuJRF5DCO+ItZNdMXS5rGK99T3gpzi1b9zcfqrhCQyuvvXd8fNhl0IxF1s
	xlAUu1yMz/cbvZDFST70ERPZrhuOFMMJQKYbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U2GFBFcbQOHpd+8rv2/mlCNIc+ORraHL
	p2SpEAVMDECwW6Pgpy83pT34MDKOCQYBQ8XQ4wnEoEUfItIjBRTxsbSv2e6ngRSc
	H0n0TtcNhxfdoghXU1x0jraML74Ltg20CuY5H8Ul+BHFp4lZpFe7ChsxEFJ9btTA
	RT9aOF72M0E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 421242D76C;
	Fri, 11 Sep 2009 01:20:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 105CA2D767; Fri, 11 Sep
 2009 01:20:25 -0400 (EDT)
In-Reply-To: <20090910202333.3722.58409.chriscool@tuxfamily.org> (Christian
 Couder's message of "Thu\, 10 Sep 2009 22\:23\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4ECE934-9E92-11DE-887A-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128171>

Christian Couder <chriscool@tuxfamily.org> writes:

> From: Stephan Beyer <s-beyer@gmx.net>
>
> This patch makes "reset_index_file()" call "unpack_trees()" directly
> instead of forking and execing "git read-tree".

And the reason why it is a good idea is...?
