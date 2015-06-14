From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 05/11] ref-filter: add parse_opt_merge_filter()
Date: Sun, 14 Jun 2015 07:49:40 +0200
Message-ID: <CAP8UFD1Qw+ctvz_CbBoE-jb5_bC3jogAsTgp-mgkVBFG1y7SiQ@mail.gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
	<1434226706-3764-1-git-send-email-karthik.188@gmail.com>
	<1434226706-3764-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 07:49:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z40ni-0003JC-Qu
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 07:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbbFNFtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 01:49:42 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:34698 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbFNFtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 01:49:41 -0400
Received: by wgv5 with SMTP id 5so46953561wgv.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A0SfqsG9az59QWOLgtWVvL0+aF48K5U82H/5735m0qU=;
        b=JXcPf61vOXyU82jWLI6cPqvR7QbsBXi32OQUlUwp4rq2jdbSs2a+xwxZ2GVv+TkYD4
         q/B557kDbelI+H+HTFxGxNg3K/1eZYLKNhXuLdM5YhdWn/9p7ntOzIgLCuiemwuVMbrv
         Z1RGc5HALiKKrZ6B5rl6ki0WFWkknAn4hP75z1MYWGOAwuGHPH/+kXWxWXcHJgT4EeDC
         /6K5/cMxLH4JidCh36NPai6TzFHIDQDHSDyeez0leIj3eQmzzFTVPfgsmdi2sW6wlSQU
         Oxca3JLHjsS0/eJpBcbLyI2K35/PYvvexsg2yK3ygNId+g4SW1qx4ieJTBTpoqxE0qe4
         K37Q==
X-Received: by 10.181.11.129 with SMTP id ei1mr20317417wid.90.1434260980211;
 Sat, 13 Jun 2015 22:49:40 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sat, 13 Jun 2015 22:49:40 -0700 (PDT)
In-Reply-To: <1434226706-3764-5-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271604>

On Sat, Jun 13, 2015 at 10:18 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> diff --git a/ref-filter.h b/ref-filter.h
> index c2856b8..799e118 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -50,6 +50,18 @@ struct ref_filter_cbdata {
>         struct ref_filter *filter;
>  };
>
> +/*  Macros for checking --merged and --no-merged options */
> +#define OPT_NO_MERGED(filter, h) \
> +       { OPTION_CALLBACK, 0, "no-merged", (filter), N_("commit"), (h), \
> +         PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
> +         parse_opt_merge_filter, (intptr_t) "HEAD" \
> +       }
> +#define OPT_MERGED(filter, h) \
> +       { OPTION_CALLBACK, 0, "merged", (filter), N_("commit"), (h), \
> +         PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG, \
> +         parse_opt_merge_filter, (intptr_t) "HEAD" \
> +       }

Could you reduce the redundancy in these 2 macros?
