From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record base tree info
Date: Tue, 26 Apr 2016 11:30:31 -0700
Message-ID: <xmqqd1pcgr3s.fsf@gitster.mtv.corp.google.com>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
	<CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
	<xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Xiaolong Ye <xiaolong.ye@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:30:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7kx-0006Of-BT
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbcDZSai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 14:30:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752552AbcDZSaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:30:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C3CE314FCA;
	Tue, 26 Apr 2016 14:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rOK+R+QjijKJCBsLw5uKLz/eO4A=; b=KZ7WTY
	H1YTp0lZtGgWzh8ZOmL2HS8rqvFOGN/sJBF1uUNTXgph9odbHkNza5GskT7+w0Gn
	pljmV9zPI3lhdX+M+umhL+XnEyWIl2LJ4C0RONaRB9a+842fnDtdnZyYOe9lRHou
	jgSilQ8q5z6pyCFcB6Lxg4rVTE8PMakJ7qjdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oe25dxwKgNeXiMOtwH0UkIrQCC+xaAnn
	3SqElk81OYdpIrjMsEwddKST0Uokk+c5XCWPEHN8gUh9gnw5AvdEB3mee93FsDta
	ZSNoKH1QcaR1EdlOdtJxovtqep05LOmnLVyaDvw3ozlP26gKVgP3g58mhjtIliz6
	rEFJu0ZmxtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B492114FC8;
	Tue, 26 Apr 2016 14:30:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08E6A14FC7;
	Tue, 26 Apr 2016 14:30:33 -0400 (EDT)
In-Reply-To: <CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
	(Stefan Beller's message of "Tue, 26 Apr 2016 11:20:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F61C3B96-0BDC-11E6-953C-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292643>

Stefan Beller <sbeller@google.com> writes:

> I can totally do that for longer series which require some back and forth.
>
> But one-offs, such as typo fixes or other small things[1], for which I do
> even have a local branch (i.e. checkout origin/master && fix &&
> commit && send-email) this is another step that potentially bothers me.

So from where are you proposing Git to grab that information if you
do not tell it?  "If the HEAD is detached, assume that the base is
where it was detached from" or something?

> From a UI perspective it seems logical to also check if the base
> can be obtained from the patch range specifier.

If you are doing "format-patch master..my-branch", what do you
propose to set your base to?  master@{u}, perhaps?
