From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Sat, 01 Nov 2008 12:17:22 +0100
Message-ID: <490C3AC2.4080002@op5.se>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <490B7FD3.8060003@op5.se> <20081031220133.GA14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 12:18:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwEVH-0001AD-0v
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 12:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYKALRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 07:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbYKALRg
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 07:17:36 -0400
Received: from mail.op5.se ([193.201.96.20]:39423 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbYKALRf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 07:17:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BDB6C24B0003;
	Sat,  1 Nov 2008 12:12:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oFOUlT00YDfO; Sat,  1 Nov 2008 12:12:16 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 5BB501B80066;
	Sat,  1 Nov 2008 12:12:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081031220133.GA14786@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99733>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>>>   * proper public "stuff" naming (I e.g. realy like types names -- not
>>>     struct or enum tags, that I don't really care -- ending with _t as
>>>     it helps navigating source.
>> *_t types are reserved by POSIX for future implementations, so that's
>> a no-go (although I doubt POSIX will ever make types named git_*_t).
> 
> Yikes.  Anyone know where a concise list of the reserved names are?
> 

The ones I know of off the top of my head are:
* Anything ending with _t (posix)
  pthread_t, size_t, socklen_t, ...
* str/mem/? function name prefix NOT followed by an underscore (C lib)
  strlen, strchr, memcmp, memcpy, ...
  (strbuf_ stuff doesn't break this, as it contains an underscore in the
   name - the underscore following it doesn't have to be immediate).
* Double underscore prefix (compiler / C lib)
  __WORDSIZE, __cplusplus, ...


It's also a good idea to stay away from single underscore prefix for
generic-ish names, as some compilers/architectures abuse it extensively.

Prefixing all public functions and macros of the library with 'git_'
(lower-case for functions and function-like macros, upper-case for
the rest) will probably see us through safe. Exceptions can probably
be made for already completed API's, such as the arg-parsing stuff
and the strbuf code.

>> Apart from that, please consider reading Ulrich Drepper's musings on
>> library design at http://people.redhat.com/drepper/goodpractice.pdf
> 
> I think I've read that before, but I'll skim over it again.
> Thanks for the link.
> 

I swear by it at work, where I'm "the library guy". I'll make sure to
review stuff and can chip in code or thoughts to make the library fly
with a minimum amount of problems and maintenance burden.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
