From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: Add tests for memmem, strtoumax and mkdtemp functions
Date: Wed, 21 Nov 2007 19:47:50 +0100
Message-ID: <200711211947.50661.jnareb@gmail.com>
References: <200711191947.05960.jnareb@gmail.com> <20071121065858.GU14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 19:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuucR-0001yU-26
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 19:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbXKUSr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 13:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXKUSr5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 13:47:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:12481 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbXKUSr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 13:47:56 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2211030nfb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=GfObD7ZzTIEKJ3xKB5jNtBJX7/gR84O8JtWwJbW+yO0=;
        b=k+lK+S+dkEJBry5yJstreGrXEp/zUZkjXnCzT4d0UgWFJW1u54BMJzkatt9e3LuZH+B1F3GjB7p105l3RjAfXbxuQHp/GwDIPQZ/MeRZYEuzJLiYYz36cCX9w7gBE8s9XBEGTUqgJlnKutPQERhhwSDgiXQ3roP/nbRYsNc4hDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SbX0BqtC8aiCXxA0cOxCbnX66ZJm5cmC7GCPHzQ2ZN8kR9V2VHC7lEl/E/MEaPoaWl9YdFd+SmDO+h9s2CeBg05jdEFLvqDVCpF0x+enm/AmhCMCyReNxJWHweaIYMp5QY2Yf1nH3JwKEgkwoj/hbcT5Mib/0nYuKryLogcn9s8=
Received: by 10.82.112.3 with SMTP id k3mr21724305buc.1195670873499;
        Wed, 21 Nov 2007 10:47:53 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.19])
        by mx.google.com with ESMTPS id 22sm31661fkr.2007.11.21.10.47.50
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Nov 2007 10:47:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071121065858.GU14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65690>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> By the way, do you have idea how to test for the following
>> in configure.ac:
>> 
>> * Define NO_PREAD if you have a problem with pread() system call (e.g.
>>   cygwin.dll before v1.5.22).
>> 
>>   - what is the problem? how to detect it?
> 
> This also appears to be broken on HP-UX (e.g. we need to set
> NO_PREAD there).  Thiago on IRC talked about this the other day
> when he was trying to build git on a bunch of different systems.
> 
> Unfortunately this may just need to be an OS based test.  The code
> compiles just fine but when index-pack tries to use pread to walk
> back through the deltas and generate their SHA-1s it barfs without
> an error code.  I suspect the failure is pread claiming it put the
> data into the user buffer but not actually doing so, which causes
> zlib's inflate() to then see data corruption.

Can you write a short program which demonstrates this error (either
fails with some error code, or produces wrong output)? That would be
enough for configure.ac (see for example NO_C99_FORMAT in configure.ac)

Unless this is Schroedinger bug...

-- 
Jakub Narebski
Poland
