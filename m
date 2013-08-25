From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] replace: forbid replacing an object with one of a
 different type
Date: Sun, 25 Aug 2013 20:35:47 +0200
Message-ID: <521A4E83.9000400@kdbg.org>
References: <20130825125940.4681.70226.chriscool@tuxfamily.org> <20130825130609.4681.25786.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.orcg>,
	Thomas Rast <trast@inf.ethz.ch>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Aug 25 20:35:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDfAK-0000sh-In
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 20:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab3HYSfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 14:35:52 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:28158 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755759Ab3HYSfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 14:35:52 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 949DB1300B4;
	Sun, 25 Aug 2013 20:35:48 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 746C319F621;
	Sun, 25 Aug 2013 20:35:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130825130609.4681.25786.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232962>

Am 25.08.2013 15:06, schrieb Christian Couder:
> @@ -100,6 +101,15 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	if (check_refname_format(ref, 0))
>  		die("'%s' is not a valid ref name.", ref);
>  
> +	obj_type = sha1_object_info(object, NULL);
> +	repl_type = sha1_object_info(repl, NULL);
> +	if (obj_type != repl_type)
> +		die("Objects must be of the same type.\n"
> +		    "Object ref '%s' is of type '%s'\n"

Is it really an "Object ref", not just an "Object"?

> +		    "while replace ref '%s' is of type '%s'.",

And here:

		"while replacement object '%s' is of type '%s'.",

BTW, I appreciate your choice of where in the sentence the line breaks are.

> +		    object_ref, typename(obj_type),
> +		    replace_ref, typename(repl_type));
> +
>  	if (read_ref(ref, prev))
>  		hashclr(prev);
>  	else if (!force)

-- Hannes
