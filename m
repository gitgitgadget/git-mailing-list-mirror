From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git submodule update is not fail safe
Date: Fri, 04 Jan 2013 13:51:05 -0800
Message-ID: <7vzk0osjli.fsf@alter.siamese.dyndns.org>
References: <50E74145.4020701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Jens Lehmann <Jens.Lehmann@web.de>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrFAs-0008JK-Ry
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 22:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355Ab3ADVvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 16:51:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320Ab3ADVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 16:51:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A01BBF01;
	Fri,  4 Jan 2013 16:51:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/B4u3YLe2xl8qsCqagkStDb+0LY=; b=uko9N0
	ccap14C0+GV7M3vGG4Ea1JpFNzQQ0yjcMWoHg/0WSxseMf8UxId0WGW8JZSgoH9+
	4nWlUhSaXh9NYwDIASJFojhLotAPEcIPXm8fqaCSVRRP56D6ea2UOsb1emqRHGza
	0VlX+vS3F/YTAZRGnMyU0Y34EeJBRuUsf1OqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vnAjlLO6WopokR0W38/jw5gM81mHMiUM
	yyO2RQme9+WCdR7L3shP+iA5n4jABtaYNfoIGWqcDHrDflritpJ9CuJ6cyM+jamJ
	ozxpfVfLtpHMipljy3rD9CpuU6XzA/p9NVq+yFfO8lNBmzMFtsnXNzWl2TcNlScV
	4a356/pjvIU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7CEBEFD;
	Fri,  4 Jan 2013 16:51:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE77EBEF4; Fri,  4 Jan 2013
 16:51:06 -0500 (EST)
In-Reply-To: <50E74145.4020701@gmail.com> (Manlio Perillo's message of "Fri,
 04 Jan 2013 21:53:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7BB48C2-56B8-11E2-8284-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212647>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> $ git submodule update --init
> ...
> Submodule 'roms/vgabios' (git://git.qemu.org/vgabios.git/) registered
> for path 'roms/vgabios'
> fatal: unable to connect to anongit.freedesktop.org:
> anongit.freedesktop.org[0: 131.252.210.161]: errno=Connection timed out
>
> Unable to fetch in submodule path 'pixman'
>
> $ git submodule update --init
> fatal: Needed a single revision
> Unable to find current revision in submodule path 'pixman'
>
> The problem is easy to solve: manually remove the pixman directory;
> however IMHO git submodule update should not fail this way since it may
> confuse the user.

Sounds like a reasonable observation.  Jens, Heiko, comments?
