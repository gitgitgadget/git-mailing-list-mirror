From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Sat, 09 Feb 2013 15:23:47 -0800
Message-ID: <7v38x5ul4s.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <7v8v72u0vw.fsf@alter.siamese.dyndns.org>
 <51122D9D.9040100@alum.mit.edu> <87pq0c15h3.fsf@59A2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:25:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4JnW-0007AU-7n
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 00:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760863Ab3BIXXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 18:23:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832Ab3BIXXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 18:23:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D330B205;
	Sat,  9 Feb 2013 18:23:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c6jc28KbqXldtyAY9mYlqU0CGd8=; b=aEqhxn
	zfGBDJCphMWvP1FnNXsWQlATWaGQVbXogMPXSe5p6ZcfzAdJNqlPoG5UGw/81qfU
	/W1pJaExy+nFH3lXj+YEsVTmpg4WsdGOgWi5u3kFd1X5WiMYODhIV6dm07341cKH
	Tzl+wa4uOMkP2W6jf/fujDPkK8ipsfC4WPLqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mpqj7huBlB28emLlOydIfbHbhXVXxRLJ
	9mBk7y8G/tLw6Q05YVXAR1HGy8NQ/4HJWYS/QmLOz539G47GOEaIrl+W+aTDK8RG
	cs1aGmzDSKE+VDM5KL/s08CgUhcqb0btrZ8dzTg/hhRc1WkBcH2Trdr2BBYzDwyH
	ErYUITmOcYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD8DB203;
	Sat,  9 Feb 2013 18:23:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ACACB202; Sat,  9 Feb 2013
 18:23:49 -0500 (EST)
In-Reply-To: <87pq0c15h3.fsf@59A2.org> (Jed Brown's message of "Thu, 07 Feb
 2013 09:58:00 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C20C7C12-730F-11E2-A48F-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215883>

Jed Brown <jed@59A2.org> writes:

> I believe that my use case would be well supported if git could push and
> pull unadvertised refs, as long as basic operations were not slowed down
> by the existence of a very large number of such refs.

I am not sure about "pushing" part, but the jc/fetch-raw-sha1 topic
(split from the main jc/hidden-refs topic) should allow your script,
after the client learns the set of smudged object names, to ask for

    git fetch $there $sha1_1 $sha1_2 ...

or

    git fetch $there $sha1_1:refs/fat/$sha1_1 $sha1_2:refs/fat/$sha1_2 ...

I think.
