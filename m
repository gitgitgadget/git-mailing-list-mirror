From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git issues with submodules
Date: Sat, 23 Nov 2013 12:23:29 +0530
Message-ID: <CALkWK0mt17FKUQUXCrL41E0dFx2XdxQQWP05CHjQjUf+g13rmg@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
 <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
 <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com> <528FC638.5060403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sergey Sharybin <sergey.vfx@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 23 07:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vk76d-0005Y6-UT
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 07:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208Ab3KWGyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 01:54:12 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50224 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab3KWGyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 01:54:09 -0500
Received: by mail-ie0-f180.google.com with SMTP id tp5so3592715ieb.39
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 22:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9T1MocFXywHOWBdulucNuxUYe0KeVwFoe8+swwLhJis=;
        b=GvczxfSOMfjZEGe/60bj7bVnhMn9VZ228LIjdsXvivWADZHIR0arE7auaS6M67B4D2
         0c5s3R1DVHujKkIq/G3ElpAaKWfLKv5LWn0I34bQefX/iSxExHv2y/e4+g3yxUBiW3O1
         bnQJqSOkyytXJOXE5as5Z5iOKn1OkUliQVUsTYAuVmO/4A6OAOZstlGzgJ0/2yWzODxv
         hkNlQq78YrfRT4Rpp7hKhwR2/FFSa3o6o5/j/r4JW4YHkTV0jrbVQ0aGsh5dkZT/BvdY
         lD8trRzAMTXJYYxOAK5N+ZmRXMpVCOidsESDAjLR9P9/QB1n4rD8LfSXgIkpCUpwXHuN
         /AbA==
X-Received: by 10.50.61.205 with SMTP id s13mr5399155igr.29.1385189649390;
 Fri, 22 Nov 2013 22:54:09 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Fri, 22 Nov 2013 22:53:29 -0800 (PST)
In-Reply-To: <528FC638.5060403@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238228>

Jens Lehmann wrote:
> But the question is if that is the right thing to do: should
> diff.ignoreSubmodules and submodule.<name>.ignore only affect
> the diff family or also git log & friends? That would make
> users blind for submodule history (which they already are
> when using diff & friends, so that might be ok here too).

No, I think it's the wrong thing to do. We don't want to show false history.

> The ignore setting is documented to only affect diff output
> (including what checkout, commit and status show as modified).
> While I agree that this behavior is confusing for Sergey and
> not optimal for the floating branch model he uses, git is
> currently doing exactly what it should. And for people using
> the ignore setting to not having to stat submodules with huge
> and/or many files that behavior is what they want: don't bother
> me with what changed, but commit what I did change on purpose.
> We may have to rethink what should happen for users of the
> floating branch model though.

I'd argue that the only reason the diff-family is blind is because the
commit hash changes in the first place; if the hash didn't change (ie.
floating submodules were represented by 0s hash or something), we
wouldn't have this problem. The correct solution is to also make `git
add' blind.
