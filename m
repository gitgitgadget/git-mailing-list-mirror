From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/7] replace: add test for --graft
Date: Thu, 03 Jul 2014 11:45:37 -0700
Message-ID: <xmqq8uoaffhq.fsf@gitster.dls.corp.google.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.23923.chriscool@tuxfamily.org>
	<xmqqy4wbfpux.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2L8wV=7dyW6ChA2Y1UddQnLMZ=b4eUvGYGQY65ndLgHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 20:45:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2m14-0002tY-NC
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 20:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759577AbaGCSpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 14:45:51 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59558 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756243AbaGCSpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 14:45:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0366224D13;
	Thu,  3 Jul 2014 14:45:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bin7LSib+uRce18wOZykY9zGBko=; b=k7oqIo
	JVMcUzi5ss8u7196xK/dPgbKgp+ATHWenDsb0Ak8MexGpbEwiG1G/7Iq2vL7LSGy
	AmGokiBzH0bvvnbGJlqgmt/X1NzZ0i6KfuRmXyVpXZ7kox+RenVbQkuhGGLtGFj9
	ojQascJnEK0VKyu1ngMwPYOZjZxdxkuiOvWGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lb9ID8ADuGsJfaG+vlpVBs7pJW5L1TsI
	IDFKGFsltOKT5mzJOpqOGZZnbIxobsM0lUzgcYFTUc+9exrGFOGpi4wVvL6Iq6zR
	/iK17uviaeQjdGFrqJmg2zcumINZRkuIPcDOGQBRQTToBK3zX3mh/pZ1yUS6tHkn
	MfsC63QAS1M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EAF9524D12;
	Thu,  3 Jul 2014 14:45:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D0C3F24D03;
	Thu,  3 Jul 2014 14:45:27 -0400 (EDT)
In-Reply-To: <CAP8UFD2L8wV=7dyW6ChA2Y1UddQnLMZ=b4eUvGYGQY65ndLgHA@mail.gmail.com>
	(Christian Couder's message of "Thu, 3 Jul 2014 15:39:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 338CB128-02E2-11E4-94DF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252873>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Jul 2, 2014 at 10:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>  t/t6050-replace.sh | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
>>> index 68b3cb2..ca45a84 100755
>>> --- a/t/t6050-replace.sh
>>> +++ b/t/t6050-replace.sh
>>> @@ -351,4 +351,16 @@ test_expect_success 'replace ref cleanup' '
>>>       test -z "$(git replace)"
>>>  '
>>>
>>> +test_expect_success '--graft with and without already replaced object' '
>>> +     test $(git log --oneline | wc -l) = 7 &&
>>> +     git replace --graft $HASH5 &&
>>> +     test $(git log --oneline | wc -l) = 3 &&
>>> +     git cat-file -p $HASH5 | test_must_fail grep parent &&
>>
>> Please do not run non-git command under test_must_fail.
>
> Ok, I think I will just use the following then:
>
> test_must_fail git rev-parse $HASH5^1
> ...

See below.

>>> +     test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
>>> +     git replace --force -g $HASH5 $HASH4 $HASH3 &&
>>> +     git cat-file -p $HASH5 | grep "parent $HASH4" &&
>>> +     git cat-file -p $HASH5 | grep "parent $HASH3" &&
>>> +     git replace -d $HASH5
>>> +'
>>> +
>>>  test_done
>>
>> For all these "git cat-file -p $commit | grep ...", I would think
>> you should add "commit_has_parents" helper function to allow a bit
>> more careful testing.  As written, the test will mistake a commit
>> with string "parent $HASHx" anywhere, not in the header part, and
>> the test does not ensure that $HASH{3,4} is the {first,second}
>> parent.
>>
>>         commit_has_parents $HASH5 $HASH4 $HASH3
>>
>> would then may be implemented like:
>>
>>         commit_has_parents () {
>>                 git cat-file commit "$1" >payload &&
>>                 sed -n -e '/^$/q' -e 's/^parent //p' <payload >actual &&
>>                 shift &&
>>                 printf 'parent %s\n' "$@" >expect &&
>>                 test_cmp expect actual
>>         }
>
> I think I'll rather use something like:
>
> test $(git rev-parse $HASH5^1) = "$HASH4" &&
> test $(git rev-parse $HASH5^2) = "$HASH3" &&
> ...

Even in that case, I'd suggest using the same "commit_has_parents"
abstraction, which you will also be using to check the "replaced to
be a new root" case in the earlier part of this test.

In case you do not get what I mean by "in that case", you are saying
that you will now be testing a different thing.  You can test what
your new code produces at the bit level by directly obtaining the
resulting object via "cat-file" and that lets you not to depend on
the rest of the system (i.e. the part that allows you to pretend an
existing object you have a corresponding replace ref for has contents
of a totally different object) working correctly.  Or you can choose
to test the system as a whole (i.e. not just the "git replace" produced
a new object with contents you planned to fabricate, but also by
having a replace ref, you can let the rest of the system use th
contents of that object when asked for the replaced object).

The implementation suggested in my previous message was in line with
the former, because your use of "cat-file" seemed to indicate that
you wanted to avoid depending on the rest of the system to test this
new feature in your new tests.  You seem to be saying that you now
want to take the other approach of testing both at the same time.

I am fine with either approach, but I want to make sure that you are
aware of the distinction.  The last thing I want to see is to flip
the approach you take to test not because "testing as a whole is
better than testing one thing without getting interfered by
potential breakage in other parts" but because "testing as a whole
is easier."

The implementation of commit_has_parents that tests the system as a
whole may look like

        commit=$1 parent_number=1
        shift
        for parent
        do
                test $(git rev-parse --verify "$commit^$parent_number") = "$parent" ||
		return 1
		parent_number=$(( $parent_number + 1 ))
	done
        test_must_fail git rev-parse $commit^$parent_number

and you would still use it like this:

  commit_has_parents $HASH5 ;# must have no parent
  commit_has_parents $HASH5 $HASH4 $HASH3 ;# must have these parents

Thanks.
