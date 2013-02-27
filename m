From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: allow pattern escape using backslashes
Date: Wed, 27 Feb 2013 07:42:20 -0800
Message-ID: <7vlia9kbkz.fsf@alter.siamese.dyndns.org>
References: <1357310809-4771-1-git-send-email-pclouds@gmail.com>
 <7v7gly5az0.fsf@alter.siamese.dyndns.org>
 <CACsJy8Ag8rJ4P6w6ZCB0vBp6Hzqr_G5vWS_Jt=RNQT8+hF_w_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 16:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAj9f-0000mc-HP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760281Ab3B0PmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:42:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760040Ab3B0PmX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 10:42:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02CE8A8D5;
	Wed, 27 Feb 2013 10:42:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sLAdW6OIL1uWctdcr99xbrxsQS0=; b=mh2gVe
	fraBtgXT8PJrJpZe2HtrUU7BnKZJ5oRLqwENYxqTVPE0kFclvCCQja20ejVhlZsw
	PVloQAtpdlPwHP/nTmTJX48yc7B4/kRyxHWwXip2KR/bHY082kd2mdyxCR9ekeXt
	5KMKuNlzaEkwxPg6ie6AXH4x65Ov/T1uLtf0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wEOfyYSNGl9ACTAvQhXuGtnSUYAKjgaG
	+7scEy41QdOMD7pqpfzCoDkEIWoosHMaSVWutFkPMGihjK2++EmaW+yCu5nVM4YD
	9Jfy78KIw9+OSCsNt5e5HTNd25Cq5K4jlYMGittKjYS75mLvZXdyFUE9aD2r6gUA
	G0DVCQEw6pU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB3B1A8D4;
	Wed, 27 Feb 2013 10:42:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CF44A8D3; Wed, 27 Feb 2013
 10:42:22 -0500 (EST)
In-Reply-To: <CACsJy8Ag8rJ4P6w6ZCB0vBp6Hzqr_G5vWS_Jt=RNQT8+hF_w_A@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 27 Feb 2013 19:23:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46E84492-80F4-11E2-AFC8-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217212>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 24, 2013 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Speaking of .gitignore, I recall that there was a hanging discussion
>> on allowing a pattern to name the directory that the .gitignore file
>> appears in, which I do not think we currently support.  With such a
>> feature, instead of listing "/junk" in the .gitignore file at the
>> top-level to say that everything inside the "junk" directory is
>> ignored by default, we could instead say "<this>" at the beginning
>> of the .gitignore file in the "junk" directory.
>
> Shouldn't "/" alone in junk/.gitignore express that? It does not work,
> but I think it's a natural interpretation of the syntax.

Yup, there is nothing that you can plug to the "<this>" in the above
to make it mean "junk" directory is ignored.  A trailing "/" is
removed after noting the fact that the entry is about a directory
and leaves an empty string, and it would be OK to define that an
empty string matches the directory the gitignore file appears in.
