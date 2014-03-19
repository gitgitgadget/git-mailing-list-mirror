From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5] fsck.c: fsck_tree() now use is_dot_or_dotdot().
Date: Wed, 19 Mar 2014 18:51:58 +0100
Message-ID: <vpq61nadqkh.fsf@anie.imag.fr>
References: <1395245290-6677-1-git-send-email-mandrei.dinu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrei Dinu <mandrei.dinu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:52:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKev-0005cq-PF
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:52:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbaCSRwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 13:52:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59578 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbaCSRwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:52:02 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2JHpuZT031156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Mar 2014 18:51:56 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2JHpwc0005386;
	Wed, 19 Mar 2014 18:51:58 +0100
In-Reply-To: <1395245290-6677-1-git-send-email-mandrei.dinu@gmail.com> (Andrei
	Dinu's message of "Wed, 19 Mar 2014 18:08:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Mar 2014 18:51:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2JHpuZT031156
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395856317.87383@cxT8EBn1BUA7gHUs4RZ0IA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244469>

Andrei Dinu <mandrei.dinu@gmail.com> writes:

> ---
>  I try to find other sites that can use id_dot_or_dotdot() function.

This should also have been sent in the same series.

> @@ -171,10 +172,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>  			has_full_path = 1;
>  		if (!*name)
>  			has_empty_name = 1;
> -		if (!strcmp(name, "."))
> -			has_dot = 1;
> -		if (!strcmp(name, ".."))
> -			has_dotdot = 1;
> +		if (is_dot_or_dotdot(name)) {
> +            if (name[1] == '\0')
> +			    has_dot = 1;
> +            else
> +			    has_dotdot = 1;
> +        }

The indentation is wrong. Configure your text editor to show you tabs
and spaces differently (e.g. M-x whitespace-mode RET in Emacs). Git uses
tabs to indent, and only that.

I find the old code much clearer than the new one. This "name[1] ==
'\0'" looks weird to test if name is the string ".".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
