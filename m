From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 11:43:13 -0700
Message-ID: <9af502e50806271143v206eb5afi193d4ed642f86c98@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <7vprq2rbfz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:44:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIvb-0007Fq-RH
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbYF0SnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbYF0SnP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:43:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:64955 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782AbYF0SnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:43:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so296971fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CKJ3m06gWpEBRtl4i1IiOzMQ8KiB5J5qy6tZw03aCQM=;
        b=nRYD47O9lE8atGoKxQBHMUTlO1FF347v02+6pjF19SGKozjoGywhFAbQDUGQE/tg98
         OGq8SNyGbAl1ZXTooWXFnFi90fW21cBt1h9Yhlq+0DjQlnDX2YePEo1P07gBlaWnrFHp
         +kCHQrM+47x/ud0hh8v/p6OJD/JaiizLkYRQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q0iiTkvk5LmbdkgcRRrV7E10PnwOjSLsoXv/eyY6V5VPv7cqk0Lzf+O6Z9ONZ7xp4T
         F5eh6i4ADF6poaUKDPgICZGVd5RCAlGSbhRi328iCA2rPX2VXcdsiEkVlmqe1CTmltub
         ypu1PJ7VSsh0XNICEUxYQCkHWxUSYjK+8fyBg=
Received: by 10.86.82.16 with SMTP id f16mr2327870fgb.9.1214592193065;
        Fri, 27 Jun 2008 11:43:13 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Fri, 27 Jun 2008 11:43:13 -0700 (PDT)
In-Reply-To: <7vprq2rbfz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86623>

On Fri, Jun 27, 2008 at 11:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I've always said that I am not in favor of any form of partial commits,
> exactly for the reason Robert states, namely that you are not committing
> what you had in your work tree as a whole.  I said so back when the only
> form of partial commits were "git commit [-o] this-file".  I said it again
> even when I introduced "add -i", that the interface goes backwards and
> does not fix the issues associated with partial commits.

We are seeing eye-to-eye here.

> But I agree with you that calling the index half-baked is missing the
> point.

What I said is that the index is a half-baked version of _what I
want_, which is the ability to do partial commits from testable
states.  Clearly the index is a way to do partial commits, but it does
not address the "untested state" issue, so it is only halfway there,
i.e., half-baked.

> The index is merely the lowest level of facility to stage what is
> to be committed, and there is no half nor full bakedness to it.  The way
> the current Porcelain layer uses it however could be improved and Robert
> is allowed to call _that_ half-baked when he is in a foul mood (even then
> I would rather prefer people to be civil on this list).

Fair enough.  I did not mean "half baked" to be particular provocative, fwiw.

> I would actually go the other way.  I think the problem we are trying to
> solve here in this thread is to support this (other) workflow:
>
>    You keep working, and eventually build all the changes intermixed in
>    your work tree, perhaps without any commit, or perhaps with a commit
>    sequence that is only meant as snapshots and not as a logical
>    sequence.  Your work tree state is in good shape right now (you do
>    build and test at this "commit goal" state).  Now you would want to
>    split the changes while making sure each step is good (i.e. builds and
>    tests fine as well as the patch makes sense standalone).
>
> One thing I think would make sense is to stash away _everything_ at this
> point.  That would take you to the state before you started working.  Then
> if we can selectively _unstash_ the parts that should logically be
> committed first to bring them to your work tree, then you can inspect that
> change against HEAD, test it, and when you are happy with it, you would
> make your first commit in the final sequence.

Exactly.  That was a good summary of the workflow I proposed in my
original email.

> Once you have capability to unstash selectively and make that first commit
> in the final sequence like so, breaking up the remainder that is still in
> your stash to a reasonable sequence of commits can be done with the same
> workflow.  Unstash the next batch, inspect, test and be satisfied and then
> commmit.  Lather, rinse and repeat.

Bingo.

Time permitting, I will propose a more well thought through UI for
this workflow.  If you like it, we can talk about how it might be
implemented.

Thanks,
Bob
