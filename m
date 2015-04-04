From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9814: Guarantee only one source exists in git-p4 copy tests
Date: Sat, 04 Apr 2015 12:41:05 -0700
Message-ID: <xmqq384ffzqm.fsf@gitster.dls.corp.google.com>
References: <1427545730-3563-1-git-send-email-vitor.hda@gmail.com>
	<1427671914-12131-1-git-send-email-vitor.hda@gmail.com>
	<xmqqk2xzxk3y.fsf@gitster.dls.corp.google.com>
	<551FA15D.30304@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 21:41:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeTwe-0001gq-E8
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 21:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbbDDTlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 15:41:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752528AbbDDTlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 15:41:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C8A845860;
	Sat,  4 Apr 2015 15:41:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vt1V/sJUZGrfI/6ca+6muVYFTQ4=; b=HifRvG
	uT7okymsZf33GAz0JzZgszHM9vjJRlIgDuJL9Hhj93UwV4W2K1dZ936nkxZU1KX7
	vI1qUd4894s+ezybchwmlis799ZMcKRUfFGdf8DLkyWWeTFehk31XPYyVZbP5DaJ
	7M9Q6krWq3W3zgkQ3Qxs5zKJUg8QPEgXh3MJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2TNc9ygEJy6pPDIom3aexjvFT63gHrD
	8itsi4YPC3Yvn/+J4ICLv61Pj4iUq3cS0BhHhRJVnhfIe9I9daJLVgDvsY7Rq1Uc
	qpCbdRbF7SoBwqmOXBP+l7pkzhplLJswISqns1m3V2sulWPWp6osN8jsG/eOP53Z
	lcAfauG8nvU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 692D94585F;
	Sat,  4 Apr 2015 15:41:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C11E4585E;
	Sat,  4 Apr 2015 15:41:06 -0400 (EDT)
In-Reply-To: <551FA15D.30304@diamand.org> (Luke Diamand's message of "Sat, 04
	Apr 2015 09:31:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8937EE46-DB02-11E4-94B5-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266780>

Luke Diamand <luke@diamand.org> writes:

> On 30/03/15 04:03, Junio C Hamano wrote:
>> Vitor Antunes <vitor.hda@gmail.com> writes:
>>
>>> * Modify source file (file2) before copying the file.
>>> * Check that only file2 is the source in the output of "p4 filelog".
>>> * Remove all "case" statements and replace them simple tests to check that
>>>    source is "file2".
>>>
>>> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>>> ---
>>
>> I am not a Perfoce user, so I'd like to ask Pete's and Luke's
>> comments on these changes.
>
> It's much clearer now that the guessing of file source has been
> cleaned up, thanks. Ack.

Thanks.

Vitor, when resubmitting v2 to fix style nits, please add Luke's
Acked-by just after your Sign-off, perhaps like this:

    t9814: guarantee only one source exists in git-p4 copy tests
    
    By using a tree with multiple identical files and allowing copy
    detection to choose any one of them, the check in the test is
    unnecessarily complex.  We can simplify by:
    
     * Modify source file (file2) before copying the file.
    
     * Check that only file2 is the source in the output of "p4 filelog".
    
     * Remove all "case" statements and replace them simple tests to
       check that source is "file2".
    
    Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
    Acked-by: Luke Diamand <luke@diamand.org>


>>> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
>>> index 8b9c295..d8fb22d 100755
>>> --- a/t/t9814-git-p4-rename.sh
>>> +++ b/t/t9814-git-p4-rename.sh
>>> @@ -132,6 +132,9 @@ test_expect_success 'detect copies' '
>>>   		cd "$git" &&
>>>   		git config git-p4.skipSubmitEdit true &&
>>>
>>> +		echo "file8" >> file2 &&
>>
>> Style: please lose SP between redirection and its target, i.e.
>>
>> 	echo file8 >>file2 &&
>>
>> The same comment applies to everywhere else.
>>
>>> +		git commit -a -m "Differentiate file2" &&
>>> +		git p4 submit &&
>>>   		cp file2 file8 &&
>>>   		git add file8 &&
>>>   		git commit -a -m "Copy file2 to file8" &&
>>> @@ -140,6 +143,10 @@ test_expect_success 'detect copies' '
>>>   		p4 filelog //depot/file8 &&
>>>   		p4 filelog //depot/file8 | test_must_fail grep -q "branch from" &&
>>>
>>> +		echo "file9" >> file2 &&
>>> +		git commit -a -m "Differentiate file2" &&
>>> +		git p4 submit &&
>>> +
>>>   		cp file2 file9 &&
>>>   		git add file9 &&
>>>   		git commit -a -m "Copy file2 to file9" &&
>>> @@ -149,28 +156,39 @@ test_expect_success 'detect copies' '
>>>   		p4 filelog //depot/file9 &&
>>>   		p4 filelog //depot/file9 | test_must_fail grep -q "branch from" &&
>>>
>>> +		echo "file10" >> file2 &&
>>> +		git commit -a -m "Differentiate file2" &&
>>> +		git p4 submit &&
>>> +
>>>   		echo "file2" >>file2 &&
>>>   		cp file2 file10 &&
>>>   		git add file2 file10 &&
>>>   		git commit -a -m "Modify and copy file2 to file10" &&
>>>   		git diff-tree -r -C HEAD &&
>>> +		src=$(git diff-tree -r -C HEAD | sed 1d | sed 2d | cut -f2) &&
>>> +		test "$src" = file2 &&
>>>   		git p4 submit &&
>>>   		p4 filelog //depot/file10 &&
>>> -		p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
>>> +		p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
>>> +
>>> +		echo "file11" >> file2 &&
>>> +		git commit -a -m "Differentiate file2" &&
>>> +		git p4 submit &&
>>>
>>>   		cp file2 file11 &&
>>>   		git add file11 &&
>>>   		git commit -a -m "Copy file2 to file11" &&
>>>   		git diff-tree -r -C --find-copies-harder HEAD &&
>>>   		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>>> -		case "$src" in
>>> -		file2 | file10) : ;; # happy
>>> -		*) false ;; # not
>>> -		esac &&
>>> +		test "$src" = file2 &&
>>>   		git config git-p4.detectCopiesHarder true &&
>>>   		git p4 submit &&
>>>   		p4 filelog //depot/file11 &&
>>> -		p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
>>> +		p4 filelog //depot/file11 | grep -q "branch from //depot/file2" &&
>>> +
>>> +		echo "file12" >> file2 &&
>>> +		git commit -a -m "Differentiate file2" &&
>>> +		git p4 submit &&
>>>
>>>   		cp file2 file12 &&
>>>   		echo "some text" >>file12 &&
>>> @@ -180,15 +198,16 @@ test_expect_success 'detect copies' '
>>>   		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>>>   		test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
>>>   		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>>> -		case "$src" in
>>> -		file10 | file11) : ;; # happy
>>> -		*) false ;; # not
>>> -		esac &&
>>> +		test "$src" = file2 &&
>>>   		git config git-p4.detectCopies $(($level + 2)) &&
>>>   		git p4 submit &&
>>>   		p4 filelog //depot/file12 &&
>>>   		p4 filelog //depot/file12 | test_must_fail grep -q "branch from" &&
>>>
>>> +		echo "file13" >> file2 &&
>>> +		git commit -a -m "Differentiate file2" &&
>>> +		git p4 submit &&
>>> +
>>>   		cp file2 file13 &&
>>>   		echo "different text" >>file13 &&
>>>   		git add file13 &&
>>> @@ -197,14 +216,11 @@ test_expect_success 'detect copies' '
>>>   		level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>>>   		test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
>>>   		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
>>> -		case "$src" in
>>> -		file10 | file11 | file12) : ;; # happy
>>> -		*) false ;; # not
>>> -		esac &&
>>> +		test "$src" = file2 &&
>>>   		git config git-p4.detectCopies $(($level - 2)) &&
>>>   		git p4 submit &&
>>>   		p4 filelog //depot/file13 &&
>>> -		p4 filelog //depot/file13 | grep -q "branch from //depot/file"
>>> +		p4 filelog //depot/file13 | grep -q "branch from //depot/file2"
>>>   	)
>>>   '
