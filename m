From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into modules
Date: Tue, 23 Aug 2011 13:40:13 -0700
Message-ID: <4E54102D.8060900@eaglescrag.net>
References: <1304431450-23901-1-git-send-email-jnareb@gmail.com> <1314131735.3120.3.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	"Alejandro R. Sedeno" <asedeno@mit.edu>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Tue Aug 23 22:42:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvxnc-00030Z-DN
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab1HWUmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 16:42:12 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:56160 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1HWUmK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 16:42:10 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p7NKeDcX010288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 23 Aug 2011 13:40:13 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1314131735.3120.3.camel@kheops>
X-Enigmail-Version: 1.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Tue, 23 Aug 2011 13:40:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179970>

Pretty much stalled like most things on gitweb.  I've been knee deep in
a lot of GSoC stuff, conferences and dealing with kernel bugs and Jakub
has been busy on other things so we haven't had a solid head bashing
session to get this all worked out yet.

Maybe while I'm over in Prague / Europe for KS & Linuxcon we can hash
things out.

- John 'Warthog9' Hawley

On 08/23/2011 01:35 PM, Sylvain Rabot wrote:
> Hi,
> 
> Just wanted to know what is the current status of splitting gitweb
> sources into modules.
> 
> Regards.
> 
> On Tue, 2011-05-03 at 16:04 +0200, Jakub Narebski wrote:
>> Gitweb is currently next to largest file (after gitk) in git sources,
>> more than 225KB with more than 7,000 lines.  Therefore adding any
>> large feature that would require large amount of code added, like
>> gitweb caching by J.H. and my rewrite of it, or "gitweb admin/write"
>> [failed] GSoC 2010 project by Pavan Kumar Sunkara, would require for
>> new code to be added as a separate module.  Otherwise gitweb would
>> fast become unmaintainable.
>>
>> Note that there is already patch series sent which as one of side
>> effects splits the JavaScript side of gitweb into many smaller
>> self-contained files:
>>
>>   [PATCH 03/13] gitweb: Split JavaScript for maintability, combining on build
>>   http://thread.gmane.org/gmane.comp.version-control.git/172384/focus=172385
>>
>> Not in all cases splitting gitweb upfront would be required.  At least
>> in the case of gitweb caching it doesn't.  What must be done however
>> is preparing the infrastructure for modular gitweb sources; to
>> properly test such infrastructure we need at least one split gitweb
>> module.  With patch series preparing for splitting or true splitting of
>> gitweb sent upfront the future patch series that implements
>> code-extensive feature (like e.g. output caching) would be smaller and
>> easier to review.
>>
>>
>> This series is intended to bring such infrastructure to gitweb, to
>> prepare way for adding output caching to gitweb. Alternatively it can
>> be thought as beginning of splitting gitweb into smaller submodules,
>> for better maintainability.
>>
>> This patch series was sent to git mailing list as
>>
>>   [PATCH 0/2] gitweb: Begin splitting gitweb
>>   http://thread.gmane.org/gmane.comp.version-control.git/165824
>>
>> In the above mentioned first version of this series, the first patch
>> that prepared the way for splitting gitweb was in three versions: A, B
>> and C.  In this second version of this series the first patch in
>> series most closely resembles version C in v1 series.
>>
>> In this version gitweb uses _both_ 'use lib __DIR__."/lib";' and
>> 'use lib "++GITWEBLIBDIR++";', in correct order (as compared to
>> version C of v1 series), so that __DIR__."/lib" is checked first,
>> i.e. modules installed alongside gitweb.cgi win.
>>
>> Pull request:
>> ~~~~~~~~~~~~~
>> This series is available in the git repository at:
>>   git://repo.or.cz/git/jnareb-git.git gitweb/split
>>   git://github.com/jnareb/git.git gitweb/split
>>
>> Well, those patches has a few minor cosmetic fixups...
>>
>> Table of contents:
>> ~~~~~~~~~~~~~~~~~~
>> * [PATCHv2 1/2] gitweb: Prepare for splitting gitweb
>>   [PATCHv2 2/2] gitweb: Create Gitweb::Util module
>>
>>   First patch implements infrastructure, second proof of concept patch uses
>>   this infrastructure, testing it ("make -C gitweb test-installed").
>>
>> Shortlog:
>> ~~~~~~~~~
>> Jakub Narebski (1):
>>   gitweb: Prepare for splitting gitweb
>>
>> Pavan Kumar Sunkara (1):
>>   gitweb: Create Gitweb::Util module
>>
>> Diffstat:
>> ~~~~~~~~~
>>  gitweb/INSTALL            |    7 ++
>>  gitweb/Makefile           |   23 ++++++-
>>  gitweb/gitweb.perl        |  151 ++++-----------------------------------
>>  gitweb/lib/Gitweb/Util.pm |  177 +++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 219 insertions(+), 139 deletions(-)
>>  create mode 100755 gitweb/lib/Gitweb/Util.pm
>>
> 
