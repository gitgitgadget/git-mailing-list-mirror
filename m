From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 14 Apr 2016 17:04:17 +0700
Message-ID: <CACsJy8CV4_AkcsmnWn4n1z15XesgHdw-g0UNMqm2EgsyQWDixw@mail.gmail.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
 <1460507589-25525-4-git-send-email-dturner@twopensource.com>
 <CACsJy8DE40dMiiqkTb=Pz8uidPk-q1-kuX514s7mO55ChFLXhg@mail.gmail.com> <1460573236.5540.83.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.co>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 12:04:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqe8s-0008KP-9q
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 12:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbcDNKEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 06:04:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36306 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbcDNKEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 06:04:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id p81so11327471lfb.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 03:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iUnNUV3jL7c0CZKz8rZBWhNyWviENnUxJ1xjO4j1W8Q=;
        b=DEFPfB87ANhLkg93rSqOo+zjwMH8IDOzfuJ8GQTXk1zK/NovMelKIjCuL9bFVB4KrK
         zD1YIeZQv4bl8y5ghWrOcBpIAgN5GWZgJU/E92EcGJVNtwyskdyRcWbpCXGE7qQn68Dn
         hAwi4Vg00aG2VVuXebNmgWXzpz+vKtLca71DnFE3UBxE4AmEGGmjjR+YxqnB1qeZ3NWW
         7dhpGk11J4QaFpcJQeMVxBcQSwnl/EI4o72K/HdiNoGlQsBzkXa8lAKuctwYldZjOcTQ
         IdIlEsBuk98GYTFyQiG43ATVRy/QqJCPG9Mu9Y+p6cAyJ6OZpRRiCcd2h/qYo1te7zYC
         +VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iUnNUV3jL7c0CZKz8rZBWhNyWviENnUxJ1xjO4j1W8Q=;
        b=kjkJq9kgVGKwhsxztAw1qvoDQwUZIdcsFOOp0mO9eC0x1ZdAnaq29I6+L/Cr2NDg2k
         pB/z0EgYNEEi1suE7ZDxl1VWV7J2VOBxh2viGP2wwKALKnndqr+eAs8HfNLU/aiT7jdU
         4upcsSPAYxXeomyEwmZn9SmmTkYCItgcClnK2yy0l8qoG5Pz4Aw7UYLeGsdjgcPyv/cd
         6DE4HnTgPn2o21G7PrJd682pAxEWImXfRCYlvnYyor1KYWEvKkirwX/csb5TIm7ScIUn
         kmeYa2ZsGc7iLM0sWWce2dnl/Oi9pfMDnOX6ntvFkQL6NuTTmOSIckTqOoAKyheudBxl
         kQUg==
X-Gm-Message-State: AOPr4FXZLSn+ZhvWvwVbK6Z5bwag9SZH2GC5chAyGyjxqM1T80QLlpK7U+ppSdPk6HnZWq1I5vaawiCS/Jtdqg==
X-Received: by 10.112.56.43 with SMTP id x11mr6176769lbp.145.1460628287475;
 Thu, 14 Apr 2016 03:04:47 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 14 Apr 2016 03:04:17 -0700 (PDT)
In-Reply-To: <1460573236.5540.83.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291520>

On Thu, Apr 14, 2016 at 1:47 AM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2016-04-13 at 20:43 +0700, Duy Nguyen wrote:
>> On Wed, Apr 13, 2016 at 7:32 AM, David Turner <
>> dturner@twopensource.com> wrote:
>> > +NOTES
>> > +-----
>> > +
>> > +$GIT_DIR/index-helper.path is a symlink
>>
>> In multiple worktree context, this file will be per-worktree. So we
>> have one daemon per worktree. I think that's fine.
>>
>> > to a directory in $TMPDIR
>> > +containing a Unix domain socket called 's' that the daemon reads
>> > +commands from.
>>
>> Oops. I stand corrected, now it's one daemon per repository...
>> Probably good to hide the socket path in $GIT_DIR though, people may
>> protect it with dir permission of one of ancestor directories.
>
> I'm not sure I understand what you're saying here.  It should be one
> daemon per worktree, I think.  And as far as I know, it is.

No you're right, it's still per worktree. I assumed
$GIT_DIR/index-helper.path points to the same $TMPDIR, but it's not.

> Socket paths must be short (less than 104 chars on Mac).  That's why I
> do the weird symlink-to-tmpdir thing.

Is relative path in sun_path portable? We could just chdir() there,
open the socket and chdir() back. Though if the current solution's
already good enough, I don't think we need to change this again.

Hmm.. googling a bit pointed me back to Jeff's patch that does exactly
that. The commit is 1eb10f4 (unix-socket: handle long socket pathnames
- 2012-01-09). It does not mention Mac though, neither does the
related discussion on mailing list..
-- 
Duy
