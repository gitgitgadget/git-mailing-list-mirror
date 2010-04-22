From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Useless error message?
Date: Thu, 22 Apr 2010 05:15:35 -0500
Message-ID: <20100422101535.GB625@progeny.tock>
References: <z2o3abd05a91004211417v263d5a0eg497341ddf7bd79a5@mail.gmail.com>
 <20100421221953.GA25348@progeny.tock>
 <7vwrw0573t.fsf@alter.siamese.dyndns.org>
 <20100422094153.GA504@progeny.tock>
 <4BD01E09.8080504@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Aghiles <aghilesk@gmail.com>,
	git list <git@vger.kernel.org>, Kim Ebert <kd7ike@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Apr 22 12:15:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4tRU-00011R-QV
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 12:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab0DVKP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 06:15:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48921 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab0DVKPX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 06:15:23 -0400
Received: by gwj19 with SMTP id 19so1963135gwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qVHNdNDk72q63UIAab750TzsaP87O4te4LQp4/Jmj9o=;
        b=GHIbLAjZ1ao4wYiKAmS3Fvg+/bJw7Olx66Y+abenVW6KaEqn9/GxxIkXy58r5jB/PJ
         U6CaldT47FgHx3MymSLtU2XdMES2FpNmEnNLN0BoXoC6jQIAwPmRYeQulVN8aqvjeqUz
         wZ8iqWBHqyYO1K2pwJui/kQBTz5MEreo4z3Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RuWr74z9NsBSd30jRyFXYQvJtyIuvuFWUsM614jWQbQHpGjZv3nUCWjiPP6+lq9wzd
         aANckWRCXbCXfdXKm0WjKVAz0gLpKp8wpAuHpat9Q6DWRT5knyKAKzGWj+EUg48+A40K
         /xKO6WFkOAfuCzoC4mzr9WVYIGnlmGkTH+vpE=
Received: by 10.90.233.3 with SMTP id f3mr4990322agh.120.1271931322560;
        Thu, 22 Apr 2010 03:15:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm7281752iwn.8.2010.04.22.03.15.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 03:15:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BD01E09.8080504@op5.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145515>

Andreas Ericsson wrote:
> On 04/22/2010 11:42 AM, Jonathan Nieder wrote:

>> [1] I do suspect that in the case of failing enter_repo() or missing
>> git-daemon-export-ok, saying =E2=80=9Ccannot read the specified repo=
=E2=80=9D would be
>> fine.  Most of the time, there is not much value in disclosing a mor=
e
>> detailed reason, anyway.
>
> That would make it possible for random attackers to determine whether
> a specific user exists on the system, which is very bad indeed.

I guess I am missing something.  How would

(*) $ git clone git://git.example.com/~u/foo
    remote: Cannot read the specified repo

tell me whether that user existed on the system?  If the daemon gives
the same message for ENOENT, missing git-daemon-export-ok, EPERM, and
so on so I cannot distinguish the cases, then I just don=E2=80=99t see =
the
problem.

If the daemon failed for some other reason, like a flaky network, I
would see

    $ git clone git://git.example.com/~u/foo
    fatal: The remote end hung up unexpectedly

So the extra information could still be helpful, without unwanted
information disclosure.  In the case (*) I learn definitively that the
address I specified does not represent a repo I have access to, rather
than this being some random, transient unexplained problem.

Thanks for the comment.
Jonathan
