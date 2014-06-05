From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Explain the purpose of fetch's and pull's <refspec> parameter.
Date: Thu, 05 Jun 2014 15:12:15 -0700
Message-ID: <xmqq61kfroow.fsf@gitster.dls.corp.google.com>
References: <53908CE3.6080106@xiplink.com>
	<1401982803-22346-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 00:12:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsftk-0007lZ-SM
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 00:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbaFEWM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 18:12:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62861 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbaFEWMV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 18:12:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CF2391D631;
	Thu,  5 Jun 2014 18:12:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HCD1QmkxhnZLpgbC3J0QpRIujIM=; b=mKyiRt
	BLwCn8bjaT7tGMYy9uap9rL4F8Di3KTpZOfu90+VpS2WLzG7RQVx9xcTnSz+giXr
	MHhIQLsx0HoCJdDdFklcyjAVtKmNn6c47sjzbvDQ4r26SnZGSuimyhb05Y1ZqePq
	4wrYljzqX0ELriw6SxuvevMnpG+0teBdSWsuw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9EcIu+fjC3q6p10v6BzvOwrVNxkEVS3
	FLqv4cnJCA/dli2Xuw9yH/ohiJnZL9suZZttyXj1vKkRAL2ZKQqjtbhVvq33sZZw
	TN/y/mvENnOGJ/So4WLpkXApvDP9Nt3SqedUOHPi+wjGu9HPQUtpmZGm2TizVb6q
	nvfGfFsYeIQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C62B81D630;
	Thu,  5 Jun 2014 18:12:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1D6971D62E;
	Thu,  5 Jun 2014 18:12:17 -0400 (EDT)
In-Reply-To: <1401982803-22346-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Thu, 5 Jun 2014 11:40:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 747ABB84-ECFE-11E3-85F0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250872>

Marc Branchaud <marcnarc@xiplink.com> writes:

> This patch applies atop your 8/9.  I feel strongly that some kind of
> reference should accompany this description, and your new CONFIGURED
> REMOTE-TRACKING BRANCHES section seems like a good one for the fetch
> variant, but since pull's variant doesn't have that section I just
> made it link to fetch's doc.
>
> (Also, I'm not sure if "CRTB" is a good link ID for your new section.)

Nobody looks at these ids, hopefully ;-)

> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index 18cffc2..40304c6 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -12,9 +12,20 @@ ifndef::git-pull[]
>  endif::git-pull[]
>  
>  <refspec>::
> -	The format of a <refspec> parameter is an optional plus
> -	`+`, followed by the source ref <src>, followed
> -	by a colon `:`, followed by the destination ref <dst>.
> +	Specifies which refs to fetch and which local refs to update.

That is an improvement.  We should first say what it is and what it
is for before saying how you spell it and the above change is
exactly that.

> +	<refspec> parameters are not normally specified on the command
> +	line, but instead are read from `remote.<repository>.fetch`

I however am not sure if this is an improvement, especially the
"normally" part.  Those who respond to a git-pull-request output
might be fewer than those who send pull requests, but that does not
mean they are abnormal.

	The command line often omit <refspec> parameters when
	fetching or pulling from a remote you regularly interact
	with, in which case `remote.<repository>.fetch` values are
	used instead.

would be OK, though.

Later today I'll push out the series on 'pu' after amending them
with your comments so far.  It would be nice if you can reroll this
on top of the updated one ("git log --oneline --first-parent
master..pu" and find jc/fetch-pull-refmap in there).

Thanks.
