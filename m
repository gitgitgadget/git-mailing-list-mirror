From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git fuse
Date: Wed, 25 Dec 2013 18:01:12 -0500
Message-ID: <CAM9Z-nmVaBDcRABMRJGLdFVDSLRGL31jMS9KpaWiQ4y_SYONdg@mail.gmail.com>
References: <201312192215.01103.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Thu Dec 26 00:08:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvxYi-0003gz-2N
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 00:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3LYXHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Dec 2013 18:07:48 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35517 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab3LYXHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Dec 2013 18:07:47 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so8179886ieb.18
        for <git@vger.kernel.org>; Wed, 25 Dec 2013 15:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3wGTsPa5UMEW+UQ45XSEtW9S5Ee2MtXBvMBSewllN1w=;
        b=0HIueFP53DmFFwv5SSks4fdYZbsd8+wX70RzaELol35OQPv4ZyGK5hNnLsBI7RWD6G
         J7yr5A6Q+Zc4DS9pBsjSgvBwBVfC2gIJKuChriGKoCr38YZwpaaOthgvKQejmaVSmWi8
         5d48my6gjVlb1U+Wd3uD1STm87HLMY19bIBOQJWJ48SHqTwVC5c7rC7eEGa/GVHHgQxc
         GJj0q59miD1sRtPDd1xafw01iUVkFYEH4YCcdJlmMGD2ikg/JzueEHNgXWj1sqQRFssT
         XpGwSU0o+mPrCK0jwPGd3LRT2YXlgcR2JJ1AB2ufq/tiZe4wdyFot7yuUnm1G2Zu2t2F
         N7fA==
X-Received: by 10.50.43.134 with SMTP id w6mr31705235igl.20.1388012472848;
 Wed, 25 Dec 2013 15:01:12 -0800 (PST)
Received: by 10.43.138.9 with HTTP; Wed, 25 Dec 2013 15:01:12 -0800 (PST)
In-Reply-To: <201312192215.01103.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239683>

On Thu, Dec 19, 2013 at 4:15 PM, Thomas Koch <thomas@koch.ro> wrote:
> Hi,
>
> I'm thinking about using Git for web application deployment and thought that I
> wouldn't even need to checkout a worktree if I could access the bare git repo
> via fuse.

Thomas,
Given that gitweb (and more than a few other similar tools) doesn't
use FUSE and works on bare repositories I question why you think you'd
need (or want) to introduce the additional layer.

> What would be the performance impact? Once the files are in the filesystem cache
> it shouldn't matter anymore, how fast the git fuse layer is, should it?

If your concern is caching, it should be implemented upon already
rendered / prepared objects whenever possible--frequently not a file
system level implementation. This is a design concern that has no
specific requirement whatsoever to do with FUSE (or for that matter,
with most of the VFS layer when accessing raw disk--as VFS itself is
highly optimized already).

I am not qualified to answer questions about FUSE use of the VFS cache.

I would strongly consider using a tool such as Varnish if you are
concerned about performance when serving static or semi-static content
(may it reside in a Git repo or elsewhere). The architectural concerns
of your web-app should probably guide your design in this sort of
direction anyway if it will be expected to sustain notable throughput
over time.

I hope that helps.

(If you want to discuss this further it would be worth considering if
your questions are Git questions or web-app design questions. The
latter should be taken elsewhere.)

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
