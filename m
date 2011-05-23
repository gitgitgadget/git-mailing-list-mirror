From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] setup: Provide GIT_PREFIX to built-ins
Date: Mon, 23 May 2011 09:43:26 -0700
Message-ID: <7v8vtxweoh.fsf@alter.siamese.dyndns.org>
References: <7vwrhjxn4t.fsf@alter.siamese.dyndns.org>
 <1306058055-93672-1-git-send-email-davvid@gmail.com>
 <4DDA0044.2060207@drmicha.warpmail.net>
 <FE7878D1-20E4-4CD4-B3FB-96322AA75855@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?B?RnLDqWTDqXJp?= =?utf-8?B?Yw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 18:43:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOYEL-0000BI-Qr
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 18:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab1EWQnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 12:43:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561Ab1EWQni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 12:43:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AFEF557C8;
	Mon, 23 May 2011 12:45:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8EHkUuIlqNyLbAD2OMFL173Fw8Y=; b=GE89XT
	kQAfRZWBazvFYyiEfW///9Zujn3Lmv4fgq4YRElDQQ9GXi7mnK303Ue9FQP4rkqO
	HjQ7qS7iopjJ3746aUIBZwnC9qK3sOu6YZ8/OGsXHVBITiZo7y+AjJGuFUVZrVvL
	Qd4/uhcltDRbKr5PiLq5KwXrWKH7VeqP7VjsI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EUqr1SMCdc8ugyM9WjnJwCQWVGGOEMF2
	+fVikmxQPfaV5FnyALs57ZACoCnT4zl/5GiJDJKadc3dk8PG0CdyJKHQtEWuxqhO
	4mLYEVB2I4w2Wdk8Q8A3h7wyORCuBk+IVJpJvHHRkeT3bTS047wS/+7nC/Wufvn9
	u5mpLzsdsls=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7062457C6;
	Mon, 23 May 2011 12:45:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3131E57C3; Mon, 23 May 2011
 12:45:34 -0400 (EDT)
In-Reply-To: <FE7878D1-20E4-4CD4-B3FB-96322AA75855@gmail.com> (David
 Aguilar's message of "Mon, 23 May 2011 01:40:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 17CA4BC8-855C-11E0-AD3C-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174251>

David Aguilar <davvid@gmail.com> writes:

> I guess external scripts can call rev-parse --show-prefix themselves?

That has always been the case, I think, and it shouldn't be a problem.

The real reason you want the new GIT_PREFIX for alias/hooks is otherwise
they would not have a way to even say --show-prefix to figure it out
themselves.

>> Overall I think it's a good change, btw. But it leaves it up to the
>> (script) user to know whether git has actually changed the cwd or not,
>> i.e.: Is $(pwd) where the user called us from or $(pwd)/$GIT_PREFIX?

As long as there is a way for a script to figure it out when it wants to
know, I think it should be Ok.

Isn't it just the matter of reading --show-prefix and comparing it with
what came in $GIT_PREFIX?
