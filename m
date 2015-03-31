From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Clone from shallow bundle bug
Date: Tue, 31 Mar 2015 15:17:01 -0700
Message-ID: <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com>
References: <551B0D37.5070407@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:17:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4T8-0001xL-BB
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbbCaWRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:17:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751817AbbCaWRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:17:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 231AE457AB;
	Tue, 31 Mar 2015 18:17:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TpVJPSQGqPKvz/e7SaevNMqFXsw=; b=o8ISTc
	gfFfj9ZQylBZPqBKqjFtOf+NsM/CwBzgekuZg8Pye6x89BMeRdPmNRplR0P7FaUS
	ov1AU+jv3xuX+jNLZPUG2Nv+HcBysRtrUV8VHdFD8ZZjKJPsoohDCmmszSEsEWcW
	jmvBl/q4Iz23coeCiD4f7WfwqkoW9w/QuerfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZPQy/5++20cjmGcsICPyMVbuwafqFVy
	7BHp5CN+evREe3JbBzcu+e3N0R3MhmSnxvkz6eqCUjHwYRYo+zTphTTzeOZRC+Wo
	QAspq+12XQshp+ONZBMwpW8r0VFryozHczkFfwqK64AZvLlaaBMDXngYNA0JNX8Y
	TDsRlCw1vwo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C558457AA;
	Tue, 31 Mar 2015 18:17:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92F25457A7;
	Tue, 31 Mar 2015 18:17:02 -0400 (EDT)
In-Reply-To: <551B0D37.5070407@ubuntu.com> (Phillip Susi's message of "Tue, 31
	Mar 2015 17:10:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8275EFC-D7F3-11E4-8F03-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266565>

Phillip Susi <psusi@ubuntu.com> writes:

> I made a shallow clone of my repo, then used git bundle create to pack
> it all into a bundle file, then cloned from that bundle.

I think the introdution of shallow clone feature broke git bundle create
by not teaching it that its shallow boundaries are prerequisite commits
to unbundle its contents.  IOW, the bundle created from the shallow clone
is broken, I would think.
