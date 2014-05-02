From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: BUG or FEATURE? Use of '/' in branch names
Date: Fri, 2 May 2014 15:16:17 -0700
Message-ID: <20140502221617.GO9218@google.com>
References: <5363D1B4.1000503@lge.com>
 <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"simon.busch@lge.com" <simon.busch@lge.com>
To: Keith Derrick <keith.derrick@lge.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:16:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLkn-0004oB-Da
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbaEBWQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:16:21 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43481 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbaEBWQU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:16:20 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so5343857pdj.3
        for <git@vger.kernel.org>; Fri, 02 May 2014 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BA8h6l0hSu7G3uuQ2gdtDHk4PB9HhAnKwjUh9s1kYBM=;
        b=d+tSwdZBLnciRP277yS/MUgXLnSX8oS3/XHF9Ivrgh6D2LOCM8j6FapRrhHffAgBVg
         P+QB9C0RBnKlRrIs6qVUd3Y5NhXdNNh0WBsxwqv0tQ6OOb/YUNYY5bdcxTp2pHoCAraQ
         5tebWjAGn1a34ij4gdByBJb6R+4NJESeR2/O5vy1KvmVldPoobH7OPFyf/YmBGDDwfRc
         mAbCcVy9XtDEQSRVEtvjQBXQd8eHDSD9nmGQbeLblScM+BdprvGryrThceZwTcETj5N/
         Dnb6CC81qI8/mFoPiFJyuTnW/ToBYylNxzms7eYxIp4aKu2Dt5UvC4zw0NbVRdzAngyD
         aYRQ==
X-Received: by 10.67.1.39 with SMTP id bd7mr39839995pad.15.1399068980088;
        Fri, 02 May 2014 15:16:20 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xr9sm1982894pab.5.2014.05.02.15.16.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 May 2014 15:16:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247995>

Hi Keith,

Keith Derrick wrote:

>     $ git checkout -b hotfix
>     Switched to a new branch 'hotfix'
>     $ git checkout -b hotfix/b2
>     error: unable to resolve reference refs/heads/hotfix/b2: Not a directory
>     fatal: Failed to lock ref for update: Not a directory
>     $

That's an ugly message.  I think we can do better. (hint hint)

Longer term, I think people would like to make it possible for a
'hotfix' and 'hotfix/b2' branch to coexist, but that will take some
work, and until then, git tries to be careful about enforcing the
constraint that they cannot coexist.

Fixing it would be complicated by the need to avoid breaking people
with older versions of git when they fetch from you (what happens to
the origin/hotfix and origin/hotfix/b2 remote-tracking refs on the
client side?).

Thanks and hope that helps,
Jonathan
