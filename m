From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sat, 28 Aug 2010 17:16:55 -0500
Message-ID: <20100828221655.GB5777@burratino>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
 <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
 <20100828214641.GA5515@burratino>
 <20100828215956.GB5515@burratino>
 <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marcin Cieslak <saper@saper.info>
X-From: git-owner@vger.kernel.org Sun Aug 29 00:19:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpTjo-00054n-A0
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 00:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab0H1WSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 18:18:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64193 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab0H1WSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 18:18:44 -0400
Received: by iwn5 with SMTP id 5so3679580iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DyeN2wECh35uYWeSoFm14Is+X6h1z55Cn/5ZR+oXEms=;
        b=CrbES52kSi2Zbvd7DXTvUXFMt6QeqssuHnkD0HvZ5GOMztfZt4yf6QflvhmyIt1pV7
         aKYmluEyM3bL98a94n8Cl28iaEHrT9YsNwQQnVx5nycWL98lVCaLkROnCEu2/t1i+iVk
         AY31ifm+S9lPVXSveX9TEselUP6Dstscqdyqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XNAgwmAK8R0d40dFYf+wdXStU4z8vzEh19W+L2jpBIKBcuZSYzVKgvl+ZDR12w7bvm
         V+4oPSWon0bY8+GN+FkB+01GiGAs9NEk7aqRgZPHTzod1n7B9hMtzHra/3yYGCHblV02
         jGR4jqcyQzezEkeMjUBYStXBK2hD9tMIZXq6c=
Received: by 10.231.130.145 with SMTP id t17mr2935118ibs.144.1283033923688;
        Sat, 28 Aug 2010 15:18:43 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm5362365ibe.17.2010.08.28.15.18.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 15:18:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154661>

Marcin Cieslak wrote:

> What's wrong?

$ /lib/libc.so.6  |head -1
GNU C Library (Debian EGLIBC 2.11.2-2) stable release version 2.11.2, by Roland McGrath et al.
$ cat test.c
#include <stdio.h>
#include <locale.h>

int main(void)
{
        int n;

        setlocale(LC_CTYPE, "");
        n = printf("%.11s\n", "Author: \277");
        perror("printf");
        fprintf(stderr, "return value: %d\n", n);
        return 0;
}
$ make test
cc     test.c   -o test
$ ./test
printf: Invalid or incomplete multibyte or wide character
return value: -1

glibc bug?
