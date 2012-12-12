From: Patrick Donnelly <batrick@batbytes.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 12 Dec 2012 02:03:56 -0500
Message-ID: <CACh33FrgZhsKp7o9ki6n1AbfRKYYbdLMWuGUGKUqDfH5m0Akng@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
	<CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
	<CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
	<20121212033043.GA24937@thyrsus.com>
	<20121212063208.GA18322@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 08:04:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TigMZ-0000cP-7X
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 08:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab2LLHD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 02:03:58 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:42194 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab2LLHD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 02:03:57 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so325979oag.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 23:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=pZL3nINpynoZQRrMlIQgFFI32ydb3xNa+nXg0wzXEiE=;
        b=hjsZOm30MwZDTOh9my9J7z0vJSF5QXOCdQ9SyV/Lj+8lBfDhPOpsbW3i7IUjdGevV1
         kjCyldc/e9/McuHWFC7yQpU7nympPlWRJGVCqrk5jBHkg+ztttE/57S7Xj3Wa+7usZCB
         Fiq90djL9BcxjMze2DaUmWFJMNidNc+dqVQloVZVvvh6HQejLcR8n3sMRpRuYOuighYo
         E3buFcAdXj38GQgkGl2fVWLm3Te4dMSc3TpPB9wan/f9lLqN9QZOtXcFzYyYN7kbtlUo
         rDweJER4dZGlV30quz5LmLZV4jXbUNg5idTP+tz9x6P9OxfFc3K/YhXFVklGKjkK9nZM
         RTEg==
Received: by 10.60.0.136 with SMTP id 8mr407oee.35.1355295836839; Tue, 11 Dec
 2012 23:03:56 -0800 (PST)
Received: by 10.76.28.101 with HTTP; Tue, 11 Dec 2012 23:03:56 -0800 (PST)
In-Reply-To: <20121212063208.GA18322@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQl3vXuJLAUoJcpCQ9Jwp//3dMmMdFcmkUm0ZOgpPLm/EQHsnNguoDr/Uust3W9Wb5ZJGh1V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211330>

Hi Jeff,

On Wed, Dec 12, 2012 at 1:32 AM, Jeff King <peff@peff.net> wrote:
> It would take a lot of effort to expose git-core's internals in a clean
> way; you'd probably be better off starting from scratch and rewriting
> large parts in a friendly library-like manner. Fortunately, there is
> already a project underway to do so: libgit2.  It does not yet have
> feature parity with git, but it can do quite a bit.  And there are
> already ruby and python bindings.

Of course, this comes back to the issue of whether it's a good idea to
use perl/ruby/python as a front-end to regular git commands
(pull/push/etc.). While, yes, bindings can be made for these
languages, you are now making git depend on the presence of one of
these languages in order for git to function. With Lua, the (static)
dependence is very small yet brings much to git in terms of
extensibility and maintainability.

As for Lua's suitability for your (2) point, I admit I'm not familiar
with how much "interacting with the outside world" the git commands
do; however, I would suspect that it is not significant enough to rule
Lua out?

--
- Patrick Donnelly
