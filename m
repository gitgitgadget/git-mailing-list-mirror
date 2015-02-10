From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/8] write_ref_sha1(): remove check for lock == NULL
Date: Tue, 10 Feb 2015 14:52:23 -0800
Message-ID: <CAGZ79kbCHAS3kbF_rwiGFxNCG1movygkcyOddELM7ikOM+wKBQ@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 10 23:52:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLJfQ-0003fR-Ti
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 23:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbbBJWwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 17:52:25 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41879 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbBJWwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 17:52:24 -0500
Received: by iecrd18 with SMTP id rd18so16549963iec.8
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 14:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MonJPIgiemRq+oAeKFPk9ta+qHJ7jGAGVUQK/B/ggBw=;
        b=EFsM7uiVxam1vLVSI+ODUUER+W3Dnmggp7tnDEdM/SecaCulVXnqYFjU4dSb4TRJMt
         KR5rX5hV6qOZ+b3ApQIFxFrAFXt6V5N766cBsQ8o73jcjfdTdlCMXSCjKjAeVKflZOat
         YF0RUpDbrjioQd6ZJ1PBWGPhy7CLDODyrie1e27D6nSDv11RUIzVTf5uOm0WpGKGK4be
         va+VRQWkd1sOYyfzV5oKJxkynCDssfx4d0o6ZPZPWTeiQFnqB5LxbAMA0HQhHk0DWwZl
         Wbs4zVh4MNgH8b6W60J3BIlJ812AFDE/pUKh7EiNeOaeOm4Ze+D5sQaq7Obp2GHWVVJD
         JMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MonJPIgiemRq+oAeKFPk9ta+qHJ7jGAGVUQK/B/ggBw=;
        b=dEA3Plo0S+PADSw2RjX/MNVjIbAJfTYje104Bk5bPLGLf4lsX3934STu8vhDfygFLm
         CC3AlDoaE0eoi9KFNaC5EyZ61r2LQ+yZq2wBdNExgwRLqkXktMz/1bwiLykCDHMbWSVq
         WaLSB2uHcIOAHr32wD2GXlsqdYzHEeq8En+6IK40L1THYgor2o7an2ClsYwT+4XTY5qA
         aB9aS/kev38kI7sJZB1QSzkthQmXoY/94viIrTHgHr4o7iOnrNXA7IJvPHu3Cr4KC461
         zQr0rDCDmhwzM9BOv1ht+OEPY+Wn1E+fp71oE2rUuaf0sb5qcBuNpLRagF8OfhwdalW8
         6ujw==
X-Gm-Message-State: ALoCoQnxjtg1gJ09kq7DNvLO+g3VcjnGIkIAgkHAH6SZAKsSlQRzl+B/RNGMKW4j+9Ge94SVVRbG
X-Received: by 10.50.85.44 with SMTP id e12mr106120igz.48.1423608743477; Tue,
 10 Feb 2015 14:52:23 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 10 Feb 2015 14:52:23 -0800 (PST)
In-Reply-To: <1423473164-6011-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263657>

On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> None of the callers pass NULL to this function, and there doesn't seem
> to be any usefulness to allowing them to do so.

Usually I'd oppose this change, as it seems to be a good defensive
measure. (I cannot assume future me or anybody knows what they're
doing), but as this function (write_ref_sha1) is not widely exposed
any more since aae383db8 (Apr 28, refs.c: make write_ref_sha1 static),
I think it's safe to assume changes affecting this call are well
understood in the future.

so
Reviewed-by: Stefan Beller <sbeller@google.com>

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index c5fa709..d1130e2 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3080,10 +3080,6 @@ static int write_ref_sha1(struct ref_lock *lock,
>         static char term = '\n';
>         struct object *o;
>
> -       if (!lock) {
> -               errno = EINVAL;
> -               return -1;
> -       }
>         if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
>                 unlock_ref(lock);
>                 return 0;
> --
> 2.1.4
>
