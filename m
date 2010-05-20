From: Jonathan Leto <jaleto@gmail.com>
Subject: Re: Help with a possibly corrupt repo
Date: Thu, 20 May 2010 07:57:30 -0700
Message-ID: <AANLkTikSo8hTPXG8kGgCLOul6wp8THobUW_rSni4D6YC@mail.gmail.com>
References: <AANLkTiks5g7BvLXBrUcb0m5dCiIrBifjDUKBDScXd1dw@mail.gmail.com> 
	<20100510201720.GH14069@dpotapov.dyndns.org> <AANLkTinYj624545WtRf8TayNkm6a_z3e6kiwRyHCjqtv@mail.gmail.com> 
	<20100510212801.GJ14069@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 16:57:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF7C3-0007NL-PM
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 16:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0ETO5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 10:57:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47231 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab0ETO5q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 10:57:46 -0400
Received: by gwaa20 with SMTP id a20so2615554gwa.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=RtZgPGPig24rWIx5cpwrt580CJH2DT+T6fFkupbXnxU=;
        b=It2etuCbVXyktlnc1G+bH1UcQwNWKs9AesuUVeUOCF8Cfj8CYQQH1MhGEWoZ7L6n45
         Kzjs44UXb00SqCvQPI+VHFlopv8ic+L26ypTcGiW9Zo3braQW6NnCTwejlGAm0OyBbs2
         J6/rnQhk9nIvPXuSP1vXoVys/vsdActZu9eNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OXNQqjo4sNrfueAW1VtyKp9tDUP7ABX5fB4cliJeGmXNPkoPXf8V+H3nXhgxFn3nJt
         85e4vDML3238emFTc008STDIssvdtLbnhlJGIWoBuQ9U7BqIKhsbu9mZ20iqaXIGbms6
         zaa3xcY3QJ++UyNI5qxIEC4bk3APt00K2vdsU=
Received: by 10.151.21.12 with SMTP id y12mr1913371ybi.226.1274367465330; Thu, 
	20 May 2010 07:57:45 -0700 (PDT)
Received: by 10.151.48.4 with HTTP; Thu, 20 May 2010 07:57:30 -0700 (PDT)
In-Reply-To: <20100510212801.GJ14069@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147392>

Howdy,

I ran into this corruption issue using ecryptfs with an ext4
filesystem (on a local SSD drive) on Ubuntu 9.10. The corruption seems
to coincide with getting these errors in my dmesg output:

[12773.772426] ecryptfs_decrypt_page: Error attempting to read lower
page; rc = [-22]
[12773.772431] ecryptfs_readpage: Error decrypting page; rc = [-22]
[12796.061574] ecryptfs_read_lower: octets_read = [-4]; expected [4096]
[12796.061584] ecryptfs_read_and_validate_header_region: Error reading
header region; rc = [-22]

I am lead to believe that ecryptfs+ext4 is not yet production-ready,
although it could be a weird failure mode of my drive. I have not had
more time to test this setup with other hardware.

Duke


On Mon, May 10, 2010 at 2:28 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Mon, May 10, 2010 at 02:05:09PM -0700, Jonathan Leto wrote:
>> 00020c0 deed 3541 7800 56dd 005c 0000 0000 0000
>> 00020d0 0000 0000 0000 0000 0000 0000 0000 0000
>> *
>> 0003000
>> error: garbage at end of loose object '66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba'
>> fatal: object 66fdbaef5ae12a8402f6b0f7c1a73a3ce72e8eba is corrupted
>
> The object is "tree", and it contains a lot of zeros at end.
> I have truncated them, and it appears to fix the problem.
> I have attached the corrected file.
>
> But the important question is how it could happen. What filesystem
> do you use? Do you store it on the local disk or network share?
>
>
> Dmitry
>



-- 
Jonathan "Duke" Leto
jonathan@leto.net
http://leto.net
