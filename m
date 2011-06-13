From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2] revert: Implement --abort processing
Date: Mon, 13 Jun 2011 15:28:06 -0500
Message-ID: <20110613202806.GD11454@elie>
References: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
 <20110611112213.GA25268@elie>
 <BANLkTi=T0wCg1bKzmtQEQ-J-5ogqRZaqRg@mail.gmail.com>
 <20110612122145.GA20495@elie>
 <BANLkTi=gYSJgG-Yu-+-5wPetpb0-AW=X+g@mail.gmail.com>
 <20110612221217.GA2789@elie>
 <BANLkTim2SOAp3=g_zie-oi2=A9X7NVd5qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 22:28:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWDkA-0005uL-9H
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 22:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327Ab1FMU2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 16:28:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42241 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1FMU2M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2011 16:28:12 -0400
Received: by iwn34 with SMTP id 34so4115321iwn.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 13:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7WjTfQBRmGJUDkmY1CDhbYMZcKGq1MTDzdqwJsLHz9k=;
        b=gxS1c0kYFpfMdyiVpG7Us9EedbsbqEDA1u7mz+8GQ9MCbBk47/EYJLX6or7xaAo9Ef
         L1fxaJYh9OTekKe6Xq0jt/uDlLBGuJvORcoO+DyHgZYAWWElVrp7GHlBEwIfmpnSuwMv
         jxLYfHE2Z0/gyuHQR+chpPfxUamSWhEfTJ4mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GrJgpY+8HVmQnimyefvEGaXTApGiks/NGsmagnlnGHVXLhnqmjPxNN78bQBfbTZmZk
         m4x5XENxrYJFJPmGwEiif2Ywwh7jzG3ewsChjdefqCk3VC8J/uI1LIRrH2T1wggvVkBJ
         QDnbV9Cd2T9xp/9EQJY+qgON4beKfhLeY2sXs=
Received: by 10.231.212.154 with SMTP id gs26mr5933282ibb.121.1307996891286;
        Mon, 13 Jun 2011 13:28:11 -0700 (PDT)
Received: from elie (adsl-68-255-110-0.dsl.chcgil.ameritech.net [68.255.110.0])
        by mx.google.com with ESMTPS id v16sm2944468ibe.51.2011.06.13.13.28.08
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 13:28:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTim2SOAp3=g_zie-oi2=A9X7NVd5qw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175730>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> If you are thinking "I would never use 'git cherry-pick --abort' ---=
 I
>> would just look in the reflog for a commit to 'reset --hard' to", th=
en
>> you are *done*. =C2=A0Just document it, make sure the reflog has use=
ful
>> content to help out, and wait until someone complains and adds a
>> shortcut they like.
>
> Ah, thanks for the helpful advice. I'll stay away from deciding
> end-user interfaces altogether, and just write in the infrastructure
> for sequencing commits with a minimalistic UI. People can add more
> later :)

Well, until "later", this minimalistic UI is an end-user interface.
So just for the record, this does not mean you are free from writing
documentation or thinking about processes that humans use for work.

That said, following a "worse is better" approach and just getting
something simple working (meaning "operable by human beings but not
necessarily perfect") before adding the bells and whistles certainly
makes sense.  I'm not unhappy with that outcome.
