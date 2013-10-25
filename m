From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/19] pack-bitmap: add support for bitmap indexes
Date: Fri, 25 Oct 2013 16:06:19 -0700
Message-ID: <xmqqk3h1hrx0.fsf@gitster.dls.corp.google.com>
References: <20131025055521.GD11810@sigill.intra.peff.net>
	<20131025060345.GH23098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 26 01:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZqSZ-0004Wk-1z
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 01:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662Ab3JYXGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 19:06:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab3JYXGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 19:06:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 464884D40C;
	Fri, 25 Oct 2013 23:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zy6BmT0hDq6lOfuY/V3lJND/H5s=; b=xsvYTJ
	q4MtDI0wSZ7pid7uxJFq4WNhXoGg6APq0b7z7h6fMv3qseOgnLqbKuiJj7tDNoCe
	0yLkFwr6lIEtPqEgBXOZVThJFOR5bZf7XNRHWX5BcFkgZzcX+aoIotTA4hoycEET
	HLEb8yJnfFZ4MjG6DfWSHf9zVgxaDKDbfNvfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iv2qDctWU6QzhLFsj/jAjTZEg5AJwDiX
	Jb1DVSrId0HpmXQ/EkIIozIk+beSHRT9H6yqQv2Tgvh8edfU6j0fSBXj8cguDN+q
	mOWLsHdnH94TPxW5996pjZcg2NvKeCOswaPTxWK9AIQWr403WOnKUvu2YVNR7c9m
	XzEPeJhgJOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37FF44D40B;
	Fri, 25 Oct 2013 23:06:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B21D4D408;
	Fri, 25 Oct 2013 23:06:21 +0000 (UTC)
In-Reply-To: <20131025060345.GH23098@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 25 Oct 2013 02:03:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 10341E24-3DCA-11E3-BEF9-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236724>

Jeff King <peff@peff.net> writes:

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> new file mode 100644
> index 0000000..73c52fd
> --- /dev/null
> +++ b/pack-bitmap.c
> @@ -0,0 +1,965 @@
> +#include <stdlib.h>
> +
> +#include "cache.h"

You among all people already know why this is bad, no?

I'll remove the first two lines while queuing.  Thanks.
