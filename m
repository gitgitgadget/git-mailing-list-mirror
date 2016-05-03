From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7300: mark test with SANITY
Date: Tue, 03 May 2016 12:28:12 -0700
Message-ID: <xmqqmvo7lz5f.fsf@gitster.mtv.corp.google.com>
References: <1462301672-20866-1-git-send-email-sbeller@google.com>
	<20160503190417.GD30530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	janx@linux.com, Lars Schneider <larsxschneider@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 21:28:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfzf-0004jp-Al
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbcECT2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 15:28:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756306AbcECT2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 15:28:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB1A6182ED;
	Tue,  3 May 2016 15:28:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZsZeTikHT42MEoz2Wuvyho2896o=; b=uo+V/s
	kHdnjIcCvRoBWxqMyAgNlbf3XOWc653fsYOYf40vwQDCurv/Z5u0X9HfTSPx9ZaB
	xzmKM5ypFNkWGlblCDr16rP1O25XsY5Avz3UoRsnmzI79Z/yzipHc0FMs9fyBxgr
	OiRVFU/KllO/UUwDc7A6nfgvq0vw/rr4uVfvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UNT4TIvlSov97v9K4n7oC8H76f2V1rLk
	wiKGkWoHGXx74oHfe7Yg2t5D0v+LjxqHKU+g+vzgfOy18rV/evS1Ha3hlNDxSM9q
	sS5Lo2Xnyg8ZTRZhIRHfCRga57oMh7J+j52JM0Y0KXS+UBI+VuVeqf1B4sJUu7AH
	9CEQd5vViVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B2E92182EC;
	Tue,  3 May 2016 15:28:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 182F1182EA;
	Tue,  3 May 2016 15:28:14 -0400 (EDT)
In-Reply-To: <20160503190417.GD30530@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 May 2016 15:04:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2DF50344-1165-11E6-93FC-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293443>

Jeff King <peff@peff.net> writes:

> On Tue, May 03, 2016 at 11:54:32AM -0700, Stefan Beller wrote:
>
>> As the test runs `chmod 0` on a file, we don't want to run that test
>> as root.
>
> This somehow misses the root (no pun intended) of the issue, to me.
> Perhaps:
>
>   We `chmod 0` a file and test a case where git is unable to read it.
>   If the test is run as root, the permissions are ignored, and our
>   simulated read failure does not happen.
>
> The patch itself looks obviously correct. :)
>
> -Peff

By the way, it is easy to make a mistake like this, not to notice it
during a review, and to leave it unnoticed for a long time,
especially because I do not think anybody active in the development
community runs tests as 'root'.

Perhaps in a future update, Travis should learn a step to catch
breakages like like this.  Or perhaps it is not worth the effort?
