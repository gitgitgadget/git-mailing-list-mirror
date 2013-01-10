From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: Re: [PATCH v4] git-clean: Display more accurate delete messages
Date: Thu, 10 Jan 2013 21:41:56 +1100
Message-ID: <CAKJhZwQ=RzLgCBUrx_QKY8Xzh-L8QC2UVcQJEpYxxGQz=8LwwQ@mail.gmail.com>
References: <1357514219-16102-1-git-send-email-zoltan.klinger@gmail.com>
	<7vk3rl3fw5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 11:42:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtFaU-0004vS-E2
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 11:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab3AJKl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 05:41:58 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:62704 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3AJKl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 05:41:57 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so376391iag.3
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3PGkD0Gko0VjocYeVbLyRE1WcYlFS5p9xUx5WbY/VmQ=;
        b=SyZ1rfBzPIYYdvHyBqyWyv8VP/mNa7BWZNtlJ6cwIyYVoAzu+CiGnlPJihb8Pc3JQY
         pAxtbz580NuvO6vlPyct4NI6piIs2kKrbljnBwMUqdul5eEga3+N1PiCpohFQ3DEACHv
         wlgWQk96FJPNlQZd8wAeZQK9Q/GNQ/5GX7j7+iw+ir6asiOg+Xa0dlwM09R24RSgitrc
         WK3HmRfsENbEkEAHVde2513O5TceQNsBcXTYsGMLmX/GSEHnKLQ+0mMtniBUkiWu7yDc
         UIxLY0VrTpaF2loKWNS3PUhSpX9NHn0bN36kf1UvpPx3i5PzyJvE1URG2E1H7YkjX6Vs
         8dAw==
Received: by 10.50.94.131 with SMTP id dc3mr1026619igb.50.1357814516734; Thu,
 10 Jan 2013 02:41:56 -0800 (PST)
Received: by 10.50.13.104 with HTTP; Thu, 10 Jan 2013 02:41:56 -0800 (PST)
In-Reply-To: <7vk3rl3fw5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213131>

> I think the code before this patch used to say "Would not remove"
> and "Not removing" in certain cases to report the paths that the
> command decided not to remove, but after this patch these two
> messages no longer appear in the patch.
>
> Is it expected, are we losing information, or...?
>

I do not think we are losing any information.
Say, we have a repo like this:
    test.git
     |-- untracked_file
     |-- untracked_bar
     |     |-- bar.txt
     |-- untracked_foo
           |-- foo.txt

The original version prints out:
  $ git clean -fn
  Would remove untracked_file
  Would not remove untracked_bar/
  Would not remove untracked_foo/

We never asked for any directories to be removed so IMHO the "Would
not remove ..." messages are just noise.

The new version prints out:
  $ git clean -fn
  Would remove untracked_file
