From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: request-pull with signed tag lacks tags/ in master
Date: Thu, 15 May 2014 11:50:09 -0700
Message-ID: <xmqqzjiiev1a.fsf@gitster.dls.corp.google.com>
References: <20140515163901.GA1403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 15 20:50:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl0jW-00065l-9b
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 20:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbaEOSuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 14:50:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59986 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbaEOSuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 14:50:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5161117549;
	Thu, 15 May 2014 14:50:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lmDgbUGVJR+tw995DEt9cImbYBg=; b=Kq2Ig4
	9KNMkwD7fe4zuEQfhjI9yRXDXqaFeXsQbGCSVxI+5YKCDRYDGKcrCpeKUHgAOpKG
	o/DFvasdJx/tB3exAeMm7sezQ7i6GYjx01RWqFZAj6WlJSc0CY/IqpyaqU3ReTTa
	Q8pLlzIYMZYu6qLBNj8HTfwtqBerCuyHBlO34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L9GgI6QYao1GiTCHN1WuZzGSA9RaZiPx
	yltRnsyBbHgrjfZ8xtMDOGT0JHlOpM9wOLHxBAFGpQmcG8xKSCGZhU49iwOQS1R3
	6VaNqs5tGKeoaI1GELJ7TmTBgaNaq+J+2c/SyaqhZ9DyQ1l6lj/2YEWwGcsWyy9y
	W16iJKEY6Fk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47D8C17548;
	Thu, 15 May 2014 14:50:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5816517540;
	Thu, 15 May 2014 14:50:11 -0400 (EDT)
In-Reply-To: <20140515163901.GA1403@redhat.com> (Michael S. Tsirkin's message
	of "Thu, 15 May 2014 19:39:01 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE4A2270-DC61-11E3-9E53-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249180>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> looks like pull requests with signed git got broken in git master:
>
> [mst@robin qemu]$ /usr/bin/git --version
> git version 1.8.3.1
> [mst@robin qemu]$ git --version
> git version 2.0.0.rc1.18.gac53fc6.dirty
> [mst@robin qemu]$ 
> [mst@robin qemu]$ /usr/bin/git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
>
> [mst@robin qemu]$ git request-pull origin/master git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream |grep git.kernel.org
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git for_upstream
>
> this for_upstream syntax is a problem because it does not work
> for older git clients who might get this request.
>
> Didn't bisect yet - anyone knows what broke this?

Linus ;-)  The series that ends with ec44507, I think.
