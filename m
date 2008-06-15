From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] The "curl" executable is no longer required
Date: Sun, 15 Jun 2008 15:33:09 +0200
Message-ID: <200806151533.11742.jnareb@gmail.com>
References: <200806120920.31161.johan@herland.net> <200806151347.31676.johan@herland.net> <vpqej6ylx99.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Symonds <dsymonds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7sN3-0008Lw-03
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbYFONdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 09:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757429AbYFONdS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:33:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:36096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424AbYFONdR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2008 09:33:17 -0400
Received: by ug-out-1314.google.com with SMTP id h2so269319ugf.16
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HHHihb2iHL+8WJHIkghnRF7ekylqa8+kUKuwyaFbIi4=;
        b=vNwDSvjc8XUUU5Xu3Pmo7KcwkS4qhnj0cSOJavFYNrVTvqgmljbd3d3B03sXCAW0S3
         lQOR3c2o7SxyWkbvwCyD7hdmW+z2yy+H+2Nw8S+zyqjHuQUHYv72w9yw8vE4XM0KjuIN
         IqWi5OXmv6hw88/ET4iNvZoz7ZKVmxUIFms7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BtRavu+Ag9VNaFuT0g5jtDmhlRfbgQ0lqoeJZF/NnK10C7ISgrzL+8PDbmDmo2YhnJ
         XShHYxlpHLLUj3Tq00L1CPQ9agKbQBboBqfFJjy9x0SPN8W51gATDWbUr3TkSoAlkUDT
         /tnnV/AtNNZMP/lNcS5HdQlRMuTPd952INfPw=
Received: by 10.210.52.9 with SMTP id z9mr4971090ebz.139.1213536796411;
        Sun, 15 Jun 2008 06:33:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.105])
        by mx.google.com with ESMTPS id x26sm1785774ugc.63.2008.06.15.06.33.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 06:33:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <vpqej6ylx99.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85089>

Matthieu Moy wrote:
> Johan Herland <johan@herland.net> writes:
>> On Sunday 15 June 2008, Jakub Narebski wrote:
>>
>>> It is not necessary to enumerate simple library dependencies, as
>>> rpmbuild _detects_ those dependencies during building binary RPMS.
> 
> Good to know, and that seems to be a valid argument ("seems to"
> because of my lack of knowledge of rpm, not lack of trust ;-) ).
> 
>>> Besides it worked without libcurl in Requires, so it should
>>> continue to work without it, isn't it?
> 
> It used to have a dependency on curl, which itself requires libcurl,
> so the dependency was implicit.
> 
>> Someone with more RPM knowledge will have to determine which is
>> right.
> 
> +1

Or simply remove 'curl' from 'Requires:' header, and check if rpmbuild
would pick up libcurl dependency, and if resulting RPM has libcurl as
requirement.

Fragment of "make rpm" output (word wrapped for better readibility):
[...]
Provides: git-core = 1.5.6.rc3.198.g368e0.dirty-1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 
 rpmlib(PartialHardlinkSets) <= 4.0.4-1 
 rpmlib(PayloadFilesHavePrefix) <= 4.0-1 
 rpmlib(VersionedDependencies) <= 3.0.3-1
Requires: /bin/sh /usr/bin/perl expat less 
 libc.so.6 libc.so.6(GLIBC_2.0) libc.so.6(GLIBC_2.1) libc.so.6(GLIBC_2.1.1) libc.so.6(GLIBC_2.1.3) 
 libc.so.6(GLIBC_2.2) libc.so.6(GLIBC_2.2.3) libc.so.6(GLIBC_2.3) libc.so.6(GLIBC_2.3.4) 
 libcrypto.so.5 libcurl.so.3 libexpat.so.0 libz.so.1
 openssh-clients 
 perl >= 0:5.006 perl(Getopt::Long) perl(Git) perl(lib)
 perl(strict) perl(warnings) 
 perl-Git = 1.5.6.rc3.198.g368e0.dirty-1
 rsync zlib >= 1.2
Obsoletes: git-core <= 1.5.4.2 git-p4
[...]

$ rpm -q --requires -p git-1.5.6.rc3.198.g368e0.dirty-1.i386.rpm
/bin/sh  
/usr/bin/perl  
expat  
less  
libc.so.6
[...]
libcrypto.so.5  
libcurl.so.3  
libexpat.so.0  
libz.so.1
[...]

As you can see rpmbuild picks up dependency on libcurl.


>From what I remember using automatically picked depndencies is
preferred solution, even if I cannot find it in "Maximum RPM" book.

HTH
-- 
Jakub Narebski
Poland
