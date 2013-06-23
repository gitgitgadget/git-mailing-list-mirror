From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: detached HEAD before root commit - possible?
Date: Sun, 23 Jun 2013 16:54:32 -0700
Message-ID: <20130623235432.GA3024@elie.Belkin>
References: <20130623225505.GO20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 24 01:55:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqu7X-0003Av-1i
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 01:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643Ab3FWXyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Jun 2013 19:54:41 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54163 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3FWXyk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Jun 2013 19:54:40 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so10165934pbc.32
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4NlpWSphWbrw8R/Zfca8ltWIHZby2QpsySQNcFQUSus=;
        b=ICswjATl0nP/STouyCQFdSGeGs2pCd+7iH5mAPkzR8cf3tU73B33VKq0KkjT4IAJSD
         /8KZ0Q+PS1MAcZ/3SvbggCrGHNuUkKrQyiSi3wGgvqQeBWGCP4DAXOd7JXk3FR8Zu6sI
         zuTu9MHNQcYiQ5bx+MT5FcWJddxqLCsDq0adejhowfnLk10GXC8b/4ZAL3CCmLZlCQNC
         /SdlgEt+e5mwBzflNutlfllbNhsrulRkTdA1T/eyj45jzU3+Lk7DS1FllkyAsp+W4Whs
         k0tXzNgyUVu49UuXtDtBPtatokLD/G/cC5VUhJa2dRjTzrqVUGh7bYH31qkNctaNh93o
         nxNQ==
X-Received: by 10.66.27.147 with SMTP id t19mr25031929pag.171.1372031679837;
        Sun, 23 Jun 2013 16:54:39 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id dg3sm15220579pbc.24.2013.06.23.16.54.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Jun 2013 16:54:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130623225505.GO20052@goldbirke>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228766>

Hi,

SZEDER G=C3=A1bor wrote:

> $ git init
> Initialized empty Git repository in /tmp/test/.git/
> $ git checkout --detach
> fatal: You are on a branch yet to be born
>
> Are there some plumbing commands and options that would still allow
> this, or can I rely on that that it's impossible?

gitrepository-layout(5) tells me HEAD can be in one of a few states:

 a) Missing.  In this case the repository is considered to be
    corrupt and attempts to access the repository fail until the user
    runs "git init" to recover.

 b) A symbolic link, which is one way to represent a symref (pointing
    to an existing branch or an unborn branch).

 c) A standard symref, in the format "ref: refs/some/branch".  Behaves
    like (b).

 d) A direct SHA-1 reference (40-character commit object name)
    pointing to a commit without associating a branch ("detached HEAD")=
=2E

 e) Anything else means the repository is corrupt, as in case (a).

In other words, HEAD always either points to an unborn or existing
branch or an existing commit.  It's not clear to me what it would
mean to detach from an unborn branch.

Improvements to the documentation to make that clearer would of course
be welcome. ;-)

Thanks,
Jonathan
