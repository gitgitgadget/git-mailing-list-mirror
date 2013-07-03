From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] teach format-patch to place other authors into
 in-body "From"
Date: Wed, 3 Jul 2013 03:21:28 -0400
Message-ID: <CAPig+cTMUrofUon85rZLw+NALQ5+agTRZW0UWYeBCutd_BPzwQ@mail.gmail.com>
References: <20130703070719.GA17638@sigill.intra.peff.net>
	<20130703070822.GB17730@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 09:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuHNo-0003Sm-8O
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 09:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab3GCHVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 03:21:32 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56992 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767Ab3GCHVb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 03:21:31 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so4056598lbi.39
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=M+0WOUpXBLXA4PpwxAViMeBmifIokETXXRRQkyxIjg8=;
        b=0aTnp5+0DskVDocceBqSePhUJTLyPMYdipZpytzqyBRmXRj/umA7k/rKPmaaI5n9Xi
         0Uc+H5YGAssZ0CpPNOJeIfaBBM9yMctQB90PfwXa1FpxavLjwZP0QfHWp46goSYucWAs
         TkwTyODeIjNBFWuJhh7IF5itA0wZH8AM+4s0J5V+A8rVN3bvqH0vWzEf5r5dw4tN8GO0
         2KyZ4XhBDq+zGgxuloYUJJnNivNYU0B2rAzrskVF21q9eJzqbJJhDOdv8xDMRpiis6rN
         oleLK7BCpMrZUkj8wwhPrpwzgSgbHBfBmI4WHpo75xE3CkkZSW/j6p2YdwpuoQfRlyAz
         JKiw==
X-Received: by 10.152.87.172 with SMTP id az12mr16245592lab.24.1372836088606;
 Wed, 03 Jul 2013 00:21:28 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 3 Jul 2013 00:21:28 -0700 (PDT)
In-Reply-To: <20130703070822.GB17730@sigill.intra.peff.net>
X-Google-Sender-Auth: tEIquRyiDRh6IIyAmCotQ1XCSt0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229459>

On Wed, Jul 3, 2013 at 3:08 AM, Jeff King <peff@peff.net> wrote:
> Format-patch generates emails with the "From" address set to
> the author of each patch. If you are going to send the
> emails, however, you would want to replace the author
> identity with yours (if they are not the same), and bump the
> author identity to an in-body header.
>
> Normally this is handled by git-send-email, which does the
> transformation before sending out the emails. However, some
> workflows may not use send-email (e.g., imap-send, or a
> custom script which feeds the mbox to a non-git MUA). They
> could each implement this feature themselves, but getting it
> right is non-trivial (one most canonicalize the identities

s/most/must/

> by reversing any RFC2047 encoding or RFC822 quoting of the
> headers, which has caused many bugs in send-email over the
> years).
>
> This patch takes a different approach: it teaches
> format-patch a "--from" option which handles the ident
> check and in-body header while it is writing out the email.
> It's much simpler to do at this level (because we haven't
> done any quoting yet), and any workflow based on
> format-patch can easily turn it on.
>
> Signed-off-by: Jeff King <peff@peff.net>
