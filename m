From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Sat, 25 Jul 2009 21:57:39 +0300
Message-ID: <20090725215739.d074e947.tihirvon@gmail.com>
References: <20090723160740.GA5736@Pilar.aei.mpg.de>
	<alpine.LFD.2.01.0907230913230.21520@localhost.localdomain>
	<20090723165335.GA15598@Pilar.aei.mpg.de>
	<alpine.LFD.2.01.0907231158280.21520@localhost.localdomain>
	<alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
	<20090723195548.GA28494@Pilar.aei.mpg.de>
	<alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
	<alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
	<alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
	<20090724234648.GA4616@Pilar.aei.mpg.de>
	<20090725004122.GA28477@Pilar.aei.mpg.de>
	<alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 20:58:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmRh-000400-Up
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbZGYS6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbZGYS6B
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:58:01 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:41320 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZGYS6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:58:00 -0400
Received: by ewy26 with SMTP id 26so2394567ewy.37
        for <multiple recipients>; Sat, 25 Jul 2009 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=U5saqx37KKiqnWdfcYDCLJZHiXj/cto6NtvqB7SWBpE=;
        b=l14Gu57c78kh83U49rKPwrV+7Fn3eFboI3yeutGulYCAViku78R06y/bheQ2ftdWY8
         vBgqKp4aENvsktAY4uzoKUV5jEgS8kLBQUhshzrYezdFXnZWx7B+5SxvvWgdKZtYp8dP
         XBdbCurAO60u+Vl+E6qInFocXhElpTmWX6DxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=YngBCQj7JXHmu52DUVgsmUbs3sr8o38B6nzHEmwp6kIYEaDSeAQ+EpQNfGY90ARC+/
         OhjQaQS/Xg/Rchwp40gV75ErDwUbdfuYGP+Fx/sdQvZKACoFwh3r4GYn14JGTcDa+7d4
         sVqvX4wQcDo656HsKF2j/hkoKklWsvDwD/Scw=
Received: by 10.210.36.10 with SMTP id j10mr5969805ebj.21.1248548278601;
        Sat, 25 Jul 2009 11:57:58 -0700 (PDT)
Received: from garlic ([88.193.43.182])
        by mx.google.com with ESMTPS id 24sm2542940eyx.53.2009.07.25.11.57.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 11:57:57 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.5; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124055>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So curl really must die. It may not matter for the expensive operations, 
> but a lot of scripting is about running all those "cheap" things that just 
> add up over time.

SELinux is the problem, not curl.

On my Arch Linux machine:

   $ ldd bin/git
	linux-vdso.so.1 =>  (0x00007fff42306000)
	libcurl.so.4 => /usr/lib/libcurl.so.4 (0x00007f8714532000)
	libz.so.1 => /usr/lib/libz.so.1 (0x00007f871431d000)
	libcrypto.so.0.9.8 => /usr/lib/libcrypto.so.0.9.8 (0x00007f8713f8f000)
	libpthread.so.0 => /lib/libpthread.so.0 (0x00007f8713d74000)
	libc.so.6 => /lib/libc.so.6 (0x00007f8713a21000)
	librt.so.1 => /lib/librt.so.1 (0x00007f8713819000)
	libssl.so.0.9.8 => /usr/lib/libssl.so.0.9.8 (0x00007f87135ca000)
	libdl.so.2 => /lib/libdl.so.2 (0x00007f87133c6000)
	/lib/ld-linux-x86-64.so.2 (0x00007f8714778000)

Your:

   [torvalds@nehalem git]$ ldd git
	linux-vdso.so.1 =>  (0x00007fff61da7000)
	libcurl.so.4 => /usr/lib64/libcurl.so.4 (0x00007f2f1a498000)
	libz.so.1 => /lib64/libz.so.1 (0x0000003cdb800000)
	libcrypto.so.8 => /usr/lib64/libcrypto.so.8 (0x0000003ba7a00000)
	libpthread.so.0 => /lib64/libpthread.so.0 (0x0000003cdb400000)
	libc.so.6 => /lib64/libc.so.6 (0x0000003cda800000)
	libidn.so.11 => /lib64/libidn.so.11 (0x0000003ceaa00000)
	libssh2.so.1 => /usr/lib64/libssh2.so.1 (0x0000003ba8e00000)
	libldap-2.4.so.2 => /usr/lib64/libldap-2.4.so.2 (0x00007f2f1a250000)
	librt.so.1 => /lib64/librt.so.1 (0x0000003cdbc00000)
	libgssapi_krb5.so.2 => /usr/lib64/libgssapi_krb5.so.2 (0x0000003ce6e00000)
	libkrb5.so.3 => /usr/lib64/libkrb5.so.3 (0x0000003ce7e00000)
	libk5crypto.so.3 => /usr/lib64/libk5crypto.so.3 (0x0000003ce7200000)
	libcom_err.so.2 => /lib64/libcom_err.so.2 (0x0000003ce6a00000)
	libssl3.so => /lib64/libssl3.so (0x0000003490200000)
	libsmime3.so => /lib64/libsmime3.so (0x000000348fe00000)
	libnss3.so => /lib64/libnss3.so (0x000000348f600000)
	libplds4.so => /lib64/libplds4.so (0x0000003cbc800000)
	libplc4.so => /lib64/libplc4.so (0x0000003cbdc00000)
	libnspr4.so => /lib64/libnspr4.so (0x0000003cbd800000)
	libdl.so.2 => /lib64/libdl.so.2 (0x0000003cdb000000)
	/lib64/ld-linux-x86-64.so.2 (0x0000003cda400000)
	libssl.so.8 => /usr/lib64/libssl.so.8 (0x0000003ba7e00000)
	liblber-2.4.so.2 => /usr/lib64/liblber-2.4.so.2 (0x0000003ceee00000)
	libresolv.so.2 => /lib64/libresolv.so.2 (0x0000003ce5600000)
	libsasl2.so.2 => /usr/lib64/libsasl2.so.2 (0x00007f2f1a030000)
	libkrb5support.so.0 => /usr/lib64/libkrb5support.so.0 (0x0000003ce7a00000)
	libkeyutils.so.1 => /lib64/libkeyutils.so.1 (0x0000003ce7600000)
	libnssutil3.so => /lib64/libnssutil3.so (0x000000348fa00000)
	libcrypt.so.1 => /lib64/libcrypt.so.1 (0x00007f2f19df8000)
	libselinux.so.1 => /lib64/libselinux.so.1 (0x0000003cdc400000)
	libfreebl3.so => /lib64/libfreebl3.so (0x00007f2f19b99000)
