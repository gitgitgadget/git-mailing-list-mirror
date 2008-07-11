From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 18:44:23 +0400
Message-ID: <37fcd2780807110744k3b2a332csdf788dabd172622c@mail.gmail.com>
References: <200807102057.15063.toralf.foerster@gmx.de>
	 <alpine.DEB.1.00.0807102028420.18205@racer>
	 <200807111539.06606.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Toralf_F=F6rster?=" <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHJsB-0001Tg-Cr
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 16:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbYGKOoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jul 2008 10:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbYGKOoZ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 10:44:25 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:35740 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbYGKOoY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jul 2008 10:44:24 -0400
Received: by rv-out-0506.google.com with SMTP id k40so4443205rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xv9tfCZ73uaFh8CXypEvunYEYOcJ3DAXYTgkXJmKplI=;
        b=rYDtiCKTuVn/0WptMVgY0iqZ1ASDzarPCUIDBTj2m//tgILVGpB/rQ50FFarpjNy/T
         9k374jCMqyzPXQUNwpl0Newv9GoYozvALVwJsL+gA2c0oni1vFIVcdn3rWsaiUdrN/14
         zXK8jWNgnjC0GRQ31Saj6xZ0NF41x/Zfa9g94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ZNRrqKUT0EvU8ZnGtF4c1IoJI6dAIPUjex4pXt4YYvllFO9bX9wT975TIzMvt8pTkS
         xyJzuRNYOS4LCJ2CKlfH8D9yOpA86CPcgRJCPJF7R55y0oGBgvQe0sGoNlukQnUKcg1Y
         IMKe44+i51cWu78Fj+AetomF4J1Xb1Jx2Mzzw=
Received: by 10.115.76.1 with SMTP id d1mr13923636wal.196.1215787463211;
        Fri, 11 Jul 2008 07:44:23 -0700 (PDT)
Received: by 10.140.126.10 with HTTP; Fri, 11 Jul 2008 07:44:23 -0700 (PDT)
In-Reply-To: <200807111539.06606.toralf.foerster@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88123>

On Fri, Jul 11, 2008 at 5:39 PM, Toralf F=F6rster <toralf.foerster@gmx.=
de> wrote:
>
> Ok, following the thread I understand why this feature isn't wanted b=
y all. But
> for the given example (where I only pulled from another git tree) thi=
s could
> work, isn't it : ?
>
> tfoerste@n22 ~/devel/linux-2.6 $ git-log v2.6.26-rc9.. | perl -e '@c =
=3D grep { /^commit/ } <>; print map { $#c - $i++ . "\t" . $_ } @c'

No, it does not. Running your script, I have

=2E..
56      commit 803a9067e19714ea7b7da760fe92f0d53bfa6994
=2E..

Now, let's see what git-describe thinks about it
$ git describe 803a9067e19714ea7b7da760fe92f0d53bfa6994
v2.6.26-rc9-38-g803a906

Your script is obviously incorrect. It is written in the assumption tha=
t
history is linear, but it is not. Even if you pull only from one repo,
this repo still contains *many* branches. Along any branch, you may hav=
e
the same number.

Dmitry
