From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR':
 Permission denied
Date: Sat, 19 Sep 2015 09:21:53 +0700
Message-ID: <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
References: <1440157010.1759.83.camel@transmode.se> <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
 <1442245035.10125.18.camel@transmode.se> <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
 <1442508864.21964.26.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Sep 19 04:22:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd7nJ-0000yS-8x
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 04:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbbISCWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 22:22:24 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33574 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbbISCWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 22:22:23 -0400
Received: by igbkq10 with SMTP id kq10so47873071igb.0
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E90thHqB7uo7wcP4UHEunuSvOvzPbJt6Uz2b3++ZhbI=;
        b=EK/oWhsDT7sJyVr33sMO8apHIHPffsPNRw302OlNb+j+y9hq9ncHVaO3TQsz+uw6C6
         27OMCUtoFM+o3tjYwg3lgcNZ3v7SbUupbZ8obThilRP9F7rLDtTHPlaWe4NYewJC7JC7
         OBfjZhSNNiYZ2G71DE45vXFzpBkQzFgyly7msKbR8xbb9nsH6ZKxmeNt5eY+amfNCcBs
         LJ+uQEI2y3nFRTRObQD5U30Gc7oFJTL+IR7DvfcI2K9DJ2Ubf2+0fgzDMiiuZU76VIRH
         +xDGwN9KAPhgJ4+n4s3faMadkw9behpL1XU04X+LyRtlpyqMvUYdtKNhGJrBEtFW79ma
         4TqA==
X-Received: by 10.50.79.196 with SMTP id l4mr1250401igx.48.1442629342601; Fri,
 18 Sep 2015 19:22:22 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Fri, 18 Sep 2015 19:21:53 -0700 (PDT)
In-Reply-To: <1442508864.21964.26.camel@transmode.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278228>

On Thu, Sep 17, 2015 at 11:54 PM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> On Thu, 2015-09-17 at 20:18 +0700, Duy Nguyen wrote:
>> On Mon, Sep 14, 2015 at 10:37 PM, Joakim Tjernlund
>> <joakim.tjernlund@transmode.se> wrote:
>> > On Mon, 2015-08-31 at 16:56 +0700, Duy Nguyen wrote:
>> > > On Fri, Aug 21, 2015 at 6:36 PM, Joakim Tjernlund
>> > > <joakim.tjernlund@transmode.se> wrote:
>> > > > I cannot push:
>> > > > # > git push origin
>> > > > Login for jocke@git.transmode.se
>> > > > Password:
>> > > > Counting objects: 7, done.
>> > > > Delta compression using up to 4 threads.
>> > > > Compressing objects: 100% (7/7), done.
>> > > > Writing objects: 100% (7/7), 13.73 KiB | 0 bytes/s, done.
>> > > > Total 7 (delta 4), reused 0 (delta 0)
>> > > > fatal: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission
>> > > > denied

I'm about to do it, but now I'm not sure if I should move
shallow_XXXXXX out of $GIT_DIR. It will not be the only command that
may write to $GIT_DIR. "git gc --auto" (which can be triggered at the
server side at push time) can write $GIT_DIR/gc.pid (and soon,
gc.log). Even if you disable gc --auto and run it periodically (with
cron or something), it will write gc.pid.

Is it really necessary to remove write access in $GIT_DIR? Do we (git
devs) have some guidelines about things in $GIT_DIR?
-- 
Duy
