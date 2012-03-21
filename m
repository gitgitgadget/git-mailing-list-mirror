From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [GSoC] Improving parallelism
Date: Wed, 21 Mar 2012 13:45:21 +0100
Message-ID: <87haxit95q.fsf@thomas.inf.ethz.ch>
References: <CANELHzNc+28ZDiZ69zv3X0DJMf0DTkiZXQD1-32Wsy-=vtWDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Felipe Tanus <fotanus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 13:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAKv7-0006Bc-Jw
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 13:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981Ab2CUMpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 08:45:25 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:31689 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757708Ab2CUMpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 08:45:24 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 13:45:20 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 13:45:21 +0100
In-Reply-To: <CANELHzNc+28ZDiZ69zv3X0DJMf0DTkiZXQD1-32Wsy-=vtWDhw@mail.gmail.com>
	(Felipe Tanus's message of "Sat, 17 Mar 2012 19:18:09 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193574>

Felipe Tanus <fotanus@gmail.com> writes:

> My proposal will most likely follow one of the proposed idea entitled
> "Improving parallelism in various commands". I'm very used to C
> programming, and pthreads is my friend, so I'm the right guy for this
> job. The downside is that I never looked at the git source code
> before, and I expect the most challenging step from the project is to
> find where parallelism can be further explored. For this, I count on
> my skill in C programming, a good mentor to help me to go through the
> code and evaluate my ideas.
>
> I find the idea of the proposal straight-forward, and no doubts pop up
> in my mind, except on what commands can I work on. The idea described
> in the wiki tells that the commands "git grep --cached" and "git grep
> COMMIT" need this improvement, and most likely "git diff" and "git log
> -p" need too. That is a good start, but if you know already other
> commands that might benefit from this parallelism, please tell me in
> order for me to include in my proposal.

As the ideas page says the steps are (the original wording was that it
would have 2.5 steps, hence "the half-step"):

 0. In preparation (the half-step): identify commands that could benefit
    from parallelism. git grep --cached and git grep COMMIT come to
    mind, but most likely also git diff and git log -p. You can probably
    find more.

 1. Rework the pack access mechanisms to allow the maximum possible
    parallel access.

 2. Rework the commands found in the first step to use parallel pack
    access if possible. Along the way, document the improvements with
    performance tests.

I think (1.) is the most important part simply because without (1.) the
other two are totally meaningless.  So I'd rather you not focus too hard
on the command list.  However, correctly identifying more commands where
pack access is the hotspot, and backing that up with numbers, may be a
good way to show your understanding of the matter.

For further reading, you should start with the discussions surrounding
git-grep threading around

  http://thread.gmane.org/gmane.comp.version-control.git/185932/focus=186217
  http://thread.gmane.org/gmane.comp.version-control.git/186618
  http://thread.gmane.org/gmane.comp.version-control.git/188701/focus=189592

etc.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
