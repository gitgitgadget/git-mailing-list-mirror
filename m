From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Restoring timestamps (Re: Branches & directories)
Date: Mon, 22 Aug 2011 18:21:16 -0500
Message-ID: <CAFzf2Xw6=BFsKauYTG-4cw0D_LzLSNb_wqz8dQJ83wJHNQXbdg@mail.gmail.com>
References: <CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<20110822210141.GA3880@elie.gateway.2wire.net>
	<CAE1pOi1+nnpnHAuhYsXcfFNUroW0JcDQKLu6D7YNrUwJg0tXPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 01:21:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvdo3-0005dw-W4
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 01:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab1HVXVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 19:21:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51596 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab1HVXVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 19:21:17 -0400
Received: by ywf7 with SMTP id 7so3883763ywf.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OFNll3MqQYOH2BSzZVg7koGlp3zHvzIGA1BD6jNx9S8=;
        b=XXPgOJU0zMROrFYR7WcwPd1SjLxv85jmQpGcV+pHDuIToIZgvN8aNSuhL5ZAj0AnIz
         LhzDSV1QKOiHODS5qrXUkMo4dGzzMBpDVgxNaM5spoYLWo8kgY+hUKb7E+I4bD+MhFL4
         +fYH2HH0P7LTbglWoHIxULwE72MDGA7T4S8U4=
Received: by 10.42.161.134 with SMTP id t6mr3180420icx.325.1314055276708; Mon,
 22 Aug 2011 16:21:16 -0700 (PDT)
Received: by 10.42.76.3 with HTTP; Mon, 22 Aug 2011 16:21:16 -0700 (PDT)
In-Reply-To: <CAE1pOi1+nnpnHAuhYsXcfFNUroW0JcDQKLu6D7YNrUwJg0tXPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179902>

Hilco Wijbenga wrote:

> You mean an extra dotfile per file in the commit?

Let me step back a moment.

When you mentioned mtime, a switch went off and reminded me of the
problem of metadata in general, especially owner and permissions. That
problem is important for people keeping track of /etc or $HOME in
version control (always a little dangerous because of the effect of a
stray "git reset --hard", but never mind). And the last time it came
up, I convinced myself that a hook script setting up entries in
.gitattributes, .gitmetadata, or .etckeepr with information like "all
files are owned by root:root unless otherwise specified" could be a
good and not too invasive way to deal with that.

Now that you remind me that the mtime of every file is likely to
differ from every other file, it is harder to imagine what situation
would make this meaningful information that should be stored in the
repository and shared with other people. It seems more like something
associated to the worktree, which fits more closely with what you are
trying to do, anyway.

Regarding the problem "eclipse metadata is not carried over from one
worktree to another", isn't that going to be a problem regardless? In
your proposed setup, each time you stash everything and start work on
a different branch, the eclipse metadata before would be stashed along
with everything else, which doesn't make anything any easier (unless
disk space is very scarce or metadata stores the absolute path to the
cwd).

Sorry for the lack of clarity.
Jonathan
