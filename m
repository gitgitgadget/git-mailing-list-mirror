From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures in t4034
Date: Sun, 19 Aug 2012 10:01:49 -0700
Message-ID: <7va9xqq0hu.fsf@alter.siamese.dyndns.org>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
 <7v7gsvquk8.fsf@alter.siamese.dyndns.org>
 <20449AC5-D068-46CF-B8C4-E0639FB92EF6@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <mister.reus@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 19:02:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T38sx-0006zv-PQ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 19:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab2HSRBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 13:01:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab2HSRBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 13:01:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E616D5CE1;
	Sun, 19 Aug 2012 13:01:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K2Se3UWuOo74GR3jA20we5oaiiU=; b=OQO5nl
	N6Zx/l1/tYIcvwmML5gCWNynDoXwZro+YEvzMKe9/BnrLMt7Dfrh0sUrMFeHBdyX
	x/IWcIr7XKto16t6VlUOT9WXbnNsYBJIzaZ5Kvbs+hUGK5d1iKX5ae80MmnUinCe
	WglP1v8KuZ8WZci6SpHcp02x1EAfkH8EFodVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MAcz6ohv3YKcqCeuRk4Ku89UaI4JCOm/
	MbB5TjSSNDKPGsg11NYc4Bv0L9+joiP5FaF2UYgfRCsFk0cGVuv1vviZ4JKuAeUD
	37ojPIlzzv+Wk/coUmwB6eVU5ibVYzYUyO5Td3JadO3qm6J1vIRmVYlGDxJ/H+0G
	gIuFE2Gj6z4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4C5F5CE0;
	Sun, 19 Aug 2012 13:01:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A41F5CDF; Sun, 19 Aug 2012
 13:01:51 -0400 (EDT)
In-Reply-To: <20449AC5-D068-46CF-B8C4-E0639FB92EF6@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Sun, 19 Aug 2012 10:21:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 920E29C6-EA1F-11E1-ACE2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203724>

Brian Gernhardt <mister.reus@gmail.com> writes:

> I wonder if there is something non-portable about the bibtex
> filter?  (The HTML filter as well, since that errors on my machine
> too.)

Yeah, that I didn't think of, but is a possibility (part of (1)
above).

The HTML one is "[^<>= \t]+" and
the Bibtex one is "[={}\"]|[^={}\" \t]+"

and both will be used with "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+"
appended and given to regcomp with REG_EXTENDED|REG_NEWLINE.  

Nothing jumps at me that is common to these two but not shared by
other patterns.
