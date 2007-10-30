From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [GIT-GUI PATCH 2/3] po2msg: ignore untranslated messages
Date: Tue, 30 Oct 2007 21:44:38 +0100
Message-ID: <200710302144.39149.stimming@tuhh.de>
References: <Pine.LNX.4.64.0710301122300.4362@racer.site> <Pine.LNX.4.64.0710301124450.4362@racer.site> <7vabq0l7wn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	spearce@spearce.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imy6O-0003ty-Mm
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbXJ3UyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbXJ3UyF
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:54:05 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:44521 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbXJ3UyE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 16:54:04 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9UKrN5N010338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 30 Oct 2007 21:53:24 +0100
Received: from [192.168.2.102] (p549001E3.dip0.t-ipconnect.de [84.144.1.227])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9UKrMkA028526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 30 Oct 2007 21:53:23 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <7vabq0l7wn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62755>

Am Dienstag, 30. Oktober 2007 20:27 schrieb Junio C Hamano:
> > Do not generate translations when the translated message is empty.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  po/po2msg.sh |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/po/po2msg.sh b/po/po2msg.sh
> > index 48a2669..91d420b 100644
> > --- a/po/po2msg.sh
> > +++ b/po/po2msg.sh
> > @@ -62,6 +62,9 @@ proc flush_msg {} {
> >  	if {$msgid == ""} {
> >  		set prefix "set ::msgcat::header"
> >  	} else {
> > +		if {$msgstr == ""} {
> > +			return
> > +		}
> >  		set prefix "::msgcat::mcset $lang \"[u2a $msgid]\""
> >  	}
>
> Is this change to fix some real issues?

I don't think to - it just makes the resulting foo.msg file smaller.

> Sometimes it is handy to be able to translate a non-empty string
> into an empty one in one target language.

Err... no, this is not the case. The semantics of an msgstr == "" is identical 
to saying "No translation exists to this source string".  Nothing more, 
nothing less. You can't specify a translation that should map a given string 
to an empty string. (If you make up a case when that would make some sense, 
usually the source string is rather weirdly chosen and should be reworded.)

Christian
