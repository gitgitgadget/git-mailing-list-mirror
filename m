From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool --dir-diff: symlink all files matching the
 working tree
Date: Thu, 14 Mar 2013 08:18:14 -0700
Message-ID: <7vboamypqh.fsf@alter.siamese.dyndns.org>
References: <7vy5dr14mc.fsf@alter.siamese.dyndns.org>
 <cover.1363206651.git.john@keeping.me.uk>
 <796eafb6816b302c87873c8f4a1bd2225ce40c55.1363206651.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 16:18:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG9vZ-00021D-TC
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 16:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075Ab3CNPST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 11:18:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758072Ab3CNPSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 11:18:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E18FA15B;
	Thu, 14 Mar 2013 11:18:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ws/lqmAELeCNfonIS94SM6t3Nw0=; b=XXhgpl
	FIEoJHOMcaOQTjeValoFHA37P85W+FWJBrLbbGIhWsc2ysvzXqNuOCSr82y+NY3B
	Ps5ssXLaJsQbvscaSFXZ9PydP5WN+j3AvEgYhgo9JePWz20iR5sP4tBoI2gD+PP4
	M8xLXb7rG2Wa/F63ve8tuj1WOGvMeIu9H76Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OTSLrD/jbVvRIpNHFvOQUunUYdPRAr9z
	wYutitmSP2rFm0AYDXpx+ELBdDT4CkXBtdVTEzdgIjBgTY0Op6YsUpUsKYGERJPc
	j3USF41r98a7aBiWS1c0xtRF8KNE2c85qgaO2jOoxWhiWdEtYqGNc0KWiMZhqdLt
	au9+MAdPqSs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 221DAA15A;
	Thu, 14 Mar 2013 11:18:16 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2A20A158; Thu, 14 Mar 2013
 11:18:15 -0400 (EDT)
In-Reply-To: <796eafb6816b302c87873c8f4a1bd2225ce40c55.1363206651.git.john@keeping.me.uk>
 (John Keeping's message of "Wed, 13 Mar 2013 20:33:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64C18628-8CBA-11E2-937B-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218144>

John Keeping <john@keeping.me.uk> writes:

> +write_script .git/CHECK_SYMLINKS <<\EOF &&
> +#!/bin/sh
> +test -L "$2/file" &&
> +test -L "$2/file2" &&
> +test -L "$2/sub/sub"
> +echo $?
> +EOF

Please drop "#!/bin/sh" from the above; it is misleading and
pointless.

After all, you are using "write_script" to avoid having to know
where the user's shell is.
