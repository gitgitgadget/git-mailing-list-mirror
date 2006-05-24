From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 20:21:19 +1200
Message-ID: <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 10:21:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiocS-0000Sk-Bm
	for gcvg-git@gmane.org; Wed, 24 May 2006 10:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWEXIVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 04:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932664AbWEXIVV
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 04:21:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:56109 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932661AbWEXIVU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 04:21:20 -0400
Received: by wr-out-0506.google.com with SMTP id i3so1446236wra
        for <git@vger.kernel.org>; Wed, 24 May 2006 01:21:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GuvpusUxk6VtQz2kZrz4RgA9psDZTK7PhEScDaTqBLLW9O4qjxWH115vxDG2VyvHRyrXDCP+X23X47Rnlcz1pChsPwL+Bq7AUwC8jcZdTVM+nZqPFsS0xe/r6Mjn6dJjWjEiYwPFeV6734bR29dYfG5uHwcyLPBL3T9gZrdkLlA=
Received: by 10.54.139.3 with SMTP id m3mr5987520wrd;
        Wed, 24 May 2006 01:21:19 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Wed, 24 May 2006 01:21:19 -0700 (PDT)
To: geoff@austrics.com.au
In-Reply-To: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20672>

On 5/24/06, Geoff Russell <geoffrey.russell@gmail.com> wrote:
> Dear Git,

Dear Geoff,

if you look at the list archive for the last couple of days, you'll
see there's been quite a bit of activity in tuning cvsimport so that
it scales better with large imports like yours. We have been playing
with a gentoo cvs repo with 300K commits / 1.6GB uncompressed.

Don't split up the tree... that'll lead to something rather ackward.
Instead, fetch and build git from Junio's 'master' branch which seems
to have collected most (all?) of the patches posted, including one
from Linus that will repack the repo every 1K commits -- keeping the
import size down.

You _will_ need a lot of memory though, as cvsps grows large (working
on a workaround now) and cvsimport grows a bit over time (where is
that last leak?!). And a fast machine -- specially fast IO. I've just
switched from an old test machine to an AMD64 with fast disks, and
it's importing around 10K commits per hour.

You will probably want to run cvsps by hand, and later use the -P flag.

cheers,


martin
