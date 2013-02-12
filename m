From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: respect core.commentchar
Date: Tue, 12 Feb 2013 10:23:16 -0800
Message-ID: <7vehglgzmz.fsf@alter.siamese.dyndns.org>
References: <aa1deab1de2e0f998b9ac0bc8c2d76557429a46b.1360610368.git.john@keeping.me.uk>
 <7vzjzali6a.fsf@alter.siamese.dyndns.org>
 <20130211213900.GE2270@serenity.lan>
 <7va9raldw8.fsf@alter.siamese.dyndns.org>
 <20130211230804.GF2270@serenity.lan>
 <7vehgmjsno.fsf@alter.siamese.dyndns.org>
 <20130212095340.GG2270@serenity.lan>
 <7v4nhhigp5.fsf@alter.siamese.dyndns.org>
 <7vvc9xh0p1.fsf@alter.siamese.dyndns.org>
 <20130212180917.GD13501@farnsworth.metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:23:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5KW7-0005ql-2C
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933541Ab3BLSXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:23:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933484Ab3BLSXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 13:23:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36B9EB146;
	Tue, 12 Feb 2013 13:23:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PEDjZoMrNmy8PxWuCUz53uOXZMY=; b=R/DCQf
	an0q+M6lk94YmcG0wpMOpxj38CrjVxr6Tvb6NfmUZT6/UpQBanWP2/IRoXfWas1c
	B3cybWy4sw9VtchbxPfPtuxvFN4lEz65mKG6px4Y6n44gBqdzqMyktkPFmMrDda/
	W+d1JposzLFbMjG9kBljz8Wq9tFK8SSwCmCpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yMsXZZ5BO7hJVEYQaZ1Ex+680uHmJweq
	E+R+UteGpJ3IXg7QnvtplPZKEjLuKCZxa+9aLdTwSZVym3n57soNlAF32mOCCpiA
	9L7b0uzHmGNfhOsmx4dksk2bE/tCFRjTZV4TJZldBeFAg5JJP1YUUk+5kwbs9pwy
	fk0g3A3HS7U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B7BAB145;
	Tue, 12 Feb 2013 13:23:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B787B142; Tue, 12 Feb 2013
 13:23:17 -0500 (EST)
In-Reply-To: <20130212180917.GD13501@farnsworth.metanate.com> (John Keeping's
 message of "Tue, 12 Feb 2013 18:09:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 459D546A-7541-11E2-86E9-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216172>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Feb 12, 2013 at 10:00:26AM -0800, Junio C Hamano wrote:
>>
>> So it needs to be more like this, and I think it still is more
>> readable.
>
> Agreed.  Will you squash this in or do you want a re-roll?

I can squash this and the previous one into your original to a
single commit.  Thanks.

>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index cbe36bf..8b3e2cd 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -945,13 +945,11 @@ test_expect_success 'rebase -i respects core.commentchar' '
>>  	git checkout E^0 &&
>>  	git config core.commentchar "\\" &&
>>  	test_when_finished "git config --unset core.commentchar" &&
>> -	cat >comment-lines.sh <<EOF &&
>> -#!$SHELL_PATH
>> -sed -e "2,\$ s/^/\\\\\\/" "\$1" >"\$1".tmp
>> -mv "\$1".tmp "\$1"
>> -EOF
>> -	chmod a+x comment-lines.sh &&
>> -	test_set_editor "$(pwd)/comment-lines.sh" &&
>> +	write_script remove-all-but-first.sh <<-\EOF &&
>> +	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
>> +	mv "$1.tmp" "$1"
>> +	EOF
>> +	test_set_editor "$(pwd)/remove-all-but-first.sh" &&
>>  	git rebase -i B &&
>>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>>  '
