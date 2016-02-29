From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Mon, 29 Feb 2016 16:57:42 -0500
Organization: Twitter
Message-ID: <1456783062.18017.65.camel@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
	 <20160227035634.GA10829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:57:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVp7-0004oC-D8
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbcB2V5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:57:46 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34388 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcB2V5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:57:44 -0500
Received: by mail-qk0-f171.google.com with SMTP id x1so62293681qkc.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 13:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=3zPpfA8vJTcIMH2up9+Ll4gV2lC8U1QPBh06qXfSBlQ=;
        b=SrPoeNeMecfk+hoSLS2xazxokY0VI6nYcayUN0hZWi3AbwMeEcJMYKLPgVNcDD3eVd
         tWnjfK1YObBlmJAzPFiHPu/sZaq8BnmfRSFu3777mCHgqq1abolAyJnH8/cxZPFqR6dU
         Cp5P3FiYXo+Pxo+TY6OnP5aqGhJ4hTopmQywKq3T7HAjU5auvRbKaklWhv0ONhWDu7Mo
         +X/bJykDAXbuBL49G0eRqKZoFRyn6NS2wf8MlcDixWGGGSzGn0aeF8JkwTLD9MF66DFn
         kOEQUtRuPaBz3fLm2V8/o9I+DCh1e6c01j1QsMuKJKgw7rWvPIereIfEO+y1PUo00tWD
         46iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=3zPpfA8vJTcIMH2up9+Ll4gV2lC8U1QPBh06qXfSBlQ=;
        b=JrKOQwnSMbhxAkNJezu27Jn8sBNUw0S0sRAS3aCxfoaTcmab2GPspRhI9fCBh5LXOS
         BOP7V9UYzWu0pJBg3gBC9xAhlLt7f5lGkYqVO3GXpeJghI/ol82lF6JFMEz1smzieKil
         ZyiZh7b6VlyJiFXnJUp/UMWC6iSr4JX/awvqlSHReUaWjZgR42bFSWq6z4alSyawzU46
         cFSaa+EKr44bjYTsz0DRRbSbVI/g3iJkiilH6/EdJATs3qnH/D4CH1psJUQKok3Q4b1O
         laZMA2JXeV0h3ia/Ro9pe5P3OxvMhrj48++UAjHrxkVIfqi9ZNxLkKdgfOhRWDoYn9H6
         KPcA==
X-Gm-Message-State: AD7BkJKUdUOKci3mTctFuCNWQ8gd11+moqs+WY+LbAoUtoDp30fbGk2z4w4jn2E0J3bZ8g==
X-Received: by 10.55.82.70 with SMTP id g67mr22340832qkb.57.1456783063984;
        Mon, 29 Feb 2016 13:57:43 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b6sm11874081qkh.12.2016.02.29.13.57.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 13:57:42 -0800 (PST)
In-Reply-To: <20160227035634.GA10829@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287916>

On Fri, 2016-02-26 at 22:56 -0500, Jeff King wrote:
> On Wed, Feb 24, 2016 at 05:59:00PM -0500, David Turner wrote:
> 
> > @@ -1207,6 +1208,29 @@ int git_config_early(config_fn_t fn, void
> > *data, const char *repo_config)
> >  	}
> >  
> >  	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
> > +		char *storage = NULL;
> > +
> > +		/*
> > +		 * make sure we always read the ref storage config
> > +		 * from the extensions section on startup
> > +		 */
> > +		ret +=
> > git_config_from_file(ref_storage_backend_config,
> > +					    repo_config,
> > &storage);
> > +
> > +		register_ref_storage_backends();
> > +		if (!storage)
> > +			storage = xstrdup("");
> > +
> > +		if (!*storage ||
> > +		    !strcmp(storage, "files")) {
> > +			/* default backend, nothing to do */
> > +			free(storage);
> > +		} else {
> > +			if
> > (set_ref_storage_backend(ref_storage_backend))
> > +				die(_("Unknown ref storage backend
> > %s"),
> > +				    ref_storage_backend);
> > +		}
> > +
> 
> Coverity complains that "storage" leaks here, and I think it does in
> the
> case that we non-default storage, and we successfully set up the
> backend. That's a pretty minor point.
>
> However, after looking at this code, I'm rather confused about a few
> things.
> 
> One is that we read the config and use ref_storage_backend_config[1]
> to
> store the string value in "storage", and then we check whether that
> is
> non-default, and if it is, I'd expect us to feed it to
> set_ref_storage_backend. But we don't; we feed ref_storage_backend
> instead!
> 
> What is that value? It looks like it is the string we set in
> check_repo_format when we load the extensions list there. So why
> are we re-reading the config here at all? Couldn't we just use
> ref_storage_backend in the first place?
>
> My second confusion is why this is happening in git_config_early().
> That
> function is called during the setup of
> check_repository_format_gently(),
> which is why I think you wanted to put the code here. But it's _also_
> called as part of a regular git_config(). Which means we're parsing
> the
> repo config and setting the ref backend all over again, every time we
> look at config for other reasons.
> 
> So I think this setup probably should be in
> check_repository_format_gently(), and should be able to trigger off
> of
> the existing ref_storage_backend string we've already saved (and we
> should bail immediately there if we don't know about the backend, as
> it
> means we _don't_ match the repo's extensions and cannot proceed).

We apparently don't always call check_repo_format before calling
git_config_early -- or, more to the point, before doing ref operations.
So I think we need this in git_config_early.

I'll fix up the memory safety/leak issues tho.
