From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 ] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Tue, 19 Nov 2013 11:31:51 -0800
Message-ID: <xmqqob5g89y0.fsf@gitster.dls.corp.google.com>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>
	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
	<5283C701.8090400@web.de>
	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
	<5287F735.3030306@web.de>
	<20131117090935.GC17016@sigill.intra.peff.net>
	<xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>
	<528BB23D.4020001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 19 20:32:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vir1s-00047b-0P
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 20:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab3KSTb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 14:31:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab3KSTbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 14:31:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCCD52BF7;
	Tue, 19 Nov 2013 14:31:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n3LC1p7lHSSBTqYKWR5J8B9cWdY=; b=EZUp34
	Ike55i4kvfWWVYctvLd2a09YNmJkyJ4r+spV7KfEpVpO5wTpNOlP9kqCdevBVcaj
	WGz2xOPq+LWlESm500zxUkHJnsZSteFbQ8qkhUHvNiR/b50QKQ0Jhz98VyFg5tKt
	a+uchL5P3XEc9d5ZexzNt135dVCeM7SAu8WsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ldt5PJJ65KEo2oYI4uR9pjxG3nr6PQiF
	mSW988lmjDeTGqrz/UxEDyenSDupQEVja0cuQRGU8J3tWQY1WJU1+b56qeFN5weL
	zfIGwy1kBGZj1kuNzjl0qqTkAWvxN9d4t+ScYT14m6J3gkskRPPJxd1/CRLZYDRY
	GBwljBqwIJM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C72752BF6;
	Tue, 19 Nov 2013 14:31:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7628C52BF4;
	Tue, 19 Nov 2013 14:31:54 -0500 (EST)
In-Reply-To: <528BB23D.4020001@web.de> (Jens Lehmann's message of "Tue, 19 Nov
	2013 19:47:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F269A46-5151-11E3-9E2B-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238038>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> diff --git a/wt-status.h b/wt-status.h
> index 6c29e6f..cd2709f 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -91,6 +91,8 @@ struct wt_status_state {
>  	unsigned char cherry_pick_head_sha1[20];
>  };
>
> +const char wt_status_diff_divider[];

This gives me:

./wt-status.h:94:12: error: array 'wt_status_diff_divider' assumed to have one element [-Werror]
cc1: all warnings being treated as errors

which is a bit unfortunate.

Regardless of that, from the API design standpoint, I think it may
be much better not to expose this particular implementation element
(i.e. the array) to the caller, but instead to export a helper
function that takes a pointer to a piece of memory and let callers
ask an "I have this line---is it the status cut mark?" question.
