From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Wed, 16 Mar 2016 09:47:56 -0700
Message-ID: <xmqqfuvq5pz7.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
	<CA+55aFyXXHNrJW56A_DKkmrmGpWxeUd6row_ja3bzqhs_yswhw@mail.gmail.com>
	<CAGZ79kZihaftwwmY23mZ_i4H6vv2Z9r=LC68M0MMD1o2h2Z4Sw@mail.gmail.com>
	<CAGZ79kZtAm1M=9CGDGxPdecXEuNEQcbpQb3FNj9=Py0VE2UrKQ@mail.gmail.com>
	<56E96D61.6060007@xiplink.com>
	<CA+55aFwFsBKZZeqhBDf_YXG6vrSrvfFVCsRc0mkFUiDS9Rd+QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEcA-0005VO-Nl
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbcCPQsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 12:48:01 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752119AbcCPQsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:48:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E9F4D4C5B7;
	Wed, 16 Mar 2016 12:47:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2RbTnwUj4YAwl408q9V+cc52VPk=; b=B7yM1N
	N2m5Mg8+uKDNz7VFAF0ZcqRR10cAB/NAI0zxqvc0rNtq0bdFf8cC2pqBYyAHmQ2R
	z1q9vBnJGsCTv1AdFjPK5Au0tKy3U4YrKfLBWi6zoPKESKo06YDM/XoBSPYINka7
	qw35u1Ugu9yMga3AjRBZwVLcX/WM1ONraJ4/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r4J63HZEbtUwYyjfuuuMhlfM/xV/hnJI
	Oimev8XJnm171eWPQnaCB3hHkDN13cQA4q3qy57FVOwbCxidurRq40IpryS8qQcc
	j8Xx+9w/EDkyZKX7FQwPGi/cYfKoaCIy52Nh/FzFPmLviPJ63KxFRxePzFFsJnEz
	aPoS6JbwMYk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0C574C5B5;
	Wed, 16 Mar 2016 12:47:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3615F4C5B4;
	Wed, 16 Mar 2016 12:47:58 -0400 (EDT)
In-Reply-To: <CA+55aFwFsBKZZeqhBDf_YXG6vrSrvfFVCsRc0mkFUiDS9Rd+QA@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 16 Mar 2016 09:15:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D694D122-EB96-11E5-A9E2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288991>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Mar 16, 2016 at 7:27 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>>
>> Could this also help with diff output, where the leading + or - mars the
>> indentation in a similar way?
>
> I don't think that's a good idea at least by default, since then it
> will break things like running diff in emacs capture mode.
>
> So even if you're in a terminal, you can't assume that you can munge
> the output too much.
>
> Of course, if colorization is on, you might as well pretty-print the
> diff by indenting things properly too, since the end result isn't
> going to be used as a _diff_.

I agree that I will never use such an end result as a diff, but I
may still be tempted to cut-and-paste individual lines after '^+'
when resurrecting a WIP topic that does not rebase very well, so I
agree with you that the output shouldn't be munged by default even
though I think it is OK to have an option..
