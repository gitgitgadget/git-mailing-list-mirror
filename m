From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Help with a possibly corrupt repo
Date: Fri, 21 May 2010 06:59:54 +0400
Message-ID: <20100521025954.GA3005@dpotapov.dyndns.org>
References: <AANLkTiks5g7BvLXBrUcb0m5dCiIrBifjDUKBDScXd1dw@mail.gmail.com>
 <20100510201720.GH14069@dpotapov.dyndns.org>
 <AANLkTinYj624545WtRf8TayNkm6a_z3e6kiwRyHCjqtv@mail.gmail.com>
 <20100510212801.GJ14069@dpotapov.dyndns.org>
 <AANLkTikSo8hTPXG8kGgCLOul6wp8THobUW_rSni4D6YC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Leto <jaleto@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 05:00:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFITJ-0005VR-4Y
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 05:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab0EUDAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 23:00:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64812 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0EUDAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 23:00:04 -0400
Received: by fxm5 with SMTP id 5so428274fxm.19
        for <git@vger.kernel.org>; Thu, 20 May 2010 20:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YWeKzL2poZiUX7tPLwGP1G5cRYWwRtuEFLo6T6tVvgI=;
        b=kP1LTJjX0VKyrIfdKZ+XetToYa2c3jck0JrtV1/Iso++1u9ys2tCn3FP0fDm7y8l2/
         SZrFw16E/hATSH21DOktqmzhh2jrMNM4D1CHQHjcdAGgl+NmeO090LhpbCvNOdJBOAlD
         L8FndBSjGIl1UboDakUSIgmBWf8860hpNIfN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rFkVfWMgcoEMYgmmV9+M+A5NxEbpmUs5vVAeswQcPYF9aMD2zXGBHXOb1q5QfbWYK6
         lppkhrHSaWx8KHhclwxR8pIrIe4tNP0DgAE7vE+wNVOzBGNFMRWedLEn5hhYJiyjc7hY
         z/V5gwyg0F16cKo7ZuQ/6XTWEzqaLD3SdLjTA=
Received: by 10.223.58.83 with SMTP id f19mr798450fah.88.1274410799175;
        Thu, 20 May 2010 19:59:59 -0700 (PDT)
Received: from localhost (ppp91-77-224-17.pppoe.mtu-net.ru [91.77.224.17])
        by mx.google.com with ESMTPS id r25sm2365226fai.23.2010.05.20.19.59.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 May 2010 19:59:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikSo8hTPXG8kGgCLOul6wp8THobUW_rSni4D6YC@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147429>

On Thu, May 20, 2010 at 07:57:30AM -0700, Jonathan Leto wrote:
> 
> I ran into this corruption issue using ecryptfs with an ext4
> filesystem (on a local SSD drive) on Ubuntu 9.10.
> to coincide with getting these errors in my dmesg output:
> 
> [12773.772426] ecryptfs_decrypt_page: Error attempting to read lower
> page; rc = [-22]
> [12773.772431] ecryptfs_readpage: Error decrypting page; rc = [-22]
> [12796.061574] ecryptfs_read_lower: octets_read = [-4]; expected [4096]
> [12796.061584] ecryptfs_read_and_validate_header_region: Error reading
> header region; rc = [-22]
> 
> I am lead to believe that ecryptfs+ext4 is not yet production-ready,

Sounds like this bug:
https://bugs.launchpad.net/ecryptfs/+bug/509180
and maybe related to this:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/490005

I don't think it is caused by combination of ecryptfs+ext4. I have seen
a similar bug report for ecryptfs+ext3 as well. In fact, a lot of bug
fixes were merged for ecryptfs during 2.6.34 development cycle.
Perhaps, those fixes were also back ported to 2.6.32, but Ubuntu 9.10
has 2.6.31, so it does not have them, and without them, it looks like
a beta-quality filesystem. So, make sure you have regular backups!


Dmitry
