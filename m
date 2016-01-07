From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG?] worktree setup broken in subdirs with git alias
Date: Thu, 7 Jan 2016 16:26:02 +0700
Message-ID: <CACsJy8CRJhdb9Gf+SkC+BSHuGa0DPEBZnCDRUa7zkJvrBK72kQ@mail.gmail.com>
References: <568E10A7.5050606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 10:26:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aH6q7-0005rm-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 10:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbcAGJ0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jan 2016 04:26:36 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33042 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcAGJ0d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 04:26:33 -0500
Received: by mail-lb0-f177.google.com with SMTP id sv6so196963085lbb.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 01:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CH7xXZqyrH9MX3NfoYDEEV1258+ptqFs5/athBp391s=;
        b=tyNepnn27ZmIOeh8CVOryl001qxZ8EcfrLjvqp7fEu8IIOBtbnowcxDjkC0h0WuYMo
         1eScRe7ElLE9pkOUh9I+RPDnIrX97UgpWNjCVi9Xa+0tAcK5Eyoa1mg6n5QP4Gv0X22A
         PKA2Tu0RvWYaeMKX6Ho/69EFzlp0inOCn2uBzFGbpoJ7JygdEA1NftmmnuYk8h/8QezU
         0WoZLXvpcBj4+3WWUrC8HiQFKDDVB4bu0Naywzxd/3AYQBG+4zS8R6oTAdz9H0R2cJtO
         MZRCToW9rGWnNW2Sb3pI8Bn5KJWp/jwF8KKliTQHprlmp6Vr3y8avBbOSX0FWSoyJeba
         Lhig==
X-Received: by 10.112.168.70 with SMTP id zu6mr36701812lbb.26.1452158791891;
 Thu, 07 Jan 2016 01:26:31 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 7 Jan 2016 01:26:02 -0800 (PST)
In-Reply-To: <568E10A7.5050606@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283472>

On Thu, Jan 7, 2016 at 2:15 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Hi there,
>
> sorry I can't dig deeper now, but the worktree code from next seems t=
o
> get confused now as soon as you cd to a subdir of a worktree (other t=
han
> the main worktree) and use an alias:
>
> git help ss
> `git ss' is aliased to `status -s -b'
> [mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git status -s -b
> ## exam
> [mjg@skimbleshanks Biomath-WS15 (exam $)]=E2=9C=93 git ss
> fatal: internal error: work tree has already been set

You forgot to mention what version you used. But it's probably related
to d95138e (setup: set env $GIT_WORK_TREE when work tree is set, like
$GIT_DIR - 2015-06-26). This commit fixed your problem (and was
released) but it introduced some other regressions so it's been
reverted in 'next'. 'pu' has a re-fix on top of the revert.

> Current worktree: /home/mjg/Teaching/LUK
> New worktree: /home/mjg/Teaching/LUK/Biomath-WS15
>
> This is inside the subdir "Biomath-WS15" of the worktree residing in
> ".../LUK".
>
> It wasn't like that last year ;)
>
> Something about setting GIT_DIR and the like in the environment must
> have changed (for aliases), badly interacting with the worktree code.
>
> Michael
--=20
Duy
