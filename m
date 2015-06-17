From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: Should the --encoding argument to log/show commands make any
 guarantees about their output?
Date: Wed, 17 Jun 2015 21:55:22 +0200
Message-ID: <5581D0AA.9020605@web.de>
References: <557E91D2.3000908@googlemail.com>
 <xmqqzj3y2snq.fsf@gitster.dls.corp.google.com>
 <5581A964.4000500@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Jan-Philip Gehrcke <jgehrcke@googlemail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 21:55:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JQp-0006x7-25
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbbFQTz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:55:27 -0400
Received: from mout.web.de ([212.227.15.3]:62537 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbbFQTz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:55:26 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0Lgpcs-1YkqiL0fCg-00oImP; Wed, 17 Jun 2015 21:55:23
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <5581A964.4000500@googlemail.com>
X-Provags-ID: V03:K0:FhJkAdSDEoz4ZkNs/Nu3VIck+mn8tyxPqYyrJEeJTZHAPIbPbLX
 Fn+NPJSUeh46JLSlLw2JAlnVkKhCU86aGASXdcbn7qNUvXJqEm0gnBqELwDK7JAkMJdmunU
 0jQQ5BCWeC5lg8nq5xtAuiJh/2ygMn9k5c4zSxijxQ8izmnMZLy0/FJ01rJ42jUIjv76LHF
 h8++I7fc66f7XhTNGDflQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271900>

> * just make this more clear in the docs and/or
> * should we adjust the behavior of --encoding or
> * should we do something entirely different, like adding a new command line
> option or
The general spirit is to keep things backwards compatible, so that users which
expect the "raw" (and possible corrupted UTF-8) data still get the same results,
when they updata their Git installation.

A new command line option will allow users to get clean UTF-8.

One suggestion could be
--fixbroken=ISO-8859-1    (a)
--fixbroken=octalescape   (b)
--fixbroken=hexescape     (c)

(a) would replace  "0xf6" with "0xc3 0xb6"
(b) could write "\366"
(c) could write "<F6>"

The exact form of the syntax can be discussed of course.

However, I would probably start with (a), and add other options
if needed.

> * should we just leave things as they are?
.... not the ideal thing.
