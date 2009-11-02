From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Binary files in a linear repository
Date: Mon, 2 Nov 2009 19:52:15 +0300
Message-ID: <20091102165215.GD27126@dpotapov.dyndns.org>
References: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org> <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de> <20091102154831.GC27126@dpotapov.dyndns.org> <20091102160903.GA6197@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 17:51:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5086-0008CL-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 17:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbZKBQvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 11:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZKBQvQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 11:51:16 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:43672 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844AbZKBQvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 11:51:16 -0500
Received: by bwz27 with SMTP id 27so6517330bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XdaUqKIatBARDOXXz8FAr2b2A8/xI+jf18L6dTuyhZI=;
        b=SKnozmuUDf5O6IHskbuzeWI3jZTpwNJ/RsYqfHsylvNqd7q2FsZxLrrQ48SVAFb6CL
         Yd7ZtGKH7asPR4DOnEg1vUQI/b/l4m/shKE4HG1TRUlhuTRiwP6jK859chFf1zSaXEqt
         i7Vrq3gAG5WuF+rpqYXt4X3cejS5tmAAg8Bzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=gFBk1D2oK5BeT+aY8AKMbHMbflCsojc/qUyJ14haQTUg5f5zEveEbx9utCzztZzZWh
         LYRKPRZjBd9PyOF2Hz2lz/sT8hgCBSYvF1qeVqtGD109oF2AaCg97Mq0apxOp0KMtBHl
         AWTKLkkF38ZZF/1AEU1yC5UtroVw/aZTHFfX0=
Received: by 10.204.34.3 with SMTP id j3mr4119077bkd.23.1257180679398;
        Mon, 02 Nov 2009 08:51:19 -0800 (PST)
Received: from localhost (ppp91-77-227-241.pppoe.mtu-net.ru [91.77.227.241])
        by mx.google.com with ESMTPS id 14sm675165bwz.1.2009.11.02.08.51.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 08:51:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091102160903.GA6197@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131924>

On Mon, Nov 02, 2009 at 05:09:03PM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.11.02 18:48:31 +0300, Dmitry Potapov wrote:
> > On Mon, Nov 02, 2009 at 04:08:25PM +0100, Markus Hitter wrote:
> > >
> > > Now I'm thinking about a much simpler solution: Simply declare th=
e =20
> > > current set of files as (a modified) master/com005 and commit the=
m. A =20
> > > "cp $GIT_DIR/master $GIT_DIR/HEAD" followed by a commit would do =
it.
> > >
> > > Now my question: Is it safe to tweak the files in $GIT_DIR this w=
ay or=20
> > > will this corrupt the repository?
> >=20
> > You probably should use 'git update-ref' if you want to change HEAD
> > manually. But it seems to me that you do not need even that. All wh=
at
> > you need is:
> >=20
> > $ git reset --soft master
> >=20
> > and then commit your changes (git reset --soft does not touch the i=
ndex
> > file nor the working tree at all).
>=20
> But then you still have to do:
> git checkout master
> git merge HEAD@{1}
>=20
> To actually update the "master" branch head. The reset doesn't re-att=
ach
> HEAD.

You are right... I forgot about that somehow. So, it should be

$ git reset --soft master
$ git checkout master

and only then

$ git commit


Dmitry
