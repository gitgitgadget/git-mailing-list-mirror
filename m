From: Jens Seidel <jensseidel@users.sf.net>
Subject: Re: [PATCH/WIP] git-svn: tweak log format to match "svn log" output
Date: Sun, 25 Jul 2010 11:09:46 +0200
Message-ID: <20100725090943.GA1998@merkur.sol.de>
References: <20100423134611.GA3440@merkur.sol.de> <20100426132710.GA9930@progeny.tock> <20100427112656.GB16323@merkur.sol.de> <20100725023114.GB18606@burratino> <20100725081057.GA22373@dcvr.yhbt.net> <20100725083708.GB22213@burratino> <20100725084057.GA23621@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Seidel <jensseidel@users.sf.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jul 25 11:10:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcxET-0007on-UK
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 11:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab0GYJKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 05:10:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37811 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0GYJKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 05:10:48 -0400
Received: by wyf19 with SMTP id 19so1419013wyf.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mail-followup-to:references:mime-version
         :content-type:content-disposition:in-reply-to:sender:user-agent;
        bh=CaeqCY426EMTkvZdm7cJ+SHV1iHoA76LS9Ag4HKoEn0=;
        b=wPE5o6gTU9DISku41Y0tFyy/02t9cr14FHz36n9gcdeNV96mGsdeJf3uauNI8GNlTC
         qv4wW4Glnepy3Zj4mJne5ZzDdQYgXkBhnwKlwRn/EXD143Gkyzv3WwHEc4guVtdUzRpo
         DTIQmdjxwruJWDvcHoUkj1sMJySWPWt44ZaDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to:sender
         :user-agent;
        b=xnmzxkhVlBCiAfXHEd5br67ex2/Z6DFNlspTnF6EGGCBd+pMNGnj/p4Xegwxl81x1g
         I2hGhvrb2OwdYjKBAYr4OBrL2tgmBDbmFLWQn+CPVE9ng6cvCBtcjCPtdPLSR1tsyNf6
         6D1EfnSXis3WJTBlsR6VwOeZI0pymGSIiZp90=
Received: by 10.227.145.66 with SMTP id c2mr5814971wbv.42.1280049047439;
        Sun, 25 Jul 2010 02:10:47 -0700 (PDT)
Received: from merkur.sol.de (p4FD7103F.dip0.t-ipconnect.de [79.215.16.63])
        by mx.google.com with ESMTPS id i25sm1973703wbi.22.2010.07.25.02.10.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 02:10:46 -0700 (PDT)
Received: from jens by merkur.sol.de with local (Exim 4.69)
	(envelope-from <tux-master@web.de>)
	id 1OcxDO-0000Zw-TY; Sun, 25 Jul 2010 11:09:47 +0200
Mail-Followup-To: Jens Seidel <jensseidel@users.sf.net>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20100725084057.GA23621@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151717>

On Sun, Jul 25, 2010 at 08:40:57AM +0000, Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:
> > diff --git i/git-svn.perl w/git-svn.perl
> > index 5252722..75e7165 100755
> > --- i/git-svn.perl
> > +++ w/git-svn.perl
> > @@ -5644,8 +5644,8 @@ sub show_commit_normal {
> >  
> >  	if ($can_localize) {
> >  		my $d = Locale::gettext->domain("subversion");
> > -		$sing_fmt = $d->nget($sing_fmt, $plur_fmt, 1);
> > -		$plur_fmt = $d->nget($sing_fmt, $plur_fmt, 10);
> > +		$sing_fmt = $d->get($sing_fmt);
> > +		$plur_fmt = $d->get($plur_fmt);
> >  	}
> >  	if (my $l = $c->{l}) {
> >  		while ($l->[$#$l] eq "\n" && $#$l > 0
> 
> Thanks Jonathan, that looks much better.  I'll squash that on top
> Jens' first patch.

No, this is still wrong, we have to use $d->nget as some languages can have
multiple plural forms. Russian e.g. has two: one if the last digit ends with
2-4 and a second one if it ends with 5-9. Exact rule:
"Plural-Forms:  nplurals=3; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 &&
n%10<=4 && (n%100<10 || n%100>=20) ? 1 : 2);\n"

That's why it's wrong to use $plur_fmt at all (and also "10" from above
makes no sense). Let's use:
$d->nget(" | %d line", " | %d lines", $nr_line), $nr_line)
where $nr_line is the variable.

Sorry for not providing a patch now but I need more time ... I suggest one
of you try it again and I check it :-)

Jens
