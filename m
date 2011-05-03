From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] specifying ranges: we did not mean to make ".." an
 empty set
Date: Tue, 03 May 2011 10:38:48 -0700
Message-ID: <7vvcxrit07.fsf@alter.siamese.dyndns.org>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
 <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
 <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org>
 <20110502210141.GA15753@sigill.intra.peff.net>
 <4DBFA31E.40207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 03 19:39:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHJYy-0004hM-91
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 19:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab1ECRjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 13:39:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab1ECRjB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 13:39:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72A60330F;
	Tue,  3 May 2011 13:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AMZplhqz8b5DD/Eh8jGJLrwieyc=; b=sdB2fd
	WlyPMG3LIGq47FnopiblUG2qHGnedyTRVVeelYauf7exhkyo+YqTqhZrBnnsASy7
	E/V7zIS5OxCdHuAdjv/kEeXEwjcw8PiYxAEhHwFQAH3vAkz/uqZPblkcQUZNjciz
	jDu77C55Ez5haX3/pNIK/EwCyLQtAEbe2czLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CoBXNz3y3pl+caV51wE2097w2ELEH2XV
	BJl0yaeNcPGxKn9pULzEQTMXpwVThb5EBeWo2oD7FKJj9jy+IXPU2x31xXjQeW4X
	SQ59wuqA8NMQzkGzXLkNfW/iIcSfA8xUKgjneHneFLJx/NwCDE5BQHuAyXJ30xnq
	BJ9a9ac4ecc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35D84330E;
	Tue,  3 May 2011 13:40:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B6BC3330D; Tue,  3 May 2011
 13:40:53 -0400 (EDT)
In-Reply-To: <4DBFA31E.40207@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 03 May 2011 08:39:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8110D134-75AC-11E0-9DD7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172675>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>>> Helped-by: Jeff King <peff@peff.net>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> 
>> Looks good to me.
>
> I'm sorry but I don't like this at all, because:
>
>> Doing "..." is still allowed, but will never produce any useful results.
>> I don't know if it is worth disallowing it to catch errors. I am tempted
>> to say it should be magic for "@{u}...HEAD", but I think just "..." is
>> getting unreadably magical. "@{u}...HEAD" is already pretty concise and
>> is much more readable.
>
> We need to disambiguate any pathspec with "--" which could be a revision
> parameter. Therefore I find it very unnatural to disambiguate ".." to a
> pathspec automatically (and have "..." error out). "../" is really
> simple enough to type.

If you are comfortable typing "../", why do you even care?  It would be a
different story if the patch made ".." error out and forbade to be used as
an empty range even when you disambiguated, i.e. "git log .. --", but that
is not what we are doing.

And we do not even special case "...".  Between the two potential requests
of asking for an empty revision range and asking for a pathspec "...", both
are just as unlikely.

Contrast that with ".." and realize that is very different.  It is
infinitely more likely that the user meant the immediate parent directory
than an empty revision range.
