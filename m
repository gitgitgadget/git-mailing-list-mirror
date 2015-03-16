From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug in git-verify-pack or in its documentation?
Date: Mon, 16 Mar 2015 17:13:25 +0700
Message-ID: <CACsJy8AXvYCje0-smbNdfGtjsdYieKyxxiHCGf32Jpi3seDrvA@mail.gmail.com>
References: <20150316080558.GA30234@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 11:14:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXS26-0007tx-1Z
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 11:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbCPKN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 06:13:57 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35855 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbbCPKN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 06:13:56 -0400
Received: by iegc3 with SMTP id c3so169469090ieg.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CyP0E+/+GpdsAwq0ExQF/7n/MzpxntqqcyE0oGMhTDk=;
        b=qXjXO/qWzENY11Z5IZuAUoQhQLKDS3uM3Au3pLEsCm9lo9ZCYvdhagU479zgdQC10n
         OcCHc0894wRS0u27kPa27ZAYBLId6esS3hrc7PM5xNtdVVaf/vekfvvsCw5IWhLMP5Pp
         JdD6dUgOYxpfrzyM6udSr8mXGOn4J0KIxhQZ3GEQgLT7ciX2XzjNM3We8mQOOKZbqu0a
         ftyg0ctrQb7FVJmPxRc4gFS14+LPc9ycV+aakQ3obxv7R4IT52hpVP1WVn0ePv5RhfKI
         /szU8/wChiEMlUq4rJNVx/A8uLduQqO39D2VO/1Z4SHajK0meN9DW9Y9ENtzhEzRvUXC
         Wpig==
X-Received: by 10.50.36.103 with SMTP id p7mr134451207igj.20.1426500835899;
 Mon, 16 Mar 2015 03:13:55 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 16 Mar 2015 03:13:25 -0700 (PDT)
In-Reply-To: <20150316080558.GA30234@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265554>

On Mon, Mar 16, 2015 at 3:05 PM, Mike Hommey <mh@glandium.org> wrote:
> Hi,
>
> git-verify-pack's man page says the following about --stat-only:
>
>    Do not verify the pack contents; only show the histogram of delta
>    chain length. With --verbose, list of objects is also shown.
>
> However, there is no difference of output between --verbose and
> --verbose --stat-only (and in fact, looking at the code, only one of
> them has an effect, --stat-only having precedence).

There is. very-pack --verbose would show a lot of "<sha-1> <type>
<"random" numbers>" lines before the histogram while --stat-only (with
or without --verbose) would only show the histogram.

> The text above also implies that this should only display the stats
> without doing any sha1 validation, but afaict from a quick glance at
> the index-pack code, they are always performed.
>
> Is it an implementation problem or a documentation problem?

I think code and document start to divert from 3de89c9 (verify-pack:
use index-pack --verify - 2011-06-03). The conversion to using
index-pack implies heavier verification anyway (all objects must be
hashed, no way around it), so I'd say it's documentation problem. The
other way would be revert some patches in verify-pack.c and add more
maintenance burden for this command.
-- 
Duy
