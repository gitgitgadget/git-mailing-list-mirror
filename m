From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 14/19] fsck: Allow upgrading fsck warnings to errors
Date: Fri, 19 Jun 2015 13:22:59 -0700
Message-ID: <xmqq616j78ik.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<49189b5b9e8ad194c6408b30db6f493c53595021.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:23:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z62oe-0004VW-6p
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbbFSUXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:23:04 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37753 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623AbbFSUXB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:23:01 -0400
Received: by igblr2 with SMTP id lr2so20741772igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Yz5ByL4DyeDScIbXJdy76dqxXKbghhogp2JUSclUV8c=;
        b=cX0tsR+meulvtLGBvJDu5ed1VoBf0O8yFhvNNjvhHFKpyOMJuC/vbSJPyIOTbh/7Z6
         2J3hRRso2sqRigdoUQXUg3jQh5wCP7pg6IiCCpO8HNuItMqPVAGzev/oaKvC8wOJMcjb
         y9SXpbUkcrUfiggZSQRtB3YrL4FLe4FBMGNCc4JAvOm28tFZhaQFljBjzqzCBKD+SO25
         84szS1vv2bCRzzL9Fas9A3KTsciJp+aAl6dwnIRN0GUFCH/OIFIkwRQPfYDDQ1HkOmfT
         D05FZmIxwiXaOLr0g+C1/gJNhxrBCG5cyy+Q0jY3mF89KaJ7NzGw7blgYB56MEOZrQgD
         S08g==
X-Received: by 10.107.167.73 with SMTP id q70mr24647018ioe.82.1434745381297;
        Fri, 19 Jun 2015 13:23:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id 196sm7720526ioe.23.2015.06.19.13.23.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 13:23:00 -0700 (PDT)
In-Reply-To: <49189b5b9e8ad194c6408b30db6f493c53595021.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:34:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272197>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  #define FSCK_FATAL -1
> +#define FSCK_INFO -2
>  
>  #define FOREACH_MSG_ID(FUNC) \
>  	/* fatal errors */ \
> @@ -50,15 +51,16 @@
>  	FUNC(ZERO_PADDED_DATE, ERROR) \
>  	/* warnings */ \
>  	FUNC(BAD_FILEMODE, WARN) \
> -	FUNC(BAD_TAG_NAME, WARN) \
>  	FUNC(EMPTY_NAME, WARN) \
>  	FUNC(FULL_PATHNAME, WARN) \
>  	FUNC(HAS_DOT, WARN) \
>  	FUNC(HAS_DOTDOT, WARN) \
>  	FUNC(HAS_DOTGIT, WARN) \
> -	FUNC(MISSING_TAGGER_ENTRY, WARN) \
>  	FUNC(NULL_SHA1, WARN) \
> -	FUNC(ZERO_PADDED_FILEMODE, WARN)
> +	FUNC(ZERO_PADDED_FILEMODE, WARN) \
> +	/* infos (reported as warnings, but ignored by default) */ \
> +	FUNC(BAD_TAG_NAME, INFO) \
> +	FUNC(MISSING_TAGGER_ENTRY, INFO)

Exactly the same comment as 12/19 applies to this change; not only
complaints but also "result makes sense" part.
