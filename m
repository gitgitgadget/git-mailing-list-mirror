From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 09/11] branch.c: use 'ref-filter' data structures
Date: Tue, 28 Jul 2015 10:22:59 +0200
Message-ID: <CAP8UFD1Bx_o2gWP0R4EbsHO0d3LRRJ2rpHDKQhRVQpTrD6pjBw@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:23:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK0AN-0004xe-Ba
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 10:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbbG1IXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 04:23:03 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:32940 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbG1IXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 04:23:01 -0400
Received: by wicmv11 with SMTP id mv11so168986668wic.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mkoXL11EqcrHIbjZ+aXQ29n0W8V9UytbbWkmu9zdYAc=;
        b=nnddeZIyozMvLtAsfw1CsZ1LD7BjZYd7/B05hwUQf/a80rZ7j8SSAAewpVJkF0553g
         BgZ2TVAGu1Si2ffwstBeJFaTtk6vOCJajj/MBjatw02g6NRRu46nkZNn69FmYzfFdw3v
         0IZcUjHQS+7ThjiRRNRVMfHo1aKubNEak5UA3JanKAct2CKKcHZX3B7SNCm/w8qLP7t4
         1vAPaRNw6l8c3A/yjLiFvSHh2r8zMJQCRIs2ikyoKAj6POzVlr1/tIJOy0RlAG9/Yu9Q
         W/nHSGzIdY3xClTO69G7FeAhkEfOwnz00Me3lCNar8AjCD4p3W1mZWr8b4lkpNITcXj5
         x3SQ==
X-Received: by 10.194.95.132 with SMTP id dk4mr69809903wjb.88.1438071779899;
 Tue, 28 Jul 2015 01:22:59 -0700 (PDT)
Received: by 10.194.36.106 with HTTP; Tue, 28 Jul 2015 01:22:59 -0700 (PDT)
In-Reply-To: <1438066594-5620-9-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274757>

On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> diff --git a/ref-filter.h b/ref-filter.h
> index 7d1871d..3458595 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -5,6 +5,7 @@
>  #include "refs.h"
>  #include "commit.h"
>  #include "parse-options.h"
> +#include "revision.h"
>
>  /* Quoting styles */
>  #define QUOTE_NONE 0
> @@ -48,6 +49,7 @@ struct ref_sorting {
>  struct ref_array_item {
>         unsigned char objectname[20];
>         int flag, kind;
> +       int ignore : 1;

Maybe you could add a comment to say that this will be removed in the
next patch.

>         const char *symref;
>         struct commit *commit;
>         struct atom_value *value;
