From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] test patch hunk editing with "commit -p -m"
Date: Thu, 06 Mar 2014 15:11:32 -0800
Message-ID: <xmqq61nqx6qj.fsf@gitster.dls.corp.google.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-2-git-send-email-benoit.pierre@gmail.com>
	<CAPig+cTTCsMDJ_B73+cbedrxoEqbM_txV6JYWmCq-LyX12TpNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit Pierre <benoit.pierre@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:11:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhS0-0004bR-NO
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbaCFXLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:11:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaCFXLg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:11:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9346E72E41;
	Thu,  6 Mar 2014 18:11:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q87+4wAb71Xml7nYwfbkcxBGN+w=; b=nAwPyN
	sp2DNrhHY2NSc2R3xLVOWJZWNRyBuy+2Wlz9A/iCCQssY9Dc+pnq7SbLVvvgP8IW
	Z9IB51xr0/egBSo7/eMyxXhAPaXsY8x8CRzTlVExDzOVjuMhE0p9H50Wjr5Og2S+
	0aMQMtfbVdXE7bwgC+r5UoPa+0t0pAXlMpKMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QySy+LUBK/j1weOv3hrfvWJvYAY7O8bc
	+g9h/qCPOwo7LC6qXTnnRk/Exne7x1QNIVdP7okJdClhRVlVyeA8wtTN8S7zTrYr
	K0FhS0uUuqv7YJSrDjvUndBLa07+w3pwcZk1PxsQYC6lcRpoCswVUZYo7pJ44QBx
	k6jDlVE6bYw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E2BA72E40;
	Thu,  6 Mar 2014 18:11:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94ED072E3D;
	Thu,  6 Mar 2014 18:11:34 -0500 (EST)
In-Reply-To: <CAPig+cTTCsMDJ_B73+cbedrxoEqbM_txV6JYWmCq-LyX12TpNw@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 6 Mar 2014 17:07:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A95165AE-A584-11E3-B8B2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243569>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +test_expect_failure 'edit hunk "commit -p -m message"' '
>> +       echo e | env GIT_EDITOR="sed s/+line3\$/+line2/ -i" git commit -p -m commit2 file &&
>> +       git diff HEAD^ HEAD >diff &&
>> +       test_cmp expected diff
>> +'
>
> If you ever add more tests, is it likely that they will be using the
> same 'expected' file used by this test? If not, perhaps it makes sense
> to move creation of 'expected' into the test itself.

All good points.  Also, I think we try to use "expect" (not
"expected") vs "actual" (not "diff") in most of the tests.
