From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-cvsimport: support local timezone
Date: Fri, 12 Oct 2012 09:57:54 +0200
Message-ID: <5077CD82.6000405@alum.mit.edu>
References: <1349988497-6158-1-git-send-email-chris@rorvick.com> <50774BA9.40609@alum.mit.edu> <CAEUsAPYaYGDHWkixf9U27_Hsa7QqCWq3csKtBH7MrjnMD6kKJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christopher Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 09:58:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMa8G-0000Qf-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 09:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933106Ab2JLH56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 03:57:58 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:46602 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932966Ab2JLH55 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 03:57:57 -0400
X-AuditID: 1207440d-b7f236d000000943-df-5077cd841f04
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id C1.48.02371.48DC7705; Fri, 12 Oct 2012 03:57:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9C7vsNN003708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Oct 2012 03:57:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <CAEUsAPYaYGDHWkixf9U27_Hsa7QqCWq3csKtBH7MrjnMD6kKJQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqNtytjzA4MNFQYudc/exWnRd6WZy
	YPLYfZrV4/MmuQCmKG6bpMSSsuDM9Dx9uwTujL5t/1kLWrkrTj4/wdrA+I6ji5GTQ0LAROLJ
	k1tsELaYxIV768FsIYHLjBLfmmy6GLmA7ONMEnMvLmUHSfAKaEtcnTuBpYuRg4NFQFVick8R
	SJhNQFdiUU8zE4gtKhAm8e7XUVaIckGJkzOfsIDYIkCtvz4+ZwNpZRYQl+j/BxYWFrCSmLpi
	NhvEqsWMEge+r2QGSXAKBEosfr8arIhZQEfiXd8DZghbXmL72znMExgFZiFZMQtJ2SwkZQsY
	mVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihAQp7w7G/+tkDjEKcDAq8fAy
	vS0LEGJNLCuuzD3EKMnBpCTKu+R0eYAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6DfUA53pTE
	yqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb/wZoEbBotT01Iq0zJwShDQT
	ByfIcC4pkeLUvJTUosTSkox4UJzGFwMjFSTFA7SXGaSdt7ggMRcoCtF6ilGX42PjvIeMQix5
	+XmpUkAXgBwuAFKUUZoHtwKWkl4xigN9LMxrAjKKB5jO4Ca9AlrCBLREZlIJyJKSRISUVAOj
	YfKCV8tabjpxGy/kPSw86dG8SSrnvr7JPc42Wzjbba9nocfstANCO3j87pi36fxkO1FoXnXg
	9Wqn55wXt9rXb69vO34p5cIVtQvrX0Znf40/liurKLJzTkK8wLWKzB2LmXXXxHLM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207539>

On 10/12/2012 02:14 AM, Christopher Rorvick wrote:
> On Thu, Oct 11, 2012 at 5:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 10/11/2012 10:48 PM, Chris Rorvick wrote:
>>> CVS patches are unconditionally imported with a UTC timezone.  Allow
>>> the local timezone by adding -l to the command line or specifying
>>> cvsimport.l in the config.
>>>
>>> This could be made the default behavior, as setting TZ=UTC in the
>>> environment before doing the import is equivalent to the current
>>> behavior.  But since a new default may be an unwelcome surprise to
>>> some, make this new behavior available os an option.
>>
>> According to rcsfile(7), all times in RCS/CVS files are recorded in UTC.
>>  So why do you need this feature?
> 
> [...]
> Likewise, just because the RCS file has a UTC timestamp does not mean
> the commit originated in Greenwich, UK.  Git includes the timezone
> offset in its timestamps, so it is reasonable to allow me to specify
> what is appropriate.

Ahh, OK, I hadn't realized that git stores (UTC time + time zone).  I
mistakenly thought you wanted to use a time zone to transform CVS-time
to git-time, i.e., as if the CVS time were recorded in local time.  Your
actual goal makes sense.

[And it is something I should consider building into cvs2git.]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
