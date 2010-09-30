From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in	submodules
Date: Thu, 30 Sep 2010 21:48:16 +0200
Message-ID: <4CA4E980.1010100@web.de>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <4CA3C569.4020309@gmail.com> <20100930185937.GA15457@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 21:49:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1P8Z-0008MR-9T
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 21:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab0I3Tts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 15:49:48 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42594 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288Ab0I3Ttr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 15:49:47 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 1BCC1173ABB6A;
	Thu, 30 Sep 2010 21:48:19 +0200 (CEST)
Received: from [93.246.41.77] (helo=[192.168.178.29])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P1P75-0005Z1-00; Thu, 30 Sep 2010 21:48:19 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20100930185937.GA15457@book.hvoigt.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+XWVKeM3MOvc03H5+NqR6jLiMlvWpTKrwC9IMP
	GP035AzlEDKj8DQBUx1l1xHD4YWDQ8zF/KDjr9FFUyIZEYQo6f
	ejkir1lJUM+kpM0vL+BA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157705>

Am 30.09.2010 20:59, schrieb Heiko Voigt:
> How about dropping the option all together and making grep search all
> populated submodules by default and maybe have an option to turn it off.

And that option might be called "--no-recursive"? :-)

But when we add an config setting to control the default behavior
later (which we had to do for all submodule recursion features so far
where we changed the default to recursion) we'll need the "--recursive"
option again anyway to be able to override the config setting. So I
vote for just leaving the option as it is for now, and we can discuss
the proper default as we go along (And in case of grep I have not made
up my mind as to what a sane default would be, personally I'm fine with
having to use the "--recursive" option when I want recursion, but I
won't object to making it the default either).


> Since git grep is searching recursive by default this would be what I
> would expect as a user. Are there other reasons to turn off the search
> in submodules than the potential runtime penalty because of forks? 

The runtime penalty is a *very* important aspect, as we have some
submodule users who have put huge trees into submodules especially to
avoid the performance penalties (see the discussions for recursive
diff and status). So if we change the default, we will have to
provide an config option for that.
