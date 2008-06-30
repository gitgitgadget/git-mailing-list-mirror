From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v8] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 30 Jun 2008 23:55:49 +0200
Message-ID: <200806302355.50560.jnareb@gmail.com>
References: <1214273933-3925-1-git-send-email-LeWiemann@gmail.com> <200806300156.28908.jnareb@gmail.com> <48682934.6090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 23:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRMy-0000vn-S8
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 23:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934214AbYF3V4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 17:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933327AbYF3V4E
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 17:56:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:60526 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934214AbYF3V4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 17:56:02 -0400
Received: by ug-out-1314.google.com with SMTP id h2so319527ugf.16
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=OpaSoKnvLoKkKXpCaMOl6RpfYCDc4pwjYpF7jigZ4qM=;
        b=muCcX5xGxDn+9CsN2Ut54jkVc9gWOZp850AQo0KofcvzIiwe7a1gr7OhUfo8872BTX
         +mmwL9LxoeFzw5/4zLeuaoDRbvAq7lJNqMToZsKXX6TYUTLByN8CBUbPmlRJenFkbrDA
         BGGQvUlXx8KEumiPdtwLfojFWRWrsKnVDh8Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=htYKW3c78efzeCmhSXBl2Sa1Lw3yF0PZQ7sOKkxJR2rXRYQgV/FPND/RaDsymuf0Is
         yStL9xWIUrPr0D91q10RlACCqOMGGO6AWx7jIU2ViJVdOEv19LbvlNvOJrTHx+M4sY7v
         Bi0LVVeXer6ncJamwm9GKgRdEe4c7sDT+N/h4=
Received: by 10.66.234.8 with SMTP id g8mr4045814ugh.43.1214862958421;
        Mon, 30 Jun 2008 14:55:58 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.210.122])
        by mx.google.com with ESMTPS id 18sm1441885ugk.80.2008.06.30.14.55.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 14:55:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <48682934.6090406@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86939>

On Mon, 30 Jun 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> some time ago I have send a patch which converted support for
>> links with hash and without action to use redirect instead of
>> silently filling correct action based on type of object [...]
>> IMHO it is better as it should prevent bookmarking "expensive" URL.
> 
> Haha, I'd actually suggest the opposite. ;-)  Figuring out the right
> action is almost free since you have to fetch the object anyways, so I
> doubt it'll make any difference performance-wise (though it'd be
> interesting to benchmark this).

It is one fork more[*1*], which doesn't matter on operating systems
like Linux where forking is fairly cheap.

But perhaps avoiding redirect would be better solution... well, yet
another solution would be to leave it up to gitweb configuration ;-)

[*1*] Or pre-fetching object (together with its type) which might be
large, into memory.

> However, gitweb's URLs are 
> prohibitively long -- so that nobody uses them in email --, and
> (automatically?) dropping the action parameter where possible would be a
> good first step to shortening them.  Another idea would be to shorten
> the hashes.

About shortening the hashes: _usually_ 8. characters is enough... but
sometimes it isn't.  What then?

[...]
>> [Git::Commit:] you should not error out on unknown header in commit object,
> 
> Unless this can actually happen in practice, I'd rather die aggressively
> -- it prevents errors (like cache hiccups) slipping through unnoticed.

If Git::Commit is to be *generic* object oriented interface to git
repository (and not only for gitweb), it has either to skip unknown
commit headers, or save them as-is.

As to checking cache: you can always check if header name is sane...
-- 
Jakub Narebski
Poland
