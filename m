From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: t3900-i18n-commit.sh problem on Solaris
Date: Tue, 4 Mar 2008 18:18:30 +0000
Message-ID: <e2b179460803041018w4c5b7692u1d24c89bbc73805a@mail.gmail.com>
References: <8ec76080803040751y4bf808f9ma83a9faa4f857039@mail.gmail.com>
	 <e2b179460803040811y38e639b6wa83857c49b55aa05@mail.gmail.com>
	 <8ec76080803040814l694a0a11i6aa8e2c9f608413c@mail.gmail.com>
	 <8ec76080803040915m3ea11ae6te4379bff05df9402@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Whit Armstrong" <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 19:19:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWbjR-0000PF-2X
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 19:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702AbYCDSSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 13:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757988AbYCDSSe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 13:18:34 -0500
Received: from el-out-1112.google.com ([209.85.162.179]:62998 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756429AbYCDSSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 13:18:33 -0500
Received: by el-out-1112.google.com with SMTP id v27so1317237ele.17
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 10:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YuBhoUDhRgpaLQ01TtbgNYgiYdm+4RkI9m38IxBnOtw=;
        b=xnbGEKr/MEjVf2Zzo3jID1k8oniqPkIWvziwftsF1VJqhSpiQZQd80fuVStmr0i7Zfzw06vTmjNX5ihuUYbvy297/Uv9o82yzDF10xbBXF0vI0WDykEvSfZC7nYboRwSd0Cgun5djVvqOfwQNqEjibkB84yXaJeuOCjri6S5Fcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rBdnwbQYXz33wrDRm0nfCM8fA75gAnbYmb1NeD/jUamhLiNWlj+gkf5Y2nhVq9S4OcnAi07pKGn0/9ZaOJKFMA7b5Dz4NZhhxzrteTEsFL6zM2e3e1L+kifCIVfIbYHHQj3+Zt9EeGBLRhEnstKwFwlF+BuA5D6gptVaaBQ+kDg=
Received: by 10.140.193.16 with SMTP id q16mr843578rvf.109.1204654710204;
        Tue, 04 Mar 2008 10:18:30 -0800 (PST)
Received: by 10.141.19.11 with HTTP; Tue, 4 Mar 2008 10:18:30 -0800 (PST)
In-Reply-To: <8ec76080803040915m3ea11ae6te4379bff05df9402@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76125>

On 04/03/2008, Whit Armstrong <armstrong.whit@gmail.com> wrote:
> I still got the same failure after using: ./configure
>  --with-iconv=/home/warmstro/bin
>
>  which is where I put GNU inconv.
>
>  Is it possible to make sure that configure used that version?
>
>  I tried ldd on the git executable, but I didn't find it.
>
>  xs5-trd-p1.grn:warmstro> ldd git
>         libcurl.so.3 =>  /usr/local/misc/lib/libcurl.so.3
>         libz.so =>       /usr/local/subversion/lib/libz.so
>         libsocket.so.1 =>        /usr/lib/libsocket.so.1
>         libnsl.so.1 =>   /usr/lib/libnsl.so.1
>         libc.so.1 =>     /usr/lib/libc.so.1
>         libdl.so.1 =>    /usr/lib/libdl.so.1
>         libz.so.1 =>     /usr/local/subversion/lib/libz.so.1
>         libz.so.1 (SUNW_1.1) =>  (version not found)
>         libgcc_s.so.1 =>         /usr/local/subversion/lib/libgcc_s.so.1
>         libmp.so.2 =>    /usr/lib/libmp.so.2
>         /usr/platform/SUNW,Sun-Fire-V240/lib/libc_psr.so.1

It looks to me like the configure script has no way to set the
ICONVDIR variable used by the Makefile, so the --with-iconv= probably
isn't doing anything.

For now, could you try setting that directly in your Makefile ?
NEEDS_LIBICONV must be defined if it isn't already.

Mike
