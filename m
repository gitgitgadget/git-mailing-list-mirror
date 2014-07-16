From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] MinGW: fix compile error due to missing ELOOP
Date: Wed, 16 Jul 2014 10:43:11 -0700
Message-ID: <xmqqmwc9ryhc.fsf@gitster.dls.corp.google.com>
References: <20140712075035.GA12400@ucw.cz>
	<1405431797-20899-1-git-send-email-kasal@ucw.cz>
	<xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>
	<53C5B0A1.4060502@gmail.com> <53C5B0E7.4050706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stepan Kasal <kasal@ucw.cz>, Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:43:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7TEj-0007Jr-8w
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 19:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934735AbaGPRnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 13:43:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58673 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933174AbaGPRnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 13:43:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C70927A62;
	Wed, 16 Jul 2014 13:43:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7t6tLbwWtr1GnLdxefJT6xjiBlY=; b=hgmUUj
	tyAN/h8VNtw6/o68PWyi7DH44z2QFZopBFkpsHDf3MI+463TaMZA2jtY1PJ4IxQO
	JEFAxUAIP+v4Mrqb90mSvzIz7jxWOwY0BU7Kr2YR0H3cq8HJKFi6dMJBWU4mFMjt
	X7I/RkzPe2KZMQ7qxf/+sZKihByRW1nGDj3Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yyj8cJ5pzFKVpQBIdc8zDgMLh/5GHYXr
	feztOxFHrSP2SE95JPvPYImRvqD8lt4/dvvx4FBhfdAeeWbG1eyekOzmHJF7Q0D7
	I7qFFc+COaQmdC9eVZSH+Ie98/kNw+fQjH+vr9yA9u9DS+BWYu8wsCGXvPKMXarH
	ZSYcMho/F/Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12A4627A61;
	Wed, 16 Jul 2014 13:43:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AFFA527A56;
	Wed, 16 Jul 2014 13:43:13 -0400 (EDT)
In-Reply-To: <53C5B0E7.4050706@gmail.com> (Karsten Blees's message of "Wed, 16
	Jul 2014 00:53:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A93E405C-0D10-11E4-AB4C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253680>

Karsten Blees <karsten.blees@gmail.com> writes:

> MinGW and MSVC before 2010 don't define ELOOP, use EMLINK (aka "Too many
> links") instead.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---

Thanks; will apply directly to 'master'.

>  compat/mingw.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 405c08f..510530c 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -35,6 +35,9 @@ typedef int socklen_t;
>  #ifndef EWOULDBLOCK
>  #define EWOULDBLOCK EAGAIN
>  #endif
> +#ifndef ELOOP
> +#define ELOOP EMLINK
> +#endif
>  #define SHUT_WR SD_SEND
>  
>  #define SIGHUP 1
> -- 
> 2.0.1.779.g26aeac4.dirty
>
> -- 
