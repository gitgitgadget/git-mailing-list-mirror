From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 18/35] commit_lock_file(): if close fails, roll back
Date: Tue, 23 Sep 2014 13:30:23 +0200
Message-ID: <542159CF.7020105@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-19-git-send-email-mhagger@alum.mit.edu> <20140916221956.GR29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 13:37:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWOPV-0005Lv-K3
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 13:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbaIWLh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 07:37:29 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52609 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753694AbaIWLh2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 07:37:28 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Sep 2014 07:37:28 EDT
X-AuditID: 12074411-f79d86d000006a97-4d-542159d2c452
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B8.27.27287.2D951245; Tue, 23 Sep 2014 07:30:26 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DCD.dip0.t-ipconnect.de [93.219.29.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8NBUNe7016715
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Sep 2014 07:30:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916221956.GR29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqHspUjHE4MlXJYuuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DO2HG6halgD3/F06mrWRsYl/F0MXJwSAiYSGycldrF
	yAlkiklcuLeeDcQWErjMKPH1nGYXIxeQfZ5J4uG0fawgCV4BbYlFD+YxgdgsAqoShx4dZwax
	2QR0JRb1NIPFRQUCJD50PmCEqBeUODnzCQuILSKgIfH80zc2kKHMAh8ZJeZePwk2VFjAW6Lv
	9D4miG2LGCXObHsDdgangIHE/3u3wTYwC+hJ7Lj+ixXClpdo3jqbeQKjwCwkS2YhKZuFpGwB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJBIENzBOOOk3CFGAQ5GJR5e
	jzUKIUKsiWXFlbmHGCU5mJREeQtDFUOE+JLyUyozEosz4otKc1KLDzFKcDArifC+CwPK8aYk
	VlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeOdHADUKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEg2I1vhgYrSApHqC9oSDtvMUFiblAUYjWU4y6HOs6v/UzCbHk
	5eelSonz3gwHKhIAKcoozYNbAUt7rxjFgT4W5l0HMooHmDLhJr0CWsIEtOT+cXmQJSWJCCmp
	Bkanbc0l+zqXvC2/+WBmV1aruoKx1wxtqURZqc//fU7oBLz6Y77k+adcvoVbzQqe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257411>

On 09/17/2014 12:19 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> If closing an open lockfile fails, then we cannot be sure of the
>> contents of the lockfile
> 
> Is that true?  It seems more like a bug in close_lock_file: if it
> fails, perhaps it should either set lk->fd back to fd or unlink the
> lockfile itself.

>From close(2) (note especially the last sentence):

> Not checking the return value of close() is a common but nevertheless serious  programming
> error.   It  is  quite  possible  that  errors  on a previous write(2) operation are first
> reported at the final close().  Not checking the return value when closing  the  file  may
> lead  to  silent  loss  of  data.   This can especially be observed with NFS and with disk
> quota.  Note that the return value should only be used  for  diagnostics.   In  particular
> close() should not be retried after an EINTR since this may cause a reused descriptor from
> another thread to be closed.

>From that I conclude that if close() fails, pretty much all bets are off
about the contents of the lockfile. So we wouldn't want to set lk->fd
back to fd.

But finishing the rollback itself might be an alternative...

> What do other callers do on close_lock_file failure?

>From what I can see, the only callers that don't die() immediately are
the following (which call close_lock_file() directly or indirectly via
write_locked_index()):

try_merge_strategy(): returns an error. It looks like this could end up
reusing the same lock_file object before it had been rolled back ->
would be improved if close_lock_file() would rollback on failure.

write_cache_as_tree(): does a rollback -> wouldn't mind an automatic
rollback.

merge_recursive_generic(): returns an error, and caller exits
immediately -> wouldn't mind an automatic rollback.

So, I will change close_lock_file() to roll back on errors.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
