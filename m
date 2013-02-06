From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 6 Feb 2013 17:34:48 +0700
Message-ID: <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin> <5110DF1D.8010505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:35:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U32Lx-0006cr-7D
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 11:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab3BFKfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 05:35:22 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46962 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3BFKfU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 05:35:20 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so1282219obb.29
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 02:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Bt/4tfVRHwgWKDzVqkCEj6RT2TvNahn3pR/y5PB4+5g=;
        b=UuRkxZ6TU9w8gX9nsCdWPDC49jr4GD3/cz8KWcE+shUreI8r/ElmwELXMFmYwTD/im
         Jq8u6jjenUH5PIKMhc6rtCErHPuhtBuqNKT+ZWPRV4EztskZIrt9sNPofjcuXgdLL7it
         w9HT7w9+d8u3CB/tBYI+oep+VyW/UfM0L36/0O7gVOtbElVGtlNifL1eYDlUBii/xfIG
         1FGoHxBi7HDzehGraGD/guLAYcMk5ih0UvSSBDvLecgixhJJG04ZnhdOmu9fCSYl+4UO
         KlzB1Yl9bT4obnhTwKJYk+bDZNSwxB2B6fNTq6IaAnlp9mAYG3U4/UmEvcSFlFoDHJJX
         Jhgw==
X-Received: by 10.60.28.133 with SMTP id b5mr21401542oeh.98.1360146919836;
 Wed, 06 Feb 2013 02:35:19 -0800 (PST)
Received: by 10.182.129.46 with HTTP; Wed, 6 Feb 2013 02:34:48 -0800 (PST)
In-Reply-To: <5110DF1D.8010505@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215570>

On Tue, Feb 5, 2013 at 5:29 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Hiderefs creates a "dark" corner of a remote git repo that can hold
> arbitrary content that is impossible for anybody to discover but
> nevertheless possible for anybody to download (if they know the name of
> a hidden reference).  In earlier versions of the patch series I believe
> that it was possible to push to a hidden reference hierarchy, which made
> it possible to upload dark content.  The new version appears (from the
> code) to prohibit adding references in a hidden hierarchy, which would
> close the main loophole that I was worried about.  But the documentation
> and the unit tests only explicitly say that updates and deletes are
> prohibited; nothing is said about adding references (unless "update" is
> understood to include "add").  I think the true behavior should be
> clarified and tested.
>
> I was worried that somehow this "dark" content could be used for
> malicious purposes; for example, pushing compromised code then
> convincing somebody to download it by SHA1 with the implicit argument
> "it's safe since it comes directly from the project's official
> repository".  If it is indeed impossible to populate the dark namespace
> remotely then I can't think of a way to exploit it.

Or you can think hiderefs is the first step to addressing the initial
ref advertisment problem. The series says hidden refs are to be
fetched out of band, but that's not the only way. A new extension can
be added to the protocol later to let the client explore this dark
space. It's only truly dark for old clients. We could even shed some
light to old clients by sending a dummy ref with some loud name like
PLEASE_UPDATE_TO_LATEST_GIT_TO_FETCH_REMAINING_REFS (new clients
silently drop this ref)
--
Duy
