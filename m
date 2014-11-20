From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] refs.c: add a function to append a reflog entry to a fd
Date: Thu, 20 Nov 2014 14:11:12 -0800
Message-ID: <xmqqzjbl1q0v.fsf@gitster.dls.corp.google.com>
References: <20141120023655.GG6527@google.com>
	<1416508657-9057-1-git-send-email-sbeller@google.com>
	<xmqq4mtt35x1.fsf@gitster.dls.corp.google.com>
	<20141120215800.GA22370@google.com> <20141120220558.GL6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 23:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZwn-0001o4-2w
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 23:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbaKTWLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 17:11:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756761AbaKTWLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 17:11:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D057A1E785;
	Thu, 20 Nov 2014 17:11:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GWMuMI+SFsYdhPD4+EOP+zoDXs4=; b=h5rsLR
	jBLPaQuRI6WafiQWhDpknE6eo0P3BZaQYxu70n4rLNmzajgBPKg1M5WtN36OUWQF
	xJMKz8E6DkGwUUEZu/Bad1TBYrATXmZfhQeY7eh5zpOfqabXdmyZR5HD7Rdmuegj
	XmRpbO3DdZOoy0/foCxZA4Ll/xgMEbDZeUkFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xSGEIxc8qUObsKcOgxekjYQB8Bql6YYw
	C4z+kNM233k5gzw2utQslCr+LuQLBICwTxgZ9UhTc3PLTAmhiJUkLO74JwWvEZHi
	6MOiGoXow7g1jeYA4GEMTDJI4bVAfIGDg7I4ZrME+VMWfOAOD1rHSv21v5ltCS7r
	0pa3VaZAm0c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C59181E784;
	Thu, 20 Nov 2014 17:11:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C40E1E783;
	Thu, 20 Nov 2014 17:11:14 -0500 (EST)
In-Reply-To: <20141120220558.GL6527@google.com> (Jonathan Nieder's message of
	"Thu, 20 Nov 2014 14:05:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 24672E38-7102-11E4-9349-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> In this case, it is about readability.  It's perhaps irrational, but I
> find text much more readable and the intent to be clearer when
> paragraphs are wrapped to a consistent width instead of lines breaking
> at arbitrary points.

Yeah I agree with that.

Also a blank line between paragraphs, but that goes without saying
once you accept that we do not do a single line per paragraph.

> Perhaps a nice way to make this a non-issue in the future would be an
> option to "git am" to rewrap.

No.  There are cases where you do need to have a single oddball long
line that you cannot flow.  In a project that employs "am", the
users of "am" are much more likely to become bottleneck than the
senders of patches, and it does not make sense to have them spend
cycles to decide if they want to let "am" do such wrapping.
