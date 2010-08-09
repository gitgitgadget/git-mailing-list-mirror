From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Excessive mmap [was Git server eats all memory]
Date: Mon, 9 Aug 2010 14:17:27 -0400
Message-ID: <AANLkTimjE5qF4cTRY=63OY5WdZhp6LqGbLDhbm1hXExX@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr> <AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
 <87ocdhlgbl.fsf@kanis.fr> <AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
 <AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
 <87hbj74pve.fsf@kanis.fr> <AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
 <wesy6cgm6wd.fsf_-_@kanis.fr> <AANLkTi=6JcwLuyNWq9oYzE_E+7DSn-sEvR-X3AHvXM6U@mail.gmail.com>
 <westyn3n3sa.fsf@kanis.fr> <AANLkTiktriuvciNTNPD4941AG3th6rWwUYT4v_UnaAz3@mail.gmail.com>
 <4C603EAF.10500@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, jnareb@gmail.com, git <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 20:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiWvf-0006jR-8i
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 20:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab0HISRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 14:17:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41271 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab0HISRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 14:17:49 -0400
Received: by wwj40 with SMTP id 40so11892106wwj.1
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bl8+u43OO8anesT0NjzPvgLS5m6+r71whjziF99lRw8=;
        b=hBEjzf6yeonp4/nGYEvnqRjKF6+eHIP/uMAsUKW5ImU44siPhGkLvtXJzj8DukuypA
         RzMIlntl0CYcmLL2l7gziioLsRTvG2NBqysvjVLIM5QOjSV/HRBmy4OMidPw8PKfZvqP
         cCeAvYtS7tNAb5wQ89p9WZZ1CYu6n6bFoYHi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P+qJBWPjyCLIu/Jd8f5+7HiHI1VTvvbL1KfcL9kz7FawLkakmWIcak1RIctMx8pshJ
         aLWbqZgYcQaeinIadtGQdohjW40UHl4ZjVlOOYd0VSwxeMPbxLslEr5evLH/LaUdg6gA
         Yfc3L94+Gj/iknEIvptdJOby6NBi1X1yanD/s=
Received: by 10.216.45.6 with SMTP id o6mr2941622web.74.1281377867119; Mon, 09
 Aug 2010 11:17:47 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Mon, 9 Aug 2010 11:17:27 -0700 (PDT)
In-Reply-To: <4C603EAF.10500@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152995>

On Mon, Aug 9, 2010 at 1:45 PM, Tomas Carnecky <tom@dbservice.com> wrot=
e:
> On 8/9/10 6:50 PM, Avery Pennarun wrote:
>> On the other hand, perhaps a more important question is: why does gi=
t
>> feel like it needs to generate entirely new packs for each person
>> doing a clone on your system? =A0Shouldn't it be reusing existing on=
es
>> and just streaming them straight out to the recipient?
>
> Isn't that something that the rev cache is supposed to fix?

I wouldn't think so - at least not when cloning a repository from
scratch.  The whole idea of a clone is you ought to be able to copy
the pack contents verbatim since you should want "all" the objects.
Though maybe I've missed something... I've never read the code for
that stuff.

Have fun,

Avery
