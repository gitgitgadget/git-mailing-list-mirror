From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 11:25:23 -0400
Message-ID: <CABURp0rBzH9=VdW0Y4Bv1tfbSzZ3dwismwgZ7zCwrXC6nDRSJQ@mail.gmail.com>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org> <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org> <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <7v4ndtcmh0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 17:25:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UftsM-0006Kb-Dt
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 17:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333Ab3EXPZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 11:25:45 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39241 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab3EXPZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 11:25:44 -0400
Received: by mail-vc0-f174.google.com with SMTP id hr11so3240133vcb.33
        for <git@vger.kernel.org>; Fri, 24 May 2013 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ehX3aahuqFQ300PxtIRnVkoUBmOuU9D+qbJhQbebMmA=;
        b=wFyla5S3FbXg9uKKwQkcxrxtFuLsGG/ddHk8kb3CZHHExVNANz/UYfaHzPxvka7E8z
         WjY2tCy7Xobrmkjhr6TFYCcEAN5Wrs+mFgPwdcS7tFDnw3vMR8F8M6qW42Xd7wd2rRKu
         r4m/NVa9ELtwCVPtCj3m18dadwI+MSN1XFMhLHq+qaJfX3whhtCyUk/snThSogx6U6eu
         ZFWSuPZcRNAkm/+KcBiutbZ5s0R6LmEKE5gnNU/k2MTIgBppLiSswNnqytC+Pb+pgxAj
         IRYLCpUdTuLLpRVBqC7qP/LGUoVxd6McXTB7R5ZLkcAAyd47hSg6qy67X29pdwS2l19W
         o9yA==
X-Received: by 10.220.246.196 with SMTP id lz4mr8996199vcb.45.1369409144096;
 Fri, 24 May 2013 08:25:44 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Fri, 24 May 2013 08:25:23 -0700 (PDT)
In-Reply-To: <7v4ndtcmh0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225361>

On Thu, May 23, 2013 at 7:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@inf.ethz.ch> writes:
>
>>> What are the workflows that are helped if we had such a bit?  If
>>> we need to support them, I think you need a real --ignore-changes
>>> bit, not an abuse of --assume-unchanged.
>>
>> I gather -- from #git -- that it's mostly used for config files, which
>> have an annoying habit of being different from the repository.
>>
>> Which is wrong, really.  But we still claim that --assume-unchanged is a
>> solution to it in git-update-index(1).
>
> That is doubly wrong, then ;-)
>
> How would we want to proceed from here?  The obvious first step
> would be to fix the documentation, but then what is next?
>
> Thinking aloud, ignoring that "Which is wrong, really" part in your
> message and assuming that we do want to support --ignore-changes....


The wording of --ignore-changes suffers the same lack of clarity that
--assume-unchanged does.

  --assume-unchanged : These changes are ephemeral

  --ignore-changes : These changes are precious but not to be committed

What's better?  --sequester is probably too obscure.  Maybe --hold.
Or --silence.  Or --shut-up.

Does this mean a new class of files for git-status?  Added, changed,
untracked, ignored and held?

I wonder if there is a use case for such a switch to be applied to
content rather than files.  Suppose I want to --hold these changes,
but further changes to the same files should be fair game?  That's
probably an insane situation for some future itch and not this one.
Anyway, it sounds like it would involve the index or maybe a 2nd
index.

Phil
