From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Documentation: explain how to check for patch
 corruption
Date: Thu, 14 Apr 2011 21:53:56 -0700
Message-ID: <7vsjtkdsij.fsf@alter.siamese.dyndns.org>
References: <87d3kq6tz7.fsf@rho.meyering.net>
 <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net> <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org> <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org> <20110415021100.GA19829@elie>
 <20110415022401.GC19829@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 06:54:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAb3C-0000e5-1Z
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 06:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab1DOEyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 00:54:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab1DOEyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 00:54:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 09D4022C7;
	Fri, 15 Apr 2011 00:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mtX3j75XarBA5zC9ldmuwyQMBCI=; b=NwLlqo
	4j0cNPV6PVJ6eFJ3UrxJQcw6pguno2ZvoGZIEUXP+H0K3N9cxj0YC3hJthJXO243
	KWObbpyt0Xecif137fpPueDMDZ8eS++u/VHkhY1VQfHVahX/5EWIQHBrwTSrRyD4
	Ff0n4AgPekWUd7RjkOa8eNb0+KK0eJAu3PAkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LQrPnata3DmSTZUCSYKDvc+ryB1GG16F
	6fT+PGAdIPa8fHKCETGx83dNDiPK6P8jx4PedFDDNQcriUeQpJq9CIzp6KkHK9e9
	ce203FNpJMGxXf/l+DtxnwUGumGWyH7djO0gIBS5WytqLL2T9yFRK4Ch8tq72mHt
	EJDGqNIYaJg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AAD522A3;
	Fri, 15 Apr 2011 00:56:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5BE79228D; Fri, 15 Apr 2011
 00:55:56 -0400 (EDT)
In-Reply-To: <20110415022401.GC19829@elie> (Jonathan Nieder's message of
 "Thu, 14 Apr 2011 21:24:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAECB3FE-671C-11E0-9627-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171587>

Jonathan Nieder <jrnieder@gmail.com> writes:

> SubmittingPatches has some excellent advice about how to check a patch
> for corruption before sending it off.  Move it to the format-patch
> manual so it can be installed with git's documentation for use by
> people not necessarily interested in the git project's practices.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/SubmittingPatches    |   58 ++++++++---------------------------
>  Documentation/git-format-patch.txt |   46 ++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index c6a5032..20b4101 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -344,50 +344,20 @@ MUA specific hints
>  
>  Some of patches I receive or pick up from the list share common
>  patterns of breakage.  Please make sure your MUA is set up
> +properly not to corrupt whitespaces.
> +
> +See the DISCUSSION section of git-format-patch(1) for hints on
> +checking your patch by mailing it to yourself and applying with
> +git-am(1).
> +
> +While you are at it, check the resulting commit log message from
> +a trial run of applying the patch.  If what is in the resulting
> +commit is not exactly what you would want to see, it is very
> +likely that your maintainer would end up hand editing the log
> +message when he applies your patch.  Things like "Hi, this is my
> +first patch.\n", if you really want to put in the patch e-mail,
> +should come after the three-dash line that signals the end of the
> +commit message.

Perhaps the last paragraph can also go, as a copy of it now is in git-am(1)?

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index a4a9813..5c60418 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -286,6 +286,52 @@ title is likely to be different from the subject
> +One way to test if your MUA is set up correctly is:
> +
> +* Send the patch to yourself, exactly the way you would, except
> +  with To: and Cc: lines that do not contain the list and
> +  maintainer address.

... "except for removing other people from To: and Cc: lines to avoid
spamming them with your test"?
