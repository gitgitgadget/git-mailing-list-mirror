From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree behaviors
Date: Mon, 01 Feb 2016 10:19:56 -0800
Message-ID: <xmqqh9hswawj.fsf@gitster.mtv.corp.google.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-1-git-send-email-pclouds@gmail.com>
	<1453808685-21235-2-git-send-email-pclouds@gmail.com>
	<xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
	<20160130142039.GB4978@wheezy.local>
	<xmqqh9htya2e.fsf@gitster.mtv.corp.google.com>
	<jwvfuxd17bz.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	<CACsJy8DGsDFnX57eQ7rN2hkOR3Wuw_eQ9ED4e-9FhAm30sBFEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Monnier <monnier@iro.umontreal.ca>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:20:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQJ51-0003DS-Nm
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 19:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbcBAST7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 13:19:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751853AbcBAST7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 13:19:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A3483F8C8;
	Mon,  1 Feb 2016 13:19:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=++UlZCslXqolNrUxDGC9We2ijcA=; b=Hd/MeO
	i8zxTXOJAt9EHdgDw89Xs7bS5cTTazL7AEGA7qt+wOp4pTdezyIs5iW2bPwq6va6
	CivGtz7Z5H/r70kugoq3Z/9PvsyPo5XKyP2bFoHgeRLbRj8PAhyb+2cKUlmvpKG4
	HK9E8U0Rk++id3lv0DFMd11OFXC5CVHbkgEyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nrX32HU/LJ7TgO3lZE4c/zZvkQ9hg3ll
	zmzpu/qJa4R8voe9epXdt+QIARjbnJATzUSUJPzthnO+eunYKCviLfL8JO5qgzMx
	SMBuFcg4p5mTgmixrx1vHsOF1PPT19cBsSjw0vYNEwAYZgYPCuoQ/c0eSSQ34uYb
	BTFJ6KiAuME=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5209F3F8C6;
	Mon,  1 Feb 2016 13:19:58 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B39503F8C5;
	Mon,  1 Feb 2016 13:19:57 -0500 (EST)
In-Reply-To: <CACsJy8DGsDFnX57eQ7rN2hkOR3Wuw_eQ9ED4e-9FhAm30sBFEQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 1 Feb 2016 12:23:46 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 664A9300-C910-11E5-A268-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285205>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Feb 1, 2016 at 9:41 AM, Stefan Monnier <monnier@iro.umontreal.ca> wrote:
>>> One lessor key phrase above is "so far", I think, and another one
>>> you forgot to use is s/which requires/that we know &/, which to me
>>> is a more serious one.  IOW, I do think it is premature for us to
>>> say that that config split issue is the only thing, or to say that
>>> the issue is best solved by changing the layout in the way being
>>> discussed; the multiple-worktree feature needs more lab experience
>>> for us to gain confidence.
>>
>> As a heavy user of the git-new-worktree "hack / script", is there
>> something I can do to help "get more experience"?
>
> You can try out "git worktree" command (in "lab" environment) and see
> what's missing, what use cases of yours it does not support.

Yup, that would be very helpful.
