From: Brett Randall <javabrett@gmail.com>
Subject: Re: A couple of rebase --autosquash proposals
Date: Tue, 10 Dec 2013 10:20:30 +1100
Message-ID: <CALeEUB7ztc0Cfz0J2MJp0HiiDNY1y98AarGeSGKKCtdp_bjekQ@mail.gmail.com>
References: <CALeEUB4mTpd9tHJCC9Ffrfe6L=m0+gaDsXYSFGaO_tMcxCX_nA@mail.gmail.com>
	<52A56887.4070909@viscovery.net>
	<xmqq1u1lzshd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 00:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqA7v-0004eH-JO
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734Ab3LIXUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 18:20:31 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50557 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab3LIXUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 18:20:31 -0500
Received: by mail-ie0-f172.google.com with SMTP id qd12so7466273ieb.3
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 15:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=bVXvdgqi1ziaMZ4eyqkrk/CZZsrWPA40fx9K0pIWwRQ=;
        b=Y/CugiV6PzXda78u56TOIRQAwa5ffCcwq3z7tEM+UeBWmHbVhnVjWPl1L7phbP1kCp
         6uRIyZY+M/FmX32Qw2IJruPUNKmI6ateFjDF6dbrW8+WiAuijrig4dmhDrtu/r5XNUYF
         3garaMcxMVfRExdEYGaXWqg/mjprTN+ybeXccp4Y1EJlrf6rAtmYl/0qG/q+c2OKxWP7
         qo/bSKBc9qrBNWawk+w/RcQ7cTZmoQi6fcM0v8CmPrAx0KK8z7PRIaYXhBOjayA0GtNE
         lXHn1gEMOiYTWW6FVbOBggCr2eHa+PS9HGxhcYvg2DHuX4XFWz9kAbPrLJmTxXrzLhb/
         /XKg==
X-Received: by 10.50.83.97 with SMTP id p1mr17683779igy.41.1386631230814; Mon,
 09 Dec 2013 15:20:30 -0800 (PST)
Received: by 10.64.126.169 with HTTP; Mon, 9 Dec 2013 15:20:30 -0800 (PST)
In-Reply-To: <xmqq1u1lzshd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239120>

I had not previously noticed commit --fixup, so that is something
useful I have learned from this thread, thanks.

The workflow here can be summarized as "I have an initial commit and
subsequent, review-generated commits, that I'd like to share on a
review-branch with proper commit-log comments, but also pre-marked for
future --autosquash".  So when the review is completed, I can auto
squash/fixup all the review-generated commits and rebase onto
origin/master at the same time.  I find this more appealing than
continually pushing rebased branches to colleagues, as the history is
lost and it is hard to review incremental changes.

I can live with it as it is: I just use rebase -i and change all
review-generated commits pick -> r as if autosquash didn't exist.
It's just that when I first tried-out fixup!, I mistakenly thought
that I could use the first line as the special syntax, and use
following-lines as annotation - which is not the case, but I thought
it might be worth suggesting here.

Brett

On 10 December 2013 07:20, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Am 12/9/2013 3:23, schrieb Brett Randall:
>>> * fixup! or squash! on it's own would default to fixing-up the
>>> previous commit (or result of previous step of rebase if that was a
>>> squash/fixup).
>>
>> Why would you want that? To fixup the previous commit, just use 'git
>> commit --amend'. What am I missing?
>
> When you are not absolutely sure if the amend is a good thing to do.
>
> Then
>
>         work work work
>         git commit --fixup HEAD
>         work work work
>         git commit --fixup HEAD^
>         work work work
>         git commit --fixup HEAD^^
>         ...
>         git rebase --autosquash -i ...
>
> may become a good way to polish a single commit.
