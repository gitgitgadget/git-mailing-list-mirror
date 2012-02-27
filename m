From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] CodingGuidelines: Add a note about spaces after
 redirection
Date: Mon, 27 Feb 2012 10:55:28 -0800
Message-ID: <7vy5ro85sv.fsf@alter.siamese.dyndns.org>
References: <1330117921-8257-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:55:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S25jV-00087y-KU
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab2B0Szc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:55:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699Ab2B0Szb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:55:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 969CC652E;
	Mon, 27 Feb 2012 13:55:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4PJyDBiEjiYLtxIRq4ACh7U555A=; b=csF7Ed
	4rDRcxGe69KAJF1vlQ06fCBxOVNAeHqw4iu4OLnRc8u8sXBbwygyYz8abqoPSXyl
	T7PSpmGd4IlaDf8EYi/TZc9JyPdZoZWljXia6UhX6IcHQ9OLXJNPwwu5FXpLzG07
	pl+w6ToVqpwdgAgEjo3ABcbvccwQ2/42UVubg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkWb+OsXXtp6v/sh9Mt9ZbdT2yTrjgiI
	APiHEAYSApMofowi4Ph6oOPpz/FKfGTDvkLDI95dotdbXeZapr8Pa1UrDPzWjmUk
	fLPxJRWt5Poi0bCZXUQaXmCy3HsmdN+qs3IiS51YOYWpBVF40s9cSgLaVdTWEjJf
	NvqTZZ7JAR8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C107652D;
	Mon, 27 Feb 2012 13:55:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21FA2652B; Mon, 27 Feb 2012
 13:55:30 -0500 (EST)
In-Reply-To: <1330117921-8257-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 24 Feb 2012 16:12:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E85E556-6174-11E1-9EA5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191650>

Tim Henigan <tim.henigan@gmail.com> writes:

> + - Redirection operators should be written with space before, but
> +   no space after them.  For example:
> +      'echo test >$file'  is preferred over
> +      'echo test > $file'
> +

If you are using a $file placeholder, then we would need to show readers
that they need to be enclosed in dq to prevent some versions of bash from
giving us a false warning, and explicitly say why.

  $ bash
  bash$ file='/var/tmp/f i l e'
  bash$ >$file
  bash: $file: ambiguous redirect
  bash$ >"$file"
  bash$ ls -1 "$file"
  /var/tmp/f i l e

Adding something like this after your two line examples, after updating
them to use "$file" instead, should be sufficient:

	Note that even though it is not required by POSIX to double quote
	the redirection target in a variable like the above example, our
	code does so because some versions of bash issue an warning unless
	we do.
