From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Thu, 20 Dec 2012 08:28:57 +0700
Message-ID: <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
References: <20121219203449.GA10001@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 02:29:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlUxG-0006f4-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 02:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab2LTB33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 20:29:29 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44403 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab2LTB32 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 20:29:28 -0500
Received: by mail-ob0-f178.google.com with SMTP id eh20so2737224obb.37
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 17:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LjUHR71WihsMla5UW8Wzic44opfW7gXIaVafuPI+YjA=;
        b=CA7Hs5pJuWD58owdCKDt8qxFurBNAXjW7EI14BhgVIsPdPOeh5VNBRDts6AuWHxL2D
         o0FSLiLjlN97ggfh3D0UPDKFgLTsFwThsYq+jmz6GT5yKo8imqFaBo//0QS1BKUyvwbU
         LGjH7+XhARkFkHErk3Bt6DKNHRolkz3muJr+Z1WQe9Db5YYlQCAN//EmOPIHH1hVfqIo
         8a5hmKSqls3imJ87Py45W4E9sjy1DfmjtoQTiaqBi+cD4xpW1zMweZjqKgqEwgEuOr7m
         X+01JkmSI4Cos+/x2bhbhJa2FSBDE12ymydboicL1UwZ/Et3Nm+3ny1oWdoTl3YI3QBk
         Sh2Q==
Received: by 10.182.141.103 with SMTP id rn7mr6659870obb.5.1355966967911; Wed,
 19 Dec 2012 17:29:27 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Wed, 19 Dec 2012 17:28:57 -0800 (PST)
In-Reply-To: <20121219203449.GA10001@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211868>

On Thu, Dec 20, 2012 at 3:34 AM, Jeff King <peff@peff.net> wrote:
> Part of me thinks this is just gross, because ":(noglob)" is the right
> solution. But after spending a few hours trying it this morning, there
> is a ton of refactoring required to make it work correctly everywhere
> (although we could die() if we see it in places that are not using
> init_pathspec, so at least we could say "not supported yet" and not just
> silently ignore it).

Yep, I'm still half way to converting everything to the new pathspec
code. I'm not there yet. And things like this probably better goes
with a config key or command line option, appending :(noglob) to every
pathspec item is not pleasant. :(icase) may go the same way.

> So I think this is a nice, simple approach for sites that want it, and
> noglob magic can come later (and will not be any harder to implement as
> a result of this patch).

Any chance to make use of nd/pathspec-wildcard? It changes the same
code path in match_one. If you base on top of nd/pathspec-wildcard,
all you have to do is assign nowildcard_len to len (i.e. no wildcard
part).
-- 
Duy
