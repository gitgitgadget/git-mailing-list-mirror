From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCHv2 1/2] am: add gitk patch format
Date: Sat, 6 Sep 2014 09:54:26 +1200
Message-ID: <CAFOYHZDeasZMFfupoXXV7ZKox-E2iDer_kEzQuZ9OhexQ=99aQ@mail.gmail.com>
References: <1409736919-22341-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-1-git-send-email-judge.packham@gmail.com>
	<1409782918-26133-2-git-send-email-judge.packham@gmail.com>
	<xmqq38c8waub.fsf@gitster.dls.corp.google.com>
	<CAFOYHZCcAwHwRy50kE8=rRwEOtrXovNkkKSQo2Gwcfvbve1Qwg@mail.gmail.com>
	<xmqqiol3uwr5.fsf@gitster.dls.corp.google.com>
	<CAFOYHZC5pWadJiqY=F3gP4DKcNzhogfWH76jAcez5AjW7FJrVQ@mail.gmail.com>
	<CAPc5daWip1dQ5Or6hzmdjoBUStusvs-jK0ODNuzAotNfM5BLbQ@mail.gmail.com>
	<CAFOYHZDfpZPvuE_BZQHajc65fZNKoyqvFf+UZyf0LyLwrooqzA@mail.gmail.com>
	<xmqq8ulxrkeq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 23:54:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ1Si-0003vT-Et
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 23:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbaIEVy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 17:54:27 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:61813 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaIEVy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 17:54:26 -0400
Received: by mail-pa0-f43.google.com with SMTP id et14so23063102pad.16
        for <git@vger.kernel.org>; Fri, 05 Sep 2014 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=II8Ah2Xy6ZLQP8xgcBGeKlVXAjqFsz0RW08cvvXb1oo=;
        b=hVEgauSs74GBNkJ1ZbAJ1qj8alCRX9bO2Z4aH6CPgjk0/8faKRVVGg8ZViZcExApVU
         wvEi7C2DtXIbpAAYVMA3Lp0R/hYzazPP86FaqrQTT0TJceGC9uSYVFls1qoZZmJMpV88
         ziAaUtmXWfC9fItDK4Ftm4QcCgZasbln9uxZJJtaTv/xFObo5C+BVL/yNYJVU1Bsb7KW
         M0gZRNMgYqGeek0nxANl/hGo3d7tIyLKcxcO7gel4XsHx12t3SPr2srLFiFDz7FJLZtu
         hFzCUANdNVmdgo1vdNtwDwjy5lC3i8BqBvXyP8O7cO/vMevYfsCAM2/ADIQTwI2gYGbN
         UZRA==
X-Received: by 10.66.178.205 with SMTP id da13mr23598682pac.146.1409954066560;
 Fri, 05 Sep 2014 14:54:26 -0700 (PDT)
Received: by 10.70.36.6 with HTTP; Fri, 5 Sep 2014 14:54:26 -0700 (PDT)
In-Reply-To: <xmqq8ulxrkeq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256543>

On Sat, Sep 6, 2014 at 6:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> So teaching git mailinfo to do s/^    // (either when asked to or
>> using some heuristic) would be a better approach? I also think we
>> should accept "Author:" as an acceptable fallback if "From:" is not
>> present.
>
> Not as "a fallback" in the sense that "Author:" should not be
> treated any specially when "am" (which stands for "apply mail") is\
> operating on the patches in e-mails.

I was proposing we avoid the "Patch does not have a valid e-mail
address." error when we can dwim and determine the email address from
"Author:". I originally was going to say "From:" should take
precedence but it would be another way to indicate that the true
author is not necessarily the person who sent the email.

> Whatever wants to convert the
> output from "log --pretty" as if it came from "log --pretty=email"
> would certainly need to flip "Author:" to "From:" (what should
> happen when it sees "From:" in the input, though???), and whatgver
> wannts to pick metainfo from "log --pretty" output like mailinfo
> does for "log --pretty=email" output would certainly need to pick
> the authorship from "Author:" (without paying any attention to
> "From:" if one exists).
>

Wow. I didn't know --pretty=email existed. Better yet it works for
diff-tree so gitk should probably be using that to produce something
that can be exported/imported easily.

I do wonder what the original use-case for "write commit to file" was.
Once it's been written to a file what is one supposed to do with it?
It's not something that 'git am' can consume (currently). Using 'git
apply' or 'patch' would lose the commit message plus you have to
manually stage/commit the changes.
