From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Sun, 28 Feb 2016 10:21:43 -0800
Message-ID: <xmqqfuwcg0g8.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
	<56D078F3.9070905@web.de>
	<xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
	<56D0D2DF.1040807@web.de>
	<xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
	<20160227032907.GB10313@sigill.intra.peff.net>
	<56D14C56.6070306@web.de> <56D1DF53.1010006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 19:21:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa5yZ-0000GO-DU
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 19:21:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbcB1SVr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2016 13:21:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753496AbcB1SVr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Feb 2016 13:21:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A299B44C37;
	Sun, 28 Feb 2016 13:21:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yRnDMw1eUyJ8
	ZlHLgjQIVSL31Nk=; b=XaKSG9W4hsZrFYnk7gryxfibb/Y4vrz0dIaOKkN2Fo2K
	RCXpXv/MCRyTp9UCLGPHDq7XbV4HxC5ZdbcwGtWPD4FYKOJj4Dphg2T/YenYW++8
	RpxOnF5uqwNH9ztv8R60xC79Iz1DxOeFj+/1JDyxfybaeMRmC414kE9WLFg+e4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=StkmXN
	MRKUcSk39bqVXgVUaMa5Ko2HzRFpi592wuDcsmYwuBFz/Ky02lloxXLLb5CFTZi8
	lHdfPHGeidepmSz7yae7XdG4zLxTmZzQ4bhLQ+OE8jpWofQZIJix3mRySw4G/wK8
	DYN53Y4+bG5wXbq8nafakbf9OM5OJZglGh8Pk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9972644C36;
	Sun, 28 Feb 2016 13:21:45 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 19E8044C35;
	Sun, 28 Feb 2016 13:21:45 -0500 (EST)
In-Reply-To: <56D1DF53.1010006@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 27 Feb 2016 18:39:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F718F9A-DE48-11E5-8305-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287780>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> How about something like this as a workaround ?
> (I can send a proper patch, if this is the way forward)
> ...
>     Make Git compile under Mac OS X 10.6 by using clang instead of gc=
c

Given that it is understandable that Apple is no longer interesting
in fixing compiler bugs for 10.6, I think that is the best we could
do to help its users.

> ...
> +       ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`=
" -ge 10 &&
> echo 1),1)

This singles out 10.6-and-nothing-else, 10.6-or-older or
10.6-or-newer?

That "-ge", which smells like a copy-and-pasta from the next one
that says "we have getdelim on 10.7-and-newer" bothers me.

> +    CC =3D clang
> +       endif
>         ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`=
" -ge 11 &&
> echo 1),1)
>                 HAVE_GETDELIM =3D YesPlease
>         endif
