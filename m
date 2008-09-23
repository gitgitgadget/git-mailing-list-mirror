From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Tue, 23 Sep 2008 19:51:19 +0200
Organization: At home
Message-ID: <gbbaam$hte$1@ger.gmane.org>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com> <20080923165247.GO21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 19:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiC45-0002D7-JG
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 19:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYIWRv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 13:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbYIWRv2
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 13:51:28 -0400
Received: from main.gmane.org ([80.91.229.2]:56917 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbYIWRv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 13:51:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KiC2n-0000o6-US
	for git@vger.kernel.org; Tue, 23 Sep 2008 17:51:25 +0000
Received: from abuz85.neoplus.adsl.tpnet.pl ([83.8.197.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 17:51:25 +0000
Received: from jnareb by abuz85.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 17:51:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abuz85.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96581>

Dmitry Potapov wrote:
> On Tue, Sep 23, 2008 at 04:37:14PM +0200, Alex Riesen wrote:
>> 2008/9/23 Dmitry Potapov <dpotapov@gmail.com>:

>>> +stat_fn_t cygwin_stat_fn = cygwin_stat_choice;
>>> +stat_fn_t cygwin_lstat_fn = cygwin_lstat_choice;
>> ...
>>> +typedef int (*stat_fn_t)(const char*, struct stat*);
>>> +extern stat_fn_t cygwin_stat_fn;
>>> +extern stat_fn_t cygwin_lstat_fn;
>> 
>>     extern int (*cygwin_stat_fn)(const char *, struct stat *);
>> 
>> Is shorter, easier to read and easier to understand (for a C person).
>> You don't even use the type anywhere else, it is just for the declaration sake!
> 
> I use it in description of a parameter of another function:
> 
> static int do_stat(const char *file_name, struct stat *buf, stat_fn_t cygstat)
> 
> Of course, you can avoid it here too, but the declaration will become
> somewhat longer:
> 
> static int do_stat(const char *file_name, struct stat *buf,
>        int (*cygstat)(const char *, struct stat *));
> 
> so I am not sure that removing stat_fn_t improves readability, but if
> there are other people who think so, I will correct that.

I think that using typedef here definitly improves readibility.
You don't have to carefully analyse if you can pass cygwin_stat_fn
to do_stat function or not.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
