From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Sun, 15 Nov 2015 15:23:51 -0800
Message-ID: <CA+P7+xoyCwgYWaiVj0FNVHuaY=kUZA5a3LBMtpe6SirOVeK9rA@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com> <CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 00:24:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zy6ez-0000iS-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 00:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbbKOXYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 18:24:12 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36497 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbbKOXYL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 18:24:11 -0500
Received: by igcph11 with SMTP id ph11so46953483igc.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nDpiKdy9QMN7zMwqM/AoBxX99YAPRfk5SZRMigA5/kA=;
        b=JKVcrxNQWpk/VwIpyF1glJOMO+f9/FGFywMExSmWeeMNVOxN5Qkkew+6+kOc0v6M59
         /9qTx+ReB/h/+j33MHLY7NA8X13g7wFGPhLcULM0ZTMOQ/iJIkDoZQzTp53stUeQngQH
         l0zA+VOLj/1iO4/bKXvcmXEytnPc0BJyL4ZwxcM/cIJlfKW0/Png7HE7NwV6mJuR4ML3
         jHWxprRJ6nnkcjUjuW8aq4dxrB+avn7/9l8DkAC28mL+HJsZLBGDYTp1l5lCWfQiLqzS
         9q2HLdWWFabmu7uJznFx9GkrPpVI0F1LL1F4lQlDBn8PUhkDXsnlPgZ6Y8hrWp9xUZPc
         mdfg==
X-Received: by 10.50.87.71 with SMTP id v7mr8689920igz.92.1447629850386; Sun,
 15 Nov 2015 15:24:10 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Sun, 15 Nov 2015 15:23:51 -0800 (PST)
In-Reply-To: <CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281324>

On Sun, Nov 15, 2015 at 2:14 PM, Johan Herland <johan@herland.net> wrote:
>> ---
>> I do not remember what version this was since it has been an age ago
>> that I sent the previous code. This is mostly just a rebase onto current
>> next. I believe I have covered everything previous reviewers noted.
>
> Looks good to me.
>
>> I'm interested in whether this is the right direction, as my longterm
>> goal is to be able to push/pull notes to a specific namespace (probably
>> refs/remote-notes/*, since actually modifying to use
>> refs/remotes/notes/* is difficult to send to users, and remote-notes
>> makes the most useful sense). The first part of this is allowing merge
>> to come from an arbitrary reference, as currently it is not really
>> possible to merge from refs/remote-notes as we'd need it to be.
>
> Yes, I agree that merging from refs outside refs/notes/ should become possible.
>

Thanks.

> A related topic that has been discussed (although I cannot remember if
> any conclusion was reached) is whether to allow more notes operations
> - specifically _read-only_ operations - on notes trees outside
> refs/notes/. I believe this should also become possible, although I
> haven't thoroughly examined all implications.
>
> ...Johan
>
>

This was discussed at some point on one of the versions of my patch.
The tricky part is in how to get it implemented correctly.

We need to be able to correctly handle DWIM logic for things, and
ensure that what we're operating on actually looks "note-like" since
we don't really want to perform read-only ops on refs that don't hold
notes like objects.

Regards,
Jake
