From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/6] Introduce publish tracking branch
Date: Mon, 2 Sep 2013 02:38:21 -0500
Message-ID: <CAMP44s3cv9NmOXvdaF+iQgN03Q51rQ-WUJUrf+22U1AFFZKwbQ@mail.gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
	<vpq1u57n0rw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 02 09:38:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGOiR-0007bg-PU
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 09:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541Ab3IBHiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 03:38:24 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:44848 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488Ab3IBHiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 03:38:23 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so3258917lab.19
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z1N9yMIsDBofjzm6coyCwSFmIduQVN2SkCeJNxijJog=;
        b=uZUQw694Ex1/vo7FLJKHvtKbkyZYwQEcA2MRYAhsYNDwopr99URpGHs89ZoXjUAhDg
         Zh7V8UnAQ+USsE5dAfUsx6Ufq6aBksCthvO3Xo3moJtt+LDi6Q9NhAfdjCOTrptrybB0
         cXLGbS4TKLonApdMRIizXUQ+o9BU58B7kWVQyWvvwSm93Yl1hZWof/vCUeA+tIHJ7R4E
         GXVkxNoVxzZpbyLaqx80kotKqCUru3YuLpZ7f2icAlbwJIvT+6ggyalaKGP3GtY+8aFz
         EoZWptJtp5/PxHlBQOz7W8v+caloW2suingtbmtg9QfSA6QCjV8AVXpUwKvXZZPbveYD
         nodw==
X-Received: by 10.152.29.103 with SMTP id j7mr19980829lah.7.1378107501885;
 Mon, 02 Sep 2013 00:38:21 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Mon, 2 Sep 2013 00:38:21 -0700 (PDT)
In-Reply-To: <vpq1u57n0rw.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233628>

On Mon, Sep 2, 2013 at 2:25 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> As it has been discussed before, our support for triangular workflows is
>> lacking, and the following patch series aims to improve that situation.
>
> I may be stating the obvious, but isn't your series a duplicate of
> remote.pushDefault, introduced in 1.8.3?

How can you currently do this in v1.8.3?

% git push --set-publish github master
% git push --set-publish backup test feature-a

% git branch -vv
  master     xxxxx [origin/master, github/master] foo
  test       xxxxx [master, backup/test: ahead 2] foo
  feature-a  xxxxx [master, backup/feature-a] foo

% git checkout master
% git rebase # onto origin/master
% git push # to github/master

% git checkout feature-a
% git rebase # onto master
% git push --force # to backup/feature-a

% git checkout test
% git branch --set-publish github/my-test
% git push # to github/my-test

remote.pushDefault doesn't let you do any of that stuff. Maybe if you
only push to one remote, and all the branches have the same names, and
you don't need to keep track of them (with git branch -vv). In other
words, there's just no comparison.

-- 
Felipe Contreras
