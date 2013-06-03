From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: preventing evil merges
Date: Mon, 3 Jun 2013 19:37:00 +0200
Message-ID: <CALWbr2yLHN7VgPhH-HvyBx04pHasH=zr6fTXtjjsKJgqHA8kKQ@mail.gmail.com>
References: <20130530163459.GI31679@gnash>
	<7vvc5vglh5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sandro Santilli <strk@keybit.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:37:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYgt-0001Qn-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758131Ab3FCRhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:37:04 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:47387 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870Ab3FCRhC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:37:02 -0400
Received: by mail-qc0-f175.google.com with SMTP id a1so2313061qcx.20
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p5cwB4iCMf2ITIwZaBQ89dZ3yJYFHDeJf/ucGz/dN7w=;
        b=zqzgZzynx3ygAQtVCfB/P43iMWKtOUF8vw8tFiTBPHb/gub/kI/Pyf1HYjvinQgzm2
         qMa/E9IgstVJ009v1Nfi/e4HsAoKJQXkybGIeLLf5y94eDimOnxyWHVxMt8KIh1xMlgx
         WKgDPYAghyXQ5Ick4DpUTk66KiR8j355tKCcJjp4x7sG2qVPJZdY8/4oGG+pgMtp1Rlw
         DxYXMIbPCOulpus7/oOIdbVUZHBn8jasznjylO1RgMKJq5VxWz2gGmdsMlz3w0C9kc6Q
         CFwQcl+dYur8XMwjT6wjc1Eizp6GmnUq7acnc448mqHRuHyJeeCXu5ulXAOm33U2eEus
         QEJw==
X-Received: by 10.224.168.145 with SMTP id u17mr969445qay.83.1370281021023;
 Mon, 03 Jun 2013 10:37:01 -0700 (PDT)
Received: by 10.49.14.40 with HTTP; Mon, 3 Jun 2013 10:37:00 -0700 (PDT)
In-Reply-To: <7vvc5vglh5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226246>

On Mon, Jun 3, 2013 at 7:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sandro Santilli <strk@keybit.net> writes:
>
>>  git merge anotherbranch
>>  git add something
>>  git commit --amend
>>
>> After the steps above the addition of "something" can't be found in
>> the history anymore, but the file is there.
>
> This is a very common and sensible thing to do when dealing with
> semantic conflict.  Imagine that you changed the name of a global
> variable in the code on your current branch since the anotherbranch
> you are pulling from forked from you.  Then imagine further that the
> anotherbranch added one location that refers to that variable.
>
> Since they are not aware of the name change, they added the new
> reference with the old variable name.  The part they added is a new
> code, so it is very likely that there is no textual conflict when
> you did "git merge anotherbranch".  But now the result is broken.
>
> And you fix that semantic conflict by editing the file they added
> the new reference to the variable under the old name and make it use
> the variable with the new name.  You "git add something" and amend
> the merge.
>
> "git show" of the result will show you what happened, I think.

Also, you need to use --cc option of log to see the change in history
(in addition to -p):

    git log --cc -p
