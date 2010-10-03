From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 15/16] Add missing &&'s throughout the testsuite
Date: Sun, 03 Oct 2010 16:34:19 -0700
Message-ID: <7v62xietqc.fsf@alter.siamese.dyndns.org>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
 <1286082644-31595-16-git-send-email-newren@gmail.com>
 <20101003144650.GE17084@burratino>
 <AANLkTin3vtqGJDC4hrmKpFZ6e+Sw5OP15QPjO16cxgkx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:34:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Y4t-00064p-7i
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0JCXeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:34:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0JCXea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:34:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 557ACDB251;
	Sun,  3 Oct 2010 19:34:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ly+Zd1Uyj7lUcNBXUECRM/692+s=; b=mrlGCRpQ4JUS/0maXWtBz7h
	rh064GZnfyPx2OV1ZbcM0TbKex71LhnQB+wvWDUpbbgnVwxZF4eVx1lYt+B8Uw65
	l0Wo/nwwDlL3HFpZxxt7XsXsbsM6r8ZGckwSnPTPpLBSKQHnOSOlNkVEzEr5Fofo
	fsRPo5/uAr8B2k6FDrcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=FGfoKt1wn1iznUe0HW3jIxtnPOvlRnZo8CEwOieqGiOvmh/Jl
	GtLeXGiPpDBsbvMnQkGtVPRQTlVbq+n28EAF95p7d8mA3CP8nvltj+iV57ASOi0+
	9U98SApoampARHkS3vo5bWSbeUvJYbV9/Iy57gfTwa2kAJgh2vvWcfS+Zo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A0F4DB24E;
	Sun,  3 Oct 2010 19:34:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FEE1DB24C; Sun,  3 Oct
 2010 19:34:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C25B5E0A-CF46-11DF-B2C1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157953>

Elijah Newren <newren@gmail.com> writes:

> On Sun, Oct 3, 2010 at 8:46 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> --- a/t/t1509-root-worktree.sh
>>> +++ b/t/t1509-root-worktree.sh
>>> @@ -232,8 +232,8 @@ say "auto bare gitdir"
>>>
>>>  # DESTROYYYYY!!!!!
>>>  test_expect_success 'setup' '
>>> -     rm -rf /refs /objects /info /hooks
>>> -     rm /*
>>> +     rm -rf /refs /objects /info /hooks &&
>>> +     rm /* &&
>>
>> I'm worried that this would fail:
>>
>>        $ mkdir foo
>>        $ cd foo
>>        $ >bar
>>        $ mkdir baz
>>        $ rm *
>>        rm: cannot remove `baz': Is a directory
>>        $ echo $?
>>        1
>
> How about replacing the two rm commands with a simple 'rm -rf /*'?

How would "rm -rf /*" that will remove /bin/sh and /usr/bin/git among
other things would possibly help?  Isn't this test about having a minimum
chroot with /bin, /usr populated with minimum git (and presumably shell
tools) and for whatever sick reason have a bare git repository at /?
