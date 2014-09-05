From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] i18n translate builtin warning, error, usage, fatal messages
Date: Fri, 05 Sep 2014 12:47:42 -0700
Message-ID: <xmqq4mwlrgrl.fsf@gitster.dls.corp.google.com>
References: <1409943445-12283-1-git-send-email-sandy.carter@savoirfairelinux.com>
	<1409943445-12283-3-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 21:47:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPzUC-0007Wj-M6
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 21:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbaIETrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 15:47:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64390 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885AbaIETrp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 15:47:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEDB036BBB;
	Fri,  5 Sep 2014 15:47:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j1UOUQTJCRCbaufqqWoHLiSJX7w=; b=iVIjqy
	u3RbSoqmrj626hhZmeLgcuCpnaKQ5C4Lw+81hBuW+r+W0BiLEvtm+yOqrAVdPDXX
	vTfrF8wPZGcbze1lY8I+GppYNM0titTvqLgL46dmoC+644f7aoDo05ysRsgep6sT
	AmufoW1yUkOva/hNiqj8Rp7BhxgdMI3sDH2Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PR5EmZN89fhZE4KR7Eg2uZ9eyb40oHeZ
	g3PRTzj7SuoyY5vyWedsLIclf3PbmKjbSRFP5T1zjyLCXIhFq0+iLyhc/xykJYmj
	dcB8HBvFEWGZPebvGvuxkNIgBEhrV9x5w+vas8wIcOLRzqKKLs1gGD+H0iCMbvqb
	c4We+ZCyp9A=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C4E4436BBA;
	Fri,  5 Sep 2014 15:47:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E3E936BB9;
	Fri,  5 Sep 2014 15:47:44 -0400 (EDT)
In-Reply-To: <1409943445-12283-3-git-send-email-sandy.carter@savoirfairelinux.com>
	(Sandy Carter's message of "Fri, 5 Sep 2014 14:57:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 811767B4-3535-11E4-A47A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256516>

Sandy Carter <sandy.carter@savoirfairelinux.com> writes:

> Allow warnings, errors, usage and fatal messages to be translated to user
> when checking out a ambiguous refname for example
>
> Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
> ---

Hmmmm.  Doesn't this break the plumbing commands whose messages are
meant to be matched and interpreted by scripts?

>  usage.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index ed14645..24a450e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -27,24 +27,24 @@ void vwritef(int fd, const char *prefix, const char *err, va_list params)
>  
>  static NORETURN void usage_builtin(const char *err, va_list params)
>  {
> -	vreportf("usage: ", err, params);
> +	vreportf(_("usage: "), err, params);
>  	exit(129);
>  }
>  
>  static NORETURN void die_builtin(const char *err, va_list params)
>  {
> -	vreportf("fatal: ", err, params);
> +	vreportf(_("fatal: "), err, params);
>  	exit(128);
>  }
>  
>  static void error_builtin(const char *err, va_list params)
>  {
> -	vreportf("error: ", err, params);
> +	vreportf(_("error: "), err, params);
>  }
>  
>  static void warn_builtin(const char *warn, va_list params)
>  {
> -	vreportf("warning: ", warn, params);
> +	vreportf(_("warning: "), warn, params);
>  }
>  
>  static int die_is_recursing_builtin(void)
