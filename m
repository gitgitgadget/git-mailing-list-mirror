From: Matthieu Moy <Matthieu.Moy@Grenoble-INP.fr>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Mon, 09 Jun 2014 16:24:47 +0200
Message-ID: <vpqmwdmtb2o.fsf@anie.imag.fr>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
	<1402318146-5062-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 16:25:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu0VR-0001tN-JE
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 16:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933388AbaFIOY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 10:24:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45033 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720AbaFIOY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 10:24:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s59EOjRq027610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 Jun 2014 16:24:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s59EOlao013954;
	Mon, 9 Jun 2014 16:24:47 +0200
In-Reply-To: <1402318146-5062-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 9 Jun 2014 05:49:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Jun 2014 16:24:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s59EOjRq027610
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1402928688.30257@S/rcXtR68JpXIdb0vIKcwA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251079>

Tanay Abhra <tanayabh@gmail.com> writes:

> +the highest priority(i.e. for the same variable value in the repo config
                       ^
missing space.

> +struct config_cache_entry {
> +	struct hashmap_entry ent;
> +	char *key;
> +	struct string_list *value_list;
> +};

I guess this crossed Eric's remark about the fact that this is a
pointer.

> +static int hashmap_is_init;

I'd call it hashmap_initialized, but that's a matter of taste.

> +static void config_cache_free(void)

I didn't look closely enough to make sure there were no memory leak
remaining, but did you check with valgrind --leak-check that it is the
case in practice?

> +	/* contents of config file has changed, so invalidate the
> +	 * config cache used by non-callback based query functions.
> +	 */

Style: Git usually writes multi-line comments

/*
 * like
 * this
 */

(not always applied, but documented in Documentation/CodingGuidelines)

(no time for a more detailed review, sorry)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
