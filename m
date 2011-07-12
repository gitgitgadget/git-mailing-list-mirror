From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Tue, 12 Jul 2011 00:58:17 -0500
Message-ID: <20110712055817.GA10169@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie>
 <7vpqlgbjmd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVzO-00004w-2K
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1GLF6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 01:58:30 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51691 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab1GLF63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 01:58:29 -0400
Received: by gxk21 with SMTP id 21so1801713gxk.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4Ibk028SzpZFzO3g8Wo0+v6V5Ewxj1DoNExxgi/ZBuc=;
        b=ttQYGfBjeNFkLqmpMovS7Tf3BBkHJ7qkC/5sD7dfTmvshJMQYpS/+/sl7AebErt0JH
         o+T52EtyBDME4A7bvx5Fe0pLpSFfu9RZVKKYH6oodRdGHEn/gAcneD39nOs9u+N0lz43
         iPaUFsi3zgioHBlyM5gJzwqt9Rkr0P1YlHs8U=
Received: by 10.150.66.3 with SMTP id o3mr4314545yba.440.1310450308832;
        Mon, 11 Jul 2011 22:58:28 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.ameritech.net [69.209.70.6])
        by mx.google.com with ESMTPS id q10sm1014778ybf.28.2011.07.11.22.58.26
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 22:58:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vpqlgbjmd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176920>

Junio C Hamano wrote:

> After all, this series was labeled "for inclusion", not an RFC, which
> would mean the submitter, helpers, and reviewers all made reasonable
> effort to perfect the series to their ability, no?

Yep, that is how I interpret the subject line, too.

Wow, the series has been through a lot of iterations.  I finally found
a moment to dig up the ones I replied to (a full list would be harder
since search.gmane.org is still down).  Maybe they can save others
some time, too.

 - RFC: Sequencer Foundations [1]
   The basic themes are introduced and Daniel explains the
   two-levels concept.

 - Sequencer Foundations[2]
   Basic discussion of the purpose of die()-to-error() conversion and
   the suggestion of an almost crash-only design to avoid some of its
   problems.

 - Better error handling around revert[3]
   A quick discussion of die() versus assert() and how to unwind
   after errors.

 - Sequencer Foundations v3, v4[4]
   Capturing globals in a struct.  Whether to save error codes before
   propagating them (versus the simpler "return -1").  Another round
   of die()-to-error() versus crash-only code.  Pacing and the idea of
   merging bit-by-bit.

 - Implementing --abort processing[5][6]
   UI design is difficult.  The easiest way is to teach the porcelain
   to do what you were doing by hand already.

 - Sequencer with continuation features[7]
   Commit messages.  Variable names.  commit_list_append().  It seems
   we are closing in.

 - Sequencer: the insn sheet format[8]
   Various loose ends: i18n, commit messages, relationship between
   breakage of scripts and workflows and the need to patch tests, the
   "me" variable, advise(), variable names.

I suspect that getting the workarounds that keep existing scripts
working will take another round.  However, some of the early patches
might be ready.  My review will focus on that possibility.

Ram, thanks for your hard work.

[1] http://thread.gmane.org/gmane.comp.version-control.git/171255
[2] http://thread.gmane.org/gmane.comp.version-control.git/173408
[3] http://thread.gmane.org/gmane.comp.version-control.git/174043/focus=174050
[4] http://thread.gmane.org/gmane.comp.version-control.git/174393/focus=174540
[5] http://thread.gmane.org/gmane.comp.version-control.git/174874
[6] http://thread.gmane.org/gmane.comp.version-control.git/175638
[7] http://thread.gmane.org/gmane.comp.version-control.git/176139
[8] http://thread.gmane.org/gmane.comp.version-control.git/176647
