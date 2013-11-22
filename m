From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 17:35:28 +0600
Message-ID: <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
	<CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 12:35:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjp1L-0004rX-5V
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 12:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424Ab3KVLfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 06:35:31 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:41698 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069Ab3KVLfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 06:35:30 -0500
Received: by mail-ve0-f181.google.com with SMTP id oy12so805120veb.12
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 03:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oj+funCkJXhhpdVsAEDfG7suhiq2f3mQRLceLUrIYf4=;
        b=tCs2MgqroflDCXS+ySaPLHYmG9EmiMS+vgjaYzVy74cuelPL0iGpqR6vRUpqPLYgrt
         MjP4ScdDnag2FLNpzQ79EvpIPPFCpEOgKkeVIWR6uHRWXV1k3dLzIyFGZxTL/0iUK5F1
         ScAiTJeM5hVrJeXFHRgLrB0QE6NAi+P0ohySoJsBM4EKkC6t6VjrJxtQUzqlp2OQJpRG
         O3MUaMzTFZbJGyTp0q4T93klb8lZbqgLSp8VUCE0HkQVFbbPN86DXlxTNuaT+SEyXLFr
         KIlvGLydgJWcsQ7VXNF/xxgONzmtlHzOtewGxLTQEN4/dS6iK3kYAL8rFz5jFgPOxda9
         yaDQ==
X-Received: by 10.58.46.18 with SMTP id r18mr11063499vem.4.1385120128756; Fri,
 22 Nov 2013 03:35:28 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 22 Nov 2013 03:35:28 -0800 (PST)
In-Reply-To: <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238180>

Hey,

Answers are inlined.


On Fri, Nov 22, 2013 at 5:16 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>
> [+CC: Jens, the goto-guy for submodules]
>
> Sergey Sharybin wrote:
> > Namely, `git ls-files -m` will show addons as modified, regardless
> > ignore=all configuration. In the same time `git diff-index --name-only
> > HEAD --` will show no changes at all.
>
> This happens because diff-index handles submodules explicitly (see
> diff-lib.c), while ls-files doesn't (see builtin/ls-files.c). My
> opinion is that this is a bug, and git ls-files needs to be taught to
> handle submodules properly.

Shall i fire report somewhere or it's being handled by the folks
reading this ML?

> > This leads to issues with Arcanist (which is a Phabricator's tool) who
> > considers addons as uncommited changes and either complains on this or
> > just adds this to commits.
>
> Does Arcanist use `git ls-files -m` to check?

Yes, Arcanist uses `git ls-files -m` to check whether there're local
modifications. We might also contact phab developers asking to change
it to `git diff --name-only HEAD --`.  Is there a preferable way to
get list of modified files and are this command intended to output the
same results?

> > There're also some more issues which happens to our
> > developers and which i can not quite reproduce.
>
> Do try to track down the other issues and let us know.

I'm trying, but doesn't happen here on laptop yet. Will give it
another try (do have some ideas). Also directed our developers here
who experienced the issue and might give some details,

> > Sometimes it happens so git checkout to another branch yields about
> > uncommited changes to addons and doesn't checkout to another branch.
>
> I've seldom used submodules with branches, so I'll let others chime in.

Ok, thanks anyway :)

-- 
With best regards, Sergey Sharybin
