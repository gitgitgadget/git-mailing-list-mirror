From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Poor push performance with large number of refs
Date: Wed, 10 Dec 2014 16:17:39 +0700
Message-ID: <CACsJy8CkydEE6Q+0PRQOwUkoo5rO9MhsZC=Ps1gWM9kf2QtS8g@mail.gmail.com>
References: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XydPV-0004EV-RE
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 10:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbaLJJSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 04:18:12 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54481 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaLJJSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 04:18:11 -0500
Received: by mail-ie0-f176.google.com with SMTP id tr6so2287121ieb.21
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=R9sgj7IpGf0QK/mpuMFkHNAedkHMz6UXaGjl9Kz4i9Y=;
        b=FT9Aqp0BXCDuU+G+4WQzuoIOWpgHrzSTrWMS0jHgjzfmPob5XF0JhAW4Ipo4Y6VWXY
         fFIMP66+sdgmNFedvvC7MtlvdKL8kdxOGcIbJWwuVQFG3OSIn5a2lWmbqUTW8PzEKR2Q
         fGPU4pqpFKxeFev6XVbV5CjFKxfsdbYqOPm56dtxn8uvcu1AVo+o5DAYS00gbvNQRj+W
         Xdndg/ouObbj/shiPAsBNVILnGmNEof0Vb4+ajZUxyXCf79cUEfcPp0464lvPbU88yUi
         JV7KjP7H7g9IA8nekMs8eCYl0qOPwPg6gVMIsZ3IN4VKrRXzeTrYyTRISbr2z6KeHK8Y
         voBQ==
X-Received: by 10.107.166.149 with SMTP id p143mr3020946ioe.16.1418203090156;
 Wed, 10 Dec 2014 01:18:10 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Wed, 10 Dec 2014 01:17:39 -0800 (PST)
In-Reply-To: <20141210003735.GA124293@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261198>

On Wed, Dec 10, 2014 at 7:37 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> I have a repository that's just under 2 GiB in size and contains over
> 20000 refs, with a copy of it on a server.  Both sides are using Git
> 2.1.2.  If I push a branch that contains a single commit, it takes about
> 15 seconds to push.  However, if everything is up-to-date, it completes
> within 2 seconds.  Notably, HTTPS performs the same as SSH.
>
> Most of the time is spent between the "Pushing to remote machine" and
> "Counting objects", running git pack-objects:
>
>   git pack-objects --all-progress-implied --revs --stdout --thin --delta-base-offset --progress
>
> Unfortunately, -vvv doesn't provide any helpful output.  I have some
> suspicions what's going on here, but no hard data.  Where should I
> be looking to determine the bottleneck?

Start with "perf record", if this is on linux?
-- 
Duy
