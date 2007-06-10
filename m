From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Mon, 11 Jun 2007 00:10:20 +0200
Message-ID: <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jun 11 00:10:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxVcC-0002qI-S7
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 00:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757302AbXFJWKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 18:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757470AbXFJWKW
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 18:10:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:26856 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302AbXFJWKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 18:10:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1870430wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 15:10:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dU2Ehx2YqX7nWEoW3XKpU/YC8DH2dYnIjITdLjytTT/GTxTmeZKhGuPGPPEIKYUkcSUvQ35HQpY8LD/YHzz0VQEeVj9yFOPLQTqsd2BrzmdGQdyMRvAtVkY0IvNqZrK/CEUDGpMO6j83SC1lq3HYGuoeKy4UPowhGJMaA6L4Vgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DRD+7fkTdH4MPLmbBT8qi6fnzSjTQmUkirsL+fiCmAg+QOGK4+idVxUBvR2frAS++MsMRuUYkKALUUJTnXdORXBo9HlgqJkfMDGyVC1qhGGLvVbaxC9XjSCgRXQnO/WVz8uwgaHExCUY9sTb8vV88Hi4xvWFdmPjxDmbpVc89TE=
Received: by 10.115.23.12 with SMTP id a12mr4821322waj.1181513421042;
        Sun, 10 Jun 2007 15:10:21 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 10 Jun 2007 15:10:20 -0700 (PDT)
In-Reply-To: <20070610150839.GG4084@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49778>

On 6/10/07, Jan Hudec <bulb@ucw.cz> wrote:
> Hello,
>
> I am thinking about adding commit --amend support to Qgit.
>

Good!

> However I see three ways to do it, so I'd like to ask whether anybody knows
> some reason why any of them is better or worse, which I don't:
>
>  - Add a button for "Amend". This would fit with what is there currently,
>    because with stgit it has buttons "New patch" and "Add to top" (refresh),
>    which correspond exactly to core git's "commit" and "commit --amend"
>    respectively.
>

>From 'Edit->commit' menu it is possible to open a dialog to commit
modified files in working dir.

Currently, at the bottom of the dialog there are 4 buttons:

- Settings (to open settings dialog on 'commit options' tab)

- Cancel (to cancel ;-) )

- Sync (to update the index but without writing a new tree)

- Commit (to commit a new revision)

In case the repository is under a StGIT stack the buttons are slightly
different, in particular:

Sync --> becames 'Add to top' (to fold and refresh changes)

Commit --> becames 'New patch' (to create a new patch with selected
modified files)


If I have understood correctly you plan to substitute 'Sync' button
with 'Amend'. Is it correct?

>    Disadvantage (for current approach too) is, that when amending (resp.
>    refreshing) the previous commit message is not there to be edited.
>

Yes but see below.

>  - Add a radio button the way git-gui does. Switching the button to "amend"
>    would load the previous commit message.
>
>    This would be more invasive change, but it would allow editing the commit
>    message when amending/refreshing. I fear it will be more user-error-prone
>    too, though.
>

I agree.

>  - Add a separate action to the menu. This action would take over the refresh
>    (Add to top) operation when using stgit.
>
>    I believe this has lower risk of user errors than the previous option. It
>    also has the advantage, that I don't have to touch the disabling logic for
>    the commit action. Amending last commit is always possible, even if there
>    are no changes, because you might want to edit the message (eg. if you
>    forget to sign-off or forget to mention some change or something).
>

Yes. But amending is an option of commit (also in git) so probably the
amend action will fire the commit dialog anyway and we are back to
previous situation. The only advantage is that we can load the message
of the tip revision as default instead of git-status output as the
current.


> I'll try doing the first option now, unless somebody persuades me that it's
> a nonsense.
>

I think it's the best: 'Sync' button is very seldom used (I think I've
never used it but for testing that it works) and updating the index is
something very plumbing anyway.

What we could add is another button 'Load prev msg' to do what it
says, so we would end up with 5 buttons:

- Settings /Cancel/ Load prev msg / Amend /Commit

I don't see a reason to set 'Load prev msg' as a check button, you may
want to reload the prev msg as many times as you need, (re)clicking
everytime on the button, also for a normal commit where as example you
want to keep the header or part of the subject of the previous
revision.

Please let me know if and where you find something obscure/messy with
the code, I will be happy to help you.


Marco
