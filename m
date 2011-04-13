From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: is hosting a read-mostly git repo on a distributed file system practical?
Date: Wed, 13 Apr 2011 14:57:10 +1000
Message-ID: <BANLkTi=cE4=EC0C4MA5iac6_O-YMsW_SLg@mail.gmail.com>
References: <20110413034715.15553.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 06:57:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9s8h-0007TQ-VV
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 06:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab1DME5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 00:57:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64364 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1DME5K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 00:57:10 -0400
Received: by iwn34 with SMTP id 34so248997iwn.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YXXxf6H126sHLxM1kHPkWbfL7vxPa70gzy8fLeDpY2w=;
        b=eTZUgaTSC/mHU0epW2Ik1wvZ38j2nnjRjPIMejjkBSf86fqrYxocgEYAJzpckZb2kM
         VOg0Z3XVaFqbtoVo9ATcp+93pfpoaunvtU2pfeo0oQ0DaZvH0am+RPC26vlk3vfvMDoQ
         3Z2X6Ugs/v1oKONQi87Qf09XaloX3XRFwMBzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n86C1e2hOdoLMDaAZoU/TodtxP5DiCOCqi56U3wwrkRZq/EHzSMEdfmqCAMmL2hphh
         cXsMXePZTZsmkseDZrgdINpdQqycprPm4DGOrl7cchr81qSXyjyYya+hbdoFI3SaDeLg
         zylpwqAIEy/V64kBFkt5Wq+SewiHaw2iAXRno=
Received: by 10.43.48.6 with SMTP id uu6mr11892041icb.325.1302670630071; Tue,
 12 Apr 2011 21:57:10 -0700 (PDT)
Received: by 10.42.218.68 with HTTP; Tue, 12 Apr 2011 21:57:10 -0700 (PDT)
In-Reply-To: <20110413034715.15553.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171433>

On Wed, Apr 13, 2011 at 1:47 PM, George Spelvin <linux@horizon.com> wro=
te:

> I think the answers are yes, but I have to make a vouple of things cl=
ear:
> * You can *definitely* control repack behaviour. =C2=A0.keep files ar=
e the
> =C2=A0simplest way to prevent repacking.

Good.

> * Are you talking about hosting only a "bare" repository, or one with
> =C2=A0the unpacked source tree as well? =C2=A0If you try to run git c=
ommands on
> =C2=A0a large network-mounted source tree, things can get more than a=
 bit
> =C2=A0sluggish; git recursively stats the whole tree fairly frequentl=
y.
> =C2=A0(There are ways to precent that, notably core.ignoreStat, but t=
hey
> =C2=A0make it less friendly.)

Bare. Developers use local disk for local repos and working tree.

> * You can clone from a repository mounted on the file system just as
> =C2=A0easily as you can from a network server. =C2=A0So there's no ne=
ed to set
> =C2=A0up a server if you find it onconvenient.

Are there advantages to using rsync for the initial clone? Will I get
better restartability in the case that the network is less than 100% re=
liable?

I do remember trying to use a DFS-file system in the past, before I und=
erstood
pack management properly and I seem to recall issues with network relia=
bility.

> Indeed, you could easily do everything via DFS. =C2=A0Give everyone a=
 personal
> "public" repo to push to, which is read-only to everyone else, and le=
t
> the integrator pull from those.
>

I'll probably use ssh-secured peer to peer for publishing purposes.
The main thing I want
the DFS-hosted repo for is to provide a single, always up, go-to point
for the shared tag set.

>
> Anyway, I hope this helps!
>

Yep, thank you.

jon.
