From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 3/5] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Sun, 13 Jan 2008 14:38:52 +0800
Message-ID: <46dff0320801122238k3c2d93f3x4faf2e08f48c43fe@mail.gmail.com>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	 <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	 <62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	 <bce0ee9fde688c27fc788fab91a571184918da67.1200122041.git.pkufranky@gmail.com>
	 <7vabnbv3sb.fsf@gitster.siamese.dyndns.org>
	 <46dff0320801120151s7959edddp1e1f8b506da79e4e@mail.gmail.com>
	 <7v4pdiua4k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 07:39:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDwV9-0005Jd-VT
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 07:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbYAMGiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 01:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbYAMGiy
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 01:38:54 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:3726 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYAMGix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 01:38:53 -0500
Received: by py-out-1112.google.com with SMTP id u52so2409895pyb.10
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 22:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GddgL2lM4rs00ACoV9RG40xSK7AQX49QHPaTwPu4KGk=;
        b=LRCX8e4y04j9/zS9A23te3E8yFK+2e5XEDHES3mE5vK0Nmj0kYsSxxDJ/d3vpQv8BlGUzjR5E2pwOGqhPd4jYK97WwoYqpKr6l0Vq3oAK53R0Xnw7IOm+1UErM43Gx4+kaWKLmruDwFsE6uF6234CfAXg9dHF1G87NtD0/QqT4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aq0xoRnmtbIBHHvjFT13Awk1zz1mU2d7EDT7kf9cZghAHxurPa2ntdyT/SFQG3DqwNnQtALF2IIhz8mwFCM/QEVfDQbPF3Wic/h/ehamgUZ1XTGhhraaP4eXcqab1C6857F6cOOesi+wTgnD5VYstodAW2+p6m8i8uH5QCyrWsk=
Received: by 10.35.98.3 with SMTP id a3mr6013272pym.22.1200206332415;
        Sat, 12 Jan 2008 22:38:52 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 12 Jan 2008 22:38:52 -0800 (PST)
In-Reply-To: <7v4pdiua4k.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70371>

On Jan 13, 2008 3:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
> > On Jan 12, 2008 4:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Ping Yin <pkufranky@gmail.com> writes:
> >>
> >> > @@ -265,6 +267,10 @@ set_name_rev () {
> >> >  #
> >> >  modules_summary()
> >> >  {
> >> > +     summary_limit=${summary_limit:-1000000}
> >>
> >> Why a million?
> > Because i think a million is big enough. I'd better define a constant
> > for unlimited number.
>
> I think that is a wrong approach to begin with.  You are
> assuming that you will always limit and by using improbably
> large limit to pretend it is unlimited.  Why not making the
> summary list generator truely capable of produce an unlimited
> list?
>
I used a pseudo unlimited number just to make code shorter.
After considering it again, i find that the code is still brief  by using
a real unlimited number. So i'll correct it.

> I also think using 100 or so as a sane default, allowing the
> user to override to say "I do not want any limitation", is a
> much better default.
>
Reasonable



-- 
Ping Yin
