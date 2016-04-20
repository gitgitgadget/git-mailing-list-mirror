From: Ben Woosley <ben.woosley@gmail.com>
Subject: Re: [PATCH] git-rebase--merge: don't include absent parent as a base
Date: Wed, 20 Apr 2016 14:19:04 -0700
Message-ID: <CAC5gnOxFVT=Y-YURxQxnT3Qng162=jogoZMEYJdN1jz8SmJtCg@mail.gmail.com>
References: <0102015434e7556a-2d9848cb-93c3-4883-96ec-c0c70098796b-000000@eu-west-1.amazonses.com>
 <xmqq1t60ugoi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 23:19:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aszXB-0002S2-0D
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 23:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbcDTVTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 17:19:36 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34854 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcDTVTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 17:19:35 -0400
Received: by mail-oi0-f49.google.com with SMTP id p188so63205398oih.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zdb3xR6qFUADk11WHMRCCbeAaflbA2KW93e/gHy88Ok=;
        b=E5k2fhD1GZOLSLWDEmE6nB1TBNO0pRd/Xz97DD1FlQzutVRlCqzitxzekWbSjFrevK
         xgNEkbjZMgne7Aq5o5kp2ubRlunDfB9VQNgKgHH1QlDIbB7PtdtfWXJhysjFI301yEOh
         x2FmwPj09t0QUsJxVLogppTkIFVpIHhmObgcko/6smExm1/oFImC64j/Dk2F/qFYpdse
         9GikNKvVJo3OtIi5I1aPzhEd7Et0cgy4gUNfQTRyJE22njOwUK6/Kx6HCs9UsgIgzSC/
         Lnro7z3MvfYu9CKWCBgcmORul2q/l69qjQLrF24xSVgHY+xmmzJxaFDXbUVQFSKiurpx
         SZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zdb3xR6qFUADk11WHMRCCbeAaflbA2KW93e/gHy88Ok=;
        b=dGrXUjbl2BCsTNzZSRcjS8FxLd70T7B3agRIcIBecQg5F+MLpvxaCXBI5DIxrqq163
         adv+3vp03Hrb/hiC11VDrMcmqpKTMMRizjpv0wj6rq2R0TA5f4LCJrqe/+sKQWGn/gSI
         9F11eCSuGZQHdrSfE3POg4Uul3XgjEonr0nexSJ4meL4am0CZCX+M64zSXNog1+W3cTS
         Q9VfZiA0iRquubpMQP2we2LGjRv7GPMeGOuvyKNWpIN+CS4Py/dGVwSSAbiTmfQ0moV4
         PwdkPFqWJglXIt+a+Cq8UBZQEEk0Xh1YVy/HQlJ1qxi2lSVA7jbjW6wAuBjmTtCYLBzb
         0p/Q==
X-Gm-Message-State: AOPr4FXZpnQ/zusRPNriZUcmzsoDa99Msnl1vmyL+Yqn/Og+LQI5NuV6Bo74RiN9n4yQdyMQ985uiarn9IoNNQ==
X-Received: by 10.157.4.72 with SMTP id 66mr5090877otc.141.1461187174264; Wed,
 20 Apr 2016 14:19:34 -0700 (PDT)
Received: by 10.202.201.82 with HTTP; Wed, 20 Apr 2016 14:19:04 -0700 (PDT)
In-Reply-To: <xmqq1t60ugoi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292083>

It's helpful in the case where a bit of code has been detached from
its history by way of copying the files and starting a new repo, where
development continues. If you want to reunite the new history with the
prior history, while preferring the new history, you need to `rebase
-Xtheirs` the new branch onto the old.

Best,
Ben

On Wed, Apr 20, 2016 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Woosley <Ben.Woosley@gmail.com> writes:
>
>> From: Ben Woosley <ben.woosley@gmail.com>
>>
>> Absent this fix, attempts to rebase an orphan branch with --strategy recursive
>> will fail with:
>>
>>     $ git rebase ORPHAN_TARGET_BASE -s recursive
>>     First, rewinding head to replay your work on top of it...
>>     fatal: Could not parse object 'ORPHAN_ROOT_SHA^'
>>     Unknown exit code (128) from command: git-merge-recursive ORPHAN_ROOT_SHA^ -- HEAD ORPHAN_ROOT_SHA
>>
>> To fix, this will only include the rebase root's parent as a base if it exists,
>> so that in cases of rebasing an orphan branch, it is a simple two-way merge.
>>
>> Note the default rebase behavior does not fail:
>>
>>     $ git rebase ORPHAN_TARGET_BASE
>>     First, rewinding head to replay your work on top of it...
>>     Applying: ORPHAN_ROOT_COMMIT_MSG
>>     Using index info to reconstruct a base tree...
>>
>> Signed-off-by: Ben Woosley <ben.woosley@gmail.com>
>> ---
>>  git-rebase--merge.sh    | 4 +++-
>>  t/t3402-rebase-merge.sh | 9 +++++++++
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
>> index 2cc2a6d..8d43db9 100644
>> --- a/git-rebase--merge.sh
>> +++ b/git-rebase--merge.sh
>> @@ -67,7 +67,9 @@ call_merge () {
>>               GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
>>       fi
>>       test -z "$strategy" && strategy=recursive
>> -     eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
>> +     # If cmt doesn't have a parent, don't include it as a base
>> +     base=$(git rev-parse --verify --quiet $cmt^)
>> +     eval 'git-merge-$strategy' $strategy_opts $base ' -- "$hd" "$cmt"'
>
> Makes sense to me.  It is not clear if such a merge without common
> ancestor is all that useful, but as it is mechanically possible,
> I do not see a reason to forbid it.
>
>>       rv=$?
>>       case "$rv" in
>>       0)
>> diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
>> index 8f64505..488945e 100755
>> --- a/t/t3402-rebase-merge.sh
>> +++ b/t/t3402-rebase-merge.sh
>> @@ -85,6 +85,15 @@ test_expect_success 'rebase -Xtheirs' '
>>       ! grep 11 original
>>  '
>>
>> +test_expect_success 'rebase -Xtheirs from orphan' '
>> +     git checkout --orphan orphan-conflicting master~2 &&
>> +     echo "AB $T" >> original &&
>> +     git commit -morphan-conflicting original &&
>> +     git rebase -Xtheirs master &&
>> +     grep AB original &&
>> +     ! grep 11 original
>> +'
>> +
>>  test_expect_success 'merge and rebase should match' '
>>       git diff-tree -r test-rebase test-merge >difference &&
>>       if test -s difference
>>
>> --
>> https://github.com/git/git/pull/228
