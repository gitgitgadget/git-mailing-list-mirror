From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Fwd: Git SCM and zlib dictionaries
Date: Tue, 15 Aug 2006 11:19:59 -0400
Message-ID: <9e4733910608150819l6ba602e2q2f52a5693a2bac4d@mail.gmail.com>
References: <9e4733910608141908g1b4d27c3p39825affe533c2b9@mail.gmail.com>
	 <9D46F80A-D544-4AA5-B3A6-736760E0F246@alumni.caltech.edu>
	 <9e4733910608142148x40be4fa4y6510112210849db9@mail.gmail.com>
	 <D0E80738-9D39-4A88-9E43-BA78191AF273@alumni.caltech.edu>
	 <9e4733910608150600u2fbe50cn208e9a188636c8e@mail.gmail.com>
	 <9e4733910608150611p75f1f369w25342bfa5726ed44@mail.gmail.com>
	 <00B40C71-72B6-499B-806B-64A140136944@alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 15 17:21:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD0i8-0007nG-UY
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 17:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWHOPUD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 11:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWHOPUD
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 11:20:03 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:63953 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030339AbWHOPUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 11:20:00 -0400
Received: by wr-out-0506.google.com with SMTP id i21so216999wra
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 08:20:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lPr4n2lCKEk1SCC948QCnWukhDjb1k0SPdXWzm/ASbCdkhyWzSOgdIFx7ZW2ZAx4BbqOVXmQ/i8XbSqKahAUqO86KDA14LqLXB453lP7nFAOpcDlLTD+Zbraoo/8n2G8KW6qoiyTy7jIIW5VwkCH+Pbv9WykVVemO5mMGVdanLg=
Received: by 10.48.220.15 with SMTP id s15mr1532434nfg;
        Tue, 15 Aug 2006 08:19:59 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Tue, 15 Aug 2006 08:19:59 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
In-Reply-To: <00B40C71-72B6-499B-806B-64A140136944@alumni.caltech.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25459>

---------- Forwarded message ----------
From: Mark Adler <madler@alumni.caltech.edu>
Date: Aug 15, 2006 10:43 AM
Subject: Re: Git SCM and zlib dictionaries
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jean-loup Gailly <jloup@gzip.org>


On Aug 15, 2006, at 6:11 AM, Jon Smirl wrote:
> What we are doing is similar to full-text
> search indexing.

If the point of very small (1Kish) compressed chunks is for random
access and individual decompression of those pieces, then there are
other approaches.  You can for example compress many of them together
for better compression (say 32), and accept some speed degradation by
having to decompress on average half (16) of them to get to the one
you want.

------------------------------
We have delta runs of about 20 revsisions, compress those 20 blobs as
a group instead of individually. The pack index would point all 20
sha1's to the same blob with a different type code. You had to load
and unzip most of these objects anyway to compute the revision off
from the diffs. Putting them into a single zip means that they share a
single compression table.
-------------------------------

Or you can process the whole thing to create a custom coding scheme,
as illustrated in "Managing Gigabytes":

     http://www.cs.mu.oz.au/mg/

mark



-- 
Jon Smirl
jonsmirl@gmail.com
