From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] commit -c/-C/--amend: reset timestamp and authorship to 
	committer with --reset-author
Date: Tue, 3 Nov 2009 21:51:43 -0200
Message-ID: <55bacdd30911031551k1bfd3151t940864e4793f5a37@mail.gmail.com>
References: <1257282551-9999-1-git-send-email-erick.mattos@gmail.com> 
	<20091104073822.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 00:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5TC5-0004dd-NF
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 00:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717AbZKCXwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 18:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbZKCXwA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 18:52:00 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:52493 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbZKCXv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 18:51:58 -0500
Received: by yxe17 with SMTP id 17so5915911yxe.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Wh6rhlmwAiwaDmMancK7NVPab2tmeVx9+geah+P79Wc=;
        b=Y9uFrkjUd0/PU+vWvJnb60fU2yIHvHWeJsn5RbCOzNVSDUJUpphBuUiJnbsJUvKbjz
         sLWDiv3JTI1X9qMhp0o0RBpW7DduJPYgTsaC/Xq1R5CMMVLFu/IOxeeLmVLjcbKHa0PR
         S8Nc00YFHx+UFdVDO2pEGso3cxnEl60dJVOvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rrXZMQS/A5qxqdaN4L5NA1AnpBWkEbWnuwK82DXatZLFckI5UgagdzP8Rtnf+zXFQp
         66h9XpwdNaY6DkDHBufJYpaO675a+NAc5LCegg1TreHpCOwmKb6Obp4DEj/Ntf4NQEir
         6LDhKH7tKNW2LZeqdNlRNNn2gpYQlSss+5jzE=
Received: by 10.150.213.7 with SMTP id l7mr1356614ybg.220.1257292323085; Tue, 
	03 Nov 2009 15:52:03 -0800 (PST)
In-Reply-To: <20091104073822.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132010>

2009/11/3 Nanako Shiraishi <nanako3@lavabit.com>:
> If you are sending an update to a previous patch (I am comparing
> this patch with the "show by example" patch Junio sent on 11/02
> http://article.gmane.org/gmane.comp.version-control.git/131893),
> it is a common courtesy to summarize what you changed relative
> to the base version after the three dashes line, so that people
> will know which part can be skipped while reviewing your patch.

I got your point.  I will try to improve that.

I have been talking to Junio during the weekend and with a lot of
emails sent to each other.  It happens that when he sent gmane/131893
(I had to find out what that code meant because I was using
[marc.info]! :-) ) I had already sent another patch with the
suggestions he made in a previous email.
So his message was late.  While I was waiting for his acknowledgment I
started thinking he could be lost on those e-mails so I sent the one
you are replying to make it the last on the queue.

> I have to say that the test script is much worse than what
> gmane/131893 had.
>
> The old test made sure that -C copied the message, with or
> without the --mine option. But this test only checks the
> author line (and it doesn't even make sure that "^author"
> matches only in the header). The messages are unchecked,
> and it will let a bug when someone breaks --reset-author
> logic in the future in such a way that it corrupts the
> message by mistake go unnoticed.

I think you misunderstood something here:
* On his patch (which he sent before seeing mine), while testing -C,
on first check, he is checking author_header only.
* While testing -C on mine I compare both messages without "parent",
"tree" and "committer".  Whole!

After check one I did concentrate only on author data.  But on mine I
separate the tests between timestamp and author (name and email),
making sure the author was set to the actual committer and that the
timestamp was behaving as expected.

I am not saying mine is better.  What I am saying is that I expected
him to notice and change/improve THIS patch.  Not the other.

The new option only touches on getting new author or copying the
original so that is why I made the first check in whole and the others
only by author.  If people think that this operation is so uncertain,
then everything should be compared: parent, author and message on all
tests.

It is not a problem for me adding more code to the test even if I
consider it unnecessary.  I am doing this only to give a pay-back for
all the good service this free software gave to me so I am very
patient to all demands.  I will be letting this effort go only at the
real end.  No matter how long it takes.

> Also the old test was much more readable because it used
> shell functions to avoid repeating cat-file and pipe to sed
> script. It also tagged the initial commit, which had a nice
> effect that a failure in any intermediate test will not change
> which earlier commit is reused (eg. yours say "-C HEAD^" but
> old test said "-C Initial").

I am so used to scripts that I really haven't thought it difficult to
read but I can do some cosmetic too if it is important.  As I said
early, I was waiting for Junio's jugdement over my later patch.

> It looks silly to create an "Initial Commit" in the middle
> of history, too (^_^).

This is something more laborious but which I thought was important to
let murphy's law act on a real case.  We never do an amend on an
initial commit so I only did the tests on a later one.

> I think it is much better to replace "--mine" in gmane/131893
> with "--reset-author" and make no other change to the test.

Let's see Junio's opinion...  We have changed names a lot since start.  ;-)

> --
> Nanako Shiraishi
> http://ivory.ap.teacup.com/nanako3/
>
>

Thank you very much for all your comments.  I really appreciate about
being noticed by you people.  It is nice for a newcomer!
