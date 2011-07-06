From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/14] revert: Introduce a layer of indirection over
 pick_commits
Date: Wed, 6 Jul 2011 06:39:28 -0500
Message-ID: <20110706113928.GO15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-12-git-send-email-artagnon@gmail.com>
 <20110706103734.GL15682@elie>
 <CALkWK0=0vBUG_UOLWt+SFMctfW1__OOG-=BAY4WwMGM5OfDj4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQSA-000774-Op
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1GFLje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 07:39:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42992 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1GFLjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 07:39:33 -0400
Received: by iwn6 with SMTP id 6so5995380iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2KkM7z6W7+9yQtmXdcy+p2JeGnq1S36o+ebh3VycEp0=;
        b=ZcSMryWNm5cVPk+TUuO93NeCnt+eD+UlaTjlhagu9ghU9NxwgEzFbXpS05BeD4FKcm
         oKawGnmhBX8ihPQK54tZtLWg/laDXW0TaLttOajWhz17ClxATfFhxFyIZb4J25L5TCsE
         20AJuYpnxBiBoNlGgt13Z3vqZFiMKtfWtEjG4=
Received: by 10.43.62.13 with SMTP id wy13mr8851713icb.342.1309952372330;
        Wed, 06 Jul 2011 04:39:32 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id hw7sm8708484icc.15.2011.07.06.04.39.30
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 04:39:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=0vBUG_UOLWt+SFMctfW1__OOG-=BAY4WwMGM5OfDj4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176693>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> In that case, I'd be mildly tempted to call it something crazy like
>> start_or_continue_replay()
[...]
> Why? Is introducing new terminology so bad?  Should I explain what I
> mean by "continuation" in the commit message/ a comment?

If "process_continuation" means "parse .git/sequencer state, which we
are pretending is a serialized continuation object, and either (a)
call it, (b) throw it away, or (c) modify it and then call it", then
yes, how do you expect anyone to know what you are talking about?

Less importantly, starting a cherry-pick (which is what pick_commits()
already does) doesn't seem to fit in that picture.

A simpler jargon-filled description of this model is checkpoint/
restart.  But it is an incomplete analogy and still not a great name.
With a goal of making future writers' lives happier and more
productive in mind, I do not think it is often worth confusing them by
choosing a clever presentation of ideas instead of a clear one.
