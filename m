From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: Re: [PATCH] rebase: add --verify-signatures
Date: Thu, 17 Dec 2015 02:04:22 +0100
Message-ID: <20151217010422.GA19500@blarch>
References: <20151210130228.GA22641@netblarch.tu-darmstadt.de>
 <xmqq37vai0ev.fsf@gitster.mtv.corp.google.com>
 <xmqqy4d2gjw6.fsf@gitster.mtv.corp.google.com>
 <20151216133915.GA3586@blarch>
 <xmqqfuz2e003.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:47:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9LnZ-0000Uc-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 00:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbbLPXrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 18:47:53 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34319 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbbLPXrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 18:47:52 -0500
Received: by mail-lf0-f51.google.com with SMTP id y184so40664308lfc.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 15:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RRIJF4odifgdZ6kVvlh1TwhIeodqodnjJK/gsvuiY8k=;
        b=Q6XsaowF1eM6YfofCSYhlmd3IbEGsuXXeuOsHIkSiTPAfkqolQFKISshfstncrL/s6
         6l9UUxNwduxF1e3PAhVTk9n7qk/TPt2aEYJUf/fo0GfNQ3NQ/trrB9n/FJIyLHN3VVQt
         dyt6/lQl0mZP2UB6/nztbKPftci5QbfKIQJhYd05e7afCQcQ3Hw0jAA99G/8w+OKs6C3
         yT8LEpth2EgT3oQVEjOl2jfCVBoDvMb96U4inCvodeNjwHAOl1Do/ZyEwhHtJ3XnOdiY
         2J5uPYclwiVjxUSl+PpZEXeDsPHzFvsLE1Hnx5uKPhXyD1bpl/Qu53ceo5yk5VuOzSDm
         kPQQ==
X-Received: by 10.25.145.76 with SMTP id t73mr16428586lfd.121.1450309671116;
        Wed, 16 Dec 2015 15:47:51 -0800 (PST)
Received: from blarch (dslb-088-069-062-066.088.069.pools.vodafone-ip.de. [88.69.62.66])
        by smtp.gmail.com with ESMTPSA id c201sm1502818lfb.4.2015.12.16.15.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2015 15:47:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqfuz2e003.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282620>

On Wed, Dec 16, 2015 at 10:12:12AM -0800, Junio C Hamano wrote:
> I do not quite understand how that would help anything.  I do not
> personally believe in projects that wants to sign each and every
> commit, but to them, "an empty signed commit on top" would not fix
> anything once they have an unsigned commit at the tip of a public
> branch.  And for those that care about only the tip to be signed,
> instead of adding such an empty commit, you would rebuild and sign
> your work on top of that unsigned public tip and push back---at
> which point the tip of the public branch would have a signature from
> you.  So such an empty signed commit would either not help, or not
> necessary, to make the resulting history kosher again.
> 

Checking all commits was a mistake I made because of misinterpreting the
git-merge code. Only the tip should be checked for a signature.
And the reason to get it signed instead of just signing the commits
rebased on top is to defer to the judgement of the author of the branch
you're rebasing onto instead of checking the unsigned commits for
validity yourself.

As I understand it, this is the same reason for the existence of
--verify-signatures for git-merge. Otherwise the same argument could be
made for git-merge - just do whatever cleanup you need after merging and
sign it yourself.
Or maybe I haven't grasped what --verify-signatures is for.
