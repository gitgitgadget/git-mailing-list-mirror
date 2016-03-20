From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for
 git-rebase
Date: Sun, 20 Mar 2016 15:00:02 +0100
Message-ID: <20160320140000.GB32027@hank>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
 <1457779597-6918-2-git-send-email-pyokagan@gmail.com>
 <alpine.DEB.2.20.1603160855390.4690@virtualbox>
 <CACRoPnS=qg=a3xYKHyk-7E2HN5HhTimGirZcwL8hMa0xLY6KdA@mail.gmail.com>
 <alpine.DEB.2.20.1603161656130.4690@virtualbox>
 <20160318110134.GA16750@hank>
 <alpine.DEB.2.20.1603181659200.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 20 14:59:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahdtV-00044P-JL
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 14:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbcCTN7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 09:59:40 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37285 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbcCTN7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 09:59:33 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so92967155wmp.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpteqwro7nhMGnuYAAAuxeEHB1/K+tNhhf5PgmObiAo=;
        b=LOHClLFlIkMofyGno2VCH4Ljgu2exR2OvbBovaSrh/2EAA3iURuzS8j5O9Bw3laZKY
         acJjFE99TumGZdLePQGErX6Mtwk7LRtfzSnj05Mria0UKOHxub80fczNkEFSzx4U0zxi
         +irS3fHGPeors2aDmPfmIwnLRovd1BaSHGYuYMFhCGMtv1l0Cwni2JmRD53CIIt02/RJ
         QdkXuFkXXwSeYb10RfcMzWFa1I0xiFVojbeipgqM6mmHdkvPyxXfEsf7BpawdzZSEQfv
         TNpicrApznL2oDPYyeMq8co0R2PHnF6FjVLtSq9ZmCtGhscZDVqkuTMc+pWVEjB6v6R+
         CKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpteqwro7nhMGnuYAAAuxeEHB1/K+tNhhf5PgmObiAo=;
        b=J5F6ApsST6q2UahhNHrekWyYHuCQXXEizuzNN8bMAcznsx/8nyJs9dhOwtlNiqayTg
         wK43cUb4U2Q7NGebvd+9qC5H5nwc7Qc86ygvUmL4rfF6TZoXG2seB5AfcqHUsBndWl6g
         emkorkjHZFFtgb8ApZPG6kgM3YP5uidzCx6YJjCxjpqR6kGsTl3yhGXdPGlzhA9phcRI
         m5utloC1Ukr79QlhDJxYNuPsefUDezZSaxkno0vtBZtRNaaLtMzB4tn8Y0Z8P3QuxKyX
         /HranB6wpozAxMSkMIxvNMKwd12eCVjRo1Ol1/sMZ3Dd2AcHm7cVVAonUNEjxJJWyQyT
         4QtA==
X-Gm-Message-State: AD7BkJIVAifrW/Ppdi1GWmpSEaTDp5jVZTBuLd3wMowAaWD2wjZ3Qb+oQ1ezY1JglwYLMw==
X-Received: by 10.28.177.132 with SMTP id a126mr8385737wmf.86.1458482371146;
        Sun, 20 Mar 2016 06:59:31 -0700 (PDT)
Received: from localhost (host86-185-232-204.range86-185.btcentralplus.com. [86.185.232.204])
        by smtp.gmail.com with ESMTPSA id o128sm7902256wmb.19.2016.03.20.06.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Mar 2016 06:59:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1603181659200.4690@virtualbox>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289354>

On 03/18, Johannes Schindelin wrote:
> Hi Thomas,
> 
> On Fri, 18 Mar 2016, Thomas Gummerer wrote:
> 
> > On 03/16, Johannes Schindelin wrote:
> > > Hrm. rebase -f just makes the reset an implicit part of the rebase, so it
> > > seems we cannot perf *just* the rebase. We are stuck with perf'ing also
> > > the reset. Sad.
> > 
> > I had the same problem back when I was working on index-v5 and posted
> > a patch series.  The discussion about it is at [1].  Maybe it could be
> > worth resurrecting?
> > 
> > [1] http://thread.gmane.org/gmane.comp.version-control.git/1379419842-32627-1-git-send-email-t.gummerer@gmail.com
> 
> Yes, I agree that something like that is needed. The proposed commit
> message suggests that things get simpler, though, while I would contend
> that timings get more accurate.
> 
> And I think you could simply move the test_start command, but that's just
> from a *very* cursory reading of the patch.

Is it possible that you might have missed patch 2/2 [1]?  The first
patch there is only the preparation for making the timings more
acurate when some cleanup is involved.  Just moving the test_start
command wouldn't do anything for the timings to get more acurate, as
the timings are measured in the test_run_perf_ function (it's outside
of the diff in the patch series).

I'm also not sure whether the test_perf_cleanup or if the other series
in the thread that came out of a suggestion by Junio makes more sense
[2]. (That is minus patch 3/3 in that series, which was added so we
could have a user of the new series, but if it's going to be used here
that's unnecessary).

[1] http://thread.gmane.org/gmane.comp.version-control.git/234874/focus=234875
[2] http://thread.gmane.org/gmane.comp.version-control.git/234874/focus=235241


> Ciao,
> Dscho

-- 
Thomas
