From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Compression and dictionaries
Date: Tue, 15 Aug 2006 09:29:28 -0400
Message-ID: <9e4733910608150629t1826717cqc4bde9f1ab5cc725@mail.gmail.com>
References: <20060815083303.13253.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 15:29:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCyzG-0006E3-7d
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 15:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbWHON3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 09:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWHON3b
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 09:29:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:41942 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752101AbWHON3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 09:29:31 -0400
Received: by nf-out-0910.google.com with SMTP id x30so328367nfb
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 06:29:29 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aVDeQZnveYD0dtDdKscVXqo5Y0J87Y3H3/eiHcmhAAySOXnMlkAPWnpvizBHOBlUEfGKhBjORq4Yh2IYqBPGU0jqIlP/T742MeBOrNKPlwKm9vJ+YqtQhOtObk9nVAUfdn7YqI45z7KrJMuXUJK6D8fiVfcBcyIHHNZB7l2zHOI=
Received: by 10.49.29.3 with SMTP id g3mr1394553nfj;
        Tue, 15 Aug 2006 06:29:29 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Tue, 15 Aug 2006 06:29:28 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060815083303.13253.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25456>

On 15 Aug 2006 04:33:03 -0400, linux@horizon.com <linux@horizon.com> wrote:
> Just to inform this discussion, a brief description of the zlib
> "deflate" algorithm.  A full description is in RFC1951.
>
> This is LZ77 compression, meaning that what is actually encoded is
> a series of instruction to either
> - Insert a specified byte, or
> - Copy a run of n bytes, starting m bytes ago.

Shawn and I did some testing overnight. A simple 4KB preload table
yielded a 4% size reduction in my 850MB pack. I'm still hoping for 10%
using an optimal 32K table.

Paper on computing the optimal preload table:
http://www.eecs.harvard.edu/~michaelm/postscripts/dcc2001a.pdf

If anyone is interested in doing some research, it would be
interesting to build a pack engine based on full-text search
technology. For example cLucene,
http://clucene.sourceforge.net/index.php/Main_Page The full-text
search app contains the code for extracting the dictionary and then
encoding all of the blobs using it.

My prediction is that a large global dictionary based scheme will
compress significantly better than zlib is capable of.

-- 
Jon Smirl
jonsmirl@gmail.com
