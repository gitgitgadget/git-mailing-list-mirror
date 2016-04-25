From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 19/33] refs: allow log-only updates
Date: Mon, 25 Apr 2016 12:46:54 -0400
Organization: Twitter
Message-ID: <1461602814.25914.4.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-20-git-send-email-dturner@twopensource.com>
	 <5718E0FC.7090501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 25 18:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujf3-0006Ow-B3
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbcDYQq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 12:46:57 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33747 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686AbcDYQq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:46:56 -0400
Received: by mail-qk0-f169.google.com with SMTP id n63so65057406qkf.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hDfexd0zpNA/D+2J0Ycu0oVHzX49PpVkd6kk0h3qkn4=;
        b=CNbLnV4ZcqNgCfF3pzi2mWy92zsNB6MzUwfPBOXNKPmFX4guoB8qPMoSTuUzUUCiBJ
         /Zz5LceZkbeqhOkdzvonMogIHIkWG3jIkdSAuJ/Mh1MTl8wBeoAwKaoZSWs9v1HH9Wwt
         lm/EsLa/HWZwwBKC7cDWFaWMtc7l/TUxlMW/E/Vqwz47jycdD6vM1Ess1VFZM3DOEaE8
         x6+TcJFQRECXUboh0+KDGzr9hPlj1wWbEoNKVt/LzrBUWU5E5V3oRe6XRhCdM0zj27kQ
         BlRWYLfMEICSzUNl/m1VhjNoxdw65vRZANgWD1aye5+8BXSfoi31wDfULTHWhlRuqxwU
         SUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hDfexd0zpNA/D+2J0Ycu0oVHzX49PpVkd6kk0h3qkn4=;
        b=BHI2hgm+GZtvrCWfXlNznE4n/hwgnrfwDaB9Wu7C7SfClHy+LSrIkmuVhOzrBD3gEL
         YMIWyt9QbQgcDtiRzKhxyY9vUAXj1Y6QhiL7iRSAob0OcEC7VPHvtg8zBW3B76VoCEs2
         kYot8LitlvAIRF91tKsqAunbnwf+ZpIrkheVJjUp4Degvx0e+WeEEzRj+nhIxD8t6dUv
         KMnJaR7XU6FlULnVAIS3ajDxdxq+T1egSCQywnMEVMZff5HauP0nBy7T8lBZvNJFrgI5
         jmjvpEwZVxqi+b3cxT7HCx8Tt+xZcABqTB3WCQM4V35/SJ7YIW9BaZImbiFc0tzhsal9
         M3xw==
X-Gm-Message-State: AOPr4FWLaPMAHKPYRsDIuNo0QmfDd6GnoehqpNaHlBmXUj1VFyQE5x8Xe7RGSX5zsyL8rg==
X-Received: by 10.55.71.76 with SMTP id u73mr39391677qka.6.1461602815946;
        Mon, 25 Apr 2016 09:46:55 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id f91sm7443618qgf.4.2016.04.25.09.46.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2016 09:46:55 -0700 (PDT)
In-Reply-To: <5718E0FC.7090501@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292512>

On Thu, 2016-04-21 at 16:17 +0200, Michael Haggerty wrote:
> On 03/01/2016 01:52 AM, David Turner wrote:
> > The refs infrastructure learns about log-only ref updates, which
> > only
> > update the reflog.  Later, we will use this to separate symbolic
> > reference resolution from ref updating.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  refs/files-backend.c | 15 ++++++++++-----
> >  refs/refs-internal.h |  7 +++++++
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 1f565cb..189b86e 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -2702,7 +2702,7 @@ static int commit_ref_update(struct ref_lock
> > *lock,
> >  			}
> >  		}
> >  	}
> > -	if (commit_ref(lock)) {
> > +	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
> >  		error("Couldn't set %s", lock->ref_name);
> >  		unlock_ref(lock);
> >  		return -1;
> > @@ -3056,7 +3056,8 @@ static int files_transaction_commit(struct
> > ref_transaction *transaction,
> >  			goto cleanup;
> >  		}
> >  		if ((update->flags & REF_HAVE_NEW) &&
> > -		    !(update->flags & REF_DELETING)) {
> > +		    !(update->flags & REF_DELETING) &&
> > +		    !(update->flags & REF_LOG_ONLY)) {
> >  			int overwriting_symref = ((update->type &
> > REF_ISSYMREF) &&
> >  						  (update->flags &
> > REF_NODEREF));
> >  
> > @@ -3086,7 +3087,9 @@ static int files_transaction_commit(struct
> > ref_transaction *transaction,
> >  				update->flags |= REF_NEEDS_COMMIT;
> >  			}
> >  		}
> > -		if (!(update->flags & REF_NEEDS_COMMIT)) {
> > +
> > +		if (!(update->flags & REF_LOG_ONLY) &&
> > +		    !(update->flags & REF_NEEDS_COMMIT)) {
> 
> I was just going over this series again, and I think this hunk is
> incorrect. If REF_LOG_ONLY, we created and opened the lockfile. And
> we
> didn't call write_ref_to_logfile(), so the lockfile is still open.
> That
> means that we want to call close_ref() here to free up the file
> descriptor. (Note that close_ref() closes the lockfile but doesn't
> release the lock. That is done further down by unlock_ref().)
> 
> So I think this hunk should be omitted.
> 
> I realize that this patch series is obsolete, so there is no need to
> re-submit. I just wanted to get a sanity check as I implement a new
> version of this patch that I'm not misunderstanding something.

I think your logic seems sound, but if you're going to change this,
please make sure tests still pass -- as you know, this area is
something of a minefield.
