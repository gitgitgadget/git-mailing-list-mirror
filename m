From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH v5 15/16] remote-svn: add marks-file regeneration
Date: Tue, 21 Aug 2012 11:44:55 +0200
Message-ID: <1916249.rjj3ZYveKT@flomedio>
References: <1345499542-15536-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vehn1gocn.fsf@alter.siamese.dyndns.org> <7va9xpgngk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 11:45:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3l1K-0007LD-Ed
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 11:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019Ab2HUJpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 05:45:04 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64337 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896Ab2HUJpB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 05:45:01 -0400
Received: by bkwj10 with SMTP id j10so2118794bkw.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=HFh3kqhVRVmBmNDDYsY1PPq5zLvo8196k9U64q2BAP0=;
        b=Nr91WpjlMQsGrLvqJ2+Lw2066jEhZ65yd5WCh6c6BDJGyTLErJAIAizI1ji8kAwtAn
         Hw0y5zoVAD5wmzoTnROaHXKk0rSl/PGQQyWImJvmGBHUE/3P8HE8pWvdn74QbCHL5xAQ
         bbraDCjwWIJor9jsvcxE7aeD3z/2lft+Zr3zKwhjjumO0G0CNxyQIk35jm03rHL9M7YU
         O0/lFHyKUSGZnxEmesQaQDzJZk2QZAIx3T5rebGLpdHsisPAjLBkM1QG8W8pZQSzodni
         coOtXzJ039CSHuU/wonHGQQw7O7e4ch0cHsEzcTV1/c4/rOwJrD6g3N87KLBWRGITuQs
         72/g==
Received: by 10.205.118.14 with SMTP id fo14mr5236480bkc.130.1345542300133;
        Tue, 21 Aug 2012 02:45:00 -0700 (PDT)
Received: from flomedio.localnet (91-115-84-27.adsl.highway.telekom.at. [91.115.84.27])
        by mx.google.com with ESMTPS id g6sm465998bkg.2.2012.08.21.02.44.57
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Aug 2012 02:44:58 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-25-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7va9xpgngk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203959>

On Monday 20 August 2012 16:20:27 Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I think you meant something like:
> > 	init_notes(NULL, notes_ref, NULL, 0);
> > 	
> >         marksfile = fopen(marksfilename, "r");
> >         if (!marksfile) {
> >         
> >         	regenerate_marks(marksfilename);
> >         	
> >                 marksfile = fopen(marksfilename, "r");
> >                 if (!marksfile)
> >                 
> > 	                die("cannot read marks file!");
> > 	
> > 	} else {
> > 	
> >         	...
> > 
> > Also there is another call to regenerate_marks() without any
> > argument.  Has this even been compile-tested?

Yes it compiled and it works (is tested by t9020), but the compiler didn't 
complain because I left out void, so every argument was ok. I need to get used 
to that C-feature.

> 
> I've made regenerate_marks() to take (void) parameter list, as
> marksfilename is a file scope static and visible to everybody, and
> applied something like the above and queued the result in 'pu'.

That's exactly how I meant it. Thanks for your fixups!
