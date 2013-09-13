From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 1/3] Doc URLs: relative paths imply the dot-respository
Date: Fri, 13 Sep 2013 15:21:49 -0700
Message-ID: <xmqq7gekicqq.fsf@gitster.dls.corp.google.com>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1379107397-964-1-git-send-email-philipoakley@iee.org>
	<1379107397-964-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbkS-0003xm-4l
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468Ab3IMWVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:21:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754990Ab3IMWVv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:21:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D46B41D36;
	Fri, 13 Sep 2013 22:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v9l+1jfViuOKjvOa8wiu3ZkvIVU=; b=no/wT5
	oSjV+1O9podLzhrUIMpNJl+XkXgTddeSni2VMJIEXJeL6WptyM6b5jKgDmJ1uxPp
	8qdeIlNrIHrS6r4FVMqDrdJUzqQeXjsINVu0vS7NO2YAS70WNGfPGwvxFI1E2iab
	AFNAEwA7I5R4cfDliLzw1qenPXYfnLPLBCRoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mqg6JN6LCM8f6Qmy+ZXlgWOuFPEC2zPk
	maiGT2r9djOCpdMXAAN2DgFAawCohfr9H5YpkG5h9j2GankS4gt/cth35ch/ao1y
	wWt93lOyB9YfKMskj7g1HB6Mw8gSYrBy5rjxZXUPgmVoGm1Zq8HGQjxARUQzQYDv
	sb53gmGbrI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5316A41D35;
	Fri, 13 Sep 2013 22:21:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD89A41D31;
	Fri, 13 Sep 2013 22:21:50 +0000 (UTC)
In-Reply-To: <1379107397-964-2-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Fri, 13 Sep 2013 22:23:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E2EFF6D6-1CC2-11E3-8302-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234781>

Philip Oakley <philipoakley@iee.org> writes:

> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/urls.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 9ccb246..5350a63 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -55,6 +55,13 @@ These two syntaxes are mostly equivalent, except the former implies
>  --local option.
>  endif::git-clone[]
>  
> +Relative paths are relative to the `$GIT_DIR`, thus the path:

Is it?

	git init src dst
        cd src
        git commit --allow-empty -m initial
        cd ../dst
        git fetch ../src HEAD:refs/heads/copy

would work, but if it is relative to $GIT_DIR, the last one would
need to be written as

	git fetch ../../src HEAD:refs/heads/copy

wouldn't it?

> +
> +- '.'
> +
> +is the current repository and acts as if it were a repository
> +named `'.'`.
> +
>  When Git doesn't know how to handle a certain transport protocol, it
>  attempts to use the 'remote-<transport>' remote helper, if one
>  exists. To explicitly request a remote helper, the following syntax
