From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 17:23:58 +0200
Message-ID: <CALKQrgdQRtfGmfaq9sS=VbezV2RVs9WJwUQBqVF+1Ozn7FxdJw@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
	<CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
	<7vhagndis4.fsf@alter.siamese.dyndns.org>
	<CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8ck-0007nj-Qb
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab3FXPYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:24:06 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:63384 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab3FXPYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:24:04 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur8cc-0001o7-Jp
	for git@vger.kernel.org; Mon, 24 Jun 2013 17:24:02 +0200
Received: from mail-oa0-f44.google.com ([209.85.219.44])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur7Vz-00008g-94
	for git@vger.kernel.org; Mon, 24 Jun 2013 16:13:07 +0200
Received: by mail-oa0-f44.google.com with SMTP id l10so12147645oag.17
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3ZQso+K0Ji9Yq2Il2gZml4bwwV2Hfl5P9iEb2L0OPfk=;
        b=cu+5X4YLOGrxOSCSLv4H6bTBxdUpKPlVSIMOBpH2xhZ8+TpvJsUDAv4t4jiNGxEDt6
         EFH3EAm4KB1FkL3MD/6nbEksn1qCBI9yY36aiOqRC8ZxF9qouV5lNYfhCJYNthpR8KHN
         IudjeMx9cvUALp8IqBcyBvxlmpPpo90GXpgbozUkyHrm9V1gRbFOlI+v5TOvn27ev8kK
         L4annnF3kYeQxQ3UwT7fow4q0yq33Ff5kGr088rBC5WXziSyKbmmuqC5LCfFN885vbyf
         04JVUOrEYfMXMM6hZQjKdhSsJqCmsrLiGip+dOou1bnPUps+Y+wzwj1V9KwrZ+m6r/Ah
         rqQA==
X-Received: by 10.60.94.72 with SMTP id da8mr11323248oeb.123.1372087438955;
 Mon, 24 Jun 2013 08:23:58 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Mon, 24 Jun 2013 08:23:58 -0700 (PDT)
In-Reply-To: <CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228839>

On Mon, Jun 24, 2013 at 4:19 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Junio C Hamano wrote:
>>>   # on branch master, derived from origin
>>>   $ git push ram
>>>
>>> And branch.master.push is set to next?  Will you let her shoot herself
>>> in the foot like this?
>>
>> It is not shooting in the foot, if branch.master.push is explicitly
>> set to update next.  I do not see any issue in that part.
>
> The question does not pertain to master being mapped to next; it
> pertains to central-workflow versus triangular-workflow: origin versus
> ram.  If the user has set push.default to upstream, she _expects_
> triangular pushes to always be denied, and this is the first violation
> of that rule.  I'm tilting towards building a dependency between
> branch.<name>.push and push.default.

I haven't followed this topic closely, and the concern described below
is probably a consequence of that. Please ignore if my worries are
unfounded.

It seems to me like we're adding (or have already added) quite a bit
of config variables and command-line options for specifying (at
varying levels of specificity and overridability) either the remote to
push to ($remote), or what ref to push into on the remote
($remote_ref). It worries me that we allow $remote and $remote_ref to
be set _separately_ and at separate levels of specificity. I wonder if
this too easily allows users to shoot themselves in the foot by
specifying $remote in one place (e.g. on the command line), then (in
their mind - unrelated) specifying $remote_ref in another place (e.g.
branch.foo.push), and then being negatively surprised when the two
conspire to push into the "wrong" $remote and/or $remote_ref.

I haven't yet dug deep enough to figure out an obvious failure mode
(and I probably should not have sent this email until I'd found one),
but I wonder if we'd be better off forcing the $remote and $remote_ref
configuration for a given branch to appear as more of a single unit.

What if, when setting up tracking for a given branch, we immediately
specified its complete pull and push targets?

For example, when in a centralized workflow (e.g. push.default =
upstream) and we're checking out local branch foo from origin's foo,
we could set up the following configuration [1]:

[branch "foo"]
    pull = origin/foo
    push = origin/foo

In a triangular workflow (assuming we had configuration to specify
such, and also a default push remote), we could then instead set up
the following config:

[branch "foo"]
    pull = origin/foo
    push = my_public/foo

This leaves no ambiguity for even the most novice user as to the pull
and push targets for a given branch, and it's also easy to change it,
either by editing the config file directly, or by using hypothetical
commands:

  git branch foo --pulls-from=origin/bar
  git branch foo --pushes-to=other_repo/foo

Any "git pull" without arguments will fail if branch.<current>.pull is
unset or invalid. Likewise any "git push" without arguments will fail
if branch.<current>.push is unset or invalid.

Obviously, specifying the remote and/or refspec on the command-line
would still override, as it does today, but for the argument-less
forms of "git pull" and "git push", the hierarchy of options and
defaults being consulted to figure out $remote and $remote_ref would
be small and easily understandable.


...Johan


[1]: I do realize that I'm abusing the "foo/bar" notation to mean
"$remote/$ref", and that this does not work in the general case where
both remote names and ref names may contain slashes, or when remote
names don't correspond to eponymous ref namespaces...

-- 
Johan Herland, <johan@herland.net>
www.herland.net
