From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 00/15] Make Gnome Credential helper more Gnome-y and
 support ancient distros
Date: Mon, 23 Sep 2013 06:20:22 -0400
Message-ID: <20130923102022.GA96514@yoda.local>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pah@qo.cx
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 12:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VO3Fn-0002RN-VB
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 12:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab3IWKU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 06:20:28 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:56652 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab3IWKU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 06:20:27 -0400
Received: by mail-qc0-f177.google.com with SMTP id x12so1854791qcv.8
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 03:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qUhn+PbeImypClTVlRXDBfxSZQ61bxHoiQki1bc0Wvg=;
        b=cEpwheOfcBMtps/JD5WD4ymso9gv6Nf3hwCVRM8alryS91Fz+qdzRpT5srn7t/veJE
         vDQroiMRDwKw3OhT+STNjUSW3uYl9Bm6pKorkm4bhlxfn4kGoLGCAMganZQHTI2GG66d
         X3ZlcYCtUj+EUH/GP6BSHocgLxBIDum4OGNJ65sBn9C9I98FKTdm2zXWiDrUREOQWcS5
         4pHtCmWuCgGoOVUZelrSVxGG0qTYC1hs0pv4WI+EJ8Rx+nYSSSkpJBQtMFmw3dA+0sx8
         cj2f8Y8ZRO5ZJFYq8KhaJx3D2Dhxo4cZD6Z3XNbJO8NYwvGaNsUIdJlpDAjjZbvxI6OB
         GOnQ==
X-Received: by 10.224.5.202 with SMTP id 10mr7774911qaw.74.1379931626394;
        Mon, 23 Sep 2013 03:20:26 -0700 (PDT)
Received: from yoda.local (pool-173-59-254-58.bltmmd.fios.verizon.net. [173.59.254.58])
        by mx.google.com with ESMTPSA id x1sm42909117qai.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 03:20:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235205>

On Sun, Sep 22, 2013 at 10:07:56PM -0700, Brandon Casey wrote:
> A few cleanups, followed by improved usage of the glib library (no need
> to reinvent the wheel when glib provides the necessary functionality), and
> then the addition of support for RHEL 4.x and 5.x.
> 
> Brandon Casey (15):
>   contrib/git-credential-gnome-keyring.c: remove unnecessary
>     pre-declarations
>   contrib/git-credential-gnome-keyring.c: remove unused die() function
>   contrib/git-credential-gnome-keyring.c: add static where applicable
>   contrib/git-credential-gnome-keyring.c: exit non-zero when called
>     incorrectly
>   contrib/git-credential-gnome-keyring.c: set Gnome application name
>   contrib/git-credential-gnome-keyring.c: strlen() returns size_t, not
>     ssize_t
>   contrib/git-credential-gnome-keyring.c: ensure buffer is non-empty
>     before accessing
>   contrib/git-credential-gnome-keyring.c: use gnome helpers in
>     keyring_object()
>   contrib/git-credential-gnome-keyring.c: use secure memory functions
>     for passwds
>   contrib/git-credential-gnome-keyring.c: use secure memory for reading
>     passwords
>   contrib/git-credential-gnome-keyring.c: use glib memory allocation
>     functions
>   contrib/git-credential-gnome-keyring.c: use glib messaging functions
>   contrib/git-credential-gnome-keyring.c: report failure to store
>     password
>   contrib/git-credential-gnome-keyring.c: support ancient gnome-keyring
>   contrib/git-credential-gnome-keyring.c: support really ancient
>     gnome-keyring

I reviewed all of the commits in this series, and most are nice
cleanups.  The only thing I'm a little shaky on is RHEL4
support (patch 15).  In particular, this:

    +/*
    + * Just a guess to support RHEL 4.X.
    + * Glib 2.8 was roughly Gnome 2.12 ?
    + * Which was released with gnome-keyring 0.4.3 ??
    + */

Has that code been tested on RHEL4 at all?  I imagine it's hard
to come by--it's pretty darn old--but it feels like a mistake to
commit untested code.

Otherwise, there are a few stylistic nits that I'd like to clean
up.  Only one was introduced by you--Felipe pointed it out--and
I have a patch for the rest that I can submit after your series
has been applied.

Acked-by: John Szakmeister <john@szakmeister.net>

-John
