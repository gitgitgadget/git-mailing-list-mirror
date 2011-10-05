From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 16:30:02 -0500
Message-ID: <20111005213002.GA12667@elie>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dzg2D+vmFRfLX01S2k98YZQBE0FFv76VAyPnXdetyWADQ@mail.gmail.com>
 <20111005200043.GA32732@inner.h.iocl.org>
 <CAG+J_DynQ8U6T9YMsWstKF_Cf6CSCr8b8E4T=p5uyGPh28G=kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 23:30:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZ2m-0007YW-Gl
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 23:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab1JEVaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 17:30:19 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45838 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932440Ab1JEVaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 17:30:18 -0400
Received: by ggnv2 with SMTP id v2so1119879ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 14:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J51biMCJHl8OKmpEFkycySKEc6hVL/N7aIWpbONZPOo=;
        b=PZNNat78gCr0s4V++vWtLRphRNO1IP8dAp2HpgLc8PpC1tnQlFlGVtCrlmkuQfpby7
         JrrynE95g/Im+UKGlC6kLrTFeUgh9u9NOASuxrJv4gU4FSAW2djQz9HLpaUy4MwKATb6
         DBy5jamCeeiT2s7WYsRAltwZ4Nx5I5jBogaN8=
Received: by 10.236.145.161 with SMTP id p21mr16044279yhj.123.1317850218056;
        Wed, 05 Oct 2011 14:30:18 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id f24sm4266176yhk.5.2011.10.05.14.30.16
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 14:30:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG+J_DynQ8U6T9YMsWstKF_Cf6CSCr8b8E4T=p5uyGPh28G=kA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182887>

Jay Soffian wrote:

> In my mind, we're trying to make new-workdir usable for non-advanced
> users.

I'd be happy already with making it comfortable for the advanced
users. :)

I think your patch goes in a right direction (using the shared
=2Egit/config file as a way to negotiate ownership of branches).
Junio=E2=80=99s comments about it seeming sensible to

 - make this apply to other operations that clobber a branch
 - make the =E2=80=9C[branch "master"] checkedout=E2=80=9D configuratio=
n multi-valued
   if there is to be support for "git checkout -f" overriding this at
   all

ring true to me.  Making the value of this variable the path to the
=2Egit dir or worktree (rather than an opaque string) seems like a very
good thing: it means that a future git could check if the directory
still exists and break the lock if someone has used =E2=80=9Crm -fr=E2=80=
=9D.

As for moving =E2=80=9Cgit new-workdir=E2=80=9D out of contrib, I belie=
ve another
prerequisite is sharing the HEAD reflog.

Just my two cents,
Jonathan
