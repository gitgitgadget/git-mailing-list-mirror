From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Metadata and checkin file date
Date: Tue, 27 Apr 2010 22:55:47 +0200
Message-ID: <201004272255.47394.jnareb@gmail.com>
References: <alpine.LFD.2.00.1004270719320.17234@bbs.intern> <m3sk6hck8b.fsf@localhost.localdomain> <alpine.LFD.2.00.1004272139080.5630@bbs.intern>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerhard Wiesinger <lists@wiesinger.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 23:02:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rux-0006sX-56
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 23:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756905Ab0D0VB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 17:01:59 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:5282 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107Ab0D0VB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 17:01:58 -0400
Received: by ey-out-2122.google.com with SMTP id d26so1240353eyd.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=8ttIYb0u+WGMsq8M48ZLWMM9JDH4Q8QoIlbY0EIZymA=;
        b=OFfxoJK8Pz6gtj0bDuF+xfpSRqYC8+YsoZsxWdmBlym4D7RwweJ0YxdfvcDLGzTg6G
         BIwDCFBr4L3iNY21YmNXdZgBdFFLWeRxNBUwMAqhX+zY0BdRbs/qOe5Sqkk7hDFUnLJZ
         QCAb2+MjX9HIaWYLzJbcNFasUX2JbX8UzoqdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eysowuqlPXhkE5KFEsCcXc1XCTeuF1t9FuAd+WWr3AS+39rmG6tLYfRDcakFqhqyA2
         XlfD9z/jCQMd79ZL6YzwMK1ttLUNQmtItI7MOk0pmh4pgqX27Z7cVnzJ0sD6cki9T7sf
         27S/r5mvXQnFwblbEnOv3LKRz4D9Qp9wPFTgU=
Received: by 10.102.240.16 with SMTP id n16mr3510956muh.100.1272401754895;
        Tue, 27 Apr 2010 13:55:54 -0700 (PDT)
Received: from [192.168.1.13] (abvy105.neoplus.adsl.tpnet.pl [83.8.222.105])
        by mx.google.com with ESMTPS id n7sm23881170mue.45.2010.04.27.13.55.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Apr 2010 13:55:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.1004272139080.5630@bbs.intern>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145956>

On Tue, 27 Apr 2010, Gerhard Wiesinger wrote:
> On Tue, 27 Apr 2010, Jakub Narebski wrote:
>> Gerhard Wiesinger <lists@wiesinger.com> writes:
>>
>>> I'm new to git and I'm looking for the following features:
>>> 1.) Metadata for
>>>    a.) directory versioning (e.g. add/rm, mv)
>>>    b.) rights (basic: chmod, chow, chgrp, extended: extended
>>> attributes like ACLs and selinux), necessary for versioning e.g. /etc
>>> 2.) Original file dates (checkin date) on clone and pull (and not
>>> checkout date)
>>>
>>> Is this possible? Any plans if missing?
>>
>> Git is distributed version control system (DVCS), not a backup system.
>> It is used mainly for distributed development of programs.  Therefore
>> it supports natively only those parts of metadata that make sense for
>> VCS, namely symlinks (with workaround for filesystems that do not have
>> support for symbolic links) and the executable permission for files.
>>
>> File ownership does not make sense for VCS, as other people that clone
>> your repository do not have the same set of users that you have, and
>> might not have the same set of groups that you have.  Neverthemind that
>> their filesystem might not support notion of file ownership, not only
>> do not have support for extended attributes and the like.
> 
> I would suggest that only with special switches like --preserve-chmod 
> --preserver-owner --preserve-group , etc. where one can guarantee user, 
> groups, etc. See also my second post for arguments.

Do *one* thing, and do it well.

Note that in 'tree' object (used to represent directories, and holding
names and executable permission of files) there is simply no place for
full ownership, for timestamp(s), for extended attributes.  And changing
repository format for such minor fringe usage is out of the question for
Git.

So you would have to use some .gitmetadata file to store additional
metadata.  And then you can utilize hooks mechanism, i.e. add this
functionality to extra tool like etckeeper or IsiSetup, just like patch
management is done with extra tools like StGit, Guilt or TopGit.

>> If you really, really need this, you can use additional tools to
>> preserve metadata, like Metastore or git-cache-meta, or even ready
>> tools that use Git as bckend like IsiSetup or bup (well, bup use
>> git package format, not git itself...), see this Git Wiki page:
>> https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
> 
> Will have a look at them.

-- 
Jakub Narebski
Poland
