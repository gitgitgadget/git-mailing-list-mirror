From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-ls-files --added?
Date: Tue, 26 May 2009 10:56:52 +1000
Message-ID: <2cfc40320905251756t32e092fdqda769e21669f5d86@mail.gmail.com>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
	 <m3fxeudhho.fsf@localhost.localdomain>
	 <2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com>
	 <7vmy921i3j.fsf@alter.siamese.dyndns.org>
	 <7vws85y9n7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 02:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8kyR-00010D-4S
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 02:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZEZA4w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 20:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZEZA4v
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 20:56:51 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:47975 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbZEZA4v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 20:56:51 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2034488yxj.1
        for <git@vger.kernel.org>; Mon, 25 May 2009 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xKcg54C7rjiCA8I45fBCzr5BQeb4gYc3hX0joAItnj8=;
        b=WL9BHKaSy7wbBLp7sfyAwYKAGC618rq5+K4roiUZYSENUh8h0DCj6C4WsiYUge2tY4
         qhtXO8fa3MNGGnBu3izXIH0U+eLMf1ui2eX1pxkbhS1ING+vpkhSpfwMO3Oxq2d/RZZM
         5BATuL1qORaPod8T1MbchSTszHqAbmXM6LB8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xL4/pBbw+zZQjD93TeZly+ZriAvCG9ZVspw7zkLyaDxf88b6hYYQ5UUqs24yGrByrm
         DzGnvz/nY1imwTalO614bF4/wxExx+CIOepXmI4/inC3GTSgocOEhO3I46jbt94q2vOu
         q6XBkbzOiv7q40XiYISjwNEwww1hOkkit9OGc=
Received: by 10.151.138.8 with SMTP id q8mr15372759ybn.222.1243299412139; Mon, 
	25 May 2009 17:56:52 -0700 (PDT)
In-Reply-To: <7vws85y9n7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119991>

Thanks for your answer's Junio.

I am indeed writing some porcelain. I currently have some bash tooling
that wraps bash which does useful things for primarily linear
development in the subversion world [ trunk + well-controlled branches
] and in order to ease the transition of the organization to
full-blown adoption of git, I'd like to provide some equivalents that
operate in git land.

scm unknown  [ equivalent to not added to index yet ]
scm broken [ equivalent to deleted from working tree but not index ]
scm uncommittable [ union of unknown and broken ]
scm added
scm modified
scm deleted
scm other  [ cases I didn't think of yet ]

I am happy to munge these together with bash, but I thought I'd just
+1 the general requirement.

jon.

On Mon, May 25, 2009 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jon Seymour <jon.seymour@gmail.com> writes:
>> ...
>>> I am still interested in the rationale for git-ls-files not support=
ing
>>> such an option directly, since git-diff still seems a little indire=
ct.
>>
>> Partly historical, but more fundamental reason is because ls-files
>> plumbing is about the index.
>> ...
>> Added is _not_ about comparision between the index and the work tree=
=2E =A0It
>> is between the HEAD commit and the index, and it does not belong to
>> ls-files plumbing.
>
> Having said all that, I think you might be interested in pursuing
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/97830/focus=
=3D99134
>
> Also, the following thread may serve as a food for thought; it shows =
that
> there is real need for some concise, easy to parse output for people =
who
> want their own Porcelain.
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/106122/focu=
s=3D108110
>
> In short, ls-files and diff-index _can_ give you what you want, but o=
ften
> people would want information from both, consolidated.
>
