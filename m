From: Shlomit Afgin <shlomit.afgin@weizmann.ac.il>
Subject: Re: Error in creating git over http
Date: Thu, 10 Oct 2013 05:25:42 +0000
Message-ID: <51123DD1BF2E03418A1296748DA730927454C9B2@ibwmbx03>
References: <20131010010616.GA14429@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 10 07:25:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU8kx-0007rc-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 07:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112Ab3JJFZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 01:25:47 -0400
Received: from sentinel1-in.weizmann.ac.il ([132.76.60.31]:37299 "EHLO
	Sentinel1-in.weizmann.ac.il" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752090Ab3JJFZr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 01:25:47 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ai4FAEw5VlKETARJ/2dsb2JhbABagwc4UsEZgR4WgxkBAQEBAzo/EgEIDgoKFEIlAgQOBQiHfgywIokUjGGCMzEHgx+BBAOZMpBSgySCKg
X-IronPort-AV: E=Sophos;i="4.90,1069,1371070800"; 
   d="scan'208";a="3131837"
Received: from doar.weizmann.ac.il ([132.77.4.35])
  by Sentinel1-out.weizmann.ac.il with ESMTP; 10 Oct 2013 07:25:43 +0200
Received: from smtp.weizmann.ac.il (ibwhbxv01.wismain.weizmann.ac.il [132.76.4.73])
	by doar.weizmann.ac.il (8.13.8/8.13.8) with ESMTP id r9A6PDPb017575;
	Thu, 10 Oct 2013 08:25:14 +0200
Received: from IBWMBX03.wismain.weizmann.ac.il ([132.76.4.77]) by
 IBWHBXV01.wismain.weizmann.ac.il ([132.77.160.73]) with mapi id
 14.02.0318.004; Thu, 10 Oct 2013 07:25:43 +0200
Thread-Topic: Error in creating git over http
Thread-Index: AQHOxDJDbgBV697Y0k2SOI9i0dnZMZnq5zcAgAIH8oCAAHrEgA==
In-Reply-To: <20131010010616.GA14429@sigill.intra.peff.net>
Accept-Language: en-US, he-IL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.6.130613
x-originating-ip: [132.77.26.178]
Content-ID: <EF259AEA9222FD49AB2227BDF1DEF39E@weizmann.ac.il>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235851>


Thanks for your answer.

I did not know about "dumb" and "smart" I will read on those in the future.

I found in google that the problem of Error: 403 can be solved.
I run on the git server, in the directory that had the repository: 'git
gc' which do git cleanup and the problem solved.

Thanks you very much.




On 10/10/13 3:06 AM, "Jeff King" <peff@peff.net> wrote:

>On Tue, Oct 08, 2013 at 03:05:22PM +0000, Shlomit Afgin wrote:
>
>> I do the following on the git server:
>>        cd /var/www/html/
>> git clone --bare  /path/to/dir/ gitproject.git
>> cd gitproject.git/
>> mv hooks/post-update.sample hooks/post-update
>> chmod a+x hooks/post-update
>
>OK, so on the next push, the info/refs file should be updated. Note that
>this file is only necessary if you want to run the "dumb" http protocol
>(i.e., the less efficient one that does not require git on the server).
>
>You didn't say whether you are trying to set up a "dumb" or "smart"
>git-http server. These days you almost certainly want to set up a
>"smart" one, and you do not need to care about info/refs or running
>update-server-info.
>
>> on the local machine run:
>> git clone http://server.name/gitproject.git
>> 
>> I got the error:
>> "Initialized empty Git repository in /local/path/gitproject/.git/
>> fatal: http://server.name/gitproject.git/info/refs not found: did you
>>run
>> git update-server-info on the server?"
>> 
>> I saw that the file does not exist,  it seem that the file post-update
>>is
>> not execute.
>
>Yes, if you didn't push yet, then it won't have been created.
>
>> I run it on the git server:
>> git update-server-info
>> 
>> Now the info/ref is created.
>
>OK, good.
>
>> On local machine I run again :
>> git clone http://server.name/gitproject.git
>> 
>> Now I get the error:
>>   Initialized empty Git repository in /local/path/gitproject/.git/
>> error: The requested URL returned error: 403 (curl_result = 22,
>>http_code
>> = 403, sha1 = 9d83b83df9fbc75ecd754264f95793fca93ccf93)
>> error: Unable to find 9d83b83df9fbc75ecd754264f95793fca93ccf93 under
>> http://server.name/gitproject.git
>> Cannot obtain needed object 9d83b83df9fbc75ecd754264f95793fca93ccf93
>
>403 is an HTTP "Forbidden". Have you configured your web server to allow
>access to the project? Have you marked the repository as
>git-daemon-export-ok, as described in "git help http-backend" (or set
>GIT_HTTP_EXPORT_ALL in the environment)? Is there anything interesting
>in the webserver's error logs?
>
>If it is still not working after checking those things, can you show us
>how you have configured your webserver (presumably apache?).
>
>-Peff
