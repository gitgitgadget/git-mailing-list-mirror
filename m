From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: git performance
Date: Wed, 22 Oct 2008 17:13:56 -0400
Message-ID: <eaa105840810221413m4d0ed51ejab28f66493a12a13@mail.gmail.com>
References: <000801c93483$2fdad340$8f9079c0$@com>
	 <20081022203624.GA4585@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Edward Ned Harvey" <git@nedharvey.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 23:15:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksl35-0000cI-Qb
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbYJVVN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbYJVVN6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:13:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:59308 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbYJVVN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 17:13:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so782rvb.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=+q+AL/xPllK+dU0SAUI6DBPO8VaUf/uXt5O++A96j+4=;
        b=QLZ+VpbqCDh8K5cMawZ6IP1arn6WMX7JkpC8YMWw5DmlY3EMTfLrdOCYycF8Sul221
         cD4GCgf0Jiz3WFhA2NnMSI0kdRgNPz3kJUxZDJBIkv/XjCszJQUsyt1Tw5Hu/Wj1sTZa
         VozIIUdq7ml/QpjGk8HKhKGubLhBAi37NlNec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=OSrVgV5+61BiA7RQznpWWtozDWwXQZzfX14PYsxS4sl6zxRDV64KeBYT0wc905/9Kq
         zPPTa/BcXwqKOBqg6/PAVB73AznQDkcqhOY1XqRM6znwFsqzkV/a7lYNZ96z7C5RaaeY
         8+hBhZcPwgKVHGGmtqGu16kAWEv0cJC4rN4UM=
Received: by 10.140.164.1 with SMTP id m1mr6789300rve.69.1224710036805;
        Wed, 22 Oct 2008 14:13:56 -0700 (PDT)
Received: by 10.141.97.15 with HTTP; Wed, 22 Oct 2008 14:13:56 -0700 (PDT)
In-Reply-To: <20081022203624.GA4585@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 96af99b6f7cb9f84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98913>

On Wed, Oct 22, 2008 at 4:36 PM, Jeff King wrote:
> On Wed, Oct 22, 2008 at 04:17:16PM -0400, Edward Ned Harvey wrote:
>
>> So - I didn't see anything out there saying "git is fast because it
>> uses inotify" or anything like that.  Perhaps git would not help me at
>> all?  Because git still needs to stat all the files in the tree?
>
> Yes, it does stat all the files. How many files are you talking about,
> and what platform?  From a warm cache on Linux, the 23,000 files kernel
> repo takes about a tenth of a second to stat all files for me (and this
> on a several year-old machine). And of course many operations don't
> require stat'ing at all (like looking at logs, or diffs that don't
> involve the working tree).

Windows is rather slower than Linux, so differences are more obvious.
I find git feels "only" about 2x as fast as svn at status. svn has to
stat all of its base files too, whereas git has the index. git pull
(vs svn update) feels better than 2x faster, since git doesn't need to
walk the tree and lock every sub-dir before it even connects to the
remote server.

So we're not talking 'inotify' fast, but maybe half a cup of coffee
instead of a full cup if you have that many files.

"git-svn" is really quite good. I recommend you try a quick (trunk and
maybe one branch only, last few revisions only) import of your svn
tree to test with.

Peter Harris
