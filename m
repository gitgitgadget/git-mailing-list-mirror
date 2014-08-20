From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 22:11:21 +0200
Message-ID: <53F500E9.6060900@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>	<1403275409-28173-44-git-send-email-sahlberg@google.com>	<53BC07FC.8080601@alum.mit.edu> <20140715180424.GJ12427@google.com>	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>	<53F4B642.7020002@alum.mit.edu> <xmqqk363t060.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:12:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKCEX-0006uE-CF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 22:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbaHTULZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 16:11:25 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:46368 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751008AbaHTULY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 16:11:24 -0400
X-AuditID: 12074413-f79ed6d000002501-c2-53f500eb56d7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.84.09473.BE005F35; Wed, 20 Aug 2014 16:11:23 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2242.dip0.t-ipconnect.de [93.219.34.66])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s7KKBL7X011302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 20 Aug 2014 16:11:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <xmqqk363t060.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqPua4WuwQeMvI4uuK91MFg29V5gt
	3t5cwmjxb0KNA4vHzll32T0WbCr1uHhJ2ePzJrkAlihum6TEkrLgzPQ8fbsE7ozvZ56yFMzh
	rJj116OBcQV7FyMnh4SAicSxlVcZIWwxiQv31rN1MXJxCAlcZpRYe+g0C4Rzjkni7tTfQA4H
	B6+AtsS31+UgDSwCqhJ35p5lArHZBHQlFvU0g9miAkESsz/PA1vAKyAocXLmExYQW0RATWJi
	2yGwmcwCfYwS3z49ZwVJCAskSFztOMkKsWwms8S+OwvZQBKcAtYS++a/ApvELKAj8a7vATOE
	LS+x/e0c5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RS
	U0o3MUKCWXgH466TcocYBTgYlXh4byz6EizEmlhWXJl7iFGSg0lJlPfvL6AQX1J+SmVGYnFG
	fFFpTmrxIUYJDmYlEV5XkBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoND
	SYKXHxi1QoJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgWI0vBkYrSIoHaO/i/yB7
	iwsSc4GiEK2nGBWlxHl5QeYKgCQySvPgxsJS1CtGcaAvhXm/gbTzANMbXPcroMFMQIO3Lv4I
	MrgkESEl1cBYf+uofbui28V41W3LW3M0PtzYr7fyzqTsBE+luQ/VypdY2u0vaFy5Wfyq3ef0
	YyoMU232+gbsF1V+HCgj8Cw74e6Xuv/bT2oJHdmpVdR0gKOktGLXUfHHv62138nK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255584>

On 08/20/2014 09:45 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I think we can get away with not including broken refnames when
>> iterating.  After all, the main goal of tolerating them is to let them
>> be deleted, right?
> 
> Or read from a ref whose name has retroactively made invalid, in
> order to create a similar but validly named ref to serve as its
> replacement?  So at least we need to give the users some way of
> reading from them, in addition to deleting them, no?

The die() error message would presumably include the name of the invalid
reference.

If we change the rules for reference names and a bunch of names become
invalid, then it would admittedly be cumbersome to run git N times to
find the N invalid names.  But if we change the rules, then *at that
time* we could always build in iteration over broken reference names.

It's not that I have something against building it iteration over broken
reference names now, as long as it is clearly segregated from "normal"
iteration to prevent illegal names from getting loose in the code.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
