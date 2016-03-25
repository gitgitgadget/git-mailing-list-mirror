From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] branch -d: refuse deleting a branch which is currently checked out
Date: Fri, 25 Mar 2016 14:00:50 -0700
Message-ID: <xmqq4mbu2ry5.fsf@gitster.mtv.corp.google.com>
References: <cover.1458927521.git.k@rhe.jp>
	<cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Fri Mar 25 22:01:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajYqo-0001AA-Fd
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 22:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbcCYVAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 17:00:53 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbcCYVAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 17:00:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C552F4E82A;
	Fri, 25 Mar 2016 17:00:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aQS502B/TcyZLbUpFAjOyrN4wZ8=; b=wILIiv
	ZlJyVgcVX6qgilqSUAdwBIw3gilIal0/id0p2j7M5eacnXRwzXxgBGJSSFB8xCV/
	rjGIDqo8/zpccuVyMag0gK0XhvdOUwDoX0a+sbgH0rDVjg4jjdK2jTqi3/zHbTBr
	6aWOL6IQcmjWzpHF7aEiFeuGep2VqofqUYGRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OUVFYNKGq6iF+dRYSToNbG+EOSvx5okY
	Sx0/h34IzsIKSRX5ZxxfCDzn1Uw7qhZCXmT1x2/O+de4v3RCAStmqGbqpjmi6maJ
	SnMuvvGSPt0KcdqiidLaYSpd4DhJDB3o6N7XAl/en7EgclD8IZdEMUqi4Y9SjOX2
	P0ssZ1i7+SE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B4D0C4E829;
	Fri, 25 Mar 2016 17:00:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 297174E828;
	Fri, 25 Mar 2016 17:00:51 -0400 (EDT)
In-Reply-To: <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
	(Kazuki Yamaguchi's message of "Sat, 26 Mar 2016 03:28:23 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8145C18-F2CC-11E5-A0C1-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289952>

Kazuki Yamaguchi <k@rhe.jp> writes:

> When a branch is checked out by current working tree, deleting the
> branch is forbidden. However when the branch is checked out only by
> other working trees, deleting is allowed.
> Use find_shared_symref() to check if the branch is in use, not just
> comparing with the current working tree's HEAD.
>
> Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> ---

It seems that applying this directly on top of 'maint' does fix the
issue (and applying only part of the patch for t/ illustrates the
existing breakage), so let's make it a separate topic as you hinted
in your cover letter.

Thanks.
