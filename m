From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] refs: document transaction semantics
Date: Thu, 25 Feb 2016 15:10:13 -0500
Organization: Twitter
Message-ID: <1456431013.18017.50.camel@twopensource.com>
References: <CACsJy8DDVbz9LnX5HM_2HB+uDvqzS7LU=12gxhxJFqYPHp0Tvg@mail.gmail.com>
	 <1456430746-5565-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 21:10:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ2Ex-0008Kq-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 21:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933644AbcBYUKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 15:10:18 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33960 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcBYUKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 15:10:16 -0500
Received: by mail-qg0-f54.google.com with SMTP id b67so49184135qgb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 12:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=z1XnD+N4LZLkEkXJN90r9f263brAs0UhrmLeP+hpRUc=;
        b=RO0l870ZmF3hIUjMZdMlYQvUz2A0xTLLZAHe8J68Z6auJBDK179mXxsAX++sHY8ygV
         BbViH28Zz2RxRblpTWg0/dGpXc+BmyM01ZtT9ZJeM6q1UwPU2yHUHoSDvcGrwPC/h6VZ
         C9pTvsf+QcCYF89ut2X6MRfTPeE3vgKGMT5Gum3RucF/Y163oJgH7JXJ1boWE0LuH34s
         jQMIfrtbmjcdH8NA3gMx2x1Q2LUP3oYc+F2JKo6rshF/O89CebJrN/pMPmLaVylfPlTj
         k19NnyVYFCa8wfDedusedORrDQItU5KwtnNHsrqOpyKwApZkwA5SVghP1QkmjgY/KxJ1
         dI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=z1XnD+N4LZLkEkXJN90r9f263brAs0UhrmLeP+hpRUc=;
        b=eWUGAsPhlCiRpCGLuWwBmiu5SIb++5bywMeA2sq4kYhhJkP/2DjArcKejLVulVZIo1
         aJw2f6yHBuIb+I45Mf+VjnHTA/A7fEiRPR/iZDkIJpDhCfG7ZwrZqER1vcC3V/mpXbza
         /R9LQzWLEu2hyxclxiNuhvbgBMFVRJQ6W+4/5onGh1wa9/SWC7T9V93Zh3WA9Aaazk6+
         vwVKCSCcsl3N7t7hsS51hsPscTzsFvyeKC4zNGUKWCl92NzBtwhDuyG4b1oRXM1E+ai1
         dmClEsFJ+iguIGvBFsQdwfxfx6rb+FzRYnKg2UWM8te6pMAEpbuzAU2rGUA7IGQIDhMF
         JkoQ==
X-Gm-Message-State: AG10YOQD38OYMaBdERr6ZmtrURgedhc3Ait35OQKI0zoesiV1Eb1kYPKRVZ+KYB9yJFwkg==
X-Received: by 10.140.232.211 with SMTP id d202mr61907863qhc.27.1456431015565;
        Thu, 25 Feb 2016 12:10:15 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b6sm3955797qkh.12.2016.02.25.12.10.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 12:10:14 -0800 (PST)
In-Reply-To: <1456430746-5565-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287428>

I thought it would be better in the api docs, since it's a design
decision that all backends should follow.

On Thu, 2016-02-25 at 15:05 -0500, David Turner wrote:
> Add some comments on ref transaction semantics to refs.h
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/refs.h b/refs.h
> index c0964f5..9b3eaf3 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -112,6 +112,11 @@ extern int dwim_log(const char *str, int len,
> unsigned char *sha1, char **ref);
>   *   If this succeeds, the ref updates will have taken place and
>   *   the transaction cannot be rolled back.
>   *
> + * - Instead of `ref_transaction_commit`, use
> + *   `initial_ref_transaction_commit()` if the ref database is known
> + *   to be empty (e.g. during clone).  This is likely to be much
> + *   faster.
> + *
>   * - At any time call `ref_transaction_free()` to discard the
>   *   transaction and free associated resources.  In particular,
>   *   this rolls back the transaction if it has not been
> @@ -127,6 +132,13 @@ extern int dwim_log(const char *str, int len,
> unsigned char *sha1, char **ref);
>   *
>   * The message is appended to err without first clearing err.
>   * err will not be '\n' terminated.
> + *
> + * Caveats
> + * -------
> + *
> + * Note that no locks are taken, and no refs are read, until
> + * `ref_transaction_commit` is called.  So `ref_transaction_verify`
> + * won't report a verification failure until the commit is
> attempted.
>   */
>  struct ref_transaction;
>  
