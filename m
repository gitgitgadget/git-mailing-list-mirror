From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 14/14] lockfile: make 'unable_to_lock_message' private
Date: Wed, 3 Dec 2014 12:42:27 -0800
Message-ID: <20141203204227.GA26810@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203052734.GX6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:42:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwGkt-0007JM-0I
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbaLCUmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:42:31 -0500
Received: from mail-ig0-f201.google.com ([209.85.213.201]:63452 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaLCUma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:42:30 -0500
Received: by mail-ig0-f201.google.com with SMTP id h15so1811034igd.4
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wxdz3VbexpJBttpVMOuemhFZrNticLP2q2gi64rBkAU=;
        b=BC1SdSooZZTZvx+R59cy9u8TjnLzEs+RN5+h3HwiuLAxOm691UIudhQnmQ2vQ3w9Nw
         6tjcUbtpMvFucJwWf4GVaUnLFBEdjkSPFUu5CMFMGmymZC0UshNCr3ddId0TcDzr/Sso
         NUp6XtSlSnU6LPWKCuFedbQP1tUvX8+VUjSrYflgvaaT3Lf7xAwEw1As9sKCXhKeHGKJ
         JES0oaqiJ/vFuSGKPT9xlEguuJ9O+9At/a8ZXGsLnLilL+1amZshqtvdjyJ4XSgZ3YJa
         5iWFWJ+0nSb9zOwEZXwysvySIs8EmUFSg8oO5wjGmvO+VvmbEhGOCKyZXqR9EyF4Oz4p
         Qwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wxdz3VbexpJBttpVMOuemhFZrNticLP2q2gi64rBkAU=;
        b=FXpzfAw+7RW4FxFsxmqLA1roGk/LL9arbgklLVe5EwOlWUMVX7Mw2GwYaEplk+tX+8
         PV/vb0qXeX4C1syq3x1EcGQHYt+t/Spyx3Z0mD155H84zJjAMwlQkekHyRXcxkXEO3YF
         bRs8ADFH+h+jwa4kYhF4LrAAldKPwvSR3brSQEbQ+VDD35DLBBGR8iV+f6kOUjqZt5iP
         Z9Ytrs3X7Y0qMsQJSztRI+Z1ukk6c1Eq20e68tce9eOHj++gE6wH45yb6lacw21+h6me
         e62eFfA5M8RPXq5ivwm/q53gGcASA5a/AieRm7o7V00pWEiXh7o06yGJxsq9JUZ0w9+O
         Dp5Q==
X-Gm-Message-State: ALoCoQmUH7q0X5saHfd74/odbMOs4haVfU7YdQldyyCHFGr4cHXWBh+JVgOT0gFTRwOTyI38v+px
X-Received: by 10.43.126.9 with SMTP id gu9mr10117030icc.11.1417639349230;
        Wed, 03 Dec 2014 12:42:29 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id r6si1029046yhg.1.2014.12.03.12.42.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2014 12:42:29 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id dgwH8kG4.1; Wed, 03 Dec 2014 12:42:29 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 212E21411A0; Wed,  3 Dec 2014 12:42:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141203052734.GX6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260690>

On Tue, Dec 02, 2014 at 09:27:34PM -0800, Jonathan Nieder wrote:
> The old external callers now use the message passed back by
> hold_lock_file_for_update / hold_lock_file_for_append instead of
> trying to interpret errno.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> That's the end of the series.  Thanks for reading.
> 
> Thoughts?

I reviewed the whole series and seems fine with me.

> 
>  lockfile.c | 42 +++++++++++++++++++++---------------------
>  lockfile.h |  2 --
>  2 files changed, 21 insertions(+), 23 deletions(-)
> 
> diff --git a/lockfile.c b/lockfile.c
> index 8d8d5ed..7121370 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -98,6 +98,27 @@ static void resolve_symlink(struct strbuf *path)
>  	strbuf_reset(&link);
>  }
>  
> +static void unable_to_lock_message(const char *path, int flags, int err,
> +			    struct strbuf *buf)
> +{
> +	if (err != EEXIST) {
> +		strbuf_addf(buf, "Unable to create '%s.lock': %s",
> +			    absolute_path(path), strerror(err));
> +	} else if (flags & LOCK_OUTSIDE_REPOSITORY) {
> +		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
> +		    "If no other git process is currently running, this probably means\n"
> +		    "another git process crashed earlier. Make sure no other git process\n"
> +		    "is running and remove the file manually to continue.",
> +			    absolute_path(path), strerror(err));
> +	} else {
> +		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
> +		    "If no other git process is currently running, this probably means a\n"
> +		    "git process crashed in this repository earlier. Make sure no other git\n"
> +		    "process is running and remove the file manually to continue.",
> +			    absolute_path(path), strerror(err));
> +	}
> +}
> +
>  static int lock_file(struct lock_file *lk, const char *path,
>  		     int flags, struct strbuf *err)
>  {
> @@ -149,27 +170,6 @@ static int lock_file(struct lock_file *lk, const char *path,
>  	return lk->fd;
>  }
>  
> -void unable_to_lock_message(const char *path, int flags, int err,
> -			    struct strbuf *buf)
> -{
> -	if (err != EEXIST) {
> -		strbuf_addf(buf, "Unable to create '%s.lock': %s",
> -			    absolute_path(path), strerror(err));
> -	} else if (flags & LOCK_OUTSIDE_REPOSITORY) {
> -		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
> -		    "If no other git process is currently running, this probably means\n"
> -		    "another git process crashed earlier. Make sure no other git process\n"
> -		    "is running and remove the file manually to continue.",
> -			    absolute_path(path), strerror(err));
> -	} else {
> -		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
> -		    "If no other git process is currently running, this probably means a\n"
> -		    "git process crashed in this repository earlier. Make sure no other git\n"
> -		    "process is running and remove the file manually to continue.",
> -			    absolute_path(path), strerror(err));
> -	}
> -}
> -
>  int hold_lock_file_for_update(struct lock_file *lk, const char *path,
>  			      int flags, struct strbuf *err)
>  {
> diff --git a/lockfile.h b/lockfile.h
> index b4d29a3..02e26fe 100644
> --- a/lockfile.h
> +++ b/lockfile.h
> @@ -71,8 +71,6 @@ struct lock_file {
>  #define LOCK_NO_DEREF 1
>  #define LOCK_OUTSIDE_REPOSITORY 2
>  
> -extern void unable_to_lock_message(const char *path, int, int err,
> -				   struct strbuf *buf);
>  extern int hold_lock_file_for_update(struct lock_file *, const char *path,
>  				     int, struct strbuf *err);
>  extern int hold_lock_file_for_append(struct lock_file *, const char *path,
