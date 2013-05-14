From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Wed, 15 May 2013 00:14:08 +0530
Message-ID: <CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com> <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 20:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKDW-0000No-74
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 20:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab3ENSou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 14:44:50 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:60113 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757889Ab3ENSot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 14:44:49 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so1846003iec.1
        for <git@vger.kernel.org>; Tue, 14 May 2013 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=6X2Glb4lvwRjwZD+9cGViwJuHiJKAcheyLA0jDd9msE=;
        b=Umz44eG7osyjotcHjMTZf36DsKhpZ7n6lVnIrWpFc5uFVBNWK/bQ1pw9yN/MqwUOFz
         vgMVvnYt6ufHHYQ0pwYDZ1dXDayWZF8yOiO4AvS2fjXsgonHGSJU0Np9SilARuvit6ZB
         xBKbKTQ5WNexgRWFQB3MwL/Aj4y7uiyYD3k4OscO1s59uW4PvZHK2FIjTgUjKwQF3rPB
         mHxQsewWIIfg4vjP9j1ZluAjR9WNilCQZj6Kv8BjyvNMlK0+F3ir5qTu8eX0p3r49uQq
         PcbVY79SYlOJKMB++qxm0dm2rZklc3VrNt9fYWk0WeF6aX8/i/OQpqZc52xj3mLNNFU4
         CQIQ==
X-Received: by 10.42.27.146 with SMTP id j18mr18047962icc.54.1368557089161;
 Tue, 14 May 2013 11:44:49 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 14 May 2013 11:44:08 -0700 (PDT)
In-Reply-To: <CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224313>

Phil Hord wrote:
> References to git-log seem out of place to me here in git-diffcore.  I
> know it's only an example, but it seems that Git normally describes
> these 'reference selectors' more generically.  The generic description
> may be more confusing to new users, but this patch is not the place to
> consider whether it should change.

It's not for new users at all.  The most useful application of -S and
-G is in log.  The translation from a log -G to a diffcore -G is not
obvious at all, and warrants an explanation.

Oh, and for the user.  No user is going to type out `man gitdiffcore`
out of the blue: she's most probably led there from log, and we're
connecting the dots for her.

> While the switches are called -S and -G, I do not think it is helpful
> to name the two pickaxe options as "the S kind" and "the G kind".

How do you describe something precisely without loss of meaning?  You
stop abstracting unnecessarily.  Read the sources: you will literally
see DIFF_PICKAXE_KIND_G there.

>> +
>> +The S kind detects filepairs whose "result" side and "origin" side
>> +have different number of occurrences of specified string.  While
>> +rename detection works as usual, 'git log -S' cannot omit commits
>
> The "cannot omit" feels like a confusing double-negative.  How about
> "includes" instead?

Intended.  Omission is expected.

> Is it worth mentioning that something in the documentation is "worth
> mentioning"?

You don't have to nitpick style.  We can allow this much creative
freedom in documentation.

>> +in effect, diffcore-pickaxe leaves only such filepairs that touch the
>> +specified string in its output.  When in effect, diffcore-pickaxe
>> +leaves all filepairs intact if there is such a filepair, or makes the
>> +output empty otherwise.  The latter behavior is designed to make
>> +reviewing of the changes in the context of the whole changeset easier.
>
> I find this description (from the original code, not from this commit)
> somewhat confusing.  It is written from the implementer's POV.

I explained the entire -S and -G thing in terms of filepairs (and yes,
that's implementation detail).  Why would I want to explain this in
any other terms?

> Does
> this seem clearer to you?
> [...]

>From diff-options.txt (the more end-user side):

When -S or -G finds a change, show all the changes in that changeset,
not just the files that contain the change in <string>.

Not clear enough?
