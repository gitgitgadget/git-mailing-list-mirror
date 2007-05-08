From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change default depth to 50
Date: Tue, 8 May 2007 10:07:44 -0700
Message-ID: <56b7f5510705081007v4840ff7cma754a75eb3d3377f@mail.gmail.com>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
	 <11786309073709-git-send-email-tytso@mit.edu>
	 <11786309072612-git-send-email-tytso@mit.edu>
	 <alpine.LFD.0.99.0705081136050.24220@xanadu.home>
	 <20070508163044.GA15796@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 19:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlTB4-000362-08
	for gcvg-git@gmane.org; Tue, 08 May 2007 19:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966453AbXEHRHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966468AbXEHRHt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 13:07:49 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:57153 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966453AbXEHRHq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 13:07:46 -0400
Received: by an-out-0708.google.com with SMTP id d18so249687and
        for <git@vger.kernel.org>; Tue, 08 May 2007 10:07:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h5uweB//MZARCbwSQnGFUpwLEuEOJ1VO7j4YwjEX5nc8iu4rb8TZR9b5D7Ubr7Cs9Q1XcjDtlCuzE8vBu+TOD7Jym+pd8yx9pnaysxDWLjS58ndtSjEwYr0vgdDsdUwN/qo+P3SbSkt5ogSHxt+ruF1t1rc/LZw+M2sDHfW8Nck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NNpRpAIP6lKe/2a1EOV7UMpxAiEmHQ8gdegpSHlsw5cFaODDLCi1YA0bRP70OBzitwP3R/q33FYSrpplN3Ld9Nzh6AkmS52xJKGXzdW5LouZIM5+Xxw3FGfuTQ3N7tJGgJAOXE38nMNQEH+RHqQakPguaY/GNUR8PbxHgmUl2I4=
Received: by 10.115.111.1 with SMTP id o1mr2673887wam.1178644064862;
        Tue, 08 May 2007 10:07:44 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Tue, 8 May 2007 10:07:44 -0700 (PDT)
In-Reply-To: <20070508163044.GA15796@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46601>

On 5/8/07, Theodore Tso <tytso@mit.edu> wrote:
> The following results are on a recent git repository, using time to
> record the real, user, and sys times on the two commands: "git-gc
> --no-reuse-delta --window=X --depth=Y" and "git log --pretty=oneline
> -S'object' > /dev/null".  All of these tests were done with a hot
> cache, so disk speed didn't enter into the calculations.
>
> ...
>
> So a couple of things immediately become evident.  First of all, as
> Junio predicted, changing --depth makes no difference to the git-gc or
> git log times.  The latter is thanks to the delta chaching.  Secondly,
> changing --depth does make a signficiant difference to the pack size.
>
> Finally, --window does help somewhat in reducing the pack size, but it
> _significantly_ increases the time to calculate the pack.
>
> My conclusion given this quick benchmark is that it seems to me that
> changing the defaults of --depth to 50, and keeping --window at 10, is
> a reasonable thing to do.

If you still have the packfiles around,  the times for some non-pickaxe
git-log commands would be interesting,  like from git-log's man page:
       git log v2.6.12.. include/scsi drivers/scsi
       git log --since="2 weeks ago" -- gitk
These operations would be more dominated by processing smaller objects.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
