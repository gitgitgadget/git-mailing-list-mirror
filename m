From: Uwe Storbeck <uwe@ibr.ch>
Subject: Re: Corner case bug caused by shell dependent behavior
Date: Sat, 15 Mar 2014 00:53:00 +0100
Message-ID: <20140314235300.GA25079@ibr.ch>
References: <20140314000213.GA3739@ibr.ch>
 <20140314003701.GF15625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 15 00:53:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WObuX-0003mM-6p
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 00:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871AbaCNXxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 19:53:04 -0400
Received: from gate.ibr.ch ([83.150.36.130]:47245 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbaCNXxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 19:53:03 -0400
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id 6483B13B62A;
	Sat, 15 Mar 2014 00:53:01 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP
	id DB1E8153F5; Sat, 15 Mar 2014 00:53:00 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id B9168D0AF7; Sat, 15 Mar 2014 00:53:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140314003701.GF15625@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244123>

On Mar 13, Jonathan Nieder wrote:
> May we have your sign-off?  (See Documentation/SubmittingPatches
> section "Sign your work" for what this means.

I could have found that myself .. thanks! I'll try to follow it
now. :)
I'll resend the patch. Hopefully I'll do it right.

> Would it make sense to add this as a test to e.g.
> t/t3404-rebase-interactive.sh?

It's a rather special case, so I'm not sure if it's worth it.
I'll send a patch which adds a test for it. The test works for
me, but as I don't understand the test mechanisms already good
enough a few questions:

- Is it correct to call the fake editor with an empty variable
  FAKE_LINES when you want it to not change the todo list of a
  rebase -i and use it as it is (the work is already done by the
  autosquash option)? I can achieve the same with EDITOR=true.
  What's the preferred way? Is there an advantage to use the fake
  editor also in this case?
- The tests in t3404-rebase-interactive.sh use their variables
  a bit differently, some just set the variables, some export
  the variables and some use a subshell to encapsulate them.
  Also some of the tests reset their rebase state so that
  subsequent tests, which also use rebase, do not fail when the
  rebase fails. Other tests don't do that.
  What's the expected resp. recommended behavior?

While trying to understand the test mechanisms I stumbled over
two other problematic uses of echo. These although only affect
the test output, not git itself.

Uwe
