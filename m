From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v2] status: always report ignored tracked directories
Date: Mon, 7 Jan 2013 21:24:35 +0100
Message-ID: <CALWbr2xQePMwPARTNu566=OU9KtKo9nWPo=0j2MSpjBjAqegyg@mail.gmail.com>
References: <20130105230303.GA5195@sigill.intra.peff.net>
	<1357510179-22852-1-git-send-email-apelisse@gmail.com>
	<7vip78izir.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 21:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsJFh-000086-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 21:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205Ab3AGUYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 15:24:37 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:65262 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab3AGUYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 15:24:36 -0500
Received: by mail-ea0-f177.google.com with SMTP id c10so7785769eaa.8
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 12:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Hvj8+B1bE4ieGAM39dUcpZ8QjeCxOwXIJ7dTa40dEJ8=;
        b=PrRk4z1B9LOMvxoZPCorgCSc11yUScv4SKdXGrhIA6jnRb3w3NPfEFGsbXRME1rsx+
         wpBQRScQfi2vMqmrrL7v9Bxz6GDKwJaft9Zosx3OpXO3omvwff+0HHtz9mg+UXC0D1dw
         hxWDmoSD3zSBYYVO62ozzsfPe4fbxURwRsndLk1V71LcfZD0158T2r5JpH2jlZIAWRRi
         CLgBUxPHvJ2i5QL9kH7cUcePyj/dMlhBaEsmt+spQpE853h1wEDz9xd6LoOEXnYsWkX6
         ME7TSizt1qjpCqpdpgJWUjFOxGlqif7lHbsSrII6FpVtkbmxUQQ3g1mGtJGa2JHKASLs
         IPTw==
Received: by 10.14.206.197 with SMTP id l45mr168312680eeo.17.1357590275521;
 Mon, 07 Jan 2013 12:24:35 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Mon, 7 Jan 2013 12:24:35 -0800 (PST)
In-Reply-To: <7vip78izir.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212917>

> Here is my attempt...
>
>     When enumerating paths that are ignored, paths the index knows
>     about are not included in the result.  The "index knows about"
>     check is done by consulting the name hash, not the actual
>     contents of the index:
>
>      - When core.ignorecase is false, directory names are not in the
>        name hash, and ignored ones are shown as ignored (directories
>        can never be tracked anyway).
>
>      - When core.ignorecase is true, however, the name hash keeps
>        track of the names of directories, in order to detect
>        additions of the paths under different cases.  This causes
>        ignored directories to be mistakenly excluded when
>        enumerating ignored paths.
>
>     Stop excluding directories that are in the name hash when
>     looking for ignored files in dir_add_name(); the names that are
>     actually in the index are excluded much earlier in the callchain
>     in treat_file(), so this fix will not make them mistakenly
>     identified as ignored.
>
>     Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>     Reviewed-by: Jeff King <peff@peff.net>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>

I like it a lot, thanks to both of you
