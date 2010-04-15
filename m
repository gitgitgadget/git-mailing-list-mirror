From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 21:21:52 -0400
Message-ID: <4BC66A30.7030107@mailservices.uwaterloo.ca>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca> <201004150225.42101.jnareb@gmail.com> <7veiihmtjw.fsf@alter.siamese.dyndns.org> <201004150302.51242.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 03:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2Dma-0001gF-2s
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 03:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab0DOBWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 21:22:11 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:36813 "EHLO
	mailchk-m04.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753410Ab0DOBWK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 21:22:10 -0400
Received: from karakura.local ([74.198.12.14])
	(authenticated bits=0)
	by mailchk-m04.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o3F1Ltuq005917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 21:21:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201004150302.51242.jnareb@gmail.com>
X-UUID: 356b3564-63d1-401f-afce-1c1bd520c165
X-Miltered: at mailchk-m04 with ID 4BC66A33.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m04
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m04.uwaterloo.ca [129.97.128.141]); Wed, 14 Apr 2010 21:22:00 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144938>

On 10-04-14 9:02 PM, Jakub Narebski wrote:
> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>>> -gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>>>> +gitweb.cgi: gitweb.perl
>>> ...
>>> That makes gitweb.cgi not depend on gitweb.min.js, not gitweb.min.css.
>>
>> That is what I inteded to do.
>>
>> Unless you are including gitweb.cgi (iow, the contents of the generated
>> file depends on the _contents_ of gitweb.min.js (or gitweb.js), gitweb.cgi
>> does _not_ depend on these files.  Of course if you generate gitweb.cgi
>> out of gitweb.perl with one setting of GITWEB_JS and then change your
>> mind, then you need to regenerate it, but that is not something you can do
>> by comparing file timestamp of gitweb.cgi and the file timestamp of
>> $(GITWEB_JS) anyway.  You would need to imitate something like how
>> GIT-BUILD-OPTIONS is used by the primary Makefile.
> 
> Right.  I agree.
> 
> P.S. This is nt the case with git-instaweb, which literally include 
> gitweb.js or gitweb.min.js...
> 

I believe we can just change the variable names as planned before as well
as the dependancies, and that should fix up instaweb as far as will need
to be fixed, the rest has to happen at gitweb.cgi generation time.

My understanding (please correct me if I am wrong) is that comparing the
mtimes of the files is not reliable. So can't we just make gitweb.cgi
depend on source .js and .css files, since any modifications there will
also cause the minified versions to be regenerated? Can Junio's patch just
be updated to subst the suffix of GITWEB_JS and GITWEB_CSS, which makes sure
the correct version is being used?



-- 
Mark Rada
