From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Gmail and unwanted line-wrapping
Date: Sat, 6 Feb 2010 19:50:35 -0500
Message-ID: <76718491002061650ge299426s22de5e00b26af108@mail.gmail.com>
References: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
	 <fabb9a1e1002061247k7a8fba5at4c687faac0dcabb8@mail.gmail.com>
	 <20100207002413.GA14744@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 01:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdvMI-0005BS-4N
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 01:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810Ab0BGAug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 19:50:36 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:44801 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132Ab0BGAug (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 19:50:36 -0500
Received: by iwn27 with SMTP id 27so851152iwn.5
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6xf/+Q+1HkG7q/spuhPC1t6KyzO1uJgI30c+G2sd3pY=;
        b=OaoPylSlh/TZxfASx4BexcxJfMyCT1pRWo2pwFEKip954XZaRrbc42R7lp3hJccgyl
         gbbitMZNeJmLf8UirmRakUDN5bTGeN4LoxMbFSMgIAdqqrxVHs3yvL3O7sMJ1eMNBzzo
         vHFaX4nek+OlvjbLr51gHPJUzn04ICppC0kp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JHmGRaTHL2HuKlfisbacTGtfWWMyN1VyUBQPzwWS3ENSY/8PSU+hTa5poplfNo0hFD
         Cb9i9+U2OQBppl0Q0VTOfmJz134WpSFrYQ/1Q3iqydGA6oXjcOEZrc8+tLEHqPiCgKpf
         zuLzoEdLhgs0ZqUtz0Wx38OOFRfZCg1jDsbR0=
Received: by 10.231.168.136 with SMTP id u8mr4755616iby.56.1265503835398; Sat, 
	06 Feb 2010 16:50:35 -0800 (PST)
In-Reply-To: <20100207002413.GA14744@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139202>

> I've added it to the Git Wiki:
> http://git.wiki.kernel.org/index.php/GitTips#Using_gmail_to_send_your_patches

If you're on MacOS X and have MacPorts installed, then install both
the curl and msmtp packages, then use an .msmtprc as follows:

defaults
tls on
tls_trust_file /opt/local/share/curl/curl-ca-bundle.crt
syslog LOG_MAIL

# gmail
account gmail
host smtp.gmail.com
port 587
auth on
from jaysoffian@gmail.com
user jaysoffian@gmail.com

# Default account
account default : gmail

Adjusting for you account of course. And in your git config:

[sendemail]
	smtpserver = /opt/local/bin/msmtp


Now why would you do this you ask instead of using git's built-in SMTP
support? Because I provided a patch to msmtp long ago that lets it
access your gmail password from Mac OS X's keychain. Note that it
looks for a password stored in the same format as Mail.app would store
it, see the msmtp man page for details.

FWIW, I think Gnome also has a keychain like thingy that msmtp can also query.

j.
