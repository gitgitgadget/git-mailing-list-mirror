From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 08:32:48 +1000
Message-ID: <BANLkTikSsoCP_d34wdBHX=r336zJSHSWEQ@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:32:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFDHz-0005eD-Nd
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 00:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964Ab1D0Wcv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 18:32:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab1D0Wcu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 18:32:50 -0400
Received: by eyx24 with SMTP id 24so657958eyx.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jkIisUD7v5L3Y1KSfezQlfnAGIc7KBsbE05g52hCq9k=;
        b=AQQdODnZBY5aTSLlIK50aMUuZwJoY0Xt1tfu2ZHbCMsZ2XEanEJ+ZkiMoMT4f4ofhv
         qSFxlH8Kz0Oc9yXOCV6W7Feg2RCSzJDO/mOSvmVUyftWqmoOJ83cdKSHFuvo+UjbV1BW
         OxDP9bv1JYRVZbzXlXcTwZxMOS9r/4/Tg9e40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yHxr2No2D2O4znvr0hcTXV1mumfs6mOGTnfJiHmxiN2JusVwY5Hw7Eo3lbhU5PQNLl
         398QGR+mwn2ySIQSsVcHuSAulxfPBaqGPL4qSDca3/sYtU8//6h1U75dal8r/GpUABND
         s/Xq6rWHU4Bs2HmTZMpIDDebkFveIPIbMpTfE=
Received: by 10.14.52.65 with SMTP id d41mr1309334eec.85.1303943568657; Wed,
 27 Apr 2011 15:32:48 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 15:32:48 -0700 (PDT)
In-Reply-To: <20110427220748.GA19578@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172282>

On Thu, Apr 28, 2011 at 8:08 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Junio C Hamano wrote:

> Or is the idea to blindly install (a symlink to) git-work to $(git
> --exec-path)/ rather than a place on the $PATH? =C2=A0In this case, I=
 would
> be a little worried. =C2=A0How will the helper deal with uninstallati=
on and
> with namespace conflicts? =C2=A0(On the $PATH, these are expected pro=
blems
> and I'd expect each user has some way of dealing with them already.)

I see 'git pm activate' managing symbolic links in a directory
dedicated to the purpose (.e.g. ~/.git-pm/activated).

One thing 'git pm activate' could do is check that the commands
exported by the 'gitwork' descriptor do not conflict with what is
already activated.

If the user has done something like:

    git clone https://repo/gitwork.git ~/hub/gitwork

and then:

    git activate pm ~/hub/gitwork

the symbolic links would be established to ~/hub/gitwork, wherever
that happens to be.

If the user has done:

   apt-get install gitwork

then given a package-manager adapter for apt-get, it could extract the
=2Egpm file from the list of installed files, and resume activation fro=
m
there. Ultimately, the end result is the same ~/.git-pm/activated is
updated, it has always been on the paths it needs to be.

If the descriptor did have a list of exported commands (e.g. git-work,
git-base, git-atomic, git-test), then a global registry could use this
list of exported commands to detect conflicts early - at package
registration time which might help avoid grief down the track.
