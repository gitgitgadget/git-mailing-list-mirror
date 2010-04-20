From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/2] git-svn: Allow certain refs to be ignored
Date: Tue, 20 Apr 2010 16:58:35 -0700
Message-ID: <7vbpddekwk.fsf@alter.siamese.dyndns.org>
References: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 01:58:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4NLG-0007Uj-3n
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 01:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab0DTX6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 19:58:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab0DTX6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 19:58:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1880AC08D;
	Tue, 20 Apr 2010 19:58:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oDn6zEjQTMXlmV1edoPDwaSEiGU=; b=RNsyg4
	BCLO4E96CywdO0YUf5bKz7cxmLw5tZKIT6AVD62Zz9PoMz/KuK+vCtxVcVozK6L5
	StKHBRuPjHemaGY1vgPwH/NmsDLIRPA8G2gq8e2CHi2JYxm6Y33CfGJvky2/bYUN
	/rDSnqYmrsKjEM2Q4GSoZJYe6Fxjpfz3SSh5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s23q7Z0rVsVHKyYaxCujWjm7A2c/G5aq
	/1whzheO6y+NWcovRLwVye6NUULoMJ14UBaDyYQuYZsT6Cq/mK+rijeCLF8rljR2
	l7qzQWcRLk11QuK+6McoaYMJIbxj1GKcGpWaMCkfXwrZBEdmVP+i0MyQewR6V5Qz
	vPKz59Zmm5c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 813BBAC08C;
	Tue, 20 Apr 2010 19:58:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A112DAC088; Tue, 20 Apr
 2010 19:58:36 -0400 (EDT)
In-Reply-To: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com>
 (Michael Olson's message of "Tue\, 20 Apr 2010 14\:30\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5EFB7AC-4CD8-11DF-9AC1-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145402>

Michael Olson <mwolson@gnu.org> writes:

> [svn-remote "svn"]
>        url = https://svn.my.org/svn/root
> ...
>        ignore-refs = ^refs/remotes/(tags/)?old/myorg

Traditionally configuration variable names are spelled camelCase without
dashes.  You probably would want to be consistent.

Also "refs" and any pathname-like things are traditionally matched using
globs and not regexes.  It is Ok to deviate if you have a strong reason to
(and I suspect it would make it easier to write "exclude" patterns like
the above example to allow a regex here), but that needs to be prominently
documented (e.g. "Unlike any other ref-matching configuration variable,
this alone uses regex, not glob") to avoid end user confusion.
