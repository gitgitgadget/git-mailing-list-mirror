From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Fri, 14 Mar 2008 17:11:53 -0400
Message-ID: <76718490803141411v24c31de5x8ba25fcd1654b4e7@mail.gmail.com>
References: <20080313231413.27966.3383.stgit@rover>
	 <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	 <m38x0lxr1k.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>, "Junio C Hamano" <junkio@cox.net>,
	git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaHCe-0002qM-Sz
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 22:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467AbYCNVL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 17:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbYCNVL5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 17:11:57 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:51678 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbYCNVL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 17:11:57 -0400
Received: by el-out-1112.google.com with SMTP id v27so2669828ele.17
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=k0LKUm2DoUo7LEr/pkz+QBIEWN8ukmk+aEYsXngwJaI=;
        b=L1h3fMZfmd1Kt20AaKz9Z8ES1v2RM5vQc7p4VHrU74uSJlQvu+jwTOE1zycz2JW+r+iYuwpJKF5+stqUa+uituOa163BukLHgT+JDFeQucerdL1HeyV2nrf+73p9PG6JbndQ3SZtOGRgSZv3BWgjmC5zEGUI+Xl7AGTr4uJmn/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hEoDqeFQDVP1QPaDL6E1l6XqCMhOAmF54W/smYS8hM2oOUk8S08KnNlc67CkCHQGrA66gTR/LalVFYRgMt0LOhJiNMG2G17L+kRg/I8XXx7ixx3/y5xXLi8Oz7noOzzd6+C8cWO3AZA7hAAocRP9Mhd9xSnBy07G6EVYJcb/faU=
Received: by 10.115.78.1 with SMTP id f1mr12721088wal.100.1205529113164;
        Fri, 14 Mar 2008 14:11:53 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Fri, 14 Mar 2008 14:11:53 -0700 (PDT)
In-Reply-To: <m38x0lxr1k.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77284>

On Fri, Mar 14, 2008 at 11:29 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>  What should the code for this look like? Like below?
>
>         use File::Temp;
>
>         my ($fh, $temp_file) = tempfile();
>         ...
>         close $fh;
>         rename $temp_file, $cache_file;

I always use something like:

  my $temp_file = "$cache_file.tmp$$";
  open(my $fh, ">$temp_file");

to ensure that the temp file is on the same filesystem.

j.
