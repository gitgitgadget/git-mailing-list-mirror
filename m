From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 04/16] refs: add do_for_each_per_worktree_ref
Date: Fri, 11 Dec 2015 19:01:50 -0500
Organization: Twitter
Message-ID: <1449878510.1678.7.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-5-git-send-email-dturner@twopensource.com>
	 <xmqqio44czm1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 01:01:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7XdN-0004d4-Q2
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 01:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbbLLABx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 19:01:53 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36282 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbbLLABw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 19:01:52 -0500
Received: by qgfb51 with SMTP id b51so5226055qgf.3
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 16:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=uxZ2jmRO+8RGzyJHhUk3f25rlKyREGvzl4MqFMBIxIE=;
        b=NZUt9y98EEpUyY61GOXrNxoWw1L32mTyahPvnYeO86Di2vgWXz8e2+DhRZGyQHBzjU
         0eSfQMgjEO8lIOEBePGP90cyjESdktIeeuzJhypcWzO3kHLnmXmapXo+KWkJhzTDk03r
         iUtKPx0YeqXk32mqkmV2CUCJVCc+tPg33RXSWQiqB2foZZicP2Jfe6//28UA/nNT7Loa
         W/LaCh6fGQE41W0H7/TZACJ69ZcsBv910NfFkNuxm3/hdeLIK36Ea1DOnqaYU0eIXCvW
         18qh6r2AQkM+opVWCplNR4u6h+w2o3JugRBr03KYunvn/lpM16UxxLuyHZtmuzgjJfSP
         dU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=uxZ2jmRO+8RGzyJHhUk3f25rlKyREGvzl4MqFMBIxIE=;
        b=UhGv8+LQqbQySUVGXdxvXtamnlSJhNCQ6uORg9M62n4jstQrTev3ff04ZwOpAfrXPJ
         Soxb6pua+CkcUUNnNznfkP7QT7hjswLUpZaxGH3BghJKlUc24LqQGwUNXjjQiEQKmf0+
         N1w80kZlKlBGv7CXzAtRxx/s/dSsEE9ZqCWoAG4b613YlH70z1VOcSapiF+6phFt0/n9
         NYzbQHJ3Ulq9N2OeGw+tI3i7e3v/Z5+Maz6nzJMDTsSZT/R31ScIFocvNggnZdnrxWOt
         vUcRfoM0jpB/prDZ4Se5DrYchPrJcWPd74HRmG6KJkVEMxtMPNUtvv3vKF4PblNhO1Sz
         FpLQ==
X-Gm-Message-State: ALoCoQkHUSYrmqticd7d7qXQATYn+VyKv2DImMFFGiwk1XwrAbig2AS6OPnYkZ9nwubTaGx/k3vG20o/fQYV5LCpadKiy3GWDA==
X-Received: by 10.141.4.4 with SMTP id g4mr19132694qhd.45.1449878512166;
        Fri, 11 Dec 2015 16:01:52 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id y7sm9199832qky.4.2015.12.11.16.01.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 Dec 2015 16:01:51 -0800 (PST)
In-Reply-To: <xmqqio44czm1.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282291>

On Fri, 2015-12-11 at 15:52 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Alternate refs backends might still use files to store per-worktree
> > refs.  So the files backend's ref-loading infrastructure should be
> > available to those backends, just for use on per-worktree refs.  Add
> > do_for_each_per_worktree_ref, which iterates over per-worktree refs.
> 
> Is this "might still use"?  I am instead getting an impression that,
> we are declaring that the recommended way to store per-worktree refs
> is with filesystem backend.
> 
> Not complaining against either such a design decision (if that is
> what is made here) or the above description in the log message--just
> want to understand the intention better.

I'm not super-happy with the notion of splitting data across backends;
it's a bit messy.  I've resigned myself to it because it seems like the
simplest way forward in the presence of per-worktree refs.  But I
figured the message could leave it open in case we change our minds.

> I also wonder if it is cleaner to have a single interface that lets
> anybody ask a pointer to the backend struct by name.  With such an
> interface, a new backend that wants to delegate per-worktree refs to
> files backend could
> 
> 	static int DB_for_each_ref(...)
>         {
> 		struct ref_be *files = locate_ref_backend("files");
> 		files->for_each_ref(... | WORKTREE_ONLY, ...);
> 		... do its own enumeration of non-per-worktree refs ...
> 	}
> 
> and such a delegation does not need to be limited to per-worktree
> iteration.
> 
> Or is that a road to expose too much implementation details of
> a backend to other backends?

Given that the files backend is special in terms of its rights and
responsibilities, I think it's OK to just refer to it directly.  I think
allowing backends to generally pick and choose bits from other backends
would be confusing.
