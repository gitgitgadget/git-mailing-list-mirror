From: Kevin Ballard <kevin@sb.org>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Wed, 13 Oct 2010 14:53:05 -0700
Message-ID: <24AC771D-07A7-49D7-8824-28E6156C90B4@sb.org>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org> <1287006523.13553.4.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:53:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69G9-0006eh-TX
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0JMVxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:53:12 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60953 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab0JMVxL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 17:53:11 -0400
Received: by pxi16 with SMTP id 16so854687pxi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 14:53:11 -0700 (PDT)
Received: by 10.142.192.5 with SMTP id p5mr8063764wff.300.1287006790919;
        Wed, 13 Oct 2010 14:53:10 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm12189315wfc.17.2010.10.13.14.53.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 14:53:09 -0700 (PDT)
In-Reply-To: <1287006523.13553.4.camel@drew-northup.unet.maine.edu>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158984>

On Oct 13, 2010, at 2:48 PM, Drew Northup wrote:

> 
> On Wed, 2010-10-13 at 14:37 -0700, Kevin Ballard wrote:
>> I've been having a rather strange problem using manual hunk edit mode (`git add -p`, e) and emacs together. It seems every time I hit ^G inside of emacs in this one circumstance, the entire process instantly shuts down, both emacs and `git add`, and it doesn't even give emacs a chance to clean up the terminal, so I'm left with garbage across my display (the remains of the emacs window) and the terminal settings are screwed up enough that I have to close and reopen it (even `reset` doesn't fix everything). Has anybody else seen this, and if so, do you know what's going on? I cannot reproduce this with emacs outside of `git add -p`, and I cannot reproduce this with vim even inside of `git add -p`.
> 
> Is there some way to get a dump of the environment that emacs is seeing?
> If we have that it will be easier to tell if this is an emacs problem or
> a git problem.

I've been investigating this on the emacs side as well. At the moment, my suspicion is that ^G causes emacs to trigger (keyboard-quit), but at the same time the surrounding environment (e.g. git) is sending a SIGINT to emacs, which normally acts like ^G but in this case may be triggering the emergency exit mode of emacs. Is there some reason that the interactive add would be sending SIGINT to emacs when I type ^G?

-Kevin Ballard