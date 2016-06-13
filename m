From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 5/6] lock_ref_for_update(): make error handling more
 uniform
Date: Mon, 13 Jun 2016 12:10:19 +0200
Message-ID: <575E868B.70402@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
 <6cc13da6767c5fd9dbf1b372634adf7c3a353464.1465544913.git.mhagger@alum.mit.edu>
 <1465585279.8278.2.camel@frank> <575E5DB5.8040109@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: David Turner <novalis@novalis.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 12:10:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCOpK-0001Se-Mu
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 12:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbcFMKKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 06:10:34 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55544 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964862AbcFMKKd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2016 06:10:33 -0400
X-AuditID: 1207440f-8bbff700000008e4-3e-575e868ee57f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id EF.F9.02276.E868E575; Mon, 13 Jun 2016 06:10:22 -0400 (EDT)
Received: from [192.168.69.130] (p548D6022.dip0.t-ipconnect.de [84.141.96.34])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5DAAKaJ004776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 13 Jun 2016 06:10:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <575E5DB5.8040109@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqNvfFhducGAqq0XXlW4mi4beK8wW
	T+beZbZY8vA1s0X3lLeMFj9aepgd2Dx2zrrL7vHwVRe7R1f7ETaPZ717GD0uXlL2+LxJLoAt
	itsmKbGkLDgzPU/fLoE74//9ZuaCV1wV+883sTcw7uToYuTgkBAwkfi+kLuLkYtDSGAro8S9
	Z53MEM45Jomb+9YxdTFycggLhEr8vHyDGcQWEVCTWPb2FxuILSRwilFi+9x6kAZmgeuMEke2
	nQZLsAnoSizqaQZr5hXQlOi+85gZZBuLgKpEy614kLCoQIjE+XVbWSFKBCVOznzCAmJzCuhI
	fGpoAWtlFlCX+DPvEjOELS+x/e0c5gmM/LOQtMxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6
	xcmJeXmpRbomermZJXqpKaWbGCHhzb+DsWu9zCFGAQ5GJR5ejVWx4UKsiWXFlbmHGCU5mJRE
	eSV84sKF+JLyUyozEosz4otKc1KLDzFKcDArifAeawTK8aYkVlalFuXDpKQ5WJTEedWXqPsJ
	CaQnlqRmp6YWpBbBZGU4OJQkeH1bgRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLi
	QREZXwyMSZAUD9BeU5B23uKCxFygKETrKUZFKXFeBpCEAEgiozQPbiwsab1iFAf6Upi3D6SK
	B5jw4LpfAQ1mAhrMsS8aZHBJIkJKqoGxor/kxfL3lgIz7gRevqc0b06u7Oq+03J/lBqkrnXI
	Rjgo7ZyqXjnB8NVKoSndJ7g6hXrM31hdXbaMwZvDY2dRcHDL7rsJuQaey5Tteuc8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297176>

On 06/13/2016 09:16 AM, Michael Haggerty wrote:
> On 06/10/2016 09:01 PM, David Turner wrote:
>> On Fri, 2016-06-10 at 10:14 +0200, Michael Haggerty wrote:
>>
>>>  /*
>>> + * Check whether the REF_HAVE_OLD and old_oid values stored in update
>>> + * are consistent with the result read for the reference. error is
>>> + * true iff there was an error reading the reference; otherwise, oid
>>
>> "error" is not a thing here?
> 
> You're right; thanks for the feedback. I'll include it in the reroll
> that I'm about to do.

I have changed the docstring as follows:

>  /*
>   * Check whether the REF_HAVE_OLD and old_oid values stored in update
> - * are consistent with the result read for the reference. error is
> - * true iff there was an error reading the reference; otherwise, oid
> - * is the value read for the reference.
> - *
> - * If there was a problem, write an error message to err and return
> - * -1.
> + * are consistent with oid, which is the reference's current value. If
> + * everything is OK, return 0; otherwise, write an error message to
> + * err and return -1.
>   */

I've folded that change into the patch series on branch
update-ref-errors on my GitHub fork [1]. I won't sent a re-roll to the
mailing list unless other changes are necessary (or unless somebody
requests it).

Michael

[1] https://github.com/mhagger/git
