From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 1 Aug 2008 18:11:06 +0700
Organization: AcademSoft Ltd.
Message-ID: <200808011811.06984.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com> <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 13:12:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOsYU-0000JU-M4
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 13:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbYHALLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 07:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbYHALLR
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 07:11:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:17163 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbYHALLR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 07:11:17 -0400
Received: by ug-out-1314.google.com with SMTP id h2so473397ugf.16
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kFNAHBvTLCZsqPKKwoBtBUWpwLGgfu2o6pJ7GmpUyXk=;
        b=L4d2uCaokrezpfZBLJxHR4C0FTX2IeDkHW6sbmdNyLVysvGXpaCBKVh4qqgkDqASjB
         hrMWOOKGurNZ+HsNszi2A6WYxftmh4pMGnkSkKpanr6CJKbE9OD+IpxJlWa+DosWDCBj
         diqLka7UJEMfQKMUxwpWPSB/xnH9/+he5qH+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wWMo8cqfTMaEQHdWcLZfOQDam+qX1oYFryoYM8NfWtjz0h9umNuitvdamn9wvtjteF
         veaL4DkEPJCaQJVvoMdMFv9awlEBmQY5hAF9dd1ly7kXlvL633c0SHRE0v4mwmWvYiCt
         YY+Cuw9BOr+nCzaz7erCTy1ozM0nh1DFG+e2A=
Received: by 10.67.106.13 with SMTP id i13mr3589118ugm.37.1217589075429;
        Fri, 01 Aug 2008 04:11:15 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id i39sm13982064ugd.75.2008.08.01.04.11.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 04:11:14 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91056>

> To being able to synchronize efficiently in both ways, you need to store
> files exactly as they were received from SVN then there will be no
> problem with applying binary delta patch. All CRLF conversion should be
> done on checkout and checkin from/to Git repository.

Sorry I have lost the mind flow here.

1. We 'fetch' files from svn as is. Yes, we know that svn use delta to rebuild 
original file.
2. We commit file to git. Right here we use git-hash-object. As I understand 
we _have_ to do convertion CRLF->LF here.
3. In some days we will checkout file from git and wil do LF->CRLF convertion.

I thought this is a right workflow. 
- We could store original file too at step 2 somwhow to be able to use delta 
at step 1.
- We can't skip convertion at step 2. Overwise git will store files with CRLF.

Am I wrong ?
