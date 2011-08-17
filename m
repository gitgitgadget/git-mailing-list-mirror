From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Wed, 17 Aug 2011 14:23:51 -0700
Message-ID: <CAE1pOi3rqqcz_6QxB8=g2jWOF-4SRZee7t8NXN1md2C4DL7wug@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CABNdCrCbSqup1=D2eEbGDhw3JzZGYHWLVqZFsB6GDO4Vk7HRxg@mail.gmail.com>
	<7vvctvdf5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 23:24:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtnag-0004yL-Kx
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 23:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452Ab1HQVXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 17:23:53 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62147 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab1HQVXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 17:23:52 -0400
Received: by gxk21 with SMTP id 21so1074815gxk.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TbFSCpf+//5c4gtYokjaRT/EaI83r56T+uoAMYnsoQM=;
        b=Jv/RqaXv4d2178vBFHS0VaUwMFgbrl9867sh+kXGV8UyHAfnL8+SBpzOoST7OJcOYT
         wbIxmcXSILvjladEGfyGfSQYo2O1yFxiUOBS72+3n57igZ+LtSUh8UK3TQI6fA3Bla41
         5wHrOMfIoerzVExsayBFr6gK+kS2VKHBMqQeg=
Received: by 10.236.9.41 with SMTP id 29mr4749216yhs.212.1313616231740; Wed,
 17 Aug 2011 14:23:51 -0700 (PDT)
Received: by 10.236.207.67 with HTTP; Wed, 17 Aug 2011 14:23:51 -0700 (PDT)
In-Reply-To: <7vvctvdf5r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179537>

On 17 August 2011 12:14, Junio C Hamano <gitster@pobox.com> wrote:
> Evan Shelhamer <shelhamer@imaginarynumber.net> writes:
>
>> (in repo on your branch)
>> mkdir test_dir
>> touch test_dir/.gitkeep
>> touch test_file
>> git add *
>> git commit -m "test commit (with directory)"
>>
>> Will commit the directory as expected in your branch, and when you go
>> to checkout another branch it will not exist.
>
> ... unless you have untracked files in test_dir/, that is.
>
> If the branch you are switching to does not have anything at test_dir, you
> will not lose the untracked file because git does not remove test_dir/ nor
> its untracked contents.
>
> Depending on what you have at the path "test_dir" in the branch you are
> switching to, the actual rules are a bit more subtle than that, though.

Yes, I should have thought of that. The problem is with .gitignore. I
have a number of files ignored that are important but can't be shared.
So when I switch to 'master' the directory is not removed because it
contains untracked, ignored files. And, of course, git status does not
complain about them either because they are in .gitignore. :-)

This is still very annoying but hardly Git's fault (Git is working as
intended). It would be really nice, though, if Git could somehow
"stash" such files when checking out a different branch. In general, I
would prefer if uncommitted changes and untracked and/or ignored files
stuck to the branch where they were created. If I want to take them
with me when I switch branches that should be possible but not the
default behaviour. Is anything like that possible? Are there
configuration options for this?
