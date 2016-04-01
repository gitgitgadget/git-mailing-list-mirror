From: Peter Waller <p@pwaller.net>
Subject: Masking or hiding directories and files during a git submodule
 checkout
Date: Fri, 1 Apr 2016 12:56:46 +0100
Message-ID: <56FE61FE.2020700@pwaller.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 14:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alxn1-0003o1-T3
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 14:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcDAMCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 08:02:55 -0400
Received: from mail.foo.to ([144.76.29.196]:52541 "EHLO mail.foo.to"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbcDAMCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 08:02:54 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Apr 2016 08:02:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pwaller.net; s=mail;
	t=1459511855; bh=3fhyJkcgZMZO52HNXrmrGySJqRypOjy2flLkjO73wRU=;
	h=To:From:Subject:Date:From;
	b=NXubFGGdOQX6VuOjlwsXzX72dqt77WvhX6SWnZrXTyq6qqJBwKmduV6J9aJWMuf36
	 2Gf9bITMkFJEzjDpw6jp/qSrMR+G40wW1p+8a+IgvI3jhrbP/9QhcU7OAzQctAJiMT
	 b3UsgrnNoxiXhxNfW7YlznSEiJTlgvTCu88bgoms=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290528>

Hi All,

My constraints are as follows:

* I use submodules to reference other people's code.
* I don't like to have to send commits to those authors of those 
submodules, they might not be accepted.
* I don't want to maintain my own fork of the submodule.
* Some submodules may contain lots of stuff I don't want to check out.
* I want other people (and existing tooling, such as `go get`) to be 
able to do an ordinary git clone --recursive and not get specific 
directories within some submodules checked not.

In my specific use case, I have:

/myfile
/submodule1/directory/nestedsubmodule2

That is, submodule1 itself uses submodules and contains a directory with 
nestedsubmodule2.

What I would like to achieve is to be able to specify in my repository 
configuration that I don't want anything living in 
/submodule1/directory/ to be checked out. But I want to check out 
everything else as normal.

Ideally, this would happen automatically during a git clone --recursive, 
probably by being specified somewhere such as .gitattributes. I envisage 
it this way so that it would work automatically with existing tooling.

* Is this possible now via any means?

* Is this against some fundamental philosophy?

* Is it conceivable that patches would be accepted to make this happen?

Thanks,

- Peter

For further information, this is a follow on from a mega-thread about 
vendoring packages in go [*]. I'm seeking a minimal solution where 
little additional tooling is required, and this is just one avenue I'm 
pursuing. One such solution (considered in this email) could be to avoid 
checking out specific directories which live in submodules. Of course if 
it requires changes to git, I'd have to wait for it to update before I 
can use that feature, but I'm OK with that, so long as we have a 
solution which works eventually.

[*] https://groups.google.com/d/topic/golang-nuts/AnMr9NL6dtc/discussion
