From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sat, 28 Aug 2010 16:59:56 -0500
Message-ID: <20100828215956.GB5515@burratino>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
 <AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
 <20100828214641.GA5515@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Marcin Cieslak <saper@saper.info>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 00:02:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpTTN-0007GP-A5
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 00:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab0H1WBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 18:01:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44914 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab0H1WBr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 18:01:47 -0400
Received: by gyd8 with SMTP id 8so1565640gyd.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Qg9y6fXLteEA0DYGW8OLpITmpwXJ0NtR6Udc7ctzPKs=;
        b=I1EQJWv0HzwuULQnZulcRcT1xynRkGZ0rDVn+n84pfRuzux3rX7SfAaWLCT2Qn+3wn
         ud5NX8OFeNULF3MUC2HOc3cDeVP6sY7UeIfapJAruP+ImKGnru4lR6CzQ3Q67NsW0nnC
         U8EHpyT60draelowEUs6RkXelersWn8H4089Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YOdmzfpfgjlYiT1hI7y3MAwgN5gnmaHXPkcKwzHS/+wEGT6me5Fy27zrk/udr1M/w3
         GYIVOU8Aw/royksa8xBN3iiqjo4da7nl2vICUZ9uQBNRWd1ixK7dgJHKY6msjeN+ajvZ
         88qEaraDxB/M6ZVb7xabDYEpEi5ybfeIbsnDI=
Received: by 10.100.57.18 with SMTP id f18mr2683293ana.8.1283032906914;
        Sat, 28 Aug 2010 15:01:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c19sm9131994ana.2.2010.08.28.15.01.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 15:01:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100828214641.GA5515@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154660>

Jonathan Nieder wrote:

>  printf("%s\n", some_nonsense_string);
>=20
> should always just work.

Ok, so apparently

 #include <stdio.h>
 #include <locale.h>

 int main(void)
 {
        setlocale(LC_CTYPE, "");
        printf("%.11s\n", "Author: \277");
	return 0;
 }

does not work.  Even while

	printf("%.1s\n", "=C3=A9tale");

does print only one byte.

Ideas?
