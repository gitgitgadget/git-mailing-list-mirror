From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Sun, 15 Feb 2015 21:57:03 -0800
Message-ID: <CAPc5daXU6x2ok+XqXDkWWi5O2N_dr+deQtOMx+Eh16UUGi5yJQ@mail.gmail.com>
References: <20150216054550.GA24611@peff.net> <20150216054754.GB25088@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:57:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEgS-0002p3-DC
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 06:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbBPF5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 00:57:24 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:52363 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbBPF5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 00:57:23 -0500
Received: by mail-ob0-f176.google.com with SMTP id wo20so38951621obc.7
        for <git@vger.kernel.org>; Sun, 15 Feb 2015 21:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5+voMRWJi0EJIxH/w+wQ3VaILTX87uullXtaPiyvBvc=;
        b=YELOheSDKkkc2+NTQ8Yb1l0lgt8f3DnyFDGodnc+Jlq3b4ZMqu5OV7RikufWMBXVuh
         GwLswaolQ+W/4ZVSw24u0Y+CeM+YzveMPWdqLrmkkz84uuiYD4fNXJ6eI5MF613atotB
         rhdkdowcgc+L6GBq7LLmy/38pe7EAlVPLwuQuTuJTd2cX3wXUO6lwwB4DaOxU+DDpBln
         7Amcj5QqKo9k7f/IE3wN8fLeSx/VS+mDHJT051Z1kruXP132ZQKpZ3LsSjtBpWaumd8S
         Mo7j8+CjGT9SvwXT0CJUvml2BHVxvi0O9hjHgDLBi0d6H38w429Kl4e+aElGenkHVT8M
         c6Hg==
X-Received: by 10.60.39.165 with SMTP id q5mr14129192oek.72.1424066243203;
 Sun, 15 Feb 2015 21:57:23 -0800 (PST)
Received: by 10.202.48.132 with HTTP; Sun, 15 Feb 2015 21:57:03 -0800 (PST)
In-Reply-To: <20150216054754.GB25088@peff.net>
X-Google-Sender-Auth: N_MdL7Hb1ku-3oddD9qAvNIjFfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263874>

On Sun, Feb 15, 2015 at 9:47 PM, Jeff King <peff@peff.net> wrote:
> When the "push_default" flag was originally added, it was
> made globally visible to all code. This might have been
> useful if other commands or library calls ended up depending
> on it, but as it turns out, only builtin/push.c cares.
> ...
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> We know this is safe because no other callers needed tweaked when the
> variable went out of scope. :) It would only be a bad idea if we
> were planning on having other code in the future depend on push_default
> (e.g., the code in remote.c to find the push destination). But it does
> not seem to have needed that in the intervening years, so it's probably
> fine to do this cleanup now.

Yay. Great minds think alike ;-)

"It definitely smells wrong to touch environment.c and cache.h" was my
first reaction to the "follow-tags config" patch, and I really think this shows
the right way forward.

Thanks.
