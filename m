From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] Add config variable to set HTML path for git-help
 --web
Date: Thu, 28 Jun 2012 14:39:37 -0700
Message-ID: <7vr4sz3yli.fsf@alter.siamese.dyndns.org>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340866684.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 23:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkMRF-0005YF-4e
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 23:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab2F1Vjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 17:39:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357Ab2F1Vjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 17:39:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 698848CAD;
	Thu, 28 Jun 2012 17:39:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OdcA2v06DuBJKmw8pjUCgf3SYls=; b=BfLb6N
	Mvo+0tORJqLoQ2tnkwwpTJiQVqsCr4yVj5/ABwxbwpVz8fzfAdhk52Rwed3DRYAv
	Yoo6Iw9Kh5srrmWjCXOnXB8ImGVeT/nTNm+TuBY2EdKNZFR3kQgHXmSTy7eNsE9c
	rCbcNY+dxho/JQ41NcnSyTKU6Sb+VPgx9lqO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mrMeah5OesVkc8CtCQQ9nUpbtQg1XFW7
	EhLpOS/YGdMSJN55rxbYstcb3NULt7Tdlw2TieI2NmjgtPLaukV67ckpLwD2PmjX
	UksGYqlewimebuqpZmwlq+QlR+ESHofB/rJw2LYUd4fYPPbE3yMsSD5YnaZvZ636
	Vf8eA3aH+8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 605A08CAC;
	Thu, 28 Jun 2012 17:39:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A25488CAB; Thu, 28 Jun 2012
 17:39:38 -0400 (EDT)
In-Reply-To: <8d3c71d21710c66e4d5560cec958552b69a22338.1340866684.git.chris@arachsys.com>
 (Chris Webb's message of "Thu, 28 Jun 2012 07:58:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C31939B8-C169-11E1-BDEC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200797>

Chris Webb <chris@arachsys.com> writes:

> If set in git-config, help.htmlpath overrides system_path(GIT_HTML_PATH)
> which was compiled in. This allows users to repoint system-wide git at
> their own copy of the documentation without recompiling.
>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  builtin/help.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 8f9cd60..b467db2 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -34,6 +34,8 @@ enum help_format {
>  	HELP_FORMAT_WEB
>  };
>  
> +static char *html_path = NULL;

I'll queue after updating this to

	static const char *html_path;

as the return value of const char *system_path(GIT_HTML_PATH) is
assigned to it.
