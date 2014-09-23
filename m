From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 22/35] git_config_set_multivar_in_file(): avoid call
 to rollback_lock_file()
Date: Tue, 23 Sep 2014 15:08:47 +0200
Message-ID: <542170DF.8050205@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-23-git-send-email-mhagger@alum.mit.edu> <20140916222814.GV29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWPwm-0001Oo-6y
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 15:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbaIWNPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 09:15:53 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62132 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750901AbaIWNPw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 09:15:52 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Sep 2014 09:15:52 EDT
X-AuditID: 1207440f-f79156d000006a5c-ad-542170e2848e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A4.B7.27228.2E071245; Tue, 23 Sep 2014 09:08:50 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1DCD.dip0.t-ipconnect.de [93.219.29.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8ND8l2d020719
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 23 Sep 2014 09:08:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916222814.GV29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsUixO6iqPuoQDHE4NomGYuuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DO2Nm+jangOmtFz+udLA2MJ1i6GDk4JARMJB4frO5i
	5AQyxSQu3FvP1sXIxSEkcJlRouNHHwuEc55JorttJjNIFa+AtsStjzPYQGwWAVWJHzdug8XZ
	BHQlFvU0M4HYogIBEh86HzBC1AtKnJz5hAXEFhHQkHj+6RvYBmaBj4wSc6+fZAW5QlggVaK3
	2xJi2SJGiVX3/oMN4hQwkNi7ex3YMmYBPYkd13+xQtjyEtvfzmGewCgwC8mOWUjKZiEpW8DI
	vIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJBL4dzB2rZc5xCjAwajEw+ux
	RiFEiDWxrLgy9xCjJAeTkihvcpZiiBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXrEMoBxvSmJl
	VWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYJXFhjxQoJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgWI0vBkYrSIoHaK8QSDtvcUFiLlAUovUUozFHS9PbXiaOdZ3f
	+pmEWPLy81KlxHm35gOVCoCUZpTmwS2CpcBXjOJAfwvzvgap4gGmT7h5r4BWMQGtun9cHmRV
	SSJCSqqBMb4g/0Jbfntf+/RCua0/focs1HT589zCLu9Owb0r2SV2prO4L0ksi7ud 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257418>

On 09/17/2014 12:28 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> After commit_lock_file() is called, then the lock_file object is
>> necessarily either committed or rolled back.  So there is no need to
>> call rollback_lock_file() again in either of these cases.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> This seems to involve an unadvertised behavior change: before
> it wouldn't call git_config_clear() on failure, and after the
> patch it would.  Intended?
> 
> I think it would be clearer with the goto for exception handling
> maintained (and just a second 'lock = NULL' assignment).

Good catch; will fix.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
