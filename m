From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH v2] git-svn: add --authors-prog option
Date: Fri, 8 May 2009 23:48:39 -0400
Message-ID: <ca433830905082048u6088a58ai16b1c979ef742f7@mail.gmail.com>
References: <1241745069-2663-1-git-send-email-lodatom@gmail.com>
	 <4A03E2A2.4050303@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 09 05:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2dYO-00078i-93
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 05:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbZEIDsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 23:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbZEIDsk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 23:48:40 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:62060 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbZEIDsk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 23:48:40 -0400
Received: by bwz22 with SMTP id 22so1673894bwz.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xOZDN2Qcn4eA1oombj+I7JitHuSp8tZcB2szdsz6ElI=;
        b=juuhsOWZVN3WTi554oKwSc9We/S8H+wmUNT6+q95xg6QlkTFxVW/hXc26A005ljkq4
         vXSTjtnVodgwV+XbHap5fZQBUpjIuIld71aEiUVA4s6Xuf7S8eN4tGwcfMBH627P9Yew
         tkvHaER4Fmmvni5xTExwM4ySUH6xb0to6V+fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jm5Q7fBHTzNlASzxbjHUULfmMT1WDE4/E54HJWanGj4KDWxud+d6RkwJevryrpqUCC
         +Xtmz7juoOp7bIQWW8+6vUomB0cmJnZQ9O6+8fWc1Eqs50RbrVGt4lSYULqw4iOmaNUm
         ENvazjSfmT3T/cgbizBDV6e2roxMQf7x85DFQ=
Received: by 10.223.123.129 with SMTP id p1mr2129210far.0.1241840919524; Fri, 
	08 May 2009 20:48:39 -0700 (PDT)
In-Reply-To: <4A03E2A2.4050303@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118648>

On Fri, May 8, 2009 at 3:43 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Mark Lodato venit, vidit, dixit 08.05.2009 03:11:
>> =C2=A0config key: svn.authorsfile
>>
>> +--authors-prog=3D<filename>::
>> +
>> +If this option is specified, for each SVN committer name that does =
not
>> +exist in the authors file, the given file is executed with the comm=
iter
>
> s/commiter/committer/
>
> Also, "If..., the given... for each..." may be easier to read.
>
>> +name as the first argument. =C2=A0The program is expected to return=
 a single
>> +line of the form "Name <email>", which will be logically inserted i=
nto the
>
> "be treated as if included in the..."

Will do.

>
> Maybe we want a config key also, just like for the authors file.

Yes, this is a very good idea.  I will figure out how to do this.

> The feature itself looks useful for large user databases. For smaller
> ones one could just as well update the authors file before each fetch=
 by
> dumping the whole db in there (or even conditionally on git svn fetch
> erroring out due to encountering an unknown name).

Right.  This feature will most likely be useful in corporate
environments.  In my case, it is not possible to dump the entire user
database to a file, so this patch is the only solution.  Another
possible use case is where SVN usernames are standardized, e.g. "jdoe"
-> "J Doe <jdoe@example.com>".  Also, using --authors-prog solves the
problem of keeping the authors file up-to-date, if users are regularly
added or deleted.
