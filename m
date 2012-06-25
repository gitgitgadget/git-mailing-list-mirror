From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Mon, 25 Jun 2012 10:01:06 -0700
Message-ID: <7vehp3gwbx.fsf@alter.siamese.dyndns.org>
References: <20120624220835.GA4762@beczulka>
 <7v4nq0hrjb.fsf@alter.siamese.dyndns.org> <20120625075726.GO3125@beczulka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Marcin Owsiany <marcin@owsiany.pl>
X-From: git-owner@vger.kernel.org Mon Jun 25 19:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjCf5-0005kl-RX
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 19:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab2FYRBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 13:01:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001Ab2FYRBL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 13:01:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A1187EBB;
	Mon, 25 Jun 2012 13:01:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8gaEtOUegQhPG+9nBBzKZOyA1g=; b=h+Wk3W
	0CJzb+pCWnhA7odHRryt4rdnHEzxhcH0fA7IqEC4HugagiUrbHw1JjJaQFGaJDlk
	gSHhxx/zu1xN3xFnjLldVWdQ/+lu12NVB9TcQuI6mFp1y3GUvFP7+iRSHQrG9Oi7
	/N2rYdQ55lMk9Q6X7JZGCqSvLmVvIFEbwidO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LnLEVs9aMvjF94LNh/ypLeQqNMzAFwGS
	dQCgRtcnpbLAexH855Oqgwrn0/KlAd8egGVihvVmbnAW8rWb/S28khjhqKBUvSXt
	Dw6Fp+mhj6xRRBRjZV0HxBvW6W5pJU8fHkVOPBF33bgTZ2KqNWw+mz1j1mLmgyZP
	VsTNYu5TO4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A6A7EBA;
	Mon, 25 Jun 2012 13:01:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B53927EB6; Mon, 25 Jun 2012
 13:01:07 -0400 (EDT)
In-Reply-To: <20120625075726.GO3125@beczulka> (Marcin Owsiany's message of
 "Mon, 25 Jun 2012 08:57:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B5F6E98-BEE7-11E1-A329-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200586>

Marcin Owsiany <marcin@owsiany.pl> writes:

>>  What are you really trying
>> to validate?  "HEAD" points at an existing branch and you do not
>> care what branch it is?
>
> Yes. I think.

Why do you even care about the value of HEAD, i.e. the output from
"rev-parse HEAD", if that is the case?  Wouldn't you rather be
reading from the output "symbolic-ref HEAD" to see if it points at
any branch?

>>  HEAD may not even point at a valid branch
>> but can be detached as long as it happens to point at a commit that
>> is at the tip of some branch (hence building further commit on HEAD
>> will break the condition you are checking in the above code)?
>
> The more questions you ask, the less I feel I know about how git works
> :-)
