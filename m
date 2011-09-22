From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Wed, 21 Sep 2011 17:49:14 -0700
Message-ID: <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	computerdruid@gmail.com
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 02:52:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6XWk-0007xN-Vj
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 02:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431Ab1IVAtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 20:49:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54234 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab1IVAtR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 20:49:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E36AB6473;
	Wed, 21 Sep 2011 20:49:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F4CG/dq6yHzpZEeUNWRicFcyWiY=; b=RFWFvZ
	MP/wfKQ8nfJpiZ1SVfkCxilC97vfXJ4euDTgQie8SoPRzBRnBkDjXHEcJfEBzqM6
	w3pfkI5WYoFD+rr+jdb7NuX5IqNVCBt8bxjhSvYOq+b91L1YyDM7SSAWkTD9o2kv
	XWzfSERJWmseMo5prYj0jooU8wMGbb+t4wIpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OvUOZftUhT5206eM/C0VzczFFElir0ND
	DL+8UxkvPXR1vWlIBv9HGj6WXbEP6dnEhCH5ruC40l3gpA9oTuf7Ei4jcZmPMPRK
	KJYwWtyiV33meGQXvm8H1tqJYDcGVscLYBvaHwjoHx5UCuYDyinjSFzudXKOa925
	Owgtj/ec5LE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5EE6472;
	Wed, 21 Sep 2011 20:49:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FA0B6471; Wed, 21 Sep 2011
 20:49:16 -0400 (EDT)
In-Reply-To: <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com> (Michael
 Witten's message of "Thu, 22 Sep 2011 00:13:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2ACD306-E4B4-11E0-AD72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181870>

Michael Witten <mfwitten@gmail.com> writes:

> On Wed, Sep 21, 2011 at 23:52, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
>> +       linkgit:git-config[1]. Note that if this option is specified
>> +       then only tags are fetched, refs under refs/heads/* stay unchanged.
>
> Note that if this option is specified, then only tags
> are fetched; refs under refs/heads/* are not changed.

Can we improve the wording without singling out refs/heads/* specifically?

I think the updated wording is not desirable for two reasons.

For one thing, for the most newbies, I think refs/remotes/origin/* (not
refs/heads/*) would be the hierarchy that they may expect to get updated
and surprised.

When you give --tags (or any other refspec for that matter; --tags is
merely a short-hand for "refs/tags/*:refs/tags/*") explicitly from the
command line, you are overriding the refspecs configured for the remote,
and all the refs that are _not_ covered by the refspec you gave from the
command line will stay unchanged, not just refs/heads/* but refs under
other hierarchies (like refs/remotes/* and refs/notes/*). 

Once the reader understands that the command line _overrides_ the
configured fetch refspecs, everything else should fall naturally into
place without further explanation.  For example,

	$ git pull origin frotz

would internally invoke "git fetch origin another_branch", and it would
not update any refs for the _same exact reason_ [*1*].  You are giving a
refspec from the command line (in this case, "grab refs/heads/frotz, but
do not store it anywhere"), and it overrides the usual fetch refspec that
may update "+refs/heads/*:refs/remotes/origin/*" (grab all refs at the
origin under refs/heads/ hierarchy, and store in refs/remotes/origin).


[Footnote]

*1* The merging of the result would update the current branch but that is
a natural consequence of "a pull integrates by running either a merge or a
rebase after running a fetch".
