From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Specifying account profile in MSMTP
Date: Sun, 19 Oct 2014 00:46:02 +0000
Message-ID: <20141019004602.GA1977@dcvr.yhbt.net>
References: <CAHd499C5FZietAxQYBFwk+Zm0AeLWSADog7+=W0Fnm6G1sPSHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 02:46:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfeda-0003OM-6m
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 02:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbaJSAqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 20:46:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50486 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbaJSAqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 20:46:04 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52891F8B3;
	Sun, 19 Oct 2014 00:46:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHd499C5FZietAxQYBFwk+Zm0AeLWSADog7+=W0Fnm6G1sPSHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> wrote:
> Hey guys,
> 
> I'm using MSMTP to define 2 accounts: Work email and personal email.
> If I send patches via email through Git at work, I want to use my work
> SMTP server and account information. Likewise at home for personal
> projects, I want to use my personal SMTP account.
> 
> I put my .gitconfig in Dropbox and I share it across all of my
> machines, so I avoid putting my SMTP server information in my global
> config because I'd then have to use the same account everywhere.
> However, I do not define a "default" account in my MSMTP file (which
> is also in dropbox, in fact my whole home directory is in there).
> 
> Is there a way to specify the MSMTP account to use at the command line
> when I run `git send-email`? If not, are there other good solutions to
> this problem?

msmtprc can be configured to picks accounts based on the envelop sender
specified by git send-email.

I make sure my email address in the git commits is correct and use
use envelopesender=auto for git send-email when using msmtp.

Config examples below:

----------- ~/.gitconfig ---------------
[sendemail]
	smtpserver = /usr/bin/msmtp
	envelopesender = auto

---- /path/to/project_a/.git/config ----
[user]
	email = a@example.com
---- /path/to/project_b/.git/config ----
[user]
	email = b@example.com
------------ ~/.msmtprc ----------------
account a
host ...
from a@example.com
user a
password ...
auth ...

account b
host ...
from b@example.com
user b
password ...
auth ...
