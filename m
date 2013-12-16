From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Mon, 16 Dec 2013 11:19:33 -0800
Message-ID: <20131216191933.GE2311@google.com>
References: <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
 <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
 <20131128092935.GC11444@sigill.intra.peff.net>
 <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
 <20131204200850.GB16603@sigill.intra.peff.net>
 <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
 <20131205160418.GA27869@sigill.intra.peff.net>
 <20131205202807.GA19042@sigill.intra.peff.net>
 <52AEAEB2.6060203@alum.mit.edu>
 <20131216190445.GB29324@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 16 20:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsdhp-0008Gj-80
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 20:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3LPTTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 14:19:49 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:49659 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755335Ab3LPTTp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 14:19:45 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so4090757yhz.41
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8G+PhXhtBNiUxkHhKVPD3N7R9koPrGIrV9wvTLsgIeg=;
        b=qkzsENJy/nVWXhJaQu4Cr3qqEC4tb085BMwHBJuRoGntxgoVbrTmaegpDSCUwUehFH
         y21fv1LKzZgeOYKFlSIZcOJmEqizI0xlI0y3eqYeggPs49JXwAzdSjatDa3zLNKx3Yr+
         DVXHV2EJ5ThwF+Uwn3K40F43e5UqQAMxtkLDXCxgF3tDhm4Z7Nu0QOoI+cxZ5Iy7Rgn1
         vgh3kH8+gcP2E8bIaavdnL+DXkva95115HOme9RrKAvJR/gOU3o/25+yFxQ1LJpoDr+C
         C5ifniIjI/TeS7TqVlL2aVC2y2n0F6/tjfwaCYrVhlY1UUldsYwCXWBqNCEZFoNTd5We
         B7XA==
X-Received: by 10.236.97.5 with SMTP id s5mr8166095yhf.68.1387221582441;
        Mon, 16 Dec 2013 11:19:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id w45sm20316046yhk.4.2013.12.16.11.19.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Dec 2013 11:19:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131216190445.GB29324@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239349>

Jeff King wrote:

> The original patch is in next, so here's one on top. I just updated the
> description.

Thanks.

>              I was tempted to explicitly say something like "this is
> opaque and meaningless to you, don't rely on it", but I don't know that
> there is any need.
[...]
> On top of jk/name-pack-after-byte-representations, naturally.

I think there is --- if someone starts caring about the SHA-1 used,
they won't be able to act on old packfiles that were created before
this change.  How about something like the following instead?

-- >8 --
From: Jeff King <peff@peff.net>
Subject: pack-objects doc: treat output filename as opaque

After 1190a1a (pack-objects: name pack files after trailer hash,
2013-12-05), the SHA-1 used to determine the filename is calculated
differently.  Update the documentation to not guarantee anything more
than that the SHA-1 depends on the pack content somehow.

Hopefully this will discourage readers from depending on the old or
the new calculation.

Reported-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-pack-objects.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d94edcd..cdab9ed 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -51,8 +51,7 @@ base-name::
 	<base-name> to determine the name of the created file.
 	When this option is used, the two files are written in
 	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
-	of the sorted object names to make the resulting filename
-	based on the pack content, and written to the standard
+	based on the pack content and is written to the standard
 	output of the command.
 
 --stdout::
-- 
1.8.5.1
