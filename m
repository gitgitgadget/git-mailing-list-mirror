From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Thu, 12 Feb 2015 17:52:18 +0100
Message-ID: <54DCDA42.2060800@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com> <CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 17:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLx0F-0000vA-Mz
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 17:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbbBLQwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 11:52:31 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50668 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900AbbBLQwa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 11:52:30 -0500
X-AuditID: 1207440c-f79376d00000680a-a3-54dcda45261c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 29.9C.26634.54ADCD45; Thu, 12 Feb 2015 11:52:21 -0500 (EST)
Received: from [192.168.69.130] (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CGqJo1018441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 11:52:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqOt6606IQW+njEXXlW4mi4beK8wW
	b28uYbTonvKW0aK37xOrxebN7SwObB47Z91l91iwqdTj4iVlj8+b5AJYorhtkhJLyoIz0/P0
	7RK4M94decJSME28YsmHq0wNjFeFuhg5OSQETCRW7u9khLDFJC7cW8/WxcjFISRwmVGiY9oJ
	FgjnPJNE847lQA4HB6+AtsT5NZEgDSwCqhJf1l1jBrHZBHQlFvU0M4HYogJBEodOP2YBsXkF
	BCVOznwCZosIeEmcWjeDGWQms8AtRokfHS/ZQRLCArESP+88ZAWxhQS2MEm0rXMDsTkFAiX+
	nL8NNpRZQF3iz7xLzBC2vETz1tnMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusW
	Jyfm5aUW6Rrq5WaW6KWmlG5ihIQ4zw7Gb+tkDjEKcDAq8fAGGN8JEWJNLCuuzD3EKMnBpCTK
	m3oTKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN2oZUI43JbGyKrUoHyYlzcGiJM6rukTdT0gg
	PbEkNTs1tSC1CCYrw8GhJMG7+QZQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwo
	VuOLgdEKkuIB2vsIpJ23uCAxFygK0XqKUVFKnPcWSEIAJJFRmgc3Fpa4XjGKA30pzMsM8hIP
	MOnBdb8CGswENHjijNsgg0sSEVJSDYyaTL4dSxtL3OUrxWZ9+bv3m0NwbZbX89TrZcK37z1Z
	uFDFbNexu3ym7CuytFdt/9lgIf/CIctz1qEY25x6Ld36VJ8vXR9eulQWnj+6iqXO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263743>

On 02/12/2015 12:25 AM, Stefan Beller wrote:
> On Wed, Feb 11, 2015 at 2:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>> When processing the reflog of a symbolic ref, hold the lock on the
>>>> symbolic reference itself, not on the reference that it points to.
>>>
>>> I am not sure if that makes sense.
>>> So when expiring HEAD, you want to have a .git/HEAD.lock file
>>> instead of a .git/refs/heads/master.lock file?
>>>
>>> What would happen if there is a concurrent modification
>>> to the master branch?
>>
>> The HEAD may be pointing at 'master' and the other party that is
>> trying to modify it would fail when it tries to update the reflog
>> for HEAD thanks to HEAD.lock being held by us.  The HEAD may be
>> pointing at 'next' and the other part that updates 'master' would
>> not try to modify HEAD reflog and we do not conflict.
>>
>> At least, I think that is the rationale behind this change.
> 
> That makes sense! Do we have documentation on symrefs?
> 
> Originally I was wondering if this would make things
> complicated for  symbolic branches which are not HEAD.
> Then you could update the branch pointed to, because it
> has no lock as the lock is on the symref. On the other hand
> this seems to be an improvement, as you cannot move the
> symref itself, as it has the lock and we don't really have other
> symrefs?

The convention is that holding lock $GIT_DIR/$refname.lock (where
$refname might be, for example, "HEAD" or "refs/heads/master") protects
two things:

* The loose-reference file $GIT_DIR/$refname
* The reflog file $GIT_DIR/logs/$refname

And this makes sense:

Suppose that HEAD is refs/heads/master. These two thing have independent
reflogs, so there is no reason that one process can't be expiring the
reflog of HEAD while another expires the reflog of refs/heads/master.

The behavior before this patch was that the reflog for "HEAD" was
modified while holding the reflog for "refs/heads/master". This is too
strict and would make those two processes contend unnecessarily.

I can't think of a reason that the current behavior is unsafe. But it's
more restrictive than necessary, and more confusing than necessary. My
guess is that it was unintended (i.e., a bug). It dates from

    68db31cc28 (2007-05-09) git-update-ref: add --no-deref option for
overwriting/detaching ref

which initially added the REF_NODEREF constant and probably forgot that
the new flag should be used in this invocation.

However, another important question is whether other Git implementations
have copied this unusual locking policy. If so, that would be a reason
not to change it. I just pinged the libgit2 maintainer to find out their
policy. Maybe you could find out about JGit?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
