From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] apply: do not read from beyond a symbolic link
Date: Tue, 03 Feb 2015 11:37:48 -0800
Message-ID: <xmqq1tm6ss4z.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-4-git-send-email-gitster@pobox.com>
	<CAGZ79kbE2frDRgXkS0zGvufR1GP15wjgf9t49U87jPT83aTF0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:38:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIjIL-0001db-41
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 20:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966457AbbBCThw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 14:37:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966015AbbBCThw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 14:37:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B18F35BFC;
	Tue,  3 Feb 2015 14:37:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I5icje0i97LWW2NLQPjsoYSPDBE=; b=WkFLN1
	9gkyJeoZRYSq20nl/Q6vYIQ28ZZwOt+MrXMSMVq9o+2BIYjby+jw8BiNeopJUd0Y
	X17PG0HxJ34Uq69rBeZJ8epnCqswhB6eh2TxQOz4bD9Wj3dCNhoiGdXdsuse6Nk+
	C2pZmnnMZhsp7E9NqJdWzAPXzLOXM/Wjsuj9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aRJQKIiRlS/92eDT18k/k291EoIy6+Xs
	zfrHLA7U2pjPRyJ6Zte6y1rUkwk1mK8oP1xpw5yyu8P8cFX3U49RMeGacjqP3+Q1
	9OC4oBZttMB8WvN02dUAxGNVH7WJU9jYJ6UJmkVGQj0t/TE7wVfkkqxs0ySyUK03
	rCu+uoWWIQ8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D96535BFB;
	Tue,  3 Feb 2015 14:37:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E22935BF9;
	Tue,  3 Feb 2015 14:37:50 -0500 (EST)
In-Reply-To: <CAGZ79kbE2frDRgXkS0zGvufR1GP15wjgf9t49U87jPT83aTF0w@mail.gmail.com>
	(Stefan Beller's message of "Mon, 2 Feb 2015 16:08:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2388CF16-ABDC-11E4-9C41-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263327>

Stefan Beller <sbeller@google.com> writes:

> On Mon, Feb 2, 2015 at 3:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +       test_must_fail git apply --index patch
>> +
>> +'
>
> Is the empty line between the last test_must_fail and the closing `'`
> intentional?

I think I just mimicked the previous existing one, but I can go with
the version without.
