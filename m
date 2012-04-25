From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: allow ~/ and ~user/ in include.path value
Date: Wed, 25 Apr 2012 13:14:32 -0700
Message-ID: <xmqqwr53bmc7.fsf@junio.mtv.corp.google.com>
References: <1335265689-2270-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335292396-8502-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120425120036.GB21579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 22:14:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN8bn-0000eE-2w
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 22:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758654Ab2DYUOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 16:14:34 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:54649 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758558Ab2DYUOd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 16:14:33 -0400
Received: by qabg24 with SMTP id g24so202577qab.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 13:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=DuEfC9DdaoUcOtgTbBrrP5NS04Q3xr6OPEZyDf2iqyQ=;
        b=kmeHtbsMrsp5UJw4cKHp3oS2Ix6+xEqkO9NSrZJrSrnMQrS1PYhC1uaxJRk60qttFZ
         vwg5kCJTEJovuTsZjAUuqfcj/DZScokXCW/Ox6nJFGkQnlchjWzYOR34YizwJyJGG/EB
         RQ4nRgZq2AKcZC31Bi0ZLA6K9CA3gDRyHG0UGda60JETHOKGU+baTCeBsW0r/7FEPql1
         yxGxx7LXi9uXBT6sg8Uruip/0GOpRWWSGGHLDlLiicJrFmn+BEoW6Sp4UPss3HevyxFB
         6gCx9UoEoUS7PvqjMbXug+mQplMSotGn4b8vyXSZYCJlfsBxkkp+6/XdD+0Hp14rToqU
         +jhw==
Received: by 10.236.76.133 with SMTP id b5mr4927480yhe.0.1335384873237;
        Wed, 25 Apr 2012 13:14:33 -0700 (PDT)
Received: by 10.236.76.133 with SMTP id b5mr4927455yhe.0.1335384872986;
        Wed, 25 Apr 2012 13:14:32 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id y36si695120yhg.2.2012.04.25.13.14.32
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 13:14:32 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id D23951E0212;
	Wed, 25 Apr 2012 13:14:32 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 7D7DAE125C; Wed, 25 Apr 2012 13:14:32 -0700 (PDT)
In-Reply-To: <20120425120036.GB21579@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Apr 2012 08:00:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnzOnTKsNNx1fWZf0YnKAbPlAa10YblBrSO+/ir6Pb/vZIfwszXEKgp3zzH2SnSYNCAbzD4hfJZktWhloswTWI/hOdx64P9OKGxjgyQr7dXMRRw7tkMfr5Tdkp5AYLTvOfQfykDGLBvrpuzAviGogPgMoyhSe/aJ+/tx7hp/77sPPgzN2c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196333>

Jeff King <peff@peff.net> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fb386ab..0b3f291 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -95,7 +95,9 @@ included file is expanded immediately, as if its contents had been
>  found at the location of the include directive. If the value of the
>  `include.path` variable is a relative path, the path is considered to be
>  relative to the configuration file in which the include directive was
> -found. See below for examples.
> +found. The value of `include.path` is subject to tilde expansion: `~/`
> +is expanded to the value of `$HOME`, and `~user/` to the specified
> +user's home directory. See below for examples.
>  
>  Example
>  ~~~~~~~
> @@ -122,6 +124,7 @@ Example
>  	[include]
>  		path = /path/to/foo.inc ; include by absolute path
>  		path = foo ; expand "foo" relative to the current file
> +		path = ~/foo ; expand "foo" in your $HOME directory

Modulo s/~/{tilde}/ in the body text (but not in the displayed example),
looked good to me, so I queued with two amends.

Thanks.
