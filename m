From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: Config option for --no-ignore-removal/--ignore-removal
Date: Wed, 16 Oct 2013 14:38:49 -0700
Message-ID: <xmqqli1s6gly.fsf@gitster.dls.corp.google.com>
References: <1380081691.7963.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Cline <matt@nightrealms.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 23:38:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWYnw-000830-5F
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 23:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab3JPViw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 17:38:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab3JPViv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 17:38:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A9B14BD73;
	Wed, 16 Oct 2013 21:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zkJh/+zEzUmSIGkucwDc6KU+Hkk=; b=ExLuwbVhKEpBsgAOeSUl
	2WHrS23hB+gGGPkjFvTgFrD3r3Zx4c5YFxjEl7Z/aC0YzmyJoCbB7G49sdDp2E9+
	uEV1fKwJBBWpkecIXv4PGXayiOCv3n3yy5KXwgQPJN+a2/EiarqYt9Bmh+PEgBmK
	6QxHPuv93Yt8BGoU3BMqTEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=li5JHXTvEh/YQWB4iAohPJHUU6ciNSMGdJlBrvZHutevMh
	FaXYz2XC35HX3rtuX3RXnfhnagrIRTdbJjqSIirmomzK3+t33C+TIoUY4TM2Vb6i
	IxR+++6CY5uhSFT3ialnEnirafBwXxZOvez9iqyaRXR8cz/LazcPHSrILSajM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20A5A4BD72;
	Wed, 16 Oct 2013 21:38:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E9144BD64;
	Wed, 16 Oct 2013 21:38:50 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 589D8C70-36AB-11E3-BD01-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236266>

Matthew Cline <matt@nightrealms.com> writes:

> When I try to a plain old "git add ." when files have been
> deleted/moved, I get the warning
>
>> You ran 'git add' with neither '-A (--all)' or '--ignore-removal'
>
> There should be some way to put something in ~/.gitconfig to tell git to
> always choose one or another.

The lack of configurability is very much deliberate.

Adding such knobs that make basic behaviour of Git different
depending on the per-user setting will make it unnecessarily harder
to run to help your coworker when she is having problems.  "git add
directory" you type in her terminal during the session to help her
could work differently from the way you are used to, if we added
such a knob.  We will not be making that mistake.

As the advice message says, "git add directory" ignores removed
files in the directory in the current version, and in Git 2.0, the
removals are recorded in the index with such a command, so that "add
directory" records the state of the directory as a whole to the
index, which is more consistent.

And that works for everybody the same way; the only way to prepare
for you not to be negatively affected by the switchover is to train
your fingers to say --all or --ignore-removal when the difference in
behaviour in the current and future versions matters, hence this
advise.
