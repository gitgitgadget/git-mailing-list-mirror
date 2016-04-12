From: Stefan Beller <sbeller@google.com>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 16:00:18 -0700
Message-ID: <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
References: <570D78CC.9030807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:00:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7IM-0001sl-0w
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbcDLXAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:00:22 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34601 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758889AbcDLXAU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:00:20 -0400
Received: by mail-ig0-f177.google.com with SMTP id gy3so118966115igb.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ndx50fVbQEbLis6Z60IuCZVc0uFjQhlvOWOUOBQ3dHU=;
        b=EmmpdK/cQQn4v+zLyQvA/IGb3rBPpq6VNIiKPW4Dpn03yL1JKjnakDjJ8wlW05gbwS
         LxNzCDvPQ2q3omkCpSHh4qQbOiDtLU+pJdEuo+w7RNVJo4ShAL6XrPHfESj2eJvSenQs
         oyHE58J9ISuwwuQuAtaNJ6s6NKL8piZSh9eSWeoQFqw5HPARw5ZLwkp/lhnNd3jF70qg
         1VHRUAfYjbCw+IGkwKNwXYh5+Rgn2TdjcN+gYSvl6L1gHZNVvxtS4AASIJ5Ii6zKpfdT
         JzEy2bAD7e9eZrFtdjyqKFPwGFA+FnmusaGYLEoOoMA1A9279Y5JlPSoU/4XreHkh+Be
         Ex9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ndx50fVbQEbLis6Z60IuCZVc0uFjQhlvOWOUOBQ3dHU=;
        b=NJGuYFx5NVm+JNcFJS9ip2x1T3MjRsO+vYkR8IhSZNoh6CcYKTcuBCcb6fjBEhTF6+
         e2Au9tBZGDtGGfnjRIT1fjzYFNnrg57agUSQi91AipqQY3C5Jv3XDfGpjELglzW4vtqP
         Z8WyBFB+IojuZS9pjc18BseCQwkpoATBEhjhEdZWg8cuewBXe/X5D+TSnPwubJwijem/
         QHl620zcrzH5QHA2zkSdDRB3lbi01UKfsSnWtb8RWEa73YtrvbpE3HVjjNSp4VoejITZ
         gOzEG7EpZS6QH/o33GToFFcGkCLw7/cYVfvbGAlS75hhi5y8waHLVeaM//9EFW9VabEi
         KAsQ==
X-Gm-Message-State: AOPr4FXgsPtLD7fdBCaLoZf9sfyL+bAi0JlNI/ryWVvGAG4UshRkqs62L+6GiTzjnt4vELi2435s0kvmSBjxDV19
X-Received: by 10.50.112.10 with SMTP id im10mr7065107igb.93.1460502019031;
 Tue, 12 Apr 2016 16:00:19 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 12 Apr 2016 16:00:18 -0700 (PDT)
In-Reply-To: <570D78CC.9030807@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291307>

On Tue, Apr 12, 2016 at 3:38 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> OK, I'm going to open this can of worms...
>
> At what point do we migrate from SHA-1?  At this point the cryptoanalysis of
> SHA-1 is most likely a matter of time.

And I thought the cryptographic properties of SHA1 did not matter for
Gits use case.
We could employ broken md5 or such as well.
( see http://stackoverflow.com/questions/28792784/why-does-git-use-a-cryptographic-hash-function
)
That is because security goes on top via gpg signing of tags/commits.

I am not sure if anyone came up with
a counter argument to Linus reasoning there?

>
> For existing repositories we will need to have a migration mechanism. Since
> we can't modify objects without completely invalidating the cryptographic
> properties, what I would suggest is that we leave the existing objects as
> is, with a persistent lookup table from SHA-1 to <new hash>, and have that
> lookup table signed (e.g. GPG) by the person responsible for converting the
> repository.  This freezes the cryptographic status of the existing SHA-1
> objects at the time the conversion happens.  This is a very good reason to
> do this before SHA-1 is actually broken  In contrast. SHA-2 has been
> surprisingly resistant to cryptoanalysis, to the point that SHA-3 was
> motivated by performance and the desire to have a well-tested function based
> on entirely different principles should a generic attack against the common
> structure of MD5/SHA-1/SHA-2 would ever be found.

When the kernel moved from BitKeeper to Git, all history was thrown away,
and started from scratch. The old history could be grafted into the
repo, if you cared
though.

I'd propose to go that route again and use a sha1 graft history which
you can get optionally
put into your new history for convenience.

Stefan

>
>         -hpa
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
