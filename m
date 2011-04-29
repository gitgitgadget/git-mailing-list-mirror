From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: fix missing space in error message
Date: Fri, 29 Apr 2011 11:33:56 -0700
Message-ID: <7vmxj8x5yj.fsf@alter.siamese.dyndns.org>
References: <1304101404-4571-1-git-send-email-sylvain@abstraction.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFsW6-0001sf-OX
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 20:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757894Ab1D2SeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 14:34:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab1D2SeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 14:34:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B2DF05EE8;
	Fri, 29 Apr 2011 14:36:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZbfrHs1C0RYftFRVamm7TBEk/ys=; b=ENwOez
	ajuvlmBxcsRn09CecivFGyFKlSsWHzmkPjtkNPwWy7rCMK6UN/rAjeGLJakYQoao
	zJRiqyJ3LYs2v+f12SP3+5lf5mfvV3JNauBCn05Xm/qX5WKjLyTHBL/R9lJ/VlfD
	UPKmg8zDtGzoJmvkU+dH9pu9RbOmpH45caFr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvojVf2vV10fBsfkC0IdE5Ps2c+/wp4h
	zxSAphfaw2/Bknd4XVLcsrnXhrWmojLZNG95zCCcPbLPER4hLmYuAgh3b9whiXee
	O//qZTXvzn/sa2OG8VnXyOsAvMXID+jV3eLDKGgDzZljz1Y1rIxHI/iwpm0MeaZJ
	F4PsucJapFA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 771315EE7;
	Fri, 29 Apr 2011 14:36:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7E8C65EE6; Fri, 29 Apr 2011
 14:36:00 -0400 (EDT)
In-Reply-To: <1304101404-4571-1-git-send-email-sylvain@abstraction.fr>
 (Sylvain Rabot's message of "Fri, 29 Apr 2011 20:23:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8981F2BE-728F-11E0-BC44-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172488>

Sylvain Rabot <sylvain@abstraction.fr> writes:

> Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>

Please keep in mind that these individual commits will eventually need an
entry added to Documentation/Relnotes/1.7.5.1.txt where I describe what
bug was fixed in a single paragraph, and it almost always talks about how
a bug would have been triggered so that the readers can tell if the fix
would benefit them.

It would have been perfect if you wrote under what condition the user
would see this error message in the body of the commit.

> ---
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 76565de..98ab33a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1091,7 +1091,7 @@ X-Mailer: git-send-email $gitversion
>  			    "VALUES: server=$smtp_server ",
>  			    "encryption=$smtp_encryption ",
>  			    "hello=$smtp_domain",
> -			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
> +			    defined $smtp_server_port ? " port=$smtp_server_port" : "";

If I were writing this from scratch, I probably would have written it
by having leading SP for all options, perhaps like this:

	"VALUES:",
        " option=value",
        " option=value",
        (showoption) ? " option=value" : "",
        (showoption) ? " option=value" : "",
        ...

Thanks.
