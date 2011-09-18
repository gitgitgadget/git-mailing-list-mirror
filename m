From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: Branch deletion (Re: [RFC] fast-import: note deletion command)
Date: Mon, 19 Sep 2011 03:54:17 +0600
Message-ID: <CA+gfSn_e3yY9eQ6O1zMdTituZMAv+a0AtF4cKrEOvBwY63pihA@mail.gmail.com>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
	<20110918203506.GG2308@elie>
	<CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
	<20110918211836.GI2308@elie>
	<CAGdFq_gH=u1BU6k3Z23Lo9mOSE4Rq-6nWU0EE91CQNpxksGw5w@mail.gmail.com>
	<20110918214954.GL2308@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5PJe-0006UC-Oh
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688Ab1IRVyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 17:54:19 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60150 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab1IRVyS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 17:54:18 -0400
Received: by qyk30 with SMTP id 30so2194790qyk.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7sbpGbYKjwMvZ82UfjsKguS+KzsshUtxyWrEH2klis0=;
        b=IRoxbUnHV6s3ppEdbZ2V0ywqH4uu71zizneBKR08ibuHFM/KWtiRSCqvWvGTJIT97j
         FzczS1jTNBewcrbUKlUBiQXx4B+khKqgtFTGDNBtD4QGmUnnCoo/TGXiTVyeuo52Mim9
         o0GPS8LKLyzkQlMJ86G1w9cXH1zoExvaV2yEM=
Received: by 10.229.69.206 with SMTP id a14mr1418731qcj.54.1316382857395; Sun,
 18 Sep 2011 14:54:17 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Sun, 18 Sep 2011 14:54:17 -0700 (PDT)
In-Reply-To: <20110918214954.GL2308@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181652>

On Mon, Sep 19, 2011 at 3:49 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Sverre Rabbelier wrote:
>
>> The problem currently is that when
>> you try to "git push origin :experimental-branch", there is no way f=
or
>> the transport-helper code to tell the helper to delete the ref.
>
> Ah! =A0Thanks for explaining.
>
> It also occurs to me that
>
> =A0 =A0 =A0 =A0reset refs/heads/experimental-branch
>
> =A0 =A0 =A0 =A0... rest of the fast-import stream comes here ...
>
> could be used as an especially non-self-explanatory way to express
> this kind of thing. :) =A0No idea whether that works already.
     feature force
     reset refs/heads/experimental-branch
Will be close. It'll overwrite the branch if any commits are done to
it. But will
keep it as is in case it's not touched in the rest of the fast-import s=
tream.

> A deleteref command and deleteref feature documented to be meant for
> this purpose sound handy to me.
>
> By the way, what does the "export" command do in the following
> situation?
>
> =A0 =A0 =A0 =A0git push origin something-big:master
>
> Does it assume the remote-tracking branch for master reflects what's
> available on the other end and send a stream for
> origin/master..something-big, or does it send the entire history of
> something-big?
>
