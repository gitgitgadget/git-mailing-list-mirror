From: Ivan Chernyavsky <camposer@yandex.ru>
Subject: Re: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Wed, 05 Aug 2015 22:48:30 +0300
Message-ID: <1758741438804110@web14m.yandex.ru>
References: <349031438778845@web22j.yandex.ru>
	<xmqqmvy54qhe.fsf@gitster.dls.corp.google.com> <xmqqio8t4qf3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:55:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN4mt-0006km-V6
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 21:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbbHETzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2015 15:55:39 -0400
Received: from forward16m.cmail.yandex.net ([5.255.216.147]:49879 "EHLO
	forward16m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753093AbbHETzh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 15:55:37 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2015 15:55:37 EDT
Received: from web14m.yandex.ru (web14m.yandex.ru [IPv6:2a02:6b8:0:2519::214])
	by forward16m.cmail.yandex.net (Yandex) with ESMTP id DF85D21F89;
	Wed,  5 Aug 2015 22:48:31 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web14m.yandex.ru (Yandex) with ESMTP id 4C3621EE191B;
	Wed,  5 Aug 2015 22:48:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1438804111; bh=mezRIOcurTDgXP00sO9WlYTZslx3PLSmrkTCcCTeAgQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VolS6DWPqjzT27T6vAtLCNKcRksl7r1oYR2CYrpafQnADQss6RWOmqV4jhRrP7cq3
	 JkUTnp3B9QAyK7lXSSFQFVFJYz3x4KGjB8kxE+TA9LpTZz5ieGFzpKxtXwsJyr4Imc
	 9hbPq0YDY3XnXEK+viD0lJIjMyqB2No93SKg3ryY=
Received: by web14m.yandex.ru with HTTP;
	Wed, 05 Aug 2015 22:48:30 +0300
In-Reply-To: <xmqqio8t4qf3.fsf@gitster.dls.corp.google.com>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275391>

Sorry for empty subject in the original mail, somehow I've deleted it a=
nd didn't even notice.

05.08.2015, 20:05, "Junio C Hamano" <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> =9AI think people do things like:
>>
>> =9A=9A=9A=9A=9Agit log --all --decorate --grep=3D...
>
> s/decorate/source/; sorry for the noise.

Thanks Junio!

I was actually considering using --source, but for me the problem is it=
 always returns *just one* branch for every matching commit. So the cal=
ler must then use his own knowledge to deduce all branches where this b=
ranch merged.

Considering following history:

* b46f30e       refs/heads/zzz eee
| * dc0280f     refs/heads/yyy ddd
|/
| * 31739da     refs/heads/xxx ccc
|/
* a42bd23       refs/heads/master bbb
* 01a8291       refs/heads/master aaa

Command "git log --all --source --grep=3Dbbb --oneline" will return:

a42bd23 refs/heads/master bbb

While I'm expecting something like "git branch --contains=3Da42bd23" ou=
tput in terms of *all* topics being listed:

  master
  xxx
  yyy
* zzz

The most common use case is when support people need to quickly get at =
least rough idea which branches have specific ticket/CR mentioned.

--=20
  Ivan
