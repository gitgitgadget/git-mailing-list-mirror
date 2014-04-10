From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 9/9] sha1_name: add support for @{publish} marks
Date: Thu, 10 Apr 2014 17:49:03 -0400
Message-ID: <CALkWK0nU_Esy6QoQG-vv3nKE=P=gWDiFgRp4RKvq4DbxOntkaA@mail.gmail.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com> <1397156686-31349-10-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 23:49:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYMr0-0001XE-3n
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 23:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934908AbaDJVtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 17:49:46 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60835 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759074AbaDJVto (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 17:49:44 -0400
Received: by mail-ob0-f179.google.com with SMTP id va2so5182568obc.10
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 14:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mZ7oSz9TM51ZjxVp3rMwcPkmfuK8nXp+9axqEiRySvI=;
        b=d0xaFx3hZcS3h0WqBbwG8hqd1cbtd6eUjEE4zk3RAJZTpsIZWKvT+2wh4qmMw6aGdr
         OrCHNv/razqbrdw3GQPkk19xXl/54t5nZ6R2WacpStJ5sZd+QoXLPsipymYH2P59j8NS
         /eBbDBE1pyLJQirQYSXNdd58sOORqyjLf2DVKJKPHwywNAqW5OIxcqNKMyBM8lT7loxK
         mr5LjPiz5PSHVeCgNSAjZbme2vZmLcE3hecw8r/Tt2MPUBJ9AC+ow0SXQq/BRtfQ5nOo
         J3+z/Y31oUsxlXKR8Dp0jbJdbFOhDZRiyIEUHvIbiedYSaRCFusW7lIezc0QaZebSQFY
         UQLA==
X-Received: by 10.60.83.234 with SMTP id t10mr16011277oey.4.1397166584417;
 Thu, 10 Apr 2014 14:49:44 -0700 (PDT)
Received: by 10.182.151.43 with HTTP; Thu, 10 Apr 2014 14:49:03 -0700 (PDT)
In-Reply-To: <1397156686-31349-10-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246058>

Felipe Contreras wrote:
> diff --git a/sha1_name.c b/sha1_name.c
> index aa3f3e0..a36852d 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -415,9 +415,9 @@ static int ambiguous_path(const char *path, int len)
>         return slash;
>  }
>
> -static inline int upstream_mark(const char *string, int len)
> +static inline int tracking_mark(const char *string, int len)
>  {
> -       const char *suffix[] = { "upstream", "u" };
> +       const char *suffix[] = { "upstream", "u", "publish", "p" };

Oh, another thing: on some threads, people decided that "@{push}"
would be a more apt name (+ alias @{u} to @{pull} for symmetry).
