From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Removed OLD_ICONV in favor of checking _LIBICONV_VERSION directly
Date: Fri, 02 Nov 2007 17:07:22 -0700
Message-ID: <7vbqacyyx1.fsf@gitster.siamese.dyndns.org>
References: <985966520711021303g905f638y2056219c22e5edeb@mail.gmail.com>
	<1194048010-65955-1-git-send-email-blaker@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Blake Ramsdell <blaker@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 01:08:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io6YX-00048Q-Lb
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 01:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762826AbXKCAHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 20:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762829AbXKCAHe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 20:07:34 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:38381 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762826AbXKCAHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 20:07:33 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D4C3C2F9;
	Fri,  2 Nov 2007 20:07:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 50EC891934;
	Fri,  2 Nov 2007 20:07:51 -0400 (EDT)
In-Reply-To: <1194048010-65955-1-git-send-email-blaker@gmail.com> (Blake
	Ramsdell's message of "Fri, 2 Nov 2007 17:00:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63196>

Blake Ramsdell <blaker@gmail.com> writes:

> diff --git a/utf8.c b/utf8.c
> index 4efef6f..a7feb4f 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -300,7 +300,7 @@ int is_encoding_utf8(const char *name)
>   * with iconv.  If the conversion fails, returns NULL.
>   */
>  #ifndef NO_ICONV
> -#ifdef OLD_ICONV
> +#if _LIBICONV_VERSION <= 0x0109
>  	typedef const char * iconv_ibp;
>  #else
>  	typedef char * iconv_ibp;

Does everybody's iconv use the same _LIBICONV_VERSION scheme?

Compiling this:

        #include <iconv.h>
        int i = _LIBICONV_VERSION;

on a Linux box with GNU C library gives:

	i.c:3: error: '_LIBICONV_VERSION' undeclared here (not in a function)

here.
