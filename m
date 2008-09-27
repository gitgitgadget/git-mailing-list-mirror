From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 4/4] cygwin: Use native Win32 API for stat
Date: Sun, 28 Sep 2008 01:54:06 +0400
Message-ID: <20080927215406.GG21650@dpotapov.dyndns.org>
References: <20080927084349.GC21650@dpotapov.dyndns.org> <200809272035.03833.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Sep 27 23:55:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjhl3-0004y8-M3
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 23:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbYI0VyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 17:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbYI0VyN
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 17:54:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:35880 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbYI0VyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 17:54:12 -0400
Received: by nf-out-0910.google.com with SMTP id d3so500678nfc.21
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Wu7TBr7Q7i6ix+37wgvFTPSUDil6o3AdmPY5W+gKzs4=;
        b=AgEasRh0MFpZTTa/Nr1gst4ntIqNf7LR85M6KwjzFSJdfH/IsKF86mp+NVUl8bu7Cm
         yGcviiJWj0SJ7i4ZVDD/CjNWnnJApotVbYpgi9l3gd/i9AiZxJllwdM7EjNAba9isPzy
         qs40NcN7yYkSLaLwfaVQI7v+Ze6fIOfXDKMi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pYJSO+0x7KbiToYaekdmmpjR1yu8jKQmep3Q7QEMxDVOH7tW86/iT3MLyOm/cGsQJ0
         Wv0wTyZF41s5VYa1suH9f0nYeHxzNOx9she2Icnz8gzz3tlgHZgYbMV1PvmoGVOeUQmc
         Bj0/hAuPfJTi4kcTXxVo9R/aJf9/1uBS9hAt8=
Received: by 10.210.82.7 with SMTP id f7mr3666902ebb.194.1222552450641;
        Sat, 27 Sep 2008 14:54:10 -0700 (PDT)
Received: from localhost (ppp85-141-151-122.pppoe.mtu-net.ru [85.141.151.122])
        by mx.google.com with ESMTPS id 23sm826069eya.7.2008.09.27.14.54.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 14:54:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809272035.03833.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96921>

On Sat, Sep 27, 2008 at 08:35:03PM +0200, Johannes Sixt wrote:
> 
> > +core.cygwinNativeStat::
> 
> This name is *really* odd, for two reasons:
> 
> - If I read "native" in connection with Windows, I would understand Windows's 
> implementation as "native". Cygwin is not native - it's a bolted-on feature.
> 
> - This name talks about the implementation, not about its effect.
> 
> Perhaps a better name would be core.ignoreCygwinFSFeatures, and the 
> description would only mention that setting this to true (the default) makes 
> many operations much faster, but makes it impossible to use File System 
> Features A and B and C in the repository. "If you need one of these features, 
> set this to false."
> 
> (And after writing above paragraphs I notice, that you actually really meant 
> Windows's "native" stat; see how confusing the name is?)

It was Shawn's suggestion. I don't care much about the name as long as
it is explained in the documentation... Therefore, I accepted what Shawn
said without giving it any thought. Now, when you bring this name to my
attention, I believe core.useCygwinStat (in the opposite to the current
core.cygwinNativeStat) would be a better name. Your name is okay too,
but a bit too long for my taste and not specific enough (I suppose
Cygwin does many FS related tricks). Anyway, I don't have a strong
opinion here, so just whatever most people like is fine with me :)

> 
> > +static inline void filetime_to_timespec(const FILETIME *ft, struct
> > timespec *ts) +{
> > +	long long winTime = ((long long)ft->dwHighDateTime << 32) +
> > ft->dwLowDateTime; +	winTime -= 116444736000000000LL; /* Windows to Unix
> > Epoch conversion */ +	ts->tv_sec = (time_t)(winTime/10000000); /*
> > 100-nanosecond interval to seconds */ +	ts->tv_nsec = (long)(winTime -
> > ts->tv_sec*10000000LL) * 100; /* nanoseconds */ +}
> 
> Shorter lines in this function would be appreciated (and not just because my 
> MUA can't deal with them ;).

I am sorry, I did not notice that the line got longer than 80 columns.
I will resent the patch once the issue with the name of the option is
resolved.

Dmitry
