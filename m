From: David Ware <davidw@realtimegenomics.com>
Subject: Re: [PATCH v5] contrib/subtree: fix "subtree split" skipped-merge bug
Date: Thu, 14 Jan 2016 08:33:53 +1300
Message-ID: <CAET=KiVY5g41YgCbGqDqUaDjrd-Do9jNf=1L6xbBPcUoGcM2Kg@mail.gmail.com>
References: <CAPig+cSfkz=SNOn+8yP-QN8gJ0ej1wo3HW+y3NO+QvUCOP=+8A@mail.gmail.com>
	<1449695853-24929-1-git-send-email-davidw@realtimegenomics.com>
	<87y4bunopj.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:34:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJRBF-00006m-9G
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 20:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbcAMTd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 14:33:56 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:32894 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbcAMTdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 14:33:54 -0500
Received: by mail-vk0-f43.google.com with SMTP id i129so129305222vkb.0
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=realtimegenomics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=195eH68itNVpargLruEAcZKaX7yGr+D93kp+yseYtjA=;
        b=GUxLLTF3YaotSa99/7Opp/8We3yidW/s24QGEAlNLBJZKXdjCg6t1I3kS7jfbTzcRV
         XWhk7h7wMFGmMwOm+cUJj4VfGKRAiSqoJqRuWrGJpAHmk0nbOcVb8plvKjEJPdKNs9OA
         /iy6q83wSfmAYptn/EwKqjtKkBysAo0PrV8qV76ulKeWaVQrzflGvDZ3N6koPup5DCOb
         TrE1iI+/aGKPb2Kl3eBC8qdj++eOAPa6nNB+VH7wNXPiu1l8bpm3QBsgu8g9stfZ8rJR
         eWvsQD9FepL+GnzRI1pcHETWPAYj/HY07m6ZcceWZJ3QwDDlFYGHl/aRkJjVc1oIqFCV
         KRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=195eH68itNVpargLruEAcZKaX7yGr+D93kp+yseYtjA=;
        b=DyHFYXF3gxzOm0f+NkpKuOsw3MusZjtZ4gbig+HU+947btQu6T0EUGVqoSYh5H4bJS
         LSmkGErwTIVlYFADplT7gRJCbrjcx+L984amrMtuuMg8BDSz2baC/UTZuSTS20d3+f80
         CViMtJxcrBwIq42e9moHnNR7FsFb8RXzgGrbHqCTETn4mBS8pF3ryJ4hlmOQTnuNpRpk
         4xooYhqB4N0D+rwp2tXgxV3omeOnLEGeqjhDq1V5YCUJlnNuN5Br4IL6bl1dRgrtOetq
         Hqqef+9XxHyGm/+JRaxVTXRyO9Ep/+fnE/+dPgC8XwXS7GqEu6PcOkRV/T1GCpKMYzmu
         HU+A==
X-Gm-Message-State: ALoCoQnHFQGYC13NH25J6q4RveAF1LXJBTS7WP63otaBDtM5uGbZZgu+p7++Uhhl6RqX9n+hMfCcc3nYMckkpLFH1FuPNXL2fBLob7zipUWRA1sJD20rLAE=
X-Received: by 10.31.157.204 with SMTP id g195mr60881459vke.79.1452713633471;
 Wed, 13 Jan 2016 11:33:53 -0800 (PST)
Received: by 10.31.161.206 with HTTP; Wed, 13 Jan 2016 11:33:53 -0800 (PST)
In-Reply-To: <87y4bunopj.fsf@waller.obbligato.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283977>

On Wed, Jan 13, 2016 at 4:27 PM, David A. Greene <greened@obbligato.org> wrote:
> Dave Ware <davidw@realtimegenomics.com> writes:
>
> [ I am sorry I took so long to respond.  This one slipped by me.  Thank
>   you for tracking this problem down and fixing it!  ]
>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 9f06571..ebf99d9 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -479,8 +479,16 @@ copy_or_skip()
>>                       p="$p -p $parent"
>>               fi
>>       done
>> -
>> -     if [ -n "$identical" ]; then
>> +
>> +     copycommit=
>> +     if [ -n "$identical" ] && [ -n "$nonidentical" ]; then
>> +             extras=$(git rev-list --count $identical..$nonidentical)
>> +             if [ "$extras" -ne 0 ]; then
>> +                     # we need to preserve history along the other branch
>> +                     copycommit=1
>> +             fi
>> +     fi
>> +     if [ -n "$identical" ] && [ -z "$copycommit" ]; then
>>               echo $identical
>>       else
>>               copy_commit $rev $tree "$p" || exit $?
>
> I don't see anything objectionable here.  I am just learning the split
> code myself.  :)
>
> However, when I apply this against master, the test doesn't actually
> pass and a gitk --all shows the merge commit still missing.  At least if
> I understand the problem correctly.  Can you verify whether it works for
> you?
>

The commit was made against v2.6.3, when I try to apply the patch
against master it fails.

However I can verify the test passes for me when applied against
v2.6.3, and it also passed if I merge my patched copy of v2.6.3 into
master. The process I'm using to run the tests is a little strange
though, it seems I have to make git, then make contrib/subtree, then
cp git-subtree to the root before running the Makefile on the tests.
Let me know if there's a less strange process for running the subtree
tests.

The test case actually began life as a bash script I was running
manually and visually inspecting. It covers the 2 cases we needed in
order to push our release
1) Merges where one parent is a superset of the changes of the other
parents regarding changes to the subtree, in this case the merge
commit should be copied (represented by "merge" in test case)
2) Merges where only one parent operate on the subtree, and the merge
commit should be skipped (represented by "second merge" in test case)

I haven't done an in depth look to verify the test checks the second
case, since this bit was never actually broken. But in terms of what
the test case should be doing only the first merge should be preserved
in the subtree

>> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
>> index 9051982..4fe4820 100755
>> --- a/contrib/subtree/t/t7900-subtree.sh
>> +++ b/contrib/subtree/t/t7900-subtree.sh
>> @@ -468,4 +468,56 @@ test_expect_success 'verify one file change per commit' '
>>       ))
>>  '
>>
>> +test_expect_success 'subtree descendant check' '
>> +     mkdir git_subtree_split_check &&
>> +     (
>> +             cd git_subtree_split_check &&
>> +             git init &&
>
> This shouldn't be necessary.  If you look at the other tests in
> t7900-subtree.sh, they all start with:
>
>   next_test
>   test_expect_success '<blah>' '
>   subtree_test_create_repo "$subtree_test_count"
>
> The "subtree_test_create_repo" takes care of creating a subdirectory and
> initializing a repository.  Perhaps you didn't (or still don't) have the
> test script rewrite patch that got merged a month or so ago.  If not,
> please update to it and reformulate your test to follow the established
> convention.  It helps *a lot* when debugging regressions.
>

I'm not a regular contributor to git (this is my first). So I'm not
very familiar with the test harness.
Also as noted I created the patch against v2.6.3, which did not have
the changes you mentioned.

>> +             mkdir folder &&
>> +
>> +             echo a >folder/a &&
>> +             git add . &&
>> +             git commit -m "first commit" &&
>
> You can use "test_create_commit" to do these "generate commit"
> operations.  It's on my TODO list to update the subtree tests to use
> more of the standard test infrastructure.  For now, just go ahead and
> use what the other tests use.
>
>> +             git branch noop_branch &&
> [...]
>> +             git checkout noop_branch &&
>> +             echo moreText >anotherText.txt &&
>> +             git add . &&
>> +             git commit -m "irrelevant" &&
>
> This is unfortunate naming.  Why is the branch a no-op and why is the
> commit irrelevant?  Does the test test the same thing without them?  I
> not they should have different names.  If so, why are these needed in
> the test?
>

This is to create a merge that operates workflow (2) mentioned above,
i.e. a branch that has absolutely no effect on the subtree and as such
should be skipped

>> +             git checkout master &&
>> +             git merge -m "second merge" noop_branch &&
>> +
>> +             git subtree split --prefix folder/ --branch subtree_tip master &&
>> +             git subtree split --prefix folder/ --branch subtree_branch branch &&
>> +             git push . subtree_tip:subtree_branch
>
> I understand the problem was discovered because of an inability to push
> and it probably makes sense to test that since that's what exposed the
> bug.  However, I wonder if there are some additional checks that should
> be done.  What do you expect subtree_tip and subtree_branch to look like
> and how do you expect them to relate to each other?  Should
> subtree_branch be an ancestor of subtree_tip?  If so we should
> explicitly test that.
>

it should look like this:

R--A1--A2-----M---H
  \               /
   B-------------

Where H is subtree_tip and B is subtree_branch. So yes subtree_tip is
a descendant of subtree_branch

Agreed, it should probably be checking things more explicitly. And
ideally should also be checking that commit "irrelevant" and "second
merge" are being skipped if possible.

> Again, thanks for your work on this!  I think I actually may have hit
> this bug in my own work but I couldn't be sure I hadn't done something
> wrong.  The sequence of commands and splits is eerily similar to
> something I tried a while back.  I'm *very* glad you were able to track
> it down!
>
>                           -David

As I noted in my original email this patch is solely designed to fix
the issue we ran into whilst trying to make our release (essentially
(1) and (2) mentioned above) and other cases of this same issue are
not addressed.
i.e.
- The many parent case. I've made no attempt to handle this situation
properly in the presence of greater than 2 parents. In theory it will
now sometimes correctly copy the merge where it wouldn't before, and
sometimes use the old behaviour.
- This is one I've only realised since submitting the patch: The case
where both parents have an identical tree to the merge commit, they
don't necessarily have the same set of commits to achieve this state,
so this should be being checked as well. Again I don't think this
patch makes this situation worse, it will simply result in the old
behaviour being used.

Thanks for taking the time to look at this.

Cheers,
Dave Ware
