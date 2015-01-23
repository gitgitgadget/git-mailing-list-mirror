From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull not ignoring the file which has been sent to the temporary ignore list
Date: Fri, 23 Jan 2015 13:14:03 -0800
Message-ID: <xmqq8ugtqjxg.fsf@gitster.dls.corp.google.com>
References: <3278910.5D06XWKxyS@linux-wzza.site>
	<xmqqiofxqoo3.fsf@gitster.dls.corp.google.com>
	<4004424.cytMaov38D@linux-wzza.site>
	<CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Arup Rakshit <aruprakshit@rocketmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 22:14:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YElYS-0002GO-JV
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 22:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbbAWVOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 16:14:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751792AbbAWVOH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 16:14:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 861E1304F2;
	Fri, 23 Jan 2015 16:14:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+8n35NH/1NNSTkhSETFil6pRuk8=; b=LcWcFo
	pRIzD1mXiCZ9eaqLPy1Nk86HT5zCWvtXrQKTds1qd/y/8KJdwNAT+InFsjyu1Tzj
	Bv7o62qOWK70Sj/3apNicPbJyHzhj1Y+AokyrBHSr/L5Koj+eLUyiAyKI/Pk0Sj6
	IdrMQ8gSdXwNoRFcz9ujqb6P4JL+MRa+Bi8aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qiiggUeePZXZ10B+15pCp6BuCi3hZZV3
	E+XB2hdPI0YvD5m2D4i4AzqIAe20PtY8HteRBbo91xSFM9h6IRi1bI5aeaPGvplj
	s+EUSTZKfpuoJxch4O8k8CINRPBxK5/bOKaXrDEgtHxC5XhWel8fgLcXTabtAq9p
	eoR7sWvkw+M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DA15304F1;
	Fri, 23 Jan 2015 16:14:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB923304EF;
	Fri, 23 Jan 2015 16:14:04 -0500 (EST)
In-Reply-To: <CAGZ79kbk=DFcMSVtnWHw7Vn-xm4q4x5T_9qiPrqt5oN1DMhFSw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 23 Jan 2015 12:12:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2D3FF78-A344-11E4-BBC9-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262961>

Stefan Beller <sbeller@google.com> writes:

>> Ok. How should I then ignore any local changes to the .gitignore
>> file ? And while taking pull, git should skip this file ?
>
> Look at .git/info/exclude

Good answer for ".gitignore".  In general, you do not "ignore local
changes" to tracked paths.

> I found https://help.github.com/articles/ignoring-files/ as Googles
> first hit, which advises to use
>     git update-index --assume-unchanged path/to/file.txt
> Not sure if that is most helpful advice there.

The piece of advice in the last paragraph on that page is wrong (and
it has been wrong from the day it was written).

The gitignore(5) documentation used to have a similar incorrect
piece of advice but we finally corrected it recently.

Cf. http://thread.gmane.org/gmane.comp.version-control.git/260954/focus=261118
