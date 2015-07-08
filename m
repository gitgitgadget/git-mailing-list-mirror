From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Wed, 08 Jul 2015 15:16:17 +0200
Message-ID: <559D22A1.9030100@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>	 <1435609076-8592-7-git-send-email-dturner@twopensource.com>	 <559AB200.5020108@alum.mit.edu> <1436316577.5521.25.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 15:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCpDp-0005fV-Ss
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 15:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbbGHNQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 09:16:31 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:55433 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965170AbbGHNQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 09:16:28 -0400
X-AuditID: 1207440e-f79516d0000012b3-8d-559d22a2106b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id FE.C5.04787.2A22D955; Wed,  8 Jul 2015 09:16:18 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0310.dip0.t-ipconnect.de [93.219.3.16])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t68DGHpR008954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jul 2015 09:16:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436316577.5521.25.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1F2kNDfUYE+DlcX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7ozr1/8zFjRIVhw83cjSwDhBpIuRk0NCwERi
	0uyTrBC2mMSFe+vZuhi5OIQELjNKfDt5mxkkISRwhkli54zyLkYODl4BbYn1l1hBTBYBVYmL
	zxVAKtgEdCUW9TQzgYRFBYIkXr/MBQnzCghKnJz5hAXEFgFqnH2kB6yTWUBcov8fWFhYwF3i
	1t+XTBBLLzJKLN91mx0kwSlgIXGp+TqYzSygLvFn3iVmCFteonnrbOYJjAKzkKyYhaRsFpKy
	BYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCQpRvB2P7eplDjAIcjEo8
	vB8i54QKsSaWFVfmHmKU5GBSEuWNewQU4kvKT6nMSCzOiC8qzUktPsQowcGsJMIbqjg3VIg3
	JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMGbBNIoWJSanlqRlplTgpBm
	4uAEGc4lJVKcmpeSWpRYWpIRD4rR+GJglIKkeID2/gfbW1yQmAsUhWg9xagoJc5rDZIQAElk
	lObBjYUlnleM4kBfCvO6glTxAJMWXPcroMFMQIOX684CGVySiJCSamCcNFH1Imfz+wuihhvu
	R9cX7P3yUzV20cQ3hmtVt9W0XjMyN1I0TFnMIfnkuNsMyZ2+Lzf5P9GuUxUw6jJY/0t5y5MD
	C1cLrVwuyh869Vravo//Df85z7AWfXJ9R1btqij//4uDbh7iLlPMWf9b8PZfudfL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273682>

On 07/08/2015 02:49 AM, David Turner wrote:
> On Mon, 2015-07-06 at 18:51 +0200, Michael Haggerty wrote:
>> [...]
>> So all in all, I think it is unwise to allow a reflog to be created
>> without its corresponding reference.
>>
>> This, in turn, suggests one or both of the following alternatives:
>>
>> 1. Allow "git reflog create", but only for references that already exist.
> 
> This turns out not to work for git stash, which wants to create a reflog
> for stash creation.
> 
>> 2. If we want to allow a reflog to be created at the same time as the
>> corresponding reference, the reference-creation commands ("git branch",
>> "git tag", "git update-ref", and maybe some others) probably need a new
>> option like "--create-reflog" (and, for symmetry, probably
>> "--no-create-reflog").
> 
> git branch should already autocreate reflogs, since the refs it creates
> are under refs/heads.

`git branch` only autocreates reflogs if core.logAllRefUpdates is on.
That setting happens to be on by default in a non-bare repository but
the user might turn it off. And it is off by default in a bare repository.

In my opinion it would be nice for the user to be able to ask for a
reflog to be created for a branch regardless of how
core.logAllRefUpdates is set. Though I'm not saying that you have to be
the one to implement that functionality :-)

>> At the API level, it might make sense for the ref-transaction functions
>> to get a new "REF_FORCE_CREATE_REFLOG" flag or something.
> 
> Junio was opposed to the converse flag, so I'm going to just add
> manually add code to create reflogs.

Unfortunately I wasn't keeping up with earlier versions of this patch
series and now I can't find the email from Junio that you are referring
to. If the earlier flag had the opposite ("converse"?) sense, like
REF_INHIBIT_CREATE_REFLOG, then I agree that it wouldn't be an improvement.

But I think this functionality *has to* be implemented within ref
transactions for references that are just being created, because

1. The reflog must *not* be created if the reference creation fails for
some reason. For example, the reflog shouldn't be created if the
reference name has a D/F conflict with an existing one in the "refs/foo"
vs. "refs/foo/bar" sense. (This conflict might not be obvious when
creating the reflog file because the other reference might not have its
reflog turned on.) There are other reasons that a reference creation
might fail, and code outside of the refs API can't be expected to know
all possibilities.

2. On the other hand, the reflog for a newly-created reference *should*
reflect the creation of the reference. So it would be awkward to require
the calling code to create the reference and *then* turn on the reflog.

For references that already exist, I see no problem with a command that
turns on the reflog without adding any entries to it. Though if you
implement this, it would be prudent to check that existing
reflog-handling code doesn't fail when confronted with an empty file; I
think empty reflog files are rare now and might not be well-tested.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
