From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 14:38:18 -0700
Message-ID: <xmqqbnewc69h.fsf@gitster.dls.corp.google.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	<xmqqsi88c8m9.fsf@gitster.dls.corp.google.com>
	<1438118327.18134.42.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:38:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKCZt-0007cN-HD
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbbG1ViV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:38:21 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35823 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbG1ViU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 17:38:20 -0400
Received: by pabkd10 with SMTP id kd10so75928711pab.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rZXxHD3skixCj85hmzWhADjxA5jQP9oSI5X1Gwh1uX0=;
        b=KTQXUzRSoR6/WNtwsQTwRPv7LfDRH6ZzVpN77IW4d50oWKtjDHYo1jbuun46DW3tBf
         0F53rxM8Wt7mFIcGmg1ZieKuesJtfr6HnDBQlFpTcVMLQmd4ktN9eCD5Vry3ltpA68IV
         80jaaXvWQoQ9TvU1no0JoPhaU+RGLrtHwK2sRtqfn10dYnH1r4HYrSBr8OcEhs33DtXt
         HftHzd1LzMZTxoH5SMqyIHLKyZQvrlhkBQGBN6otHGz6p5zUv37Hj/ekPUq8Ru5c83Pl
         J3KwJZ8hhaKXYHrkZaKFbMgALc8M9S3tMs5rbNwuSX52ysop9JBtVd3+dhoaHXkSJhsT
         99cw==
X-Received: by 10.66.119.174 with SMTP id kv14mr73951689pab.115.1438119500170;
        Tue, 28 Jul 2015 14:38:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id 2sm36875489pdp.68.2015.07.28.14.38.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 14:38:18 -0700 (PDT)
In-Reply-To: <1438118327.18134.42.camel@twopensource.com> (David Turner's
	message of "Tue, 28 Jul 2015 17:18:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274853>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2015-07-28 at 13:47 -0700, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>> 
>> > When we unpack trees into an existing index, we discard the old index
>> > and replace it with the new, merged index.  Ensure that this index has
>> > its cache-tree populated.  This will make subsequent git status and
>> > commit commands faster.
>> >
>> > Signed-off-by: David Turner <dturner@twopensource.com>
>> > Signed-off-by: Brian Degenhardt <bmd@bmdhacks.com>
>> > ---
>> >
>> > This patch is by my colleague, Brian Degenhardt (as part of his work
>> > on git at Twitter).  I'm sending it with his and Twitter's approval.
>> 
>> I'd need to tweak the From:/Author: line then, and flip the order of
>> the sign-off, as Brian wrote and signed off then David relayed (as
>> attached).
>
> Where do I put an Author: line? In the commit message above the
> signoffs?  As an email header?  I didn't see an option to git send-email
> that would do this.  I don't want to use the From: header because I want
> to be the point-of-contact for these patches.

The message you are responding to would have been a good example of
forcing the author, subject and author-date to be different from the
e-mail headers.  That is, if you did "git am -s -c" on my message
you responded to, you would have seen a new commit authored by
Brian; and anybody responding to the message would have sent that
e-mail to me (and git@vger.kernel.org).

I think that is the arrangement you are looking for.

Delete everything before and including the "-- >8 --" line from my
message you responded to and then the person who applies does not
have to say "-c" but just with "git am -s" the same thing would have
happened.  E-mail coming from (and reply going to) you, but resulting
commit would be authored by Brian.

"git send-email", if you are sending somebody else's commit, should
automatically add the in-body header "From: Brian ..." as the first
line of the body, with a blank line and the body of the commit log.

>> By the way, I wonder if we can lose/revert aecf567c (cache-tree:
>> create/update cache-tree on checkout, 2014-07-05), now the
>> underlying unpack_trees() does the necessary cache_tree_update()
>> when a branch is checked out.
>
> Well, the tests still pass, so I guess so. That is, we still need the
> WRITE_TREE_REPAIR bit, but not the update check.
>
> Will re-roll once I hear back on the author line.

Let's not do the "drop cache-tree generation from checkout" in the
same patch.  It can be done as a separate patch but I do not think
it is a very high priority.

With that understanding, what I have received from you (with a minor
tweak shown in the message you are responding to) is already fine, I
think.

Thanks.
