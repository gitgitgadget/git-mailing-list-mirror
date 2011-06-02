From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status --ignored
Date: Wed, 01 Jun 2011 22:13:55 -0700
Message-ID: <7vr57cerxo.fsf@alter.siamese.dyndns.org>
References: <4DE712CE.20509@vpac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Spiers <aspiers@vpac.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 07:14:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS0EY-0003vY-P6
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 07:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab1FBFOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 01:14:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1FBFOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 01:14:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57EEA24AC;
	Thu,  2 Jun 2011 01:16:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GfQFEZaBWpk2nBcjsiGRKToYLkk=; b=CkH/i0
	PT64FdOSfRlC9nvTnMnq0XMTVadAVwprBGfh3Vs1x/yhEC7ALIdlzZC+ioXBo48c
	PypHzo1EU/wEApXL1HRsrrjAcybeLgDI3Av27pePogwqi0aR11q7g2MQKQLNHKoY
	IAb7nK7p22UsBU7jVXOuFt7MM1txF9qY/4JtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XZiKK6PflAfoL0XTq57OTYxamNqen+Af
	lPUGw88yrsGnc9GgrEHcz654scwymGcDwXiKcDQ/barzCLq5bUxzvYb/WhNWflHS
	K6UhgQFQOf9pAFvp5s4NIvzwnA7ry0zTs4M37g0ahR6JeJXzK0r/ulqvBBhnCEWr
	ic/d+TpUQ04=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 216F924AB;
	Thu,  2 Jun 2011 01:16:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA55024AA; Thu,  2 Jun 2011
 01:16:04 -0400 (EDT)
In-Reply-To: <4DE712CE.20509@vpac.org> (Andrew Spiers's message of "Thu, 02
 Jun 2011 14:34:22 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C117850-8CD7-11E0-9410-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174928>

Andrew Spiers <aspiers@vpac.org> writes:

> This looks like a bug in git 1.7.4.1.
>
> git status --ignored does not show my ignored files and
> directories. git status -h suggests it should.
> git status --ignored -h does show my ignored files and directories.

Does not reproduce for me. With --ignored (with or without -s), I see all
the dot-o files that are ignored by .gitignore rules that are usually
omitted from status output without --ignored.

  $ make >/dev/null 2>&1
  $ rungit v1.7.3 status | grep -F git.o
  $ rungit v1.7.3 status --ignored | grep -F git.o
  #       git.o
  $ rungit v1.7.3 status -s --ignored | grep -F git.o
  !! git.o

The same for v1.7.4.5 or more recent versions. I am not inclined to build
and install v1.7.4.1 to test, as I do not think it is likely that the
particular version is bad. It is more likely that there is something wrong
with your particular setting or expectation.  E.g. already tracking a path
that would match .gitignore rule, and expecting that such a path is shown,
even though it is not "ignored".

> Also, git help status does not mention the --ignored switch.

That may be true; patches welcome.
