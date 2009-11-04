From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v2] commit -c/-C/--amend: reset timestamp and authorship 
	to committer with --reset-author
Date: Wed, 4 Nov 2009 14:45:00 -0200
Message-ID: <55bacdd30911040845s6cec0873o2cccd7e0c3bf8f04@mail.gmail.com>
References: <1257304811-26812-1-git-send-email-erick.mattos@gmail.com> 
	<7vpr7ykbh8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 17:45:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5izJ-0003zu-T0
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 17:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757322AbZKDQpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 11:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757315AbZKDQpQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 11:45:16 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:35128 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757147AbZKDQpP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 11:45:15 -0500
Received: by gxk26 with SMTP id 26so4884348gxk.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 08:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=H/NskYFnGemIaoIaVVGB+4gllGkNo6F5i+YglZxf4qQ=;
        b=fasb1cFOn65tEEYUoSITZQ7n4GCiqmj7yPP2aOAtsT0XuXTuKFuWbiixBbB5HP7P6O
         tMR4V8XmUy2vWDuAE1/jaamfVmxc4OMsffywU33a8Op3mJ+ScXwdaU6GW/k25ouXhDBx
         RxbTkmP6lTa75D9VSNqvYD+xjBOB8VBIOouAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UArjcumsc4hOk+QkZ8/HbCk5PGudh7drd2kDLPlWmv7ofxC31DdoQhN+o8rLpXFfns
         A815Sv3Npim++u2Yt7C1bhoh7GAu21M2RGteKGXMQPqls0GE2VShZGS0o6P8bhrfEACj
         EC3pyu1UNeYBu2Nk8+Fp5iTaFnpp9O4VqZps4=
Received: by 10.150.61.15 with SMTP id j15mr3087895yba.154.1257353120101; Wed, 
	04 Nov 2009 08:45:20 -0800 (PST)
In-Reply-To: <7vpr7ykbh8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132095>

2009/11/4 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> Cutting --author away would make impossible for someone to force a new author
>> with a new timestamp in case he is templating.  As an example he can be using
>> the --author because he is doing a change in a computer not his own or
>> something alike.
>
> Sorry, but I cannot help feeling a bit frustrated and mildly irritated.
>
> I had an impression that we have already established that setting the
> author with --author="Somebody Else <s@b.e>" and committing with the
> current time does not make much sense from the workflow point of view long
> time ago in this thread.
>
> The mail transport might have mangled the name, and when using --amend (or
> read-tree followed by commit -c), it is handy to fix the mangled name by
> using --author, but in such a case you would actively want to keep the
> timestamp obtained from the e-mail via either --amend or -c.
>
> But allowing this combination, even though it might not make much sense,
> is just giving extra length to the rope, so it may not be such a big deal.

I don't see a reason to be hassled by a suggestion, made because I
didn't really was confident you got it right from me from the previous
email flood.  No big deal.

> I didn't feel motivated enough to read the whole thing while other patches
> are in my inbox, so I instead ran diff between the previous one (without
> my suggestion today) and this round.

I really can't imagine all the work you have.  Probably very hard.

As we were doing before, you were saying what was wrong to you and I
was fixing it to your
demands.  So I imagine that you are doing the diffs over my versions.

I haven't got a change in that way of working.

> I see that you fixed a lot of grammar in the log message of my earlier
> suggestion, all of which looked very good.  Also you added a check in the
> program to make sure that --renew is given only when -C/-c/--amend is
> given, which is also good.  Neither of our set of tests checks this
> condition, though.  IOW, we would need to add something like this at the
> end of my version (adjust to --reset-author for your version):
>
>    test_expect_success '--mine should be rejected without -c/-C/--amend' '
>            git checkout Initial &&
>            echo "Test 7" >>foo &&
>            test_tick &&
>            test_must_fail git commit -a --mine -m done
>    '
>
> I am not sure why you insist to use your version of test script and keep
> changing it, though.  It looks a lot worse even only after reviewing its
> early part.

As I told you before I thought you were wanting me to do it.  I didn't
get a change about me working under your supervision as the coder...

I know anyone in this list is able to code those or any other change.
It is just about who is available to work at anything in particular.

>  - author_id runs an extra grep that is unnecessary.  The separation of
>   _id and _timestamp are unnecessary if you checked against an expected
>   author ident and timestamp as a single string, i.e.

author_id or author_timestamp could be changed independently and a
single string would find it corrected in any case.  The new option
ought to change both as expected in the algorithm.

>   FRIGATE='Frigate <flying@over.world>' ;# do this only once at the beginning
>   ...
>   git commit -C HEAD --reset-author --author="$FRIGATE" &&
>   echo "author $FRIGATE $GIT_AUTHOR_TIME" >expect &&
>   author_header HEAD >actual &&
>   test_cmp expect actual

If you make my script fail in any of the checks then you are going to
have "trash..." folder holding the full message log history and the
file foo with each step recorded on it with the "initials" separating
the -C, -c and --amend.  This way you can also check the differences
in the author log timestamp among cited options because the "initials"
make a barrier in between.  I made it purposely to become easier to
audit.

>   This becomes irrelevant if we don't support mixing --renew and
>   --author, of course.

It won't be supported.

>  - message_body() now has a backslash whose sole purpose is to be an
>   eyesore.

No backslash then.

>  - initiate_test() does not string the commands together with &&

It is not something difficult to add.

> I might change my mind after I take a break, review others' patches, and
> spend some time on my own hacking on other topics before revisiting this
> patch, but at this point I find that reviewing newer rounds of this series
> has rather quickly diminishing value, and more time is being spent on
> teaching shell scripting to you rather than on polishing the end result.

Now you are being impolite and then I am not saying anything back.

> Sorry, but I cannot help feeling a bit frustrated and mildly irritated.
> Time to take a break and attend other topics for a change.
>

Again:  I don't see a reason to be irritated by a suggestion...

Sorry fellow.  I just tried to help.  Let me know if you want my work anytime.

And sorry for any communication problem we had, taking in account that
I am not a native english speaker.

Best regards.
