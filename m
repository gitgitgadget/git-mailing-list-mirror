From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git repository modified after migration
Date: Mon, 11 Jan 2016 10:19:26 -0800
Message-ID: <xmqq4mekx9ld.fsf@gitster.mtv.corp.google.com>
References: <CAFwKRnQ_EZ73DBfrb0HNks3dt3=YJbLRoHvB0mfsD9FA-ey6hA@mail.gmail.com>
	<5693C48A.7060801@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yang Yu <yang.yu.list@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 19:19:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIh43-00018z-KD
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 19:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933159AbcAKSTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 13:19:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932541AbcAKSTa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 13:19:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3849039BE7;
	Mon, 11 Jan 2016 13:19:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tzs5SEFpTn5/ZStzpTdZ1ZxCfUU=; b=RmoxY0
	UOmrHDa7NdXBVEHBkmUpD/bAYQLrR9TUave68OiPXfKf/QsJFw3O5bB8S/Z2lW3h
	rLVik+TcMFcmi8d99blGAZWt97DordWO0PAMAYy5irzHyMV7AUIJS2GTxyMPrQ0y
	PMELHGEsmln8Aig4cGXxDf6qasaUyLJ7hj8CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tk9gotx+9BqSlpHmKRlbkxh13Ycdt37W
	NxmhYjf4WwAic1HD0oFwPqlIK+H+Sifl8zlas3pyRMxHtxwUq8dl4C3lgWBF7H3q
	LMjQPcjcGOt9n7Ih1lMf3NzAWLVAggDpTeqrx/5A4FpFo3eNk6PSGoeh5Lh64Qhi
	Ic/iyByMeoA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3024A39BE6;
	Mon, 11 Jan 2016 13:19:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9AC1739BE4;
	Mon, 11 Jan 2016 13:19:28 -0500 (EST)
In-Reply-To: <5693C48A.7060801@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Mon, 11 Jan 2016 16:04:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DA4554D4-B88F-11E5-A385-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283688>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> This happens whenever the "stat" information changes, e.g. due to
> changed device numbering and such. "git reset --hard" would have been
> the quickiest way to reset the stat cache/index - after git diff, of
> course ;)

That does not quite explain why 'git status' reported modified files
in the first place.  It would have refreshed the cached stat info in
the index as the first thing to do.  "git status" I think is the
recommended way these days ("update-index --refresh" for us old
timers) to nondestructively correct the cached stat information
discrepancy caused by "cp -R".

If you need to resort to "reset --hard", then there is something
else going on.
