From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-notes, how do they work?
Date: Sat, 12 May 2012 18:01:40 +0700
Message-ID: <CACsJy8DRujbCc5Etod8eCoUW5+SxK-1qbJaAYw7gdvkO2SdSRw@mail.gmail.com>
References: <20120512104332.GN71676@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ulrich Spoerlein <uspoerlein@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 12 13:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STA5Z-0004DL-H0
	for gcvg-git-2@plane.gmane.org; Sat, 12 May 2012 13:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab2ELLCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 May 2012 07:02:13 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47414 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab2ELLCM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2012 07:02:12 -0400
Received: by wibhm6 with SMTP id hm6so221790wib.1
        for <git@vger.kernel.org>; Sat, 12 May 2012 04:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e5naP5EFn/QL1gIL1N5vgglR+NilIOjrRbc1ysM9oDs=;
        b=jsqkCE8BCCe+YwW4fVFIlT4odP04rnI5PZVdI6r3oF2Nje7wk6a8VK6xYA0qHeUMnV
         U/tjwpmfpuG2dQoCqzerS6DQ0HZtKYsbfb5E9fVECjLDYoduntod3bsDNrfFTFqPk7XB
         CkQvhwJu7hWgJinLgNCxiQkKEzOeRQ0d1uUP5HLOopPjC1ioGcTUN+fD5T0aiW0loSaA
         3kz1rJ1JLD0MCzWqd90QdorCd5WnNvnhPj1sFIAmjoGqDpm24gJd4IwUC0PzFoYi2r7T
         dY7RsTw2VNFNaD/Qa/XgBa13Jj7zkRNum6l8PZIHmIZPDGPadTvvP7QXL9pc2BiLjp4N
         aSkg==
Received: by 10.180.97.3 with SMTP id dw3mr3491551wib.19.1336820531022; Sat,
 12 May 2012 04:02:11 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 12 May 2012 04:01:40 -0700 (PDT)
In-Reply-To: <20120512104332.GN71676@acme.spoerlein.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197722>

On Sat, May 12, 2012 at 5:43 PM, Ulrich Spoerlein <uspoerlein@gmail.com> wrote:
> IIUC refs/notes/commits points to the latest note, which points to HEAD.
> However, there's no reference that points to the note pointing to
> HEAD^1, so how will it not be garbage collected?

No. refs/notes/commits points to a commit, whose tree contains all
notes at the last time a note is changed. This commit has a parent
commit that stores note snapshot of the previous change and so on..

refs/notes/commits is an ordinary ref, which is searched for
reachability at gc time, so all notes (even replaced notes) cannot be
deleted.

> How can it be pushed to a remote repository?

What I wrote about were my findings while I studied the notes code.
I'm new to it too. And I believe there's no mechanism to transfer
notes. Of course you can transfer resfs/notes/commits like any other
refs, but the objects those notes are attached to might or might not
exist at destination repo.

> I understand that notes cannot point to older notes, as that would make
> removing/adding notes from/to older commits quite a hassle.
>
> So, what am I doing wrong here? How can I avoid notes from disappearing
> so that each and every one of it remains in the repo?
-- 
Duy
