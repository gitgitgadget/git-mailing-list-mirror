From: Johan Herland <johan@herland.net>
Subject: Re: Notes and submodules
Date: Mon, 19 Aug 2013 15:55:56 +0200
Message-ID: <CALKQrgfGUMrcR+EPTvN9+mFPcW6Q-zv1JM6MJK-61BvF3yYpbQ@mail.gmail.com>
References: <CAC9WiBj-ij1o6JL-FtUuCgdf8ZqrhJb2=dQcSXjRMEwwL4VWFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 16:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBQDF-0003bm-9n
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 16:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab3HSONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 10:13:37 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:59421 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab3HSONg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 10:13:36 -0400
X-Greylist: delayed 1054 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Aug 2013 10:13:36 EDT
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VBPw8-0002Hu-Jt
	for git@vger.kernel.org; Mon, 19 Aug 2013 15:56:00 +0200
Received: from mail-pb0-f48.google.com ([209.85.160.48])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VBPw8-000Amb-7J
	for git@vger.kernel.org; Mon, 19 Aug 2013 15:56:00 +0200
Received: by mail-pb0-f48.google.com with SMTP id ma3so5003028pbc.35
        for <git@vger.kernel.org>; Mon, 19 Aug 2013 06:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=99lZHUdV35BJjrivLYtSyHpJszXpNKgvqZOrsfDqY50=;
        b=UAlGCi2X+kd5dtNlS6WZ+ck/O4kuZfX0Zrm5KrKF13vLjLlt0VwDaR1U+xpjKaOIiZ
         iweoz3GuXm/IBDUM34+IKr24/bncdipU/9DgysWo3+DR5F6v0RBzw4GmFwXlo4T2vMtM
         ud2hyj9vZRb13rSwvMInR1AbGFygSwOH2+9xUEpDZv4sMaFLLewjrOzZq+v4uvs+TzHu
         9IvTTOf7+PRpQ/a2kUuJitcIB0g6PXuWDehcLdC2iVxbuqTffQbfvjyzk4pBjvkOAEpJ
         8SCpdbLRlTo8D4KTZ2XPSoR6yCL6P50YPibSqZp2O/F9qsuowqNCYJUf+0SbFUxIWBrP
         vbQw==
X-Received: by 10.69.0.168 with SMTP id az8mr13447082pbd.51.1376920556180;
 Mon, 19 Aug 2013 06:55:56 -0700 (PDT)
Received: by 10.70.126.67 with HTTP; Mon, 19 Aug 2013 06:55:56 -0700 (PDT)
In-Reply-To: <CAC9WiBj-ij1o6JL-FtUuCgdf8ZqrhJb2=dQcSXjRMEwwL4VWFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232545>

On Mon, Aug 19, 2013 at 10:13 AM, Francis Moreau <francis.moro@gmail.com> wrote:
> Hello,
>
> Is it possible to keep submodules notes in the super project  ?

Not easily. I guess it depends on what you want to use the notes for.
In order for notes to be generally useful (i.e. show up in logs,
surviving a notes prune, etc.) they really must reside in the same
repo as the annotated objects [1]. Now, if all your interaction with
notes happens through scripts that you control, then I guess it would
be possible to hack this in some sort of semi-workable way, but you
would still have to make sure never to run "git notes prune" in the
super project. I guess the real question here is: Why would you want
to do this? and is there maybe some other way your use case can be
accomodated?

...Johan

[1]: If you were to annotate objects in a submodule, but then store
the notes objects in the super project, it would be impossible for
"git log" in the submodule to find the notes objects, and your log
would show no notes. Similarly, a "git log" in the super project would
see a lot of notes objects pointing to non-existing objects (because
those objects live in the submodule), hence the notes objects would be
removed when running "git notes prune" in the super project.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
