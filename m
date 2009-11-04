From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 11:56:00 +0100
Message-ID: <16cee31f0911040256s1c69e86j46ac573b4ef33017@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <40aa078e0911040250k55fa1920g6eee5657c6e35345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 04 11:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dX8-0006V9-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 11:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376AbZKDKz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 05:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbZKDKz5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 05:55:57 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64665 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349AbZKDKz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 05:55:56 -0500
Received: by bwz27 with SMTP id 27so8696166bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c0KiqFQ9Pk5XLB2kyT/Wf1KC9jQz7EqsyKYUYcS7q+M=;
        b=mYxbPFqD5Xsk14gAfHHEJ4sHqBt8XpustJwOhgbj/fIbmV4GV8lZOkZTH6vbswxnry
         ebCBhToB71N8YdNhanO7b5QWYZ9vQIajGz5rATlD/qmght9uEzq4gerlNKFRkpzvzZV7
         +QWjShE9ep7eenxvIJn9n3eG9DAj0LIDxT3j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rUPxBqR+dtUe+fJRGhycXWvzofVPooUdAtdN+RA+RetN+N2b4qYC+MU9FSPJH1zYOe
         PqeRTS0lq2Ne1DhSlzD46jK/87g7guFuzF6uVlmXNKyUYM9M2WVOZRS+EWzPW0c5MXDH
         oNq+asr8WAXrqd+Zi4QnduNnmBLcRtZLwdiGI=
Received: by 10.239.181.163 with SMTP id m35mr137377hbg.175.1257332160365; 
	Wed, 04 Nov 2009 02:56:00 -0800 (PST)
In-Reply-To: <40aa078e0911040250k55fa1920g6eee5657c6e35345@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132074>

2009/11/4 Erik Faye-Lund <kusmabite@googlemail.com>:
>
> Seeing how THREAD_RETURN is only called with NULL-parameter, perhaps
> it would be better to do this?
>
> +/*
> + * Properly defines thread routine for Windows and POSIX
> + */
> +#ifndef NO_PTHREADS
> +# ifndef _WIN32
> +# =A0define THREAD_FUNC(f, a) void *f(void *a)
> +# =A0define THREAD_RETURN() return NULL;
> +# else
> +# =A0define THREAD_FUNC(f, a) DWORD __stdcall f(LPVOID a)
> +# =A0define THREAD_RETURN() return 0;
> +# endif
> +#endif

Good point. Should I resubmit the patch again?

Andrew
