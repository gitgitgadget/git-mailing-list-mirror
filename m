From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 16:42:44 -0700
Message-ID: <7vzjvmh98r.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 01:42:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfIgJ-0006Qn-P0
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 01:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab3EVXmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 19:42:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40292 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab3EVXmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 19:42:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1647F2144D;
	Wed, 22 May 2013 23:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cFpP5Qaf3ko7o42js0b7rhFzM7A=; b=UXI9KY
	aODiwC/sC67nsjCak/FZu+2bNEbtuL2SasGpt0RL+AL8IpHU6sZbRjb35NW0uvxz
	1R8FB/l2Uh1cRxg6/AxLTu84yjfOXuxK1FA2OiIl3piruoID8uthkoiCXlwUR9pZ
	bhYYOLEl1lt9p9Yx9OzV77/HOrwAYetqZiljw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A8Z1o9IxmzCViJ3cL34YoKiZxfQV+Imq
	g1xlsydX4zkAEJhAaWr/ACOZUu7Lc7BYF+7LAOsCwJvGU3H6KPXIOHhlXMPK89Cp
	dh+gEWcLKIuMTPPCmRta+I7JkVsrFEqbD8DL25Y2zJQY7RDpWuNMvbX8KB/n8d99
	lmH0dBghz9I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D61F2144C;
	Wed, 22 May 2013 23:42:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CC342144B;
	Wed, 22 May 2013 23:42:46 +0000 (UTC)
In-Reply-To: <7v4nduipvb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 22 May 2013 15:58:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E0315B8-C339-11E2-8EF2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225205>

Junio C Hamano <gitster@pobox.com> writes:

>>> The person who moved the code will be on the list regardless,
>>
>> That is exactly the point I have been trying to raise.  Does the
>> person appear in the list when you run blame with -CCC?  You ask for
>
> s/person/commit/;
>
>> the body of the function, and the -C mode of blame sees through the
>> block-of-line movement across file boundaries, and goes straight to
>> the last commit that touched the body of the function in its original
>> file, no?

-- >8 --
cd /var/tmp/
git init blame
cd blame

cp /src/git/COPYING COPYING
git add COPYING
git commit -m initial

sed -ne 120,140p COPYING >EXTRACTING
git add EXTRACTING
git commit -m second

git blame -C -C -C EXTRACTING
-- 8< --

will show that all lines from EXTRACTING came from the original
revision of COPYING, and we will miss the line-move event.

"blame -C" with a single -C does not look at the files that did not
change in the commit that added these lines to EXTRACTING
(i.e. COPYING), so the digging stops there.

After this, if you do this:

-- >8 --
echo >>COPYING
git commit --amend -a --no-edit

git blame -C EXTRACTING
-- 8< --

then the commit that did add these lines to EXTRACTING touched
COPYING, and the origin of these lines are traced to it (this is
designed to be useful in a typical "refactor by moving code";
"cut and paste without changing the original" people need heavier
copy detection with more -C).

IIRC, git-gui runs two blames, one without any -C and one with (I do
not offhand recall how many -C it uses) to show both.

HTH.
