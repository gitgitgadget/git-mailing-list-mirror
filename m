From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 03/10] ref-filter: support printing N lines from tag annotation
Date: Thu, 09 Jul 2015 15:07:09 +0200
Message-ID: <vpqpp417a4i.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<1436437671-25600-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:07:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDBXs-0003Yl-BJ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 15:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbbGINHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 09:07:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38033 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbbGINHO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 09:07:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t69D77Gr032355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jul 2015 15:07:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t69D79S6017808;
	Thu, 9 Jul 2015 15:07:09 +0200
In-Reply-To: <1436437671-25600-3-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 9 Jul 2015 15:57:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 09 Jul 2015 15:07:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t69D77Gr032355
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437052029.92379@ddA+iIiT+63JfMaIfjf/cQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273749>

Karthik Nayak <karthik.188@gmail.com> writes:

> In 'tag.c' we can print N lines from the annotation of the tag
> using the '-n<num>' option.

Not only annotation of the tag, but also from the commit message for
lightweight tags.

> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
>  	return contains_test(candidate, want);
>  }
>  
> +/*
> + * Currently dupplicated in ref-filter, will eventually be removed as

dupplicated -> duplicated.

> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -55,6 +55,7 @@ struct ref_filter {
>  	struct commit *merge_commit;
>  
>  	unsigned int with_commit_tag_algo : 1;
> +	unsigned int lines;
>  };
>  
>  struct ref_filter_cbdata {
> @@ -87,7 +88,7 @@ int verify_ref_format(const char *format);
>  /*  Sort the given ref_array as per the ref_sorting provided */
>  void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
>  /*  Print the ref using the given format and quote_style */
> -void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
> +void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style, unsigned int lines);

I would add "If lines > 0, prints the first 'lines' no of lines of the
object pointed to" or so to the docstring.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
