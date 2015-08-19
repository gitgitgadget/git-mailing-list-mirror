From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v12 12/13] tag.c: implement '--format' option
Date: Wed, 19 Aug 2015 16:53:59 +0200
Message-ID: <vpq614b49dk.fsf@anie.imag.fr>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
	<1439923052-7373-13-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 16:54:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS4kq-00030L-T4
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 16:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbbHSOyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 10:54:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50562 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932285AbbHSOyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 10:54:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7JErw3d008441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 16:53:58 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JErxSk020638;
	Wed, 19 Aug 2015 16:53:59 +0200
In-Reply-To: <1439923052-7373-13-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 19 Aug 2015 00:07:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 19 Aug 2015 16:53:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7JErw3d008441
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440600839.49362@cgONtMR3hWZsdq3LXUxi5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276178>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -158,6 +159,18 @@ This option is only applicable when listing tags without annotation lines.
>  	The object that the new tag will refer to, usually a commit.
>  	Defaults to HEAD.
>  
> +<format>::
> +	A string that interpolates `%(fieldname)` from the object
> +	pointed at by a ref being shown.  If `fieldname` is prefixed
> +	with an asterisk (`*`) and the ref points at a tag object, the
> +	value for the field in the object tag refers is used.  When
> +	unspecified, defaults to `%(refname:short)`.  It also
> +	interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
> +	interpolates to character with hex code `xx`; for example
> +	`%00` interpolates to `\0` (NUL), `%09` to `\t` (TAB) and
> +	`%0a` to `\n` (LF).  The fields are same as those in `git
> +	for-each-ref`.
> +

This documentation should probably be shortened to stg like

	A string that interpolates `%(fieldname)` from the object
	pointed at by a ref being shown. The format is the same as the
	one of linkgit:git-for-each-ref[1]. When unspecified, defaults
	to `%(refname:short)`

Alternatively, you can extract the "FIELD NAMES" section of
git-for-each-ref.txt to a separate file and include it in the doc for
each command having this --format option (this is how it's done for "git
log --format" IIRC). But taking that much space to describe hexadecimal
escapes that very few people would use and not documenting the %(atoms)
is counter-productive IMHO.

I would favor the first option (keep it short, include a pointer) with
Junio's remark in mind: "git tag" and "git branch" are meant to be
simple commands, and the scary swiss-army-knife should remain "git
for-each-ref".

I am still (slightly) in favor of adding --format to tag and branch, as
long as it does not make the commands too scary.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
