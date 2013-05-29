From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Thu, 30 May 2013 01:49:17 +0530
Message-ID: <CALkWK0=kA8mPt-8h8dYS9HrOcF1tx=0Pj-=jFHfa_UxdC=ehPQ@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
 <CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
 <CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
 <CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com> <7v38t5sg7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:20:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhmqo-0006Eg-47
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 22:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966743Ab3E2UT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 16:19:59 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39456 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965519Ab3E2UT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 16:19:57 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so5595350iea.3
        for <git@vger.kernel.org>; Wed, 29 May 2013 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=82HPepx6xc6bCgtXT6Bpu2f6dt4B7smjfXKFR8w4Oi4=;
        b=NbAvAHmj4W4lF6PLGZ018iQwoNXbKB4Rm/NJLOaFc9xg8IkbtckZFA5jQDiVzjx23m
         rekMr2+T+C0nqUjkwKKy38Pq7qvB70dr+WuXjZI0Djj5KuO/fGMFXc3qJ+QeJEs9G8yP
         jnm3s9/ywfCeLY2/Iz5SgRkVGk2gKN0qI5k0+cihKKVNvJtRcqArIHWuX76HicIselNs
         uftvTZD6liEncUaR2IoBGBO47jzWDJQPnduUvztJPHMGi8ArOPoSx8B0aM8L3xqbLvgY
         DWcCMZSJboXLEzmzbDYSgxjKki+hQJMZZOytPupscZAJ0SFJjsP/w3ld3OYkBXp/LjOr
         HUQw==
X-Received: by 10.50.153.6 with SMTP id vc6mr10087098igb.57.1369858797227;
 Wed, 29 May 2013 13:19:57 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 13:19:17 -0700 (PDT)
In-Reply-To: <7v38t5sg7k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225885>

Junio C Hamano wrote:
>> Some Git commands expect to be in the top level directory (e.g. git blame).
>
> "Git" things we can fix [*1*], but more importantly, build structure
> of many project may require you to go up to the top to build the
> whole thing, so being able to get a relative path to the top when
> you are deep inside is a necessity.

How is the project built?  When I type `make` inside Documentation/, I
want documentation to be built.  When I want a toplevel-build, I use a
custom git-make function (which does a cd before calling make).

> [Footnote]
>
> *1* "blame" is an oddball (and I suspect the recent log -Ln,m:path
>     may share the same) in that it really wants a concret path, not
>     a pathspec, so you cannot even say
>
>         cd Documentation; git blame :/Makefile

*scratches head*

  cd Documentation; git blame ../Makefile

Isn't this how pathspecs are specified everywhere?

  cd Documentation; git log ../Makefile
  cd Documentation; git log -L0,10:../Makefile

What is the difference between "concrete path" and "pathspec"?
