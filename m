From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH next] don't let mailmap provoke use of freed memory
Date: Fri, 15 Oct 2010 01:18:21 -0500
Message-ID: <20101015061821.GE21830@burratino>
References: <87tyksd9er.fsf@meyering.net>
 <20101011162153.GG25842@burratino>
 <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 08:21:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6dfv-0000XJ-2q
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 08:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0JOGVt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 02:21:49 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43221 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab0JOGVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 02:21:48 -0400
Received: by yxm8 with SMTP id 8so182655yxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 23:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UHfLwaHV+0RUm5aLfl4nW3WT+LE/L4iziU8/3KsbdfQ=;
        b=bkjkjBGq5C3Do2WcGrzemgm+8kUCKmx432ZyoYohPtWC7KkHrDs6e3RkZ6gpAwpnIt
         7Tx+jKsy+/s5KAFF6TLcFUPaA1wc7MgkfjiF91F6gnvXrFo0XF5lnqRT3qCMnbaP0gRI
         lG0Iw+yHqQ6m7mH77uiLSHoGFqPHD99e8mg5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=px85yPIj3TBMK5XH0OmqdS/G8yLHds7Mq8u0d3A/xpLAKzzxXlo0Z9D0DWUJrCKu8B
         +coZzvc8l1MEaQKzftz1IyzSc/Alx+agDpk8P3cTwcNbZp0KmrV42Ys9V4Mc4trvvKdk
         Y9rlODukFcw19Yxhlz8GXzMV/3349MCaRinN0=
Received: by 10.151.101.6 with SMTP id d6mr1034882ybm.77.1287123708013;
        Thu, 14 Oct 2010 23:21:48 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id n48sm9604452yha.7.2010.10.14.23.21.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 23:21:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159100>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> ok 6 - mailmap.file non-existant
> not ok - 7 name entry after email entry
> not ok - 8 name entry after email entry, case-insensitive
> ok 9 - No mailmap files, but configured
> ok 10 - Shortlog output (complex mapping)
> ok 11 - Log output (complex mapping)
> not ok - 12 Blame output (complex mapping)
> # failed 3 among 12 test(s)

Odd.  I can reproduce test 12 failing with commit ids changed
(embarrassed I didn't notice before) but the others pass here.
Trying a --valgrind run.
