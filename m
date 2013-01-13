From: Olivier Delalleau <shish@keba.be>
Subject: Re: Suggestion: add option in git-p4 to preserve user in Git repository
Date: Sat, 12 Jan 2013 23:56:06 -0500
Message-ID: <CAFXk4bp3RRkmEvubvYVRv795-92zn2tMrFJX61CcUQfyG6xB8g@mail.gmail.com>
References: <CAFXk4bpQo26sAfHkE5_VLi_UkZcgsYvwYNH8byZjuXs=EAhu+A@mail.gmail.com>
	<20130112163838.GA28722@padd.com>
	<CAFXk4bpM8X3k=iwRjM9kvm4XbZyKS+hTCiVbHOjH3jK6MkkBSg@mail.gmail.com>
	<20130112225640.GA23079@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 05:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuFcZ-0004Xz-7y
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 05:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab3AME4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 23:56:08 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:45727 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab3AME4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 23:56:07 -0500
Received: by mail-oa0-f49.google.com with SMTP id l10so3016693oag.22
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 20:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=NUqGlXqPkxUQk4uFCGJ0ohb3qu8NPLO03Wlnr0rf3+0=;
        b=DxN6/EaoBs3Ump3PLbJO3Y3JfrdBMASj3GyBRwngOcLW4WdRtQJbTcZibJ4hjfTKj+
         V4xqp8mz+0vHaDry0GOEXEsFb7lV7UWVGH0ZGqrqibvsJ+lqNa6jjgJKhg66YflQQSHI
         Ef9PXPWee6IeJdPTk4i6K1GI5if+P8ZsqSfGGvlyXajheMCEblVPv3EVaBfRf/2VTXDy
         287E9euI/5XjimVxWLf5eMmURg8+4sqD7Y1XF/UIyEGiKAqU4XCdLdVmrs5vxX4iWAXq
         bM5mrE0XP2dAFiFDgKwQ/8tXDVUGnnaQhyzN5jXx3Kjv9msgAk2GZl7gWZ4LB/8uHoKN
         toyg==
Received: by 10.182.216.38 with SMTP id on6mr5990208obc.65.1358052966712; Sat,
 12 Jan 2013 20:56:06 -0800 (PST)
Received: by 10.76.28.69 with HTTP; Sat, 12 Jan 2013 20:56:06 -0800 (PST)
In-Reply-To: <20130112225640.GA23079@padd.com>
X-Google-Sender-Auth: dr3WJf3E-Yt5c0TN8vlLAoM96Dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213330>

2013/1/12 Pete Wyckoff <pw@padd.com>:
> shish@keba.be wrote on Sat, 12 Jan 2013 14:44 -0500:
>> 2013/1/12 Pete Wyckoff <pw@padd.com>:
>> > shish@keba.be wrote on Thu, 10 Jan 2013 22:38 -0500:
>> >> I'm in a situation where I don't have P4 admin rights to use the
>> >> --preserve-user option of git-p4. However, I would like to keep user
>> >> information in the associated Git branch.
>> >>
>> >> Would it be possible to add an option for this?
>> >
>> > The --preserve-user option is used to submit somebody else's work
>> > from git to p4.  It does "p4 change -f" to edit the author of the
>> > change after it has been submitted to p4.  P4 requires admin
>> > privileges to do that.
>> >
>> > Changes that are imported _from_ p4 to git do have the correct
>> > author information.
>> >
>> > Can you explain a bit more what you're looking for?
>>
>> Sorry I wasn't clear enough. When "git p4 submit" submits changes from
>> Git to P4, it also edits the Git history and replaces the Git commits'
>> authors by the information from the Perforce account submitting the
>> changes. The advantage is that both the P4 and Git repositories share
>> the same author information, but in my case I would like to keep in
>> the Git repository the original authors (because the P4 account I'm
>> using to submit to P4 is shared by all Git users).
>
> Ah, I see what you're looking for now.  It's certainly possible
> to keep a mapping in the git side to remember who really wrote
> each change that went into p4, but there's nothing set up to do
> that now.  And it would be a fair amount of work, with many
> little details.
>
> You could put the true name in the commit message, like
> we do signed-off-by messages: "Author: Real Coder <rc@my.com>".
> That would keep the proper attribution, but not work with "git
> log --author", e.g.; you'd have to use "--grep='Real Coder'"
> instead.

Ok, thanks. I actually manage to hack my way around it, restoring the
author information with "git filter-branch" and overriding the remote
p4 tracking branch with "git update-ref". Did some limited testing and
it seems to work -- hopefully I won't have nasty surprises down the
road ;)

-=- Olivier
