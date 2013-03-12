From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] submodule: add 'deinit' command
Date: Tue, 12 Mar 2013 09:22:07 -0700
Message-ID: <7v1ubk8u6o.fsf@alter.siamese.dyndns.org>
References: <5112C6F6.4030607@web.de>
 <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 17:22:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFRyM-0001MS-KT
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 17:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897Ab3CLQWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 12:22:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34297 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932465Ab3CLQWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 12:22:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16678A4F3;
	Tue, 12 Mar 2013 12:22:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uv1+hA9sVr/zmXnVbnzWxl5vwiM=; b=o1t0SM
	U+eWwZqPaEUM4ScvAmGBjAL6cpljaWXblfLjZnXrzNUU0JXHcKZncDPvYJXLsiLL
	CBIYrupKlCwgEgMG+RfiGDO6uXKMC0hQ/DvQcReMkEPCBUaTIg8kzLsCbv+AzZR6
	8pnoKdQTSug22VMvIv75OptMXV5c7vTn+goGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rk62jvGDPBr2kthjgNrEcAXRXn46oabv
	vSx3AmBQoDpFfiF5CbezN5dwtmWpmqtxRotpRV0Vo+x0roOcHExxT2kPuegfmdeh
	yZ/s6ZXAiE0umdLxJmDI8FWJ/GCkBFdVzBR3K2ZsAui+cIw1PXtjpx4toq1eQhHN
	61K0ugKdIBE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09FF8A4F2;
	Tue, 12 Mar 2013 12:22:09 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D540A4F1; Tue, 12 Mar 2013
 12:22:08 -0400 (EDT)
In-Reply-To: <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com> (Phil
 Hord's message of "Tue, 12 Mar 2013 11:39:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC7E5AC6-8B30-11E2-8EA8-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217973>

Phil Hord <phil.hord@gmail.com> writes:

> I think this would be clearer if 'git deinit' said
>
>     rm 'submodule/*'
>
> or maybe
>
>     Removed workdir for 'submodule'
>
> Is it just me?

The latter may probably be better.  

After cloning the superproject, you show interest in individual
submodules by saying "git submodule init <that submodule>" and until
then your .git/config in the superproject does not indicate that you
are interested in that submodule, and you won't have a submodule
checkout.

"deinit" is a way to revert back to that original state; recording
that you are no longer interested in the submodule is the primary
effect, and removal of its checkout is a mere side effect of it.
