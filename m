From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 08/35] lock_file(): always add lock_file object to
 lock_file_list
Date: Wed, 17 Sep 2014 18:10:30 +0200
Message-ID: <5419B276.9000808@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu> <1410896036-12750-9-git-send-email-mhagger@alum.mit.edu> <20140916205736.GI29050@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 18:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUHol-0005fi-Di
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 18:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbaIQQKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 12:10:38 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55469 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756081AbaIQQKe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Sep 2014 12:10:34 -0400
X-AuditID: 12074412-f792e6d000005517-f0-5419b27924c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 41.FE.21783.972B9145; Wed, 17 Sep 2014 12:10:33 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB1C15.dip0.t-ipconnect.de [93.219.28.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8HGAU8l022465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 17 Sep 2014 12:10:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140916205736.GI29050@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsUixO6iqFu5STLE4NBFWYuuK91MFg29V5gt
	nsy9y2zx9uYSRosfLT3MFv8m1Fh0dnxldGD32DnrLrvHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DOmPhrLmtBO0/FnZMbmBsYL3J2MXJwSAiYSFz7FdTF
	yAlkiklcuLeerYuRi0NI4DKjxOTDT1ghnHNMEr8aJjCDVPEKaEtsX/iPHcRmEVCVmHj/NAuI
	zSagK7Gop5kJxBYVCJD40PmAEaJeUOLkzCdgNSICGhLPP30D28As8JFRYu71k6wgCWGBKIlJ
	B2+DNQsJLGSUmL+zGMTmFDCQWP38IBuIzSygJ7Hj+i9WCFteonnrbOYJjAKzkOyYhaRsFpKy
	BYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCIkFoB+P6k3KHGAU4GJV4
	eDdclggRYk0sK67MPcQoycGkJMp7bJ1kiBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXuuNQDne
	lMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4OJQneUpBGwaLU9NSKtMycEoQ0
	EwcnyHAuKZHi1LyU1KLE0pKMeFCsxhcDoxUkxQO0tx9sb3FBYi5QFKL1FKMux7rOb/1MQix5
	+XmpUuK8ViBFAiBFGaV5cCtgae8VozjQx8K8OSBVPMCUCTfpFdASJqAlZ3vEQJaUJCKkpBoY
	w+6k3Pk354JkwqM9cTr2Qpfiir+/0ni7kHfJtZTNssuXFLIqv36dsttlscqp7GqF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257225>

On 09/16/2014 10:57 PM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> The ambiguity didn't have any ill effects, because lock_file objects
>> cannot be removed from the lock_file_list anyway.  But it is
>> unnecessary to leave this behavior inconsistent.
> 
> Nit: commit messages usually use present tense for current behavior
> (and imperative for the behavior after the patch).

OK, will change.

> More importantly, the above + the diffstat don't leave me very happy
> about the change.
> 
> Can you spell out more about the intended effect?  E.g., is this about
> making sure other code is appropriately exercised to tolerate the
> signal handler even when there are a lot of errors (which should make
> debugging easier) or something?

This patch is mostly about two things:

* Making the state diagram for lock_file objects easier to document and
reason about.

* Defining a clear moment when the lock_file object is initialized,
early in the function. This will be useful later when its filename field
is turned into a strbuf and requires nontrivial initialization before it
can even be used to construct the filename of the lockfile.

By "diffstat" I assume you mean that some lines were added to the
initialization. This is also to make the state diagram of lock_objects
very clear.

I will rewrite the commit message to try to explain the commit's purpose
better. Let me know if you still think that the commit is unjustified.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
