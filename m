From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Fri, 8 Oct 2010 02:05:11 -0500
Message-ID: <20101008070511.GA4671@burratino>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
 <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com>
 <20101007202847.GA13234@burratino>
 <4CAEBF2E.8020206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:08:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P474C-0003pY-IY
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752065Ab0JHHI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:08:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38349 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0JHHIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:08:25 -0400
Received: by gwj17 with SMTP id 17so243495gwj.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7ZTDN55/kqgsD8DI7xOzmli2AecM5mpwuHphvjt1ex0=;
        b=J0bpm9MIlxzyjRnS+bp3phxlVPslFkeZ2TDUGMS+T1VQIk32q2Qst107kLnPi2sfnQ
         /PLMUkDMtrc9Fn5C6xDXSWlA7dZRZbWT33Bemq1Db8SqHYDztWuP4Z4uu+/3pOVLZSZa
         6+dz0pbrGQuXxhlwuzheBe5xVSN6zBMkri80U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FW8LGgm3MgTD45Ds9djtgUxUuD5lVDHDBoFv+jEedCoRBEY3JA9Gf+2BZPmdk6zlf7
         sQCr3Ke3B5b75hLXX2PEC+q7oTc7CwzRUwExc8oeLObPw/bwZRSVz+lkv2mweKncKq+R
         OQpsq5Li4nwrLAvyYQLyNrsx1XiLmWCs+F1pA=
Received: by 10.101.118.2 with SMTP id v2mr265290anm.267.1286521704577;
        Fri, 08 Oct 2010 00:08:24 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g18sm2881708anh.38.2010.10.08.00.08.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:08:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4CAEBF2E.8020206@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158479>

Johannes Sixt wrote:
> Am 10/7/2010 22:28, schrieb Jonathan Nieder:

>> | For a command (like filter-branch --subdirectory-filter) that wants
>> | to commit a lot of trees that already exist in the object db, writing
>> | undeltified objects as loose files only to repack them later can
>> | involve a significant amount[*] of overhead.
>
> 1. But when an object already exists in the db, it won't be written again,
> will it?

In David's application, the trees already exist, but the commits are new.

> 2. Even though fast-import puts all (new) objects into a pack file, the
> pack is heavily sub-optimal, and you should repack -f anyway. So what's
> the point? Only to avoid a loose object?

To avoid thousands of loose objects.

> (I'm not saying that the patch is unwanted, but only that the
> justification is still not sufficiently complete.)

No problem - these questions are useful.  If the result is learning
that something else is responsible for the speedup David observed in
his script, that would not be a bad outcome after all.

I suppose supporting M 040000 <tree> "" and C <path> "" could still
be a good idea in that case anyway, for the convenience of front-end
authors.

Jonathan
who still hasn't reviewed the patch (sorry)
