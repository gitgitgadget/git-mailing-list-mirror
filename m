From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-remote-mediawiki: use dont-update-private capability on dumb push
Date: Thu, 29 Aug 2013 12:08:37 -0700
Message-ID: <xmqq61uo48ne.fsf@gitster.dls.corp.google.com>
References: <vpqsixvfvdk.fsf@anie.imag.fr>
	<1377802704-30881-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377802704-30881-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:08:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7aH-0005Ue-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805Ab3H2TIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:08:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154Ab3H2TIk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:08:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7FFA3DAA9;
	Thu, 29 Aug 2013 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cLEl2e/q/Nf8qBbvrAKsuD2B/sA=; b=Exy6bO
	rb3Ep/Q59hUk6crmoScvfb3abFaLYd0jdfoQDOvX5CxkQFWyr5N+bA/oiOoOG8LV
	eBefQ+z9Mx6YHnWDHiASTlYJGigE7Qjqf+7HA2H/OZP4qD7R9It0YjHUdPnlSIbk
	IRqPdiNGjqs42bAKu8bNoDSpdAEtsogqDpDuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5pVrZ8gjJ8P3HnxkBg0Nl+P5Az3VhyT
	FKyZEGhpiUBfANzpK2T2LQyDxBJiRZ+1OIi3Db1gaqUSzWMBXS1w5A/q2r9sRq8M
	Q+sM8DVdtRPjpQ7IlktIq2+SDSARitPUXfpSkY96ctORCYgYAYiRNWOtavD7oGX+
	I0GFXdxJxWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE81A3DAA8;
	Thu, 29 Aug 2013 19:08:39 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BB593DA9D;
	Thu, 29 Aug 2013 19:08:39 +0000 (UTC)
In-Reply-To: <1377802704-30881-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 29 Aug 2013 20:58:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 699C70E2-10DE-11E3-9B63-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233341>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>
> I prefer not to bother with compatibility of git-remote-mediawiki with
> older Git versions. The recommanded way is to install Git and
> git-remote-mediawiki from the same source tree. People who want to
> keep an old Git version can still use old versions of
> git-remote-mediawiki.

I think that is a sane assumption.

>
>  contrib/mw-to-git/git-remote-mediawiki.perl | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
> index f8d7d2c..cdc278c 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -590,6 +590,9 @@ sub mw_capabilities {
>  	print {*STDOUT} "import\n";
>  	print {*STDOUT} "list\n";
>  	print {*STDOUT} "push\n";
> +	if ($dumb_push) {
> +		print {*STDOUT} "dont-update-private\n";
> +	}
>  	print {*STDOUT} "\n";
>  	return;
>  }
