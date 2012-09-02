From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Sun, 02 Sep 2012 13:42:44 -0700
Message-ID: <7voblognny.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com> <50412E2D.7070503@kdbg.org>
 <5041BC94.7000304@gmail.com> <504214AA.9080706@kdbg.org>
 <50425F8B.5020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2M-00008J-AD
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab2IBUok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab2IBUog (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9B4C8317;
	Sun,  2 Sep 2012 16:44:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=V6foorU5StgVmhFtcIo/HNqfwbs=; b=uQiA+XlgiAv7AuHQaE+l
	hBS1t4l8sKkRC/aSeHMS70COMJqdrHkNXww60Q/EMtzq3mTf5jOvI8qLRPlwuRC6
	tlYziZlxhytuvNBBbmT/RNMxgWFTmbhBi81JI2izjzHVFjK50SVHjC14mxUgrG80
	RrFq7QX41IJLebSvAzv57Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SuvhFVShjFQXcCRiiZlFmkTKnK1XiJcam5Kn5yFqdOeIvQ
	RE0gvyCr/+pK9pc7+wWj0k74o5u7Y7YtdLcy9BOXaYWDDhRDuVmgGl+4KpDdg+Vu
	UoorR655qh+ok0J2UrIPSM/QAPIW+zxq72cnydRU0d42KaC9RI3qEa4QFchxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D71508316;
	Sun,  2 Sep 2012 16:44:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4038E8314; Sun,  2 Sep 2012
 16:44:35 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01610364-F53F-11E1-AACE-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204673>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> Il 01/09/2012 15:59, Johannes Sixt ha scritto:
>
>> Look how you write:
>>
>>    perl -e '... $ENV{'PATCHTMP'} ...'
>>
>> That is, perl actually sees this script:
>>
>>    ... $ENV{PATCHTMP} ...
>>
>> (no quotes around PATCHTMP). That my be perfectly valid perl, but is not
>> what you intended.
>
> I don't understand what you mean when you say "is not what you
> intended"...

When you wrote this:

    CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'};...

which one of the following did you mean to feed Perl?

 (1) open FILE, $ENV{'PATCHTMP'};
 (2) open FILE, $ENV{PATCHTMP};

The patch text makes it look as if you wanted to do (1), but what is
fed to perl is (2), as Johannes points out.

Saying:

    CCS=`perl -e 'local $/=undef; open FILE, $ENV{PATCHTMP};...

would have been more natural if you really meant to do (2), don't
you think?  So what you wrote is at least misleading.

But I think I agree with Johannes's rewrite of the loop, so this may
be a moot point.
