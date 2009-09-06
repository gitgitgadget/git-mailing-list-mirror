From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] grep: accept relative paths outside current working
 directory
Date: Sun, 06 Sep 2009 15:58:15 -0700
Message-ID: <7v3a6zu1dk.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905072017.GA5152@coredump.intra.peff.net>
 <7v3a717rgl.fsf@alter.siamese.dyndns.org>
 <20090905123117.GA3099@darc.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 07 00:58:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkQgt-0005ts-LB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 00:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758176AbZIFW6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 18:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758125AbZIFW6Y
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 18:58:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZIFW6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 18:58:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8124D28A94;
	Sun,  6 Sep 2009 18:58:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xPNm/upStBWaQu6qk6zuZdkOEFU=; b=WYcNVL
	ulwsm1h72ITQu3cp8JBDrJBGKBFKohEYDjf6iUM4zPdKh9wSRH6uGZP+RnEAlUK5
	RpqaMnkTe+zFdQB7mnVN0cruQkpITYGWYi/dztr1o72XV5IcOv9pPxAHp6c/ad4h
	71OC3VXmdh5b1kI8/g1ZJykdy3QP8/WgUJo+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WvBNpQFWarqyRoY8olQK0Pc5U7n6LPdr
	1OA2ZAMg5B1TSNDtj+BVyijKvxQhNFsY7TDw/NPUwNDeiqxEh4fGK2K9u2aMEo4X
	jc2N8wc8X5yEZ8Q7XdgTk+7erbPgId/dvZgHiwvZcZG57CTH+WO1vPzJnWYramUI
	7B84BP2oU/k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CCCA28A93;
	Sun,  6 Sep 2009 18:58:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 649B728A92; Sun,  6 Sep
 2009 18:58:17 -0400 (EDT)
In-Reply-To: <20090905123117.GA3099@darc.dnsalias.org> (Clemens Buchacher's
 message of "Sat\, 5 Sep 2009 14\:31\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6BF5B24-9B38-11DE-91CB-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127875>

Clemens Buchacher <drizzd@aon.at> writes:

> On Sat, Sep 05, 2009 at 12:58:50AM -0700, Junio C Hamano wrote:
>> >> If "git add -u ../.." (I mean "the grand parent directory", not "an
>> >> unnamed subdirectory") did not work 
>
> In git.git:
>
> $ cd t
> $ git grep addremove -- ../
> fatal: git grep: cannot generate relative filenames containing '..'
>
> So here's a fix for that. And a configurable solution for add and grep's
> scope as a follow-up. I did not look at any other commands yet.

Thanks.  This was oa breakage I pointed out in an earlier message in this
discussion, and it is worth fixing.

Your patch is queued in 'pu', but it seems to break the exit status in a
strange way with my limited test.

Here is a non-broken behaviour without the "look in uplevel":

: git.git/cb/maint-1.6.3-grep-relative-up; ./git grep adddelete .
: git.git/cb/maint-1.6.3-grep-relative-up; ./git grep adddelete .; echo $?
1
: git.git/cb/maint-1.6.3-grep-relative-up; ./git grep adddelete . >/dev/null; echo $?
1

Now we go down, and grep from an uplevel:

: git.git/cb/maint-1.6.3-grep-relative-up; cd t
: t/cb/maint-1.6.3-grep-relative-up; ../git grep adddelete ..
: t/cb/maint-1.6.3-grep-relative-up; ../git grep adddelete .. ; echo $?
1
: t/cb/maint-1.6.3-grep-relative-up; ../git grep adddelete .. >/dev/null; echo $?
0

The command should not give different exit status depending on the
destination of standard output stream.
