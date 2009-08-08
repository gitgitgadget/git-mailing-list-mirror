From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: git failing to create new branches, depending on the name
Date: Sat, 08 Aug 2009 19:33:21 +0200
Message-ID: <4A7DB6E1.3000302@gmail.com>
References: <4A7D9AA7.1030709@gmail.com> <200908081904.58186.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 08 19:33:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZpnd-0000vs-Ov
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 19:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbZHHRd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 13:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZHHRd1
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 13:33:27 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45803 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbZHHRd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 13:33:26 -0400
Received: by bwz19 with SMTP id 19so1951244bwz.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 10:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=wSTt9ssIbtgdG8TwusjCyf/PaKDp8WpOQi0rc6Q3asw=;
        b=AjFWtkA+X6dZrLcoboTlBadQzAEqOnY0/j9N8VAFQcUssna89/gKjkzigu8PHb4AOy
         1fbQJHt2K6Eihw95ZiHetDAxo8hbcINlUA4juX1jFrA3x6zkQjIis2PvCU9hhMfiOdpd
         PMzS8raq5/7JhfgUjgj74tHO4MybKMx9ga0wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=Or1YqCC11tUn2aDLYJik3mn51nFktD1p1a+R4G6JGkeNO5ySeg6JT60jxRJJCjnrlz
         hquQZj912bBdkhu4XeOfukbCULUZGrzmF8PE9ksGeQtQlIZWAFcAebrAk8pdr8cu6iLs
         xSSr1EYtYY554Q6wkWzp9qaZ+KcQ5/DjRjagY=
Received: by 10.103.252.5 with SMTP id e5mr1070485mus.136.1249752803494;
        Sat, 08 Aug 2009 10:33:23 -0700 (PDT)
Received: from ?172.19.43.221? (ip-89-174-122-138.multimo.pl [89.174.122.138])
        by mx.google.com with ESMTPS id u26sm11421999mug.51.2009.08.08.10.33.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 10:33:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22pre (X11/20090422)
In-Reply-To: <200908081904.58186.trast@student.ethz.ch>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125292>

Thomas Rast wrote:
> Artur Skawina wrote:
>> + git checkout -f -b branch-g90bc1a6 askern/release
>> fatal: git checkout: branch branch-g90bc1a6 already exists
> 
> This bisects to
> 
> commit 352eadc40024b141e1295693654ec20cc123844f
> Author: Daniel Barkalow <barkalow@iabervon.org>
> Date:   Sun Sep 21 14:36:06 2008 -0400
> 
>     Check early that a new branch is new and valid

> Not sure this is a bug though.  If we allow branch names that are

well, it didn't say it didn't like the name, and sent me looking
for bugs in my scripts for quite a while, until i realized what's
going on...

> ambiguous to rev-parse, what do they resolve to?  E.g., in the
> presence of only 'master', 'master-g01234567' is defined to be the
> same as 01234567.  What is it if you also have a *branch* called
> 'master-g01234567'?

I'd expect the branch namespace to take precedence, unless branches
ending in -g01234567 are illegal, but that seems like an odd limitation.

Note that currently this works:

+ ( cd /tmp/build-tree/ && git checkout -f whatever/random-name-g90bc1a6 )
HEAD is now at 90bc1a6... Merge branch 'upstream' of git://ftp.linux-mips.org/pub/scm/upstream-linus

which doesn't seem right either.

artur
