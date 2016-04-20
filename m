From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 03/15] index-helper: new daemon for caching index and
 related stuff
Date: Wed, 20 Apr 2016 15:38:57 -0400
Organization: Twitter
Message-ID: <1461181137.5540.167.camel@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
	 <1461108489-29376-4-git-send-email-dturner@twopensource.com>
	 <alpine.DEB.2.20.1604201349590.2826@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 21:39:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asxxp-0005Zs-Js
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 21:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbcDTTjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 15:39:03 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35302 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcDTTjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 15:39:00 -0400
Received: by mail-qk0-f181.google.com with SMTP id q76so7996338qke.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=RjddEzkWA/nG6caeZ4+wntvVgM/CLAU//K7ucj1zBdo=;
        b=kaljQM86evs+BNW64+bELzi6o5KRuIZdrrM8ZojQD7Io1a5vdW3JFWK8p28DDWPMOl
         gmpVN5ZiSNwrRFki5HxUqX/A0cQ8HybXq/FknE0k2D0z/d+O5v0a9/HiAWycQDNS73l8
         18Cs94oTiGocht13I78dzILZTIkykObpJ95acxz6s7DCkX7BUUJ7mLS2hgXv3HyC5fVy
         sCz4zlAPt0FQmrDuEjBCUefttBzE/LaiAh+xf/0J5AmMoJ0emxWpwwVpaGN1yDTydIRC
         H9Y92Q4v3MaseqLy0x92tKTkpwzD+/5HQLRPgm681Q7h4WZLe+OUa/wlpvle88An3tiq
         +a2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RjddEzkWA/nG6caeZ4+wntvVgM/CLAU//K7ucj1zBdo=;
        b=cLQ33rVJPh2F2fZm9lXaAvmVqbuYfPQgWXJVwXEDBW1NgY3GAPKqrI52aGoWXTI//M
         EQHENaR/vRxYrM0LfXfkIipSLCA5xPBhP6DlEvLwBZb4zz2VyRUk0zaWYMGScJGuHvPj
         n0s/8VT5hwZUpZYUw483ntChpVModVS/k8DGVHSALK54JHfM3ChjoOjXHrxfow49wQM4
         BSPC5MJA9obRwNl2kMNRMnSHNcYO0vcaJkBaNram8IC7SajYLBknTJR6grBKhnzsEmzy
         ZPaZVErI0a9ZQbqqg6ObqBsNgLn2iSzywXw6ZZQfyTONxYXbTOd4aDWaSts3nZaaIccQ
         po/g==
X-Gm-Message-State: AOPr4FVu096dxYqprNrcwA0cVWsICLfGW3BDmBfjUqsBkHzVxQJZK1jH7C2Ot8/ewDeKAw==
X-Received: by 10.55.71.146 with SMTP id u140mr13999905qka.14.1461181138857;
        Wed, 20 Apr 2016 12:38:58 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id x189sm31780713qhb.43.2016.04.20.12.38.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Apr 2016 12:38:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604201349590.2826@virtualbox>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292061>

On Wed, 2016-04-20 at 14:17 +0200, Johannes Schindelin wrote:
> Hi Dave,
> 
> (apologies in advance if I may bring up anything that has been
> discussed
> in earlier iterations; I simply was too busy with the rebase--helper
> project to even look.)
> 
> On Tue, 19 Apr 2016, David Turner wrote:
> 
> > Shared memory is done by storing files in a per-repository
> > temporary
> > directory.  This is more portable than shm (which requires
> > posix-realtime and has various quirks on OS X).  It might even work
> > on
> > Windows, although this has not been tested. The shared memory
> > file's
> > name folows the template "shm-<object>-<SHA1>" where <SHA1> is the
> 
> s/folows/follows/

Will fix, thanks.

> And: now that it is no longer shared memory, should we not do away
> with
> the "shm-" prefix?

Hm.  It's intended to be shared via MAP_SHARED.  So it is just a "disk
-backed" shared memory object instead of a POSIX shm object.

> > +	if (*new_mmap == MAP_FAILED) {
> > +		*new_mmap = NULL;
> > +		goto done;
> 
> Shouldn't we provide some sort of error message here?

We generally try to fail silently on index-helper failures -- the user
isn't necessarily expecting output at that point, and we can always
fall back to directly reading the index.

On the other hand, this error should pretty much never happen, so maybe
it's worth calling out?
