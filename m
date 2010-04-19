From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote add: add a --no-tags (-n) option
Date: Mon, 19 Apr 2010 11:13:31 -0700
Message-ID: <7vvdbnqpis.fsf@alter.siamese.dyndns.org>
References: <20100419135014.1077.28627.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Apr 19 20:13:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3vTd-0002BU-UZ
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 20:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419Ab0DSSNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 14:13:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab0DSSNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 14:13:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B2A3ACFEC;
	Mon, 19 Apr 2010 14:13:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aVWYZcqtcFuaCDhsaosbXMQOsxg=; b=xVqXfL
	j+FxdKM8dqMEbczAOvs39SmckqxECzF39pUL4m6pPmRB2GMe/82lFCxqmlEqibUN
	1RFFuiffYTNhE8/OU5K0KQ7QCjym30Xk43sb09i+ym+ZxfscUZYyT0OT1LwnmLam
	KphqAfgw+5jAYIp0DUkjEYugcwn+a9e1r+XW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NqhZNlEH1xIF9op2K4s/mwq2NhFBNNuC
	UqazCBUCRR4v3fEPsjq24TNeczWDQRbfneoroSNk1behOuuPOMPkHUGnQzVOvvSM
	J3B03YrR34QZBYPMkZtK+tzMN4ESs/YAa3OG61O4Pc1v5mv4VigdsJvtX6DF/U0B
	Ck28XcpmNOM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBD76ACFE6;
	Mon, 19 Apr 2010 14:13:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F959ACFE0; Mon, 19 Apr
 2010 14:13:33 -0400 (EDT)
In-Reply-To: <20100419135014.1077.28627.stgit@localhost.localdomain> (Samuel
 Tardieu's message of "Mon\, 19 Apr 2010 15\:50\:14 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 460BCDF2-4BDF-11DF-88C0-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145322>

Samuel Tardieu <sam@rfc1149.net> writes:

> @@ -116,6 +116,8 @@ static int add(int argc, const char **argv)
>  
>  	struct option options[] = {
>  		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
> +		OPT_BOOLEAN('n', "no-tags", &notags,
> +			"do not import remote tags when fetching"),

Any long-opt that begins with "no-" looks wrong, especially that will
allow people to say "--no-no-tags".  Perhaps something like this is
necessary.

    { OPTION_BOOLEAN, 0, "tags", &tags, NULL, "fetch tags", PARSE_OPT_NOARG }

Or imitate whatever we do in builtin-fetch.c; although I suspect the
default would be different in this command and "git fetch", so you may
need to adjust for the difference a bit.
