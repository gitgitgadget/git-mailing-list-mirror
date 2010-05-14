From: Dmitry Potapov <dpotapov@gmail.com>
Subject: utf8 BOM
Date: Fri, 14 May 2010 14:16:48 +0400
Message-ID: <20100514101648.GB6212@dpotapov.dyndns.org>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
 <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
 <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com>
 <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com>
 <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Buck <buck.robert.j@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 12:17:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrx0-0004DT-M0
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 12:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759071Ab0ENKQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 06:16:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38612 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759049Ab0ENKQz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 06:16:55 -0400
Received: by fxm6 with SMTP id 6so1300388fxm.19
        for <git@vger.kernel.org>; Fri, 14 May 2010 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NndW0GqXLdSAWTWNEFI4mGnbEXG6M1FUqNpHw44yFvc=;
        b=IAoJWP5RrffWVkVjV8iKaxz3280vJ0sKFqmhGx2qTWUCL42Ls24FRGf/CXWfRIFRpU
         /ZhxTLMGZn4CzQXDoELA2lToJ0lPbSY0aldaqlYOqVXjUDb9J6S5O9m7h67GC0nH1GoI
         shd2MWB0/Ry5HjB00LjjLocr39INv3rWzSZ0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FO3FfSOjoJmDUBh3wKEcZWvgR+VmM4Nh/Ub8FNVfFno3g7o1lWLVp5yhTOQCocZLfg
         Z0ZMYZi3pQjtYafplGPC53N80tGQh5zs8VB+Bq8phSDQoMKueNg1lV9HLLTzoWkRGpfL
         1W0c3Z5m1biHm42jw16KmbPoyApWEHKRbuUQM=
Received: by 10.223.68.131 with SMTP id v3mr1322399fai.82.1273832212596;
        Fri, 14 May 2010 03:16:52 -0700 (PDT)
Received: from localhost (ppp85-140-167-195.pppoe.mtu-net.ru [85.140.167.195])
        by mx.google.com with ESMTPS id 2sm10271195fav.1.2010.05.14.03.16.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 03:16:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147079>

On Thu, May 13, 2010 at 01:47:45PM +0200, Eyvind Bernhardsen wrote:
> 
> I just did a quick test with a plain text file; it was detected as
> text both with and without a utf8 BOM.  Looking at the code,
> characters >= 128 are considered printable so the BOM shouldn't make
> any difference at all.  Do you have an example utf8 text file that is
> misdetected as binary?

Though UTF-8 BOM does not present any problem for automatic text
detector, it is another piece from Microsoft that creates some
interoperability issues when you work with non-ASCII text files.
In short:

1. Microsoft editors and tools like to add utf8 BOM to files, and
   you cannot turn this behavior off.
2. Many tools (such as Microsoft compiler) incapable to recognize
   UTF-8 files without BOM, so they screw up all non-ASCII chars.

#1 is a problem, because it creates changes consisting solely of adding
utf8 BOM. Moreover, users of non-Windows platforms are not exactly
thrilled with having utf8 BOM at the beginning of every text file.

Probably, ability of automatic add utf8 BOM on Windows to text files
(which are marked as "unicode") can be helpful, but it is just a part
of the problem of how to deal with text files in "legacy" encoding,
which are still widely used on Windows.



Dmitry
