From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Mon, 29 Feb 2016 16:57:49 -0500
Organization: Twitter
Message-ID: <1456783069.18017.66.camel@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
	 <20160227035634.GA10829@sigill.intra.peff.net>
	 <20160227041416.GA11604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:57:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVpE-0004sg-QM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbcB2V5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:57:52 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34705 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcB2V5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:57:51 -0500
Received: by mail-qg0-f51.google.com with SMTP id b67so127544030qgb.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=dm4rjxnUMc2Ukr8Zlf5cP7IIN8+sF5hH/M+qLoH1Nsk=;
        b=xzPH10jlu/1XZqD0yGw6rRwsJJ25tu67UjShF2nPhqZkBBdJDcp0euz1KiCFIdP5VO
         XLGKPBHJS3B7YxNBSVTda6thBH+0BjsFmCfNOn/keAXyHIep79KAcxYwk1rA9hMys27W
         rGTaxGueBUhhqYyKF3/FaEs31vKA478JLtMuFJHfZLLhZqwzFeC8oeSPKRrrlQv+JOt+
         f/dA7f/35ZIx/r7mqLBtOiD5cEKcibnCbtJuwt8qYJtOn1pZOEM14tH67yldhi85if/b
         +zt80v5S/mzHAFfjzI5Bs6SgDGpJoZtnMYEXqWo8VbhEMLNq6W6KE30y/f0zEP2r9AGV
         jDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=dm4rjxnUMc2Ukr8Zlf5cP7IIN8+sF5hH/M+qLoH1Nsk=;
        b=VBjqXPcDhoKzCx9MrpizOgQNa5yRZ+o5uZkEYyrAyDC2REGcXNNb7Ax+DHo9zPQqSU
         srexLfnQo3twRyDmZwqHv0eJgYPjpXJeL7dwA1zFPBGQL0JNZe5Cj3KwhAsV4loN+P6Q
         5vx1jXppZl8LecHx8bjzukhekqrJj1WtTmdgw2LvdYRGddDxwHulw6TrKcdR5SiHUPHX
         6C6qns3b0rPDmw2KGjWyvK72QDjh8y2PWPHuG/t6kE7/LjX85x5wlWsDPWwV8kuho95e
         Lyg1k07EmbwwJqi8e5gjIC79cxZfCn7nFFD7CKf/IIE3xVIGAiC65P8nGgVfG4LiuWva
         /YJA==
X-Gm-Message-State: AD7BkJINsirH2V5B+pbp2LhUujKK5c0Z0S0ocmGfauadxbNENIjuSfSjAgCnX8226bcphQ==
X-Received: by 10.140.194.205 with SMTP id p196mr23988114qha.30.1456783071014;
        Mon, 29 Feb 2016 13:57:51 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p80sm11751831qge.0.2016.02.29.13.57.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 13:57:50 -0800 (PST)
In-Reply-To: <20160227041416.GA11604@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287917>

On Fri, 2016-02-26 at 23:14 -0500, Jeff King wrote:
> On Fri, Feb 26, 2016 at 10:56:34PM -0500, Jeff King wrote:
> 
> > My second confusion is why this is happening in git_config_early().
> > That
> > function is called during the setup of
> > check_repository_format_gently(),
> > which is why I think you wanted to put the code here. But it's
> > _also_
> > called as part of a regular git_config(). Which means we're parsing
> > the
> > repo config and setting the ref backend all over again, every time
> > we
> > look at config for other reasons.
> > 
> > So I think this setup probably should be in
> > check_repository_format_gently(), and should be able to trigger off
> > of
> > the existing ref_storage_backend string we've already saved (and we
> > should bail immediately there if we don't know about the backend,
> > as it
> > means we _don't_ match the repo's extensions and cannot proceed).
> 
> By the way, I notice that the default value for the_refs_backend is
> "&refs_be_files". It might be safer to make this NULL (or some
> &refs_be_null that fills the vtable, but just returns an error for
> each
> call).

In 'refs: register ref storage backends', I do make this change.  I
don't do it earlier because we don't have this config stuff in place
yet.  
