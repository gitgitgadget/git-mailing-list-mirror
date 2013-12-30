From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: do not fail on invalid bookmarks
Date: Mon, 30 Dec 2013 08:41:13 +0100
Message-ID: <CALWbr2wYqxdMhaWfXQCOk3J_Mxy6=NcScyg9-__j8PPdhY7reA@mail.gmail.com>
References: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
	<20131229222433.GA31355@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 08:45:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxXXy-00032d-4f
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 08:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754459Ab3L3HlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 02:41:18 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:49538 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab3L3HlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 02:41:15 -0500
Received: by mail-lb0-f173.google.com with SMTP id z5so5335620lbh.4
        for <git@vger.kernel.org>; Sun, 29 Dec 2013 23:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=318tyA3iSxef6Ps96w7n5NXf69i/1p1ACKxFxqXwRag=;
        b=rj2nq22HeXw9hMuSzCCfHoFM0w0hH5wOZjcsu2+/WT7CSARks6tSWESdermnTfSuaO
         TUMNy5BKSxm/I1PnjZnHI8JVIZ/pg8oVFLewrP6m8Sz/3pP1TPiWO1LAlU3PB+RH67UA
         rmMNCoqprTjEosBjY2XE4Z9B4ZyPfZLUBdhJNyTDFUQosK4kww3sj8CQ4KvUd+lJ13GD
         SzkistV7DdhN4egwXp96O4S7ftx6GYG8rHv9qpha+5gGO1LhxXTIS3hf4gqhNmX0n4ck
         MBN/BL58RqXDnVE3PeV4SvfrzQjd7uod4lu2xHTm34rGAR6auevveNOyStejg8AEafH0
         E2gQ==
X-Received: by 10.152.234.75 with SMTP id uc11mr14095840lac.30.1388389273750;
 Sun, 29 Dec 2013 23:41:13 -0800 (PST)
Received: by 10.112.52.40 with HTTP; Sun, 29 Dec 2013 23:41:13 -0800 (PST)
In-Reply-To: <20131229222433.GA31355@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239800>

On Sun, Dec 29, 2013 at 11:24 PM, Mike Hommey <mh@glandium.org> wrote:
> On Sun, Dec 29, 2013 at 12:30:02PM +0100, Antoine Pelisse wrote:
>> Mercurial can have bookmarks pointing to "nullid" (the empty root
>> revision), while Git can not have references to it.
>> When cloning or fetching from a Mercurial repository that has such a
>> bookmark, the import will fail because git-remote-hg will not be able to
>> create the corresponding reference.
>>
>> Warn the user about the invalid reference, and continue the import,
>> instead of stopping right away.
>
> It's not invalid, it's used to indicate deleted bookmarks. (Tags have
> the same property)

Hey Mike,
Indeed, I don't know how I ended-up with such a bookmark, but it
prevented me from git-cloning the repository (and the backtrace was
not very helpful at first).
But I'm still not sure what you mean by "deleted bookmarks" ?
I guess it's not "hg bookmark --delete", as it would not be listed at
all. Is it "hg strip some_changeset" that end-up deleting the
bookmarked changeset ? I think I've tested this use-case and it moved
the bookmark to a parent changeset.

Antoine,
