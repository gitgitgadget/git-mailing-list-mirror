From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Sat, 25 Apr 2015 10:04:59 -0700
Message-ID: <xmqqsiboyw90.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
	<20150419002807.GA11634@hashpling.org>
	<xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
	<20150420074433.GA30422@hashpling.org>
	<8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
	<20150420091920.GA31279@hashpling.org> <553520CF.6070304@gmail.com>
	<20150421101641.GA13202@hashpling.org>
	<CAPig+cRmPv5u_OCtUPNoYOUcOoa9xn++Xw-rkD6EP6_eq0YvEQ@mail.gmail.com>
	<xmqqh9s9gqw9.fsf@gitster.dls.corp.google.com>
	<553B78E2.5070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Charles Bailey <charles@hashpling.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 19:05:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym3Vu-0002pc-Jx
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 19:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966192AbbDYRFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 13:05:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965570AbbDYRFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 13:05:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4D6F49BAB;
	Sat, 25 Apr 2015 13:05:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RnGjajfD4VBu2RRj6wMUDbJ0vpQ=; b=IkXmKF
	o+f1tbtEUJNN+72OUlNouBrBwqOuEFLrrRoIZI87iwmX226va78tpr249Fl3UTQH
	CbLQYkffj90lfitv5Xj9vxVtyzbOVq1jrJLEUCOZL4+ci6JjYVFs3U3aTRCD13/t
	6DQGgR5WIaO6GHTKTr2YP7bWrpTb5AQGgTvJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xHY/ZiLmRwpii5N7MG9bWzmc1OiCBWFu
	MKgkTZfm6UT9YjkcS8ifXyBuFfm7JkvXwDzwbCzv/XZ3XLKvQJHQ1C8ZxEYYMPxa
	4joJyRi1X6ChsIhcbR3aJIHPW6zh1kG2wZTIg1a00EW5GYIU6+XtjuR46RPt2UsE
	pSeDf+/aGHA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A19EE49BAA;
	Sat, 25 Apr 2015 13:05:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 932FE49BA6;
	Sat, 25 Apr 2015 13:05:01 -0400 (EDT)
In-Reply-To: <553B78E2.5070608@gmail.com> (karthik nayak's message of "Sat, 25
	Apr 2015 16:52:10 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35E679B2-EB6D-11E4-B8D3-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267796>

karthik nayak <karthik.188@gmail.com> writes:

>> Is there any other way to make cat-file looser other than accepting
>> an unknown type name from the future?  If not, then perhaps it may
>> make sense to give it a generic name that implies that we would
>> trigger such additional looseness in the future.  But as the
>> inventor of it as a debugging aid, I would say a name that spells
>> out the specific way this option is being loose, e.g.
>>
>> >      --allow-bogus-type
>>
>> or with s/bogus/unknown/, best describes what it currently does.
>
> Yes this gives the best description, but its large, while we could use something
> like --no-strict instead.

We could, if you answered my first question with "no".

By naming this "--no-strict", the first bug report you will receive
may be that "cat-file --no-strict" should parse a zlib deflate that
begins with "blob 1234\n\0" (notice that there are two SPs instead
of the usual one, and length is followed by LF that should not be
there before the NUL) but it does not.

As your option name "--no-strict" signals that you will make the
best effort to parse such nonsense, that would be a valid bug
report, against which you would need to update the code to make it
work.  But is it worth the effort to make such a thing work?  I
dunno.
