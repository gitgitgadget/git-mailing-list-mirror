From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] improve documentation for some commands that use pathspecs
Date: Tue, 31 Mar 2015 09:38:23 -0700
Message-ID: <xmqqd23prukg.fsf@gitster.dls.corp.google.com>
References: <20150331152224.GA16617@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joeyh@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 31 18:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YczBR-00005q-4o
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 18:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbbCaQi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 12:38:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755261AbbCaQi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 12:38:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BC5D5442D5;
	Tue, 31 Mar 2015 12:38:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3nhfFguKjYmoNFajfjzZVfP32c4=; b=OoliE6
	e+1+1gSci3GyKCq/DLsXJNrlb3HMtL7sy23bEuL6lCgLLCKS1BykPRIACOJai7Sl
	LywGss1ZHbK9d/Mm7dv3IKK3g1/Xc0ZxlQlpTWB647PEziw8aN5lye00TjfLewED
	fs8XgxFuEkSCLxI+Y/3Q1+MH05BJuHkDKRw/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N/ND7edG+Va8TdXo1F1/EYmDrC85CZ5j
	vqQfV3zgrkLCEeR2JLfYBrhK7+O/Mtel79KXwxizqu9jvhoSPC9SMYo6qTiR+bCN
	0MuWvtOYbsWSYDjFZ6lHyC0996n5lWKmiIgnu7NLKKpA7XxXsts3+viVJFquSCC6
	Ld7Tqf3U8Hc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5C75442D4;
	Tue, 31 Mar 2015 12:38:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28DA3442D3;
	Tue, 31 Mar 2015 12:38:25 -0400 (EDT)
In-Reply-To: <20150331152224.GA16617@kitenet.net> (Joey Hess's message of
	"Tue, 31 Mar 2015 11:22:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A053C46-D7C4-11E4-8ED9-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266529>

Joey Hess <joeyh@joeyh.name> writes:

> After being surprised that git-ls-files expands pathspecs, here's a patch
> that would have saved me.
> ---

I have a vague recollection that we originally wanted to
consistently say pathspec but some "user friendliness" folks wanted
to avoid the term as much as possible---blaming might reveal this
may be reverting the description to the original ;-).

I like the general direction, but please sign-off your patch.

> @@ -150,9 +150,10 @@ a space) at the start of each line:
>  \--::
>  	Do not interpret any more arguments as options.
>  
> -<file>::
> +<pathspec>::
>  	Files to show. If no files are given all files which match the other
> -	specified criteria are shown.
> +	specified criteria are shown. (Note that this isn't really raw
> +	pathnames, but rather a list of patterns to match.)

After updating the heading to <pathspec>, it would be clear that it
is not listing filename but a specification to choose path with.  I
do not see the need for this added "Note that".

Perhaps what you need to update is the first sentence "Files to
show".  It is more like "Limit the paths to show with." or
something, perhaps?  Then the "If no files are given" part (which is
wrong after your patch, because this is no longer talking about
giving any "file") can go.  By default we show everything, and
use of pathspecs is merely one of the ways to limit the output, and
you would not want to repeat "if this option is not given, all paths
that match the other specified criteria are shown" to all the other
options that limit what is shown.
