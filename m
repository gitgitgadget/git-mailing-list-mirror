From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/3] Re: [PATCH] vcs-svn: Fix some compiler warnings
Date: Thu, 2 Feb 2012 04:41:28 -0600
Message-ID: <20120202104128.GG3823@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
 <7vipjpzxav.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsu6x-0008MJ-LC
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035Ab2BBKlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 05:41:47 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:65271 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753447Ab2BBKlq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 05:41:46 -0500
Received: by obcva7 with SMTP id va7so2602372obc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R+KCR3q5g/ALHqbTLsQ3Y+1bGCNrby58cw5lJ6aQJes=;
        b=FukOmKoRE4PnqzDIUSfib3U5wTVEOPGlBSowV7pXRoj2s6V5YhNtt+GsHLwYR0jKME
         f+KrVPFRLHI5yCtfFZBw9HypQCEqGA05HAI03s0undkFprrWumIqzMGaLo1bv7DZeaz5
         ZAYVMKhMRd9lrXhFB8uwEHSyYcP4K+Vqmswqs=
Received: by 10.50.217.129 with SMTP id oy1mr3281658igc.4.1328179305941;
        Thu, 02 Feb 2012 02:41:45 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gw1sm6622045igb.0.2012.02.02.02.41.45
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 02:41:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vipjpzxav.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189618>

Junio C Hamano wrote:

> I'd hold the branch in 'next' for now, until this gets resolved (one
> possible resolution is to declare Ramsey's patch is good enough for now,
> and do the follow-up later).

Sounds sensible.  How about the following?  Intended to replace
Ramsay's patch.  Not well tested yet.

By the way, wouldn't the (p->field < 0) test in grep.c line 330
trigger the same compiler bug?

Jonathan Nieder (2):
  vcs-svn: allow import of > 4GiB files
  vcs-svn: suppress a -Wtype-limits warning

Ramsay Allan Jones (1):
  vcs-svn: rename check_overflow arguments for clarity

 vcs-svn/fast_export.c    |   15 +++++++++------
 vcs-svn/fast_export.h    |    4 ++--
 vcs-svn/sliding_window.c |   10 +++++-----
 vcs-svn/svndump.c        |   21 +++++++++++++++------
 4 files changed, 31 insertions(+), 19 deletions(-)
