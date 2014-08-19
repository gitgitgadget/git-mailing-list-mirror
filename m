From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 09:39:08 -0700
Message-ID: <xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<20140819102421.GA5012@book.hvoigt.net>
	<CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 18:39:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmRS-0007DG-Mx
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbaHSQjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:39:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57734 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbaHSQjT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:39:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1594133BD5;
	Tue, 19 Aug 2014 12:39:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qF8yP1kO8w05vLTQpZHAsPqXLTI=; b=pBGuvL
	Sd3quJyJBM4onAbHSXDaUWqyHvPL+HpM0egMtB6u/us9zUUFiRXc4+WhQxM3ybIK
	ngYI2MunIWJVxixJNebMut2uDJ8P1/Rxahm/2qXeGsFn8f1cHMB8P+5lMZYZRy03
	fdjbzAweKpYzX5R+Ysrf1FuoTo9qUM1xblzKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wz2QNHIaDDAQUyJk625Rs1NHGS1mhFEW
	Ry4kzYMgREvT/cSECmc0Ph2tzWagIU72SJwzKxVztgboa3fytTkj37wMBNaIvY6o
	mbxdecsGa9kXcDP/3chVaciB78LSkQQmAmBYyUiAwF6qukP/Ji/ddHGZc0n+dsPh
	R2iewE2iGog=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED3EA33BD4;
	Tue, 19 Aug 2014 12:39:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C5E133BCB;
	Tue, 19 Aug 2014 12:39:10 -0400 (EDT)
In-Reply-To: <CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
	(Robert Dailey's message of "Tue, 19 Aug 2014 11:15:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5847A138-27BF-11E4-B145-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255499>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> The way I set up my remote tracking branch will be different for each
> of these commands:
>
> - git pull :: If I want convenient pulls (with rebase), I will track
> my upstream branch. My pushes have to be more explicit as a tradeoff.

Keeping 'origin' pointing at the repository where you cloned from,
without doing anything funky (i.e. "set up my remote") would give
you convenient pulls.

> - git push :: If I want convenient pushes, track my origin branch.
> Pulls become less convenient. My relative submodules will now need to
> be forked.

You need to configure your pushes to go to a different place, if you
want them to go to a different place ;-).

Long time ago, it used to be that you have to affect the URL used in
both direction, making pulls less conveninent, but hasn't this been
made an non-issue for triangular workflows with the introduction of
remote.pushdefault long time ago?

> - git submodule update :: I track upstream to avoid forking my
> submodules. But pushes become more inconvenient.

If 'submodule update' follows the same place as 'pull' goes by
default, I would imagine that there is no issue here, no?  Am I
oversimplifying the issue by guessing that the root cause of is that
you are not using remote.pushdefault from your configuration
toolchest and instead setting the 'origin' to a wrong (i.e. where
push goes) place?
