From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 16:21:24 +0100
Message-ID: <e1dab3980808190821l2d859bf0p4986260b1fe1ab65@mail.gmail.com>
References: <48AA4263.8090606@gmail.com>
	 <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
	 <32541b130808190754l43f053abnc4e3c5c064d6ade7@mail.gmail.com>
	 <e1dab3980808190802r202aadc0p2cf8431f645354e3@mail.gmail.com>
	 <32541b130808190808g79bb53a1l9ea7f2ea4c1e5ed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pat LeSmithe" <qed777@gmail.com>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVT2V-0003ii-5E
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 17:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYHSPV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 11:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbYHSPV0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 11:21:26 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:64260 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYHSPV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 11:21:26 -0400
Received: by gxk9 with SMTP id 9so5151161gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 08:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FOTnMbU2KDI9NOno2rgWKLdjyIxjvIANwl7IPc+ju/4=;
        b=OqsZiZgwyeW/Ebdb0fp/ke9DdbnVjs12dYpy4Qd0SmzoI28vVLQ8a9e258wdjUqxF3
         pPRTkCiIRQF1r56Q5JfeBtM9dMT+2axmZk3gOduHXDswZE9qd5Yq1oiU1JjeaKQQbjQ8
         QypkGNeza5s3h/Nf2Ytf9g2LT/oRVmtOLz3Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=c2ck5tXfC6fAHfSxodGLZsw+Scw0nzeQl58EsWpw66uQ+A11R2lZRF5+ibGTjvCG3Y
         Xt930TxdQDIf1238Xt5RdDWEZ/big9oRiozcgkf/in0B3CERpvtWNPS0lh9UDEummf/O
         3WIxs01izSIjdkXpkEFZvtNW94SsG9Jd/treQ=
Received: by 10.143.5.21 with SMTP id h21mr2557482wfi.175.1219159284475;
        Tue, 19 Aug 2008 08:21:24 -0700 (PDT)
Received: by 10.142.136.18 with HTTP; Tue, 19 Aug 2008 08:21:24 -0700 (PDT)
In-Reply-To: <32541b130808190808g79bb53a1l9ea7f2ea4c1e5ed3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92877>

On Tue, Aug 19, 2008 at 4:08 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> Doing the 10-minute snapshot doesn't preclude the on-make snapshot.
> Just commit at *both* times.  But commiting "around the time there was
> a successful build" is kind of pointless since you might change a file
> two seconds later.  (Or maybe only I'm that idiosyncratic. :))

I think I was unclear: the only point about the "roughly" was to
emphasize that being dead-on 10 minutes line doesn't matter from the
chronological aspect. Clearly you want to start the commit processes
as soon as a successful compile you decide is worth keeping completes.
(Actually, looking at the commit times on my cron-initiated commits
the time is mostly 1 or 2 seconds past the 10 minute boundary already,
so there's an already up to 2 seconds for my "detect new files" script
to scan the directories.)

> Shawn's GIT_INDEX_FILE script seems like a good place to start.  If it
> were me, I'd use *two* branches here: one for every time I build, and
> one for the periodic commits.  Then the build branch would always be
> bisectable, and the periodic branch would always have up-to-date data.
>  Commits on the periodic branch would use *both* branch heads as
> parents, so you'd be able to easily see and diff the full history.

I think you mean 3 branches: successful compile, short term history
(every 10 minutes) and long-term archival history (every hour). I
already have the last two, although not in as optimal a manner as
Shawn suggested, and wipe the short term history every week or so.

Interesting idea. I'll ponder it.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
