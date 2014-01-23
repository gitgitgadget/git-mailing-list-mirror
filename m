From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] solaris test fixups
Date: Thu, 23 Jan 2014 12:52:30 -0800
Message-ID: <xmqqeh3yto8h.fsf@gitster.dls.corp.google.com>
References: <20140123195404.GA31314@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:52:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6RGW-0005Ar-0V
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbaAWUwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:52:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbaAWUwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:52:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B259D643D7;
	Thu, 23 Jan 2014 15:52:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OLJhtYgIPdET9KNj0c8HvIIspIw=; b=KD9NRE
	Xs9Q8msYlYmPdsbLgPcptnXQ0m/z8gJ+1P6Dulscm6OyNibHjkRF/VZ/SjO3yJbS
	gN+E13kn/LGIexdTsZfyPQ23eotSXD+BjAbZyk7SaEh02SIqLOX3pK7mnM4MHIou
	ACxsiBkAl5KoznNHvRt+gkCpedYjUsjnqZfmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SCIeaZhHvFNy/V9/jDDsy2Q360C7SnMz
	3abiIeWNjbOf8pjnHyf0GRq/08gFhQbce/4o0or9tw/68SrGAlt0dMpSsDufGjtj
	Iq1E4bNjrJ/ohLIR+XSEwBjAQY3upsojsSGI5mAcaeLsPUDKGMNn870HO6I+RVhk
	7j6QcHtW2CY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0587643D6;
	Thu, 23 Jan 2014 15:52:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 641DB643D5;
	Thu, 23 Jan 2014 15:52:35 -0500 (EST)
In-Reply-To: <20140123195404.GA31314@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jan 2014 14:54:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A038C24-8470-11E3-8F30-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240950>

Jeff King <peff@peff.net> writes:

> and assume that it will fail. It doesn't. Solaris happily renames
> some-file to a regular file named "no-such-dir". So we fail later during
> the index-update, complaining about adding the entry "no-such-dir/", but
> still exit(0) at the end. I'm mostly willing to just call Solaris crazy
> for allowing the rename (Linux returns ENOTDIR), but I do wonder if
> the index codepath could be improved (and especially to return an
> error).

I think j6t has a patch for that, a8933469 (mv: let 'git mv file
no-such-dir/' error out on Windows, too, 2014-01-08).
