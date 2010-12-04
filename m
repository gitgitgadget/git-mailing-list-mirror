From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git reset and ctime
Date: Fri, 3 Dec 2010 19:47:51 -0600
Message-ID: <20101204014751.GA18629@burratino>
References: <AANLkTimyYTup+PqJFJ+2g-tVwWXA2bxTT3noonEuKBSu@mail.gmail.com>
 <20101204005131.GB15906@burratino>
 <AANLkTi=MSf+0rkBmvuJQBaSs1-G_gFahnLvt44fnwAwf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: ghazel@gmail.com
X-From: git-owner@vger.kernel.org Sat Dec 04 02:48:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POhEX-0000ol-2H
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 02:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab0LDBsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 20:48:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64948 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131Ab0LDBsH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 20:48:07 -0500
Received: by ywl5 with SMTP id 5so5116700ywl.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 17:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Dkpqo2hOzNPMqj7qFkgwc56OEn8P9zNyINyw8o/aRek=;
        b=ArExegwSm1G2ZpkIeso3L/GyqywCDyvtUDERa/0SAuFkfVfyvPN5KI/bWMimU0OERT
         8s2TFpiOm9cRUNwY1pb8Y47kiSBYobaryB2ZvMkSlZIG69c/SQditwADUEnvvLsrFrKQ
         /z1b1S4XwwppVco6NGR/GJJTX89edpuudSQBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PvTdJnE0ZtEOAmONkUi4zknem9cISLvN34LKPkYG4GbKQseRMHvR1zksZHI1QBSu9O
         Iwv/GvB/wF9lKl+kelDbq2hNA7A8c3J6rReTjGS4fadMCgIolR92zVk9Qfiet4LOHpo2
         N6H9pXxvukdvnvWDj3O99EshFWM8XdzkJShbg=
Received: by 10.151.145.21 with SMTP id x21mr5207516ybn.47.1291427286756;
        Fri, 03 Dec 2010 17:48:06 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id v39sm900588yba.19.2010.12.03.17.48.05
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 17:48:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=MSf+0rkBmvuJQBaSs1-G_gFahnLvt44fnwAwf@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162879>

ghazel@gmail.com wrote:
> On Fri, Dec 3, 2010 at 4:51 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>> ghazel@gmail.com wrote:

>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0My deploy process (=
capistrano) maintains a cached copy of
>>> a git repo, which it fetches, resets, and then hardlinks files from
>>> when a deploy occurs ( https://github.com/37signals/fast_remote_cac=
he
>>> ). The hardlinking step is meant to save the time of copying the fi=
le.
>>> but hardlinking changes the ctime of the source files.
>>
>> Interesting. =C2=A0Setting "[core] trustctime =3D false" in the repo=
sitory
>> configuration could be a good solution (no performance downside I ca=
n
>> think of).
>
> This is a very useful suggestion. I do not see a case where ctime
> would be valuable to me. Is it really valuable to other people? What
> is the trade-off?

Some reading for a rainy day :): [1] and surrounding discussion.

Short answer: I think the main purpose is catching worktree corruption
(e.g., if rsync screws up).

[1] http://thread.gmane.org/gmane.comp.version-control.git/89370/focus=3D=
89993
