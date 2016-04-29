From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 24/29] ref_transaction_update(): check refname_is_safe()
 at a minimum
Date: Fri, 29 Apr 2016 09:42:58 +0200
Message-ID: <57231082.50806@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <a67a1b745d0a14111c774f13a5776d3756cbf2f2.1461768690.git.mhagger@alum.mit.edu>
 <xmqqtwim95cm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 09:43:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw353-0007Dn-8r
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 09:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbcD2HnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 03:43:11 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:56151 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752892AbcD2HnI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 03:43:08 -0400
X-AuditID: 1207440f-8bbff700000008e4-04-572310856742
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 8B.F3.02276.58013275; Fri, 29 Apr 2016 03:43:01 -0400 (EDT)
Received: from [192.168.69.130] (p548D6182.dip0.t-ipconnect.de [84.141.97.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3T7gwwT012431
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 03:42:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqtwim95cm.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsUixO6iqNsqoBxu8P4xl8X8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1g5sHjtn3WX3eNa7h9Hj4iVlj/1Lt7F5LHh+n93j8ya5ALYo
	bpukxJKy4Mz0PH27BO6MtimXmAr2sVacnHiTsYFxNUsXIweHhICJxIKpQV2MXBxCAlsZJS7+
	e8oE4ZxnkmjtP8ncxcjJISwQLXHn8hQ2EFtEQE1iYtshFoiinYwSd+Z/ZAVxmAXuM0psOd3F
	ClLFJqArsainmQlkBa+ApsSquWwgJouAqsT1ySIgFaICIRLb1n0Dq+YVEJQ4OfMJC4jNKWAt
	8eliJzuIzSygJ7Hj+i9WCFteYvvbOcwTGPlnIWmZhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOT
	dYuTE/PyUot0TfRyM0v0UlNKNzFCgpt/B2PXeplDjAIcjEo8vDPuKYULsSaWFVfmHmKU5GBS
	EuUN4VQOF+JLyk+pzEgszogvKs1JLT7EKMHBrCTCO5MPKMebklhZlVqUD5OS5mBREudVX6Lu
	JySQnliSmp2aWpBaBJOV4eBQkuB9BdIoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIR
	D4rI+GJgTIKkeID2ivCD7C0uSMwFikK0nmLU5Vjw4/ZaJiGWvPy8VClx3i6QHQIgRRmleXAr
	YKnsFaM40MfCvDIgo3iAaRBu0iugJUxASwQ2KYIsKUlESEk1ME7ceL8vz1TF9KHKruiVhwN9
	vVcqr2JOW3z97LqHV+2ENdZwBD11ezO/y2nrxj8L1+YtbG593zDHd9qW5N13JJ6l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292978>

On 04/27/2016 10:14 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> If the user has asked that a new value be set for a reference, we use
>> check_refname_format() to verify that the reference name satisfies all
>> of the rules. But in other cases, at least check that refname_is_safe().
> 
> It isn't clear to me what "in other cases" exactly refers to.  A
> request to delete a ref would obviously one of those that do not
> "ask that a new value be set", but are there other cases?

The other case is `verify`, which can be used to check the old value of
a reference without modifying it. `verify` is exposed via `git
update-ref --stdin`

Michael
