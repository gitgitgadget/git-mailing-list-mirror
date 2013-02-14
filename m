From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: inotify to minimize stat() calls
Date: Thu, 14 Feb 2013 09:36:01 -0500
Message-ID: <20130214143558.GA671@google.com>
References: <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
 <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh>
 <CANgJU+WYSD8RHb19EP0M89=Y_XskfjDtFWf51qjg4ur+rDb3ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 15:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6037-0002tG-G5
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 15:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934730Ab3BNOoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2013 09:44:08 -0500
Received: from mail-qe0-f73.google.com ([209.85.128.73]:47923 "EHLO
	mail-qe0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934172Ab3BNOoG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 09:44:06 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Feb 2013 09:44:06 EST
Received: by mail-qe0-f73.google.com with SMTP id 7so243787qeb.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2013 06:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=s0hyGoYBS+kGzst6vsTt0lN+8JcRB+po8q0Mh+wnRcs=;
        b=FW7HZOPeS2TAkwAcD68FToDmukOMkkQuWTG/KpFTJsks1sPSNne47LeJzSobBPtlsa
         xk/9BiXKw/4LhmFsqe2rm5NmFAyxD4/BJtUIutfbeE8Rw0xV5BCLzig8+8O8g/uRNqCY
         +7vgP87HeJC+mBg0uxDgX1shzS9W4jRGu/nF8FDyXQ2KLb7s1ezOHHB4g7RZlaClrNpb
         +KeZAPDdqX79nximrTCDVS/0JuxYaFzs0CS1BOjsMZAVgAQo19WnO/GaMe8y0RvuQ0pU
         zk6S43HhZqpzYK7u1Klu3PV4avllcKaereZkA13pJe5K8F9o9pNfplq4PA64fq9bcmlI
         rpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent:x-gm-message-state;
        bh=s0hyGoYBS+kGzst6vsTt0lN+8JcRB+po8q0Mh+wnRcs=;
        b=bYTANQvqsYWjKlyfOsPtJM/TygKtUdnQpB6ytB+yXrULj98Ghvr0g/OcM03DL1Vq8+
         RfY09VMhzfvPKHUA0OT19XmPgEeaMlXttn9pTX5E6LHLfL6HLKd/luXwY7RbCuBN8Y+Y
         woTL3RhkVk1lO3XtWtukcuRx2L1Nc6VY8B57gxLFcBEgvPeznhKVrdG+piSbiTCTNV23
         WPgTl2E4ZBej3/th5jZ0maiZaIrrTRUh8C7vkv4485ksA0zsd/zttntwb4xtVYJMWN7E
         gXVKkfG6GxRxsZP8MVLCNRpAfGrMxsx2llc9TNykOH7UPJbu3ecTa8oyW3l5jQvUPX+Z
         HdQA==
X-Received: by 10.236.76.73 with SMTP id a49mr9698728yhe.30.1360852561810;
        Thu, 14 Feb 2013 06:36:01 -0800 (PST)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id e7si2124603yhk.3.2013.02.14.06.36.01
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 14 Feb 2013 06:36:01 -0800 (PST)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A67F05A4267;
	Thu, 14 Feb 2013 06:36:01 -0800 (PST)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 42D5D40906; Thu, 14 Feb 2013 09:36:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CANgJU+WYSD8RHb19EP0M89=Y_XskfjDtFWf51qjg4ur+rDb3ug@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQldfM5vMoEUWGP87kWKLUka0E++v+2P8ges0kNeHjb9iaybaCVzS2CUcTGtaDKCNUaq166QiZcNTPwrkOf8k4BsDsYraMvQ77M2taSURMxx+hii54Rmlck4s2LgibFiLNKwGsLP2R0F45Ex0Q7SXPfHgdllhcM0uvHPElk0hPC1AdH0DTkPts/ETcsayhA713orABL3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216308>

On Sunday, February 10, 2013 at 08:26 EST,
     demerphq <demerphq@gmail.com> wrote:

> Is windows stat really so slow?

Well, the problem is that there is no such thing as "Windows stat" :-)

> I encountered this perception in windows Perl in the past, and I know
> that on windows Perl stat *appears* slow compared to *nix, because in
> order to satisfy the full *nix stat interface, specifically the nlink
> field, it must open and close the file*. As of 5.10 this can be
> disabled by setting a magic var ${^WIN32_SLOPPY_STAT} to a true value=
,
> which makes a significant improvement to the performance of the Perl
> level stat implementation.  I would not be surprised if the cygwin
> implementation of stat() has the same issue as Perl did, and that sta=
t
> appears much slower than it actually need be if you don't care about
> the nlink field.

I suggested a few years ago that FindFirstFile() be used to implement
stat() since it's way faster than opening and closing the file, but
=46indFirstFile() apparently produces unreliable mtime results when DST
shifts are involved.

http://thread.gmane.org/gmane.comp.version-control.git/114041
(The reference link in Johannes Sixt's first email is broken, but I'm
sure the information can be dug up.)

Based on a quick look it seems GetFileAttributesEx() is still used for
mingw and cygwin Git.

--=20
Magnus B=E4ck
baeck@google.com
