From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Tue, 27 Nov 2012 23:36:38 -0800
Message-ID: <7vy5hmgovt.fsf@alter.siamese.dyndns.org>
References: <20121128025734.21231.47468.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 08:37:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdcCa-0002vY-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 08:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab2K1Hgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 02:36:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40047 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab2K1Hgk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 02:36:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9878B73F0;
	Wed, 28 Nov 2012 02:36:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qkr85QYA5mZNE72hqjYgyR6yovI=; b=a66vin
	bu7xF/zYEWV9YCxruysXlaBf7WTwuhy44BgOf8Q3XVP/JhPQ7oRUIQRnec6n7nRz
	/pLifyiF3toFIw1B8maEFOqJ2UVxmR0jPQJNRyJZ1LZ4h2PhsgBDonZnXpUMYrF3
	mGTCjtrbmhHmwgXVF6vN04RpdbKw/R8TMr2ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ff+C+AmCepjgL1tH0K3x5Gi6111gtUZd
	wXpsTW0YvucfiSCw3W1ex5+fCiI4xeSh4NQwiO+EoBCBCWos9m5AYOo3fqFI7Am/
	TUVmK6KxV9sXYECXgT9RUjyy2ChHlc4O4WZMioJ5Pk6uS0icrg29xD7EqO6s9yqe
	knOT0ZsaG/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85DF573EF;
	Wed, 28 Nov 2012 02:36:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E122173EE; Wed, 28 Nov 2012
 02:36:39 -0500 (EST)
In-Reply-To: <20121128025734.21231.47468.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed, 28 Nov 2012 03:57:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5904BFE2-392E-11E2-9B82-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210714>

Christian Couder <chriscool@tuxfamily.org> writes:

> All the python scripts except contrib/svn-fe/svnrdump_sim.py
> start with "#!/usr/bin/env python".
>
> This patch fix contrib/svn-fe/svnrdump_sim.py to do the same.

I suspect you need a bit more than that.

    $ make git-p4
    $ diff -u git-p4.py git-p4

shows you how we tell the scripts how to find their interpreters
(that way, there is no need to rely on the existence of
/usr/bin/env).

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  contrib/svn-fe/svnrdump_sim.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
> index 1cfac4a..d219180 100755
> --- a/contrib/svn-fe/svnrdump_sim.py
> +++ b/contrib/svn-fe/svnrdump_sim.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python
>  """
>  Simulates svnrdump by replaying an existing dump from a file, taking care
>  of the specified revision range.
