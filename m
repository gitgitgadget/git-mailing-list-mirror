From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Mon, 03 Nov 2008 19:01:11 +1300
Message-ID: <1225692071.20883.44.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <20081030143918.GB14744@mit.edu> <vpqmygmw1mr.fsf@bauges.imag.fr>
	 <alpine.LFD.2.00.0810301259130.13034@xanadu.home>
	 <20081030170329.GK24098@artemis.corp>
	 <7vabch22ou.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:02:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwsWX-0000J4-Iu
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:02:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYKCGBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 01:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYKCGBU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 01:01:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:44575 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbYKCGBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 01:01:20 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id CC1B7C4002; Mon,  3 Nov 2008 19:01:18 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 44952C4001;
	Mon,  3 Nov 2008 19:01:12 +1300 (NZDT)
In-Reply-To: <7vabch22ou.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99900>

On Sun, 2008-11-02 at 14:17 -0800, Junio C Hamano wrote:
> I'd agree that 'reset' is rather unfortunate.  It very originally was all
> about the index (the "mixed" semantics, specifically "git reset" without
> any committish nor any pathspec, was the original use case) and nothing
> else.  IOW, "I staged a wrong change, let's start over by discarding all
> staged changes".  A logical extension to it is "git reset -- pathspec",
> IOW, "I know which paths I fubared, please reset only these paths, as
> other staged changes are Ok".
> 
> So "reset <file>" is very much useful.
> 
> Then 'reset' learned to also muck with HEAD, so "reset HEAD^" (still
> mixed, without any pathspec) can be used to amend the latest commit but
> without losing the state you would eventually want to arrive at.  A
> logical extension to this was "git reset --hard HEAD^" to nuking instead
> of amending the mistake, and "git reset --soft HEAD^" to save the trouble
> of staging the changes when the mistake you are fixing is small compared
> to the entire change.
> 
> "checkout [$committish] $path" came much later, and the command is all
> about index and files, and never about resetting HEAD.  "checkout $path"
> does "reset --hard $path" (notice there is no $committish in either one)
> would have done, so we stopped enhancing the "reset" command in that
> direction.

Interesting.

I'm wondering whether the important thing here is not making a new
command, but simply deprecating "revert", and pointing the user to "git
reset" - then making sure that you can do everything revert-like (eg, as
Elijah points out) from that command.

Sam.
