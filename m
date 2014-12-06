From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 5 Dec 2014 18:04:58 -0800
Message-ID: <20141206020458.GR16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 03:05:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx4kG-0002V8-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 03:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbaLFCFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 21:05:03 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54336 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbaLFCFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 21:05:01 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so1818372ieb.21
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 18:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OEPxr9rm9nP2NlppWbG98+41wj75eTjOLNf/vmNKkjc=;
        b=chxyrrns1a79+xRr5LXMkXlbb44w5FdjTsV+c/dGjnm7GK4SLZUWiaJxgfCUH+GsXl
         puvIQjJ+1zmVXL/0ImTGurSb4hSwQqyEJ3wZR09JB5XIKvkxaFTthK/ckemHlcEqw359
         El5ojljgZXc/3Z7LhKxNYHc4uSzcI1ucYnC6vdcXBmd2Uw9GApJ2tWqgqyC0v5p4Trnl
         TaD2QwNCRMje1NUp/Ffe3sa7u91lXJCobIpEQ+QYXFc6NwAd0Z53zBAYaXwIR2ETv2Su
         t6yOX+HQP2TOfIQ0NtN9yT10Sq65b7GpEfhzmqIp63avOEa2tKDYa9XX/X7oPRHcEzR2
         C81Q==
X-Received: by 10.50.79.167 with SMTP id k7mr5491813igx.16.1417831501115;
        Fri, 05 Dec 2014 18:05:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d425:9c48:1673:7021])
        by mx.google.com with ESMTPSA id g5sm16878740iod.25.2014.12.05.18.05.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 18:05:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417830678-16115-1-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260923>

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Just stumbled accross this one and wasn't sure if it also frees up
>  the memory involved.
>
>  string-list.h | 5 +++++
>  1 file changed, 5 insertions(+)

Sounds reasonable.  Documentation/technical/api-string-list.txt
documents these functions more fully.  The right balance between
documenting things in two places vs. adding "see also" pointers vs.
just putting the highlights in one of the two places isn't obvious to
me.

[...]
> --- a/string-list.h
> +++ b/string-list.h
> @@ -21,6 +21,11 @@ struct string_list {
>  void string_list_init(struct string_list *list, int strdup_strings);
>  
>  void print_string_list(const struct string_list *p, const char *text);
> +
> +/*
> + * Clears the string list, so it has zero items. All former items are freed.
> + * If free_util is true, all util pointers are also freed.
> + */
>  void string_list_clear(struct string_list *list, int free_util);

The api doc says

	Free a string_list. The `string` pointer of the items will be freed in
	case the `strdup_strings` member of the string_list is set. The second
	parameter controls if the `util` pointer of the items should be freed
	or not.

One option here would be to say

	Free a string_list.  See Documentation/technical/api-string-list.txt
	for details.

That reminds me: why do we call this string_list_clear instead of
string_list_free?

Thanks,
Jonathan
