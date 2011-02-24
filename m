From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Thu, 24 Feb 2011 16:02:15 +0100
Message-ID: <4D6672F7.4020101@drmicha.warpmail.net>
References: <20110224112246.3f811ac2@glyph>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco <netuse@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 16:05:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsclB-0004j2-DF
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 16:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269Ab1BXPFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 10:05:35 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60476 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753542Ab1BXPFc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 10:05:32 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 050CD20AD5;
	Thu, 24 Feb 2011 10:05:32 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 24 Feb 2011 10:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6vpZdBHolwmtGU+43WBOZFgfAaQ=; b=uifi8slMAqk0HZ5Ki3A/0lE3dSsW8+GdD9FyI+aQ7nZErQSFeJRraxd+BnHmuGxKMipmWE/YnDC34jJR1wO7UXbD/DiVTOB344F8D1KSR3BoHpoLqDIthEpo1ettLcJEAT3bfMeh6064fmnOheBUxIfqzxPU23jxBVqxIaGTOoc=
X-Sasl-enc: LingJaUWdSoBfRIik72d+NW7hNKIQ2inTjNeanAc7WnK 1298559931
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 84C69406C74;
	Thu, 24 Feb 2011 10:05:31 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <20110224112246.3f811ac2@glyph>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167820>

Marco venit, vidit, dixit 24.02.2011 11:22:
> Hi,
> 
> I'm new to git and a bit confused about how some commands work.
> 
> git add .                    -- Adds everything *but* deleted files
> git add -A                   -- Adds everything
> git commit -a -m "whatever"  -- Commits everything *but* new files
> 
> I don't understand why there's not switch (is there?) for commit to commit new
> and deleted files, like -A for git add? Is the only thing to do this sth like
> 
> git add -A && git commit -m "Message"

"commit -a" is much like "add -u", at least when used without file
arguments ("pathspec").

"commit -A" does not exist, so that "git add -A && git commit" is your
only way.

Why does it not exist? Because you should at least
"git add -A && git status && behappy && git commit".

The middle part of that line could be done in the editor which commit
invokes, of course.

>From the technical side: git-add and git-commit share surprsingly little
code (the "add" part of commit is not shared). So, implementing it
wouldn't simply be a different "add call" from commit.

Also, "-A" supports a very "un-gitty" way of using git. This makes it
unlikely that someone cares to implement it... (By "un-gitty" I don't
mean a matter of personal taste, but a matter of fruitful habits.)

Michael
