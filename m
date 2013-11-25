From: Johan Herland <johan@herland.net>
Subject: Re: branch annotations?
Date: Mon, 25 Nov 2013 15:55:29 +0100
Message-ID: <CALKQrgdTxYmy2ncXNB29B0-05g8CK=-jxWfDVPbUjHTPsm1yOw@mail.gmail.com>
References: <20131125084644.350bd4f7@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 15:55:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkxZc-0007Vq-W6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 15:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862Ab3KYOzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 09:55:37 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:54735 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab3KYOzf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 09:55:35 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VkxZV-0007sn-JX
	for git@vger.kernel.org; Mon, 25 Nov 2013 15:55:33 +0100
Received: from mail-pd0-f177.google.com ([209.85.192.177])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VkxZV-000Lbp-7M
	for git@vger.kernel.org; Mon, 25 Nov 2013 15:55:33 +0100
Received: by mail-pd0-f177.google.com with SMTP id q10so5619008pdj.36
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 06:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9cD4fqTIY+JLBX82Nwxv1EfS4fyUG6jM8Oa8p9ucg2M=;
        b=Gs/+/q6PwOW5zW4L3j0dslPxjdlK0A9pp6bGw0HFpLh+ya6b1mkwhgfD/yODc6I+r9
         +b/vWBkbedIPZzsBnerYsGddohZesVVUT3usEu+6O+gAUle/vxybdgsP9frC2hAYYhjR
         twm9LhCp1TXoMsBJblqUOHD4z+y4opXg0fHnXBYz8g5qkL22Or5F1tLzC2FDfNnA94qv
         OqwTt6cuai+jOoMOatCxAIPGysmUt+itLsUa8cpvuzaLKhHS1dLCwHG8FqWnuAO0t948
         LbkQz8W39IPBUaLa37ZEyT9VuIfPBed15kHPm4OKFSoU4/L/L/0BNOMQ8G298ZVNk3Or
         Pppg==
X-Received: by 10.66.121.201 with SMTP id lm9mr27567146pab.80.1385391329249;
 Mon, 25 Nov 2013 06:55:29 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Mon, 25 Nov 2013 06:55:29 -0800 (PST)
In-Reply-To: <20131125084644.350bd4f7@bigbox.christie.dr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238312>

On Mon, Nov 25, 2013 at 3:46 PM, Tim Chase <git@tim.thechases.com> wrote:
> Is there any way to associate some sort of note with a branch that
> would be shown when listing them?  While I currently have things like
> "issue/QA-42", it would be nice to have a note associated with it so
> I could do something like
>
>   $ git branch --show-notes
>     issue/CR-88: make sure NoSQL engines support .CSV file backends
>     issue/QA-31: add missile launch codes
>   * issue/QA-42: support flying cars
>     master
>
> as I currently need to flip back and forth between my git/terminal
> and my issue-tracker to know that, if I need to be adding missile
> launch codes, I need to be working on QA-31.  I know there are "note"
> features elsewhere for commits, and I know that git-branch supports
> showing the most recent commit (that's not always enough info to
> discern the branch's purpose).
>
> Thanks for any ideas on how to ease this pain-point, :-)

"git branch --edit-description" allows you to write a descriptive
string for your branch. AFAICS, however, it currently only shows up
when using request-pull. It does not show up in any git branch
command. IMHO that should be fixed.

As a workaround, you can use this one-liner:

  git for-each-ref --format "%(refname:short)" refs/heads/ | while
read branch; do echo "$branch - $(git config
branch.$branch.description)"; done

I guess that could even be turned into an alias...


Hope this helps,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
