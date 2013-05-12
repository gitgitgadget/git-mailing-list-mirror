From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 15:22:50 -0700
Message-ID: <7vwqr3u9c5.fsf@alter.siamese.dyndns.org>
References: <cover.1368274689.git.john@keeping.me.uk>
	<518FB8DE.7070004@bracey.fi> <20130512162823.GK2299@serenity.lan>
	<20130512163317.GL2299@serenity.lan> <518FCDDE.9040707@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon May 13 00:22:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbefR-0003vr-4R
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 00:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab3ELWWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 18:22:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab3ELWWw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 18:22:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AD061DFE8;
	Sun, 12 May 2013 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=85d2UhTIJQtxM+42hUTEHrcQRKQ=; b=jL/Ygt
	YswQSFMcngqYAANCQ9tv6sTU8HmmaDKKFd3+bipKZrztMD0Uvn6xIgbdze7h/LV6
	sXY9n//azpV11TqPqL7RG13XULgZYc1bfwXjCfee+aICHcyKrw0qnhkY+EdVDfhL
	ca4jFiMFU11jkPPw1bbpmkRZd+C4I/roFJRbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AJs9AqMuWOJlt/b3z2K2Wa+29EYsRnc/
	Jt1fHL8RNyBJeLEUDk1Wo0U1q6v6WW53TG7gA8+FlTlqFgdeN35FNTIvfpd5SkKe
	iartHds65a2dSc4zlHfeseXb5ghRrisDzpNYaPcHKKXVFBUrsDhDyLHj0Uo7RIC4
	zTLcoCkp+ck=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C0991DFE7;
	Sun, 12 May 2013 22:22:52 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91AEE1DFE6;
	Sun, 12 May 2013 22:22:51 +0000 (UTC)
In-Reply-To: <518FCDDE.9040707@bracey.fi> (Kevin Bracey's message of "Sun, 12
	May 2013 20:14:06 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BF808E6-BB52-11E2-A98F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224066>

Kevin Bracey <kevin@bracey.fi> writes:

> Although I realised after
> sending my mail you could also use
>
>    git log --ancestry-path --left-right E...F --not $(git merge-base
> --all E F)
>
> which looks like we're having to repeat ourselves because it's not
> paying attention...

You are half wrong; "--left-right" is about "do we show the </>/=
marker in the output?", so it is true that it does not make sense
without "...", but the reverse is not true: A...B does not and
should not imply --left-right.
