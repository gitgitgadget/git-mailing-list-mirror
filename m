From: John Clemens <clemej@gmail.com>
Subject: Re: mirroring and development with three levels of repositories?
Date: Tue, 28 Sep 2010 21:58:46 -0400
Message-ID: <AANLkTimg9NKbL033Et9CgKw_KUZ97oDSCy2Wh7mz2p5E@mail.gmail.com>
References: <AANLkTinFiOA6Grzk16W2D=k8Xt+EgTanrS7iryW2evop@mail.gmail.com>
	<20100928173710.GA31419@nibiru.local>
	<AANLkTin2UPUPn5Sr=7dqT5bxFB7a-BYFzJhGV74r6taF@mail.gmail.com>
	<20100928184116.GA27401@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 03:58:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0lwf-0007E7-3A
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 03:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab0I2B6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 21:58:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50005 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0I2B6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 21:58:47 -0400
Received: by bwz11 with SMTP id 11so228356bwz.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 18:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=OtQaI00Il7qQnyoiEpywf5AAnl3uoi8oBnO87kOpVog=;
        b=CVF5py4rBTpemkvC3hkuBi4FqhgRFJJQLLDxRHjFg1x7p2t17QECQlB/ByGsELPjnb
         7ZcExwycx88YZOL1sArjkHbhP0wcP2X+c0vXuFQEgnyjdNwRttl9CyzyrLFs9c5mT+zT
         90tO+EedEzm/y5f0/WllLEpu0Z4lcO9dMQG7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=TYbscqzMEmnU9EbTIqEQDShZ36OLkvrxe7XIszsUjTpzfOGoB0N6CFNvoBAdtctxEe
         oQ8jiCB1nVQIy8V3xeYOd1gh8Ltb6M1JPr5TYws/oicA8hpxHbkV41Pak40DLU08Vwro
         UPyWgfv7nqKseQplXfJv77A5Z7hJg03g6ZYKg=
Received: by 10.204.55.211 with SMTP id v19mr628222bkg.153.1285725526482; Tue,
 28 Sep 2010 18:58:46 -0700 (PDT)
Received: by 10.204.153.10 with HTTP; Tue, 28 Sep 2010 18:58:46 -0700 (PDT)
In-Reply-To: <20100928184116.GA27401@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157519>

Wait.  I just set up some dummy repositories in a working directory
that mirror what we're trying to do, and it all worked.  I created a
dummy "upstream" repo with some branches, then a local mirror repo
with 'git clone --mirror'.  I'm able to check out from the local
mirror, add "local" branches and push them to the mirror repo, and
able to then commit to those "local" branches, no problem.

Since it all seems to work locally,  I suspect a problem with our
webdav git server.  I'll check that out tomorrow.  Thanks for the help
and sorry for the noise.

john.c

On Tue, Sep 28, 2010 at 2:41 PM, Enrico Weigelt <weigelt@metux.de> wrot=
e:
> * John Clemens <clemej@gmail.com> wrote:
>> > [remote "origin"]
>> > =A0 =A0url =3D ...
>> > =A0 =A0fetch =3D +refs/heads/*:refs/heads/origin/*
>> > =A0 =A0fetch =3D +refs/tags/*:refs/tags/origin/*
>>
>> Hmm.. I do actually see the branches on dev machine. =A0When I clone=
 from our
>> local mirror, everything works fine UNTIL I create a new branch and =
push it
>> to our local mirror. =A0From that moment on, all new clones fail (mo=
re precisely,
>> they do download all the blobs, but the refs only point to the newly=
 created
>> branches, and HEAD is messed up.
>>
>> config on the local mirror is this:
>>
>> [remote "origin"]
>> =A0 =A0 =A0 =A0 fetch =3D +refs/*:refs/*
>> =A0 =A0 =A0 =A0 mirror =3D true
>> =A0 =A0 =A0 =A0 url =3D xxx
>
> Ah, maybe it corrupts refs/HEAD somehow ? What does it point to ?
>
> Perhaps you better don't fetch the whole refs/* but refs/heads/* and
> refs/tags/* namespaces separately (as described above).
>
>> On the local mirror, HEAD is:
>> ref: refs/heads/xxx/stable
>
> Does that ref exist there ?
> What does it tell on the upstream (big central) repo ?
>
>
> cu
> --
> ---------------------------------------------------------------------=
-
> =A0Enrico Weigelt, metux IT service -- http://www.metux.de/
>
> =A0phone: =A0+49 36207 519931 =A0email: weigelt@metux.de
> =A0mobile: +49 151 27565287 =A0icq: =A0 210169427 =A0 =A0 =A0 =A0 sky=
pe: nekrad666
> ---------------------------------------------------------------------=
-
> =A0Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
> ---------------------------------------------------------------------=
-
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
John Clemens <clemej@gmail.com>
