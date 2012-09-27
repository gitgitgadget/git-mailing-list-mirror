From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] completion: quote completions we find
Date: Thu, 27 Sep 2012 15:31:10 -0700
Message-ID: <7vy5jvnln5.fsf@alter.siamese.dyndns.org>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
 <20120926215700.GB18628@sigill.intra.peff.net>
 <20120927214046.GJ10144@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THMc7-00078o-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab2I0WbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2012 18:31:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab2I0WbN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2012 18:31:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 861C787C5;
	Thu, 27 Sep 2012 18:31:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mz/Pz0opGWa2
	YDSrvHHA+zNW2tY=; b=Ev8qxvVSufjmRvRxAl6ZDeqO/eVvC7wsGkLW99n1pnQd
	4UweLyfwPdMORNFaMk2bM3nyYKwvCFBsAugP+tprUfaSQ7hoCq+LfHcPMrgnpCcz
	si4hzRZOC3F09tJxxWmy/5Fs/VCYJ1Tg9AdtnyZXeo5IXWFeqdZuIOGnmoEoR2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DuU4tq
	/UTUQRKsTpGGz+7Cg0aiIJd1lqtiVzt/9e3fYn2d1t+tXOaB3c+31SZmulw3uR32
	jWoU7B2VJxSiNqc/UY66JiY+9zRunFPw4EGHu76fQZDMaCft0NtPfZxe8KlmBq4Y
	/c+nQxNv5szh7QIpu/KDJ/IpfL/M3DZsM4550=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7339B87C4;
	Thu, 27 Sep 2012 18:31:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5C7087BF; Thu, 27 Sep 2012
 18:31:11 -0400 (EDT)
In-Reply-To: <20120927214046.GJ10144@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of "Thu, 27 Sep 2012 23:40:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A6C9C62-08F3-11E2-B6F5-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206525>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Wed, Sep 26, 2012 at 05:57:00PM -0400, Jeff King wrote:
>> +		COMPREPLY[$i]=3D"${COMPREPLY[$i]}$stripped"
>
> This reminded me to a mini-series collecting dust in my git repo,
> which converts a few similar var=3D$var$something constructs to use t=
he
> +=3D append operator instead.

Is the benefit of rewriting it to var+=3D$something large enough to
worry about the below?

> Now, Bash supports this +=3D append operator since v3.1
> (bash-3.1-alpha1, to be exact), which is around since July 2005, if I
> can trust the mtime at ftp://ftp.cwru.edu/pub/bash/.  MSysgit ships
> v3.1 so it already supports this, too.  So, what is the oldest Bash
> version we care about for completion?
