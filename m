From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Sparse checkout in worktree
Date: Wed, 25 Nov 2015 20:38:58 +0100
Message-ID: <CACsJy8Acb0Z3sw7_r6QfTTz=GqedsU76QxjexWf4yZFg9O7W-w@mail.gmail.com>
References: <5655AC29.20801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1fue-0000Y7-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 20:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbbKYTjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 14:39:31 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35684 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbKYTj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 14:39:29 -0500
Received: by lfdl133 with SMTP id l133so72751224lfd.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 11:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g5ZtEnKmU2MDPJeji6ZyXwD3MWlp7EFCL77GDLmAY08=;
        b=sn7YdQQkklrLfVL7hxgba0+UCAK3RP2ad9S4gS+6SyLMPEvi+RC4FbERe3JjPaGB+N
         jJ0ORcVsSVm2uAWxT3ci9ccnp8ur1AHd3e9NEIr/5C0fJVzDkZ5mmkk38+5N6QA0y1/t
         zIzrCQ+4mOBuRVDhqhChrFaLYPfHw4ExBQU8y5on447COc/LNYMa3MPDwErw2XZ+gELb
         e09Ue7gZ2shcNhNqydHHyU+Zmy1qGnte08tOPo65VEca/F0Gn7LoPA+MjNejoJztkksL
         DLE98Xy0A7Wc8sw+fF7K+qpIyuAmNsAgEhFjDFAKHRO56p/OfPqbfZPC7oUL4EjP7BMf
         MamA==
X-Received: by 10.112.202.168 with SMTP id kj8mr15886166lbc.12.1448480367989;
 Wed, 25 Nov 2015 11:39:27 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Wed, 25 Nov 2015 11:38:58 -0800 (PST)
In-Reply-To: <5655AC29.20801@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281731>

On Wed, Nov 25, 2015 at 1:40 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Hi there,
>
> I'm wondering how much it would take to enable worktree specific sparse
> checkouts. From a superfluous look:
>
> - $GIT_DIR/info/sparse_checkout needs to be worktree specific

It already is.

> - We don't have much tooling around sparse to speak of at all.
>
> The endgoal would be to have something like
>
> git checkout [--sparse <pattern>]...
>
> which sets up the sparse_checkout file and "git worktree" to pass any
> --sparse option on to "git checkout"

Or.. convert pathspec specified at 'git-checkout' (or git-worktree)
into sparse patterns. For example,

git worktree add --sparse some-path branch --  foo/

will automatically create sparse-checkout file that limits to 'foo'.
Not easy (and in some cases probably impossible), but it's more
intuitive.
.
> While in an ideal world we all have micro repos, in the real world we
> often have larger repos with mostly independent subdirs. For a quick fix
> on a side branch in a subdir, a new sparse worktree would be an ideal
> lean solution.

Sparse checkout should eventually be replaced with something better
that does not keep full tree in index, but I don't think anybody is
working on that..

> As it is, "git stash save && git checkout" is leaner but interrupts the
> workflow more, and a local "git clone" with links and alternates is
> leaner, too, but conceptually overkill if you want to work quickly on an
> existing side branch.
--
Duy
