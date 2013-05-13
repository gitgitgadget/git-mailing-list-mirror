From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Mon, 13 May 2013 00:48:42 -0400
Message-ID: <CAPig+cR-FkOtGvn+A+JdQ5ia+eUXw6iVzEmOpxCrUgkPttZkVQ@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 13 06:49:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubkh4-0000Lg-1I
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 06:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076Ab3EMEsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 00:48:45 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:54051 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3EMEso (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 00:48:44 -0400
Received: by mail-lb0-f171.google.com with SMTP id u10so5959606lbi.16
        for <git@vger.kernel.org>; Sun, 12 May 2013 21:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=lJwNya5gwDtmMwIkK/VcCBgHK7/hcOiPedn2mwKZBKI=;
        b=iWdFtwORUTN84nZbItQ/7TpFF4XDIdfICS4I8zeduNbarYPUVKtngsV76sgjT5hNzK
         eMV5bvt3v6semy+qc3Y44ogxliUcn/JcPalPjAmPwrCpKE5RI4rDJqePoNqtLX/aABmh
         bSTCOXKA9K3r2DP1EwUV3KdLzSnUvo/7C6nsWiz+Cn/qvW7Wsr/DX7SIay4ErJH4IaQA
         iqM8XiwnuLu+HAcnnwdOWEyRNK7ilRmkzJqNa4mbmJ/h9lYcGmiYbbzPVbaAFvQJ5CiM
         e0Nmyou95JaWrsgzpCOK2AtIh4+qzy9iYbCM860L09zGGeqFO/FDhCwFxcasilfu0eF0
         3BzQ==
X-Received: by 10.112.72.163 with SMTP id e3mr12052383lbv.28.1368420522759;
 Sun, 12 May 2013 21:48:42 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sun, 12 May 2013 21:48:42 -0700 (PDT)
In-Reply-To: <1368289280-30337-5-git-send-email-johan@herland.net>
X-Google-Sender-Auth: JOyitf-S0pnnzwOmFeDs6i47m8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224081>

On Sat, May 11, 2013 at 12:21 PM, Johan Herland <johan@herland.net> wrote:
> Although we definitely support and encourage use of multi-level branch
> names, we have never conciously tried to give support for multi-level

s/conciously/consciously/

> remote names. Currently, they are allowed, but there is no evidence that
> they are commonly used.
>
> Now, they do provide a source of problems when trying to expand the
> "$nick/$name" shorthand notation (where $nick matches a remote name)
> into a full refname. Consider the shorthand "foo/bar/baz": Does this
> parse as $nick = foo, $name = bar/baz, or $nick = foo/bar, $name = baz?
>
> Since we need to be unambiguous about these things, we hereby declare
> that a remote name shall never contain a '/' character, and that the
> only correct way to parse "foo/bar/baz" is $nick = foo, $name = bar/baz.
>
> This patch teaches 'git remote' to reject remote names with slashes,
> and adds tests verifying this.
>
> Signed-off-by: Johan Herland <johan@herland.net>
