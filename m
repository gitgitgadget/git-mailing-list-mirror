From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Sat, 13 Jul 2013 20:37:58 -0400
Message-ID: <CAHREChiOE8oMWQYFY_7yzf1tz-4E2_L5W9--k33vwATFSrR==A@mail.gmail.com>
References: <7v38rjlif4.fsf@alter.siamese.dyndns.org> <20130712190531.GD8482@google.com>
 <7vtxjzk13q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 02:38:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyAKd-0004Ls-E4
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 02:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609Ab3GNAiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 20:38:20 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:40881 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab3GNAiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 20:38:19 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so12638506obc.6
        for <git@vger.kernel.org>; Sat, 13 Jul 2013 17:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J0l5s5HdqxjzXBuauVOS2Zf0IizF2M/JxlTKaotHtZ8=;
        b=Ota+lC5hFZi8DBPlyhDhRGUXNoz+nv6EJ3wHumJQ16bMWNLM44++zIEc6sT9q4Slz7
         ZH+wdA7Uf/72scQaaFPbG+FVaMl0s8wbNVNatqGTnR65dIf1G1Sljs6y8idrF2O4QNcU
         r9JKKaQrGpzJwNyy6mxuoBmQT9nP1dDdW0wtarJeAw4TPwpas/XivdHCNQUQX3m4T8Dz
         3omcB7Lmx2E+l29ryqOqKNDUciXL4ZhKkagVClRfpwkpQLgiQQyvvBKoz9EypKZLv7rf
         0FgrFKnAQPxQFSNXIe06CIbnfEhVf+wuLRiWmSIf+zUIKM6r20A78A4g5VzqbGX2URAq
         dAHA==
X-Received: by 10.182.16.137 with SMTP id g9mr40149988obd.17.1373762298815;
 Sat, 13 Jul 2013 17:38:18 -0700 (PDT)
Received: by 10.182.95.42 with HTTP; Sat, 13 Jul 2013 17:37:58 -0700 (PDT)
In-Reply-To: <7vtxjzk13q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230295>

On Fri, Jul 12, 2013 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
> > FWIW the GIT_SSL_CERT_PASSWORD_PROTECTED envvar has a similar "can
> > only enable" behavior, but since it's documented, that's not as big
> > of a problem.  Do you remember why it was written that way?
>
> Not me ;-).

Because that's how GIT_NO_VERIFY, GIT_CURL_FTP_NO_EPSV, and
GIT_CURL_VERBOSE (and perhaps others) work.  That said, I agree that
parsing the variable's value as a boolean would make much more sense.
Perhaps this is how all of those variables should work?

> > When that setting was first added[1], there was some mention of
> > autodetection if libcurl could learn to do that.  Did it happen?
>
> I do not think so, but let's see if our resident cURL guru has
> something to say about it.

I tried back in 2009 but eventually gave up, so unfortunately no.
Maybe the situation in libcurl has changed since then?  (If you are
interested in pursing this, please let me know and I can give you the
details of what I tried.)
