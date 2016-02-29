From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_TRACE_PERFORMANCE and pager
Date: Mon, 29 Feb 2016 08:47:08 -0800
Message-ID: <CAPc5daWp+ACy_5=prqa2f_ry4Z92B7mOEw_mC_-arCSNeX=3Kw@mail.gmail.com>
References: <CAP8UFD2zFBV7gRVvLB-gGEB=cfZJmYKrfiD2vdTdxgEgYU6jHQ@mail.gmail.com>
 <20160229113924.GC29769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 17:47:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaQyr-0001LQ-7G
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 17:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbcB2Qr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 11:47:29 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33535 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcB2Qr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 11:47:28 -0500
Received: by mail-yw0-f175.google.com with SMTP id u200so125841263ywf.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 08:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BqW0ZcNMNk1Q4dw5D/BjtbGbiYv2i5Tz3qHxOp739Y4=;
        b=hv1qg24fqnShCSeqPl4aTtBb/d1GFZIu9RuqT0RBOdT0/djebaYp7SZvq/Z5zXokwF
         Y3HljtdmeDQhGyEZmms/q71YHM4PKujGiDEJBdFyIaNanLl9v9bXRUc58Hsq6YyxazI5
         hCs+QrIWluWwAAuCdvZi3w0lRE8CpRjh3+OkvWQRkc81NVThuqs6R8SQldNSA1vK33Ef
         uHnuNtPwhXJm4i6R9rmsNBhC/TRfFavwNc620B5ZC7D9nI3Jrepi9l7KVvZnQHUqxe/T
         jw43ysXDrUxBwsJSIFANIY/n27V7Q4uUKcvn5Voj9p68MFulVa3ppmSD8ArOwmC+vmFu
         Ulew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BqW0ZcNMNk1Q4dw5D/BjtbGbiYv2i5Tz3qHxOp739Y4=;
        b=YgH6lvsdac41dlc/IJwQIuNe7sb+Blzn37BtgljzddF2xmwxDcKiMYvc6FGaAkGjRd
         Gfl5AKf0kWSWssiKGYFyse2tU3d+angxkEWEC1YCv/Tc565XuroGXorZNVM1crT+2eNy
         6SN+JmgmKJP6FP341OM7oEz9AiD42l6EQOl5aJ8urNJWjCaa5gCZYeqBETmhbdkcePbv
         IF0Y4TJ+Ct/a+ZauRRh+53Rhz1sROz+sm7CWFW8VLSSTCPGc6NCoQ9dHGlzFBZZU3zGk
         /DHCZx7iqMNhFfd+cFvzijYMlGydj7+YfUE4NtyUV25c48A3Mb47Pb0D23NfKe/6y2hH
         DfMw==
X-Gm-Message-State: AD7BkJJTaXKxbxU/9SBSqJoOO8zaZo1YNwBvHe+fyVGUvKuVt5W0gsIfj9RrRM7GKPT1ey9wJ4jHzvHpU6YyNw==
X-Received: by 10.13.229.1 with SMTP id o1mr9061803ywe.173.1456764447900; Mon,
 29 Feb 2016 08:47:27 -0800 (PST)
Received: by 10.129.116.131 with HTTP; Mon, 29 Feb 2016 08:47:08 -0800 (PST)
In-Reply-To: <20160229113924.GC29769@sigill.intra.peff.net>
X-Google-Sender-Auth: oDHO_LeZAcN-GCuGR4JokHSqRuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287848>

On Mon, Feb 29, 2016 at 3:39 AM, Jeff King <peff@peff.net> wrote:
> One workaround is something like:
>
>   GIT_TRACE_PERFORMANCE=3 3>&2 git ...
>
> though I guess I'd question whether trace-performance is interesting at
> all for a paged command, since it is also counting the length of time
> you spend looking at the pager waiting to hit "q".

Yup, exactly. I see Christian tried to add something to the documentation,
but I think it is sufficient to suggest running commands with --no-pager.
