From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Mon, 21 Jul 2008 11:59:42 +0100
Message-ID: <320075ff0807210359r31d81d63i4d0584c4a1aab4c1@mail.gmail.com>
References: <alpine.DEB.1.00.0807171513560.8986@racer>
	 <20080717182253.GZ32184@machine.or.cz>
	 <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
	 <20080718091608.GL10151@machine.or.cz>
	 <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com>
	 <20080718100048.GN10151@machine.or.cz>
	 <320075ff0807180420k4b28c317mc026713b22c44839@mail.gmail.com>
	 <20080718144325.GR10151@machine.or.cz>
	 <320075ff0807180809x599aefafw2c7fe88fea2691d2@mail.gmail.com>
	 <20080718154959.GS10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 13:00:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKt8G-0001XV-Pc
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 13:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbYGUK7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 06:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYGUK7p
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 06:59:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:42318 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbYGUK7o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 06:59:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so440224nfc.21
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 03:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Nit3t6b2ORWo2I3LjnZuT06ZaP1Y1he843P11lYINyM=;
        b=ogJD3ubmBixAG4yjnSIvlVuBTSk1cUuycBPiZPLbw21DdrHimUULlsKV5ac97y264E
         0rTwv9aFmSpAJDrByPp8G1gHdCQOPU3by66bRw2XpRoa5izBvfo/dIVZbelvFNdnYNHM
         PzrhZkD9SNVMjub5pSMFdewMxIMypl1s2WYxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=p4+Fg4mRWbfJYknte2quuYOcvIZm8uclW05CJ7WIzW6K0uYXs4fKi0X0W1vVRqotzD
         /4aGmrEVdK9VjDdWZCCRnZbYKbtug6LUe+Yd8PLtI2j25uO2rv3XDNtHxnyPpmAqb0vp
         DHc3iqfUrB1tbmM/Q+uqBRKMLHztimy2ZnpGU=
Received: by 10.103.215.17 with SMTP id s17mr2460366muq.61.1216637982657;
        Mon, 21 Jul 2008 03:59:42 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Mon, 21 Jul 2008 03:59:42 -0700 (PDT)
In-Reply-To: <20080718154959.GS10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89341>

> In that case you would need the "URL mappings", perhaps as a per-remote
> attribute. That is, you could configure:
>
>        "When I am doing git pull fred, do git submodule update but
>        apply remote.fred.subrewrite sed script on each URL before
>        fetching the submodule."
>
> Still, that feels quite hackish to me, and I'm not convinced that your
> workflow cannot be adjusted so that users merge only the next-to-last
> commit of a branch instead of the last one.
>

Hm - I'm still disliking having 'special' commits to change
.gitmodules. I can hack scripts to make it work, but it would be nice
to have a UI that is generally useful.

Thinking out loud, could we have in .git/config something like

[submodule "moduleA"]
   url = git://origin.com/path/to/.git  # Current place of origin
   fred.url = git://fredcomputer/path/to/freds/moduleA.git # where
fred declares moduleA to come from
   local = git://myhost/working/copy/super/moduleA/.git # where other
people can get access to *my* moduleA repo

So if I look in the git repository of fred (as specified in my [remote
"fred"], I can see their "local" entry, and enter that as fred.url in
my config

And the ability to do (e.g)

$ git submodule init fred
$ git submodule update fred

?
