From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] am: handle stray $dotest directory
Date: Sun, 16 Jun 2013 19:45:18 -0700
Message-ID: <7v38shjw01.fsf@alter.siamese.dyndns.org>
References: <1371300192-6222-1-git-send-email-artagnon@gmail.com>
	<1371300192-6222-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 04:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoPRf-0008TA-2O
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 04:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755402Ab3FQCpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 22:45:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755007Ab3FQCpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 22:45:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 982581DAB9;
	Mon, 17 Jun 2013 02:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xzbRlYbWcEURVuyK5ujwRJSzuco=; b=AyWc4s
	wt3k/yMqdrXvVML1uglGKyF9Izu8CEsLtVv9Wke0nGblGjaYyKw224ZVmYFXnRKY
	nLUnYBj1jDssN5T1fq+VteKhlLJGVt5xfXsJtDgewIeFvIYXbZzuAaFjddWfxy3a
	PbpNIiq31lH1otfsJ82kFY3tLZyi1ROridMQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FkqI8B+zMWdvNT/Ep7T4WBGWT/4q2sqy
	G0mwrBSyQaIF0NevR1fFfYsXjbGvDczKaHv+Jr1+l8/EkzKChm/E+8kAr/etcbX/
	t8/Sy1W3ESymXhRIVO0ptfv9dMY4gOk8F87Kf4D5L4ZT+EiJKinTGT5h+KlAL5wn
	goIeTbGXdnM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DA9A1DAB8;
	Mon, 17 Jun 2013 02:45:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDE071DAB1;
	Mon, 17 Jun 2013 02:45:19 +0000 (UTC)
In-Reply-To: <1371300192-6222-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sat, 15 Jun 2013 18:13:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3305416-D6F7-11E2-B761-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228033>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>  else
> +	# Possible stray $dotest directory in the independent-run
> +	# case; in the --rebasing case, it is upto the caller
> +	# (git-rebase--am) to take care of stray directories.
> +	if test -d "$dotest" && test -z "$rebasing"

The $rebasing variable is set only when the command line of "git am"
has --rebasing, i.e. only when it is driven by "git rebase".  So
this will not affect what happens to "git am --abort" that is run by
the end user.  That sounds like a safe thing to do as far as "am" is
concerned.

Will replace what has been queued on 'pu'.  Thanks.
