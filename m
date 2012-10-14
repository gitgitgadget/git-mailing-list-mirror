From: Junio C Hamano <gitster@pobox.com>
Subject: Re: looking for suggestions for managing a tree of server configs
Date: Sat, 13 Oct 2012 21:41:45 -0700
Message-ID: <7vpq4l1x86.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1210131413240.6253@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Oct 14 06:42:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNG1Z-0000pn-E0
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 06:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab2JNElt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 00:41:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813Ab2JNEls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 00:41:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BDD76023;
	Sun, 14 Oct 2012 00:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J9DgGDxd+mzZyVJ/Xp68pu38u/Q=; b=cTDwoY
	vgW3NNS4yBlbdCidkR5y45zkhcN/SS3TuAJfp2TefDUpVfbw5gbXsczOQ0zlQNSA
	GXxi2c6pvLdewNXCogZrpzbmaYsx1gatvR6axQ1Oh0S3IyqLuDwxfcL2v81E8Kgd
	86XG97ITNDGETXcHiIIgyHaaAyllcG0XZdj74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CHyPA2406EmKLBcQGxGMm1XX22csmtJH
	PQxJBbum61mkdm01ChanqSNw6gqyuF5UB4GxsuLf9qmlT+M2D3QKsCqOnKi86oF6
	vi5seWBW7spHGgbigZSJza/uH869UMBOq3PXn/bbCiIfYr1jQqSpeiKiBT3kAbU+
	acor7CWZkFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2912E6022;
	Sun, 14 Oct 2012 00:41:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F28D6020; Sun, 14 Oct 2012
 00:41:47 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.02.1210131413240.6253@asgard.lang.hm>
 (david@lang.hm's message of "Sat, 13 Oct 2012 14:20:59 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76828A42-15B9-11E2-AAFB-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207608>

david@lang.hm writes:

> I've got a directory tree that holds config data for all my
> servers. This consists of one directory per server (which is updated
> periodically from what is currently configured on that server), plus
> higher level summary reports and similar information.
>
> today I have just a single git tree covering everything, and I make a
> commit each time one of the per-server directories is updated, and
> again when the top-level stuff is created.

It is quite clear to me what you are keeping at the top-level files,
but if a large portion of the configuration for these servers are
shared, it might not be a bad idea to have a canonical "gold-master"
configuration branch, to which the shared updates are applied, with
a branch per server that forks from that canonical branch to keep
the machine specific tweaks as differences from the canonical stuff,
instead of having N subdirectories (one per machine).
