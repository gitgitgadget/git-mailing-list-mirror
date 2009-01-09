From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH/RFC v3 1/2] Optimised, faster, more effective symlink/directory
 detection
Date: Fri, 09 Jan 2009 02:20:18 -0800
Message-ID: <496724E2.6010907@pcharlan.com>
References: <1231334689-17135-1-git-send-email-barvik@broadpark.no> <1231334689-17135-2-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Fri Jan 09 11:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLEVT-0003Bh-QL
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 11:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160AbZAIKU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 05:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754940AbZAIKU6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 05:20:58 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:51360 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbZAIKU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 05:20:58 -0500
Received: from swarthymail-a7.g.dreamhost.com (lax-green-bigip-5.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id A8B6717F620
	for <git@vger.kernel.org>; Fri,  9 Jan 2009 02:20:58 -0800 (PST)
Received: from [192.168.0.2] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by swarthymail-a7.g.dreamhost.com (Postfix) with ESMTP id 558B5DE574;
	Fri,  9 Jan 2009 02:20:19 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <1231334689-17135-2-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104999>

Here are some suggestions for the commit message.

Kjetil Barvik wrote:
> Changes includes the following:
> 
> - The cache functionality is more effective.  Previously when A/B/C/D
>   was in the cache and A/B/C/E/file.c was called for, there was no
>   match at all from the cache.  Now we use the fact that the paths
>   "A", "A/B" and "A/B/C" is already tested, and we only need to do an

is -> are

>   lstat() call on "A/B/C/E".
> 
> - We only cache/store the last path regardless of it's type.  Since the

it's -> its

>   cache functionality is always used with alphabetically sorted names
>   (at least it seams so for me), there is no need to store both the

seams -> seems

>   last symlink-leading path and the last real-directory path.  Note
>   that if the cache is not called with (mostly) alphabetically sorted
>   names, neither the old, nor this new one, would be very effective.
> 
> - We also can cache the fact that a directory does not exist.
>   Previously we could end up doing lots of lstat() calls for a removed
>   directory which previously contained lots of files.  Since we
>   already have simplified the cache functionality and only store the
>   last path (see above), this new functionality was easy to add.
> 
> - Previously, when symlink A/B/C/S was cached/stored in the
>   symlink-leading path, and A/B/C/file.c was called for, it was not
>   easy to use the fact that we already known that the paths "A", "A/B"

known -> knew

>   and "A/B/C" is real directories.  Since we now only store one single

is -> are

>   path (the last one), we also get similar logic for free regarding
>   the new "non-exsisting-directory-cache".
> 
> - Avoid copying the first path components of the name 2 zillions times

zillions -> zillion

>   when we tests new path components.  Since we always cache/store the

tests -> test

>   last path, we can copy each component as we test those directly into
>   the cache.  Previously we ended up doing a memcpy() for the full
>   path/name right before each lstat() call, and when updating the
>   cache for each time we have tested an new path component.

an -> a

> 
> - We also use less memory, that is PATH_MAX bytes less memory on the

is -> is,

>   stack and PATH_MAX bytes less memory on the heap.

Cheers,

--Pete
