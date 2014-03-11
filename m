From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/26] t1400: Pass a legitimate <newvalue> to update command
Date: Tue, 11 Mar 2014 13:06:47 -0700
Message-ID: <xmqqa9cwpkiw.fsf@gitster.dls.corp.google.com>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
	<1394455603-2968-4-git-send-email-mhagger@alum.mit.edu>
	<531DF079.9050909@kitware.com> <531E30D7.40208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:06:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSwz-0004Hx-BL
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892AbaCKUGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 16:06:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbaCKUGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:06:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D369F74756;
	Tue, 11 Mar 2014 16:06:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6biiYzAaT+MrJ1x7DjlJNMusJHg=; b=a9Kbnh
	JDHzzDapAaMcIe561D+50W6jCyZO65TrXHfDCnlcfp+TgVIdaaFMbGFIDDGSrY6G
	5zVXprruQ2795jwG7ZaL0grlC+PM6XiLFDh4kpOoTVBuXYpHbK+Dd9TsGPveKQEU
	vu2vqe2U5h4ouHMzqDRyhFfoVYKnopcCFHUZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LZvnbgtzUrnWrvnMLkSnnRTftSZSJ6Za
	j+XI9o/9oU7uj1uLZgvS2Lc2srNS5VfSQrJN5MR9NgazvrtDi0fzvESdBLhzb+mw
	8cN4DRzuswlNSQPJmooo8LhoBglGB/hsr3GsCAJPCaLZfLPqj6/pZ6qZkITpWwbT
	c5D8e0f3N8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C22A574755;
	Tue, 11 Mar 2014 16:06:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B0DD74753;
	Tue, 11 Mar 2014 16:06:51 -0400 (EDT)
In-Reply-To: <531E30D7.40208@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 10 Mar 2014 22:38:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AF1B49D2-A958-11E3-9BE5-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243889>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It seems to me that "-z" input will nearly always be machine-generated,
> so there is not much reason to accept the empty string as shorthand for
> zeros.  So I think that my version of the rules, being simpler to
> explain, is a slight improvement.  But your version is already out in
> the wild, so backwards-compatibility is also a consideration, even
> though it is rather a fine point in a rather unlikely usage (why use
> update rather than delete to delete a reference?).
>
> I don't know.  I'm willing to rewrite the code to go back to your rules,
> or rewrite the documentation to describe my rules.
>
> Neutral bystanders *cough*Junio*cough*, what do you prefer?

I may be misremembering things, but your first sentence quoted above
was exactly my reaction while reviewing the original change, and I
might have even raised that as an issue myself, saying something
like "consistency across values is more important than type-saving
in a machine format".

Since nobody else were raising the issue back then, however, we are
stuck with the interface.  I am not against deprecating and removing
the support for it in the longer term, though.
