From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git describe` in an export-subst format string?
Date: Sun, 28 Apr 2013 15:52:20 -0700
Message-ID: <7vbo8yp8t7.fsf@alter.siamese.dyndns.org>
References: <CAFoDJR8RQExLwXcrViAJpWgvq+wBopY-Wq1keHxVqB3QwtAz4A@mail.gmail.com>
	<7vobcypciw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Gallagher <johnkgallagher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 00:52:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWaSX-0007cm-Bw
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 00:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab3D1Ww0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 18:52:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756321Ab3D1WwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 18:52:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAFB31AD7C;
	Sun, 28 Apr 2013 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xckv84JXNC9RyE1WK5c5e4kXJZU=; b=iOfbp7
	0D1Zhe2bCA42yCNGkZ3zXFSVJuuPj5njdR8rCmtnEogrXnpQs8jM5pp2p9LFGu+s
	d3tF5baoql+JiZPLuZZsrTTM4FRAQXIiptKPPlx1w0ZdXfzhjeYBzwq+Fyhz/xek
	qOT624mnEwrTJVwAxwLDAuN0ZYWLXM/CUSW/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbOJtHsYe0e83eU13c29gjyzXC4zlB7Q
	SYN2C9LdVOlwHd1e/BgMu5iRpFta6ozquvNQn7Z7TIMtJMTf2X7EJaWH6Opywmim
	TqCMvYPZ6VMNDqucfVVJqic5BFMjxgogzR2l4yPuRv6ycGeb0dhnstEcZl6ttwAE
	LYa1cqEwJ/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE2F91AD7B;
	Sun, 28 Apr 2013 22:52:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 536001AD7A;
	Sun, 28 Apr 2013 22:52:22 +0000 (UTC)
In-Reply-To: <7vobcypciw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 28 Apr 2013 14:32:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49A0ECB6-B056-11E2-9C09-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222758>

Junio C Hamano <gitster@pobox.com> writes:

> John Gallagher <johnkgallagher@gmail.com> writes:
>
>> The actual thing I want to do is
>> something like this:
>>
>>   static const char *project_version = "$Format:...$";
>>
>> where "..." is something that `git archive` will replace with the
>> output of `git describe`,...
>
> You need to find an appropriate pair of placeholders that can
> represent "git describe $it" and "git describe --contains $it".
>
> I am tempted to suggest a more generalized way that is not limited
> to describe at all, perhaps like this:
>
>     $ git show --format='%x( git describe %H )'
>     $ git show --format='%x( git describe --contains %H )'

Just in case anybody takes it too seriously, this particular
implementaiton will never be acceptable at least for use in
"$Format:" of export-subst.

I am "tempted to" suggest, but am not crazy enough to actually doing
so ;-).
