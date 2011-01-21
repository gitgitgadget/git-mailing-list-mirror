From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Thu, 20 Jan 2011 22:08:36 -0800
Message-ID: <7vy66epz4r.fsf@alter.siamese.dyndns.org>
References: <4D3893EA.5090907@hartwork.org>
 <201101202127.39962.trast@student.ethz.ch> <4D389E69.608@hartwork.org>
 <7vk4hzqnbx.fsf@alter.siamese.dyndns.org> <20110120231649.GC14184@vidovic>
 <20110120233429.GB9442@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 21 07:08:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgAB7-0000K4-V5
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 07:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab1AUGIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 01:08:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab1AUGIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 01:08:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AE2F2306;
	Fri, 21 Jan 2011 01:09:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=oxGrvzEiLI5Yo+U5epf6Q9SxYBo=; b=Sdr/S3uuMLibSx5PshiyMur
	jUmb3oBs01d1bwqWfjlOHSQz2bOE6M5C23G/4So5LKdJxTR4hUUWcCyX3DRftNGW
	FZq+rjyzFOn29xjVcM+LS/wtU74CYED8nTRh3iGGbyLXWoY28mTA78zyP8G1L6Dm
	uSPLHMp99KREz7uE/TT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=blWydx29W5YXvgr2QlC+MGFq2p+78ZH0/1e1pN38UffWgTxKq
	t7eF0PTyPSzebr/Udu9TrMtaizzDJwxtGkubVdcSc3f7+qhGgKb/zsurhEmrSy3R
	DstcSF2S28SeicSNHQBwXD5BbSn/BwFh3LpH85pT29QtD/08YhcS1clxAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DCBAB2303;
	Fri, 21 Jan 2011 01:09:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 151802302; Fri, 21 Jan 2011
 01:09:24 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03308CC8-2525-11E0-9143-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165354>

Jeff King <peff@peff.net> writes:

> The problem is that we have a bazillion diff options that appear in many
> manpages, so you are stuck with one of:
>
>   1. repeat them all in each manpage (usually via some automagic
>      include), which dwarfs the original content, and makes it hard for
>      users to see subtle differences between commands
>
>   2. Say "this describes only the most frequently used options", which
>      leaves the user wondering which infrequently used options exist.
>
>   3. Say "we also take diff options, and you can find out more about
>      diff options in git-diff(1)." This at least points the user in the
>      right direction, but you can't search for "--color-words" in the
>      page.
>
>   4. Do (3), but also list the all (or common) diff options in a succint
>      list without descriptions, and refer the user to git-diff(1). Then
>      they can grep if they like, and while they won't get the immediate
>      answer, they will get referred to the right place.
>
> As you can probably guess, I favor option (4), though we already do (3)
> in some places.

We attempt to do 1 to solve it "nicely" in some manual pages, and indeed
there are many "exclude this option from the command X's manpage" magic
that causes the problem of subtle differences you mentioned (which I
agree).

One complication in either 3 or 4 is that they sometimes need to be
accompanied with "... except these diff options do not make sense in the
context of this command, so they are no-op".  That is probably a price
worth paying to be more helpful than 2 is.
