From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] make update-server-info more robust
Date: Mon, 15 Sep 2014 11:39:12 -0700
Message-ID: <xmqqlhpk7mpb.fsf@gitster.dls.corp.google.com>
References: <20140913201538.GA24854@peff.net>
	<20140913201920.GB27082@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:39:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbBQ-0005hJ-FD
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbaIOSjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 14:39:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64582 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754361AbaIOSjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 14:39:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 60C4439748;
	Mon, 15 Sep 2014 14:39:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VJWCwGbjl1TdD5TjivkQRYcYHm0=; b=gfbskQ
	c1/gpuRcy9eZzGws+oi5R4ydg9SXs1eCNAewQ7M4G52dPiEkgqXqu5DJ17vSW1G8
	yrIHhK0gb0TNKhaY5VgK1E0R+EZsV3dL9Q/CdlcpajGsVxusyPtRG0Ks3uMU6LMm
	s5IQ7FfvzxcYxRXfU8WRR2X9pffGrYIP/qTXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CqUum6dAy+1MAhNuYuNW6VcZz7Wg98Mh
	U29QSwcWZNhQ86fwbg7xBUdCt6sFqFhXxIOLLxAMD3qNPwGnPfv8CdSlAXUF4nDy
	gURBI5E2UxfZUZmkhaZHmEpxY59WT7BVNc8hCc1Vm+7C/Gnvn72bZYjp0rnBPLpv
	MtX+XRePE2o=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 536C939747;
	Mon, 15 Sep 2014 14:39:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94CE139746;
	Mon, 15 Sep 2014 14:39:14 -0400 (EDT)
In-Reply-To: <20140913201920.GB27082@peff.net> (Jeff King's message of "Sat,
	13 Sep 2014 16:19:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 97A5665A-3D07-11E4-B93C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257065>

Jeff King <peff@peff.net> writes:

> Since "git update-server-info" may be called automatically
> as part of a push or a "gc --auto", we should be robust
> against two processes trying to update it simultaneously.
> However, we currently use a fixed tempfile, which means that
> two simultaneous writers may step on each other's toes and
> end up renaming junk into place.

Thanks.  I'll queue these clean-ups but we may want to start
thinking about deprecating and removing the dumb http support.
