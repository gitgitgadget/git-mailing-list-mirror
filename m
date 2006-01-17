From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: git-diff-files and fakeroot
Date: Tue, 17 Jan 2006 00:59:24 -0500
Message-ID: <95E085A7-B910-4C01-BA6E-43971A6F5F97@mac.com>
References: <43CC5231.3090005@michonline.com> <7vzmlvk2bs.fsf@assigned-by-dhcp.cox.net> <20060117052758.GA22839@mythryan2.michonline.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 06:59:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyjsc-00065v-QN
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 06:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWAQF7i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 00:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWAQF7i
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 00:59:38 -0500
Received: from smtpout.mac.com ([17.250.248.44]:47581 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751116AbWAQF7h (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 00:59:37 -0500
Received: from mac.com (smtpin03-en2 [10.13.10.148])
	by smtpout.mac.com (Xserve/8.12.11/smtpout12/MantshX 4.0) with ESMTP id k0H5xVDr021216;
	Mon, 16 Jan 2006 21:59:31 -0800 (PST)
Received: from [198.82.78.50] (hc6524e32.dhcp.vt.edu [198.82.78.50])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin01/MantshX 4.0) with ESMTP id k0H5xRuR022380
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 16 Jan 2006 21:59:30 -0800 (PST)
In-Reply-To: <20060117052758.GA22839@mythryan2.michonline.com>
To: Ryan Anderson <ryan@michonline.com>
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14778>

On Jan 17, 2006, at 00:27, Ryan Anderson wrote:
> On Mon, Jan 16, 2006 at 06:36:39PM -0800, Junio C Hamano wrote:
>> BTW, Ryan, I suspect this is where you try to append "-dirty" to  
>> the version number.  But I wonder why you are doing the build  
>> under fakeroot to begin with?  Wasn't the SOP "build as
>> yourself, install as root"?
>
> That's exactly what started this search, because I was running  
> "make deb-pkg". (Effectively.)  dpkg-buildpackage wants to think it  
> is running as root, either via sudo or via fakeroot.  I had my  
> build environment switched over entirely to fakeroot, as it just  
> seems to be a better practice, but I've temporarily switched back  
> to sudo.
>
> However, your explanation has pointed out to me how I can solve  
> this - run "fakeroot -u" instead of "fakeroot", and I think it will  
> be fixed.

You should run "make" first, then after that completes run "fakeroot  
make deb-pkg".  I think this is similar to what the Debian package  
"kernel-package" does, except it substitutes an alternate "debian/"  
directory.  IIRC, it just runs "make install" as a normal user to a  
staging directory, then runs "$(ROOTCMD) dpkg-deb -b [...]" to build  
the package.  IMHO it's somewhat of a cleaner solution, and I've used  
it for several years now with no issues.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson
