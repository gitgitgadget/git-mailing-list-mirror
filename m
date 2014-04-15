From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 19/27] refs: add a concept of a reference transaction
Date: Tue, 15 Apr 2014 07:41:48 +0200
Message-ID: <534CC69C.1020503@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>	<1396878498-19887-20-git-send-email-mhagger@alum.mit.edu>	<xmqq8urhlzr1.fsf@gitster.dls.corp.google.com>	<534BBE67.3040100@alum.mit.edu> <xmqqa9bnmwnk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 07:41:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZw86-0003k1-8M
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 07:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbaDOFlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 01:41:53 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:46718 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768AbaDOFlw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2014 01:41:52 -0400
X-AuditID: 1207440d-f79d86d0000043db-35-534cc69f1de1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 91.9E.17371.F96CC435; Tue, 15 Apr 2014 01:41:51 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97931.dip0.t-ipconnect.de [79.201.121.49])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3F5fm0T024461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 15 Apr 2014 01:41:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqqa9bnmwnk.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqDv/mE+wwYPv5hY710lYdF3pZrJo
	6L3CbDHv7i4mix8tPcwWHzsXMDuweeycdZfd49LL72weH58tZ/d41ruH0ePiJWWPz5vkAtii
	uG2SEkvKgjPT8/TtErgz1p77xVxwXaZi295+tgbGR2JdjJwcEgImEtv/LGKEsMUkLtxbz9bF
	yMUhJHCZUeLdl0OMEM55JomV92aCVfEKaEucf7odqIqDg0VAVWL99DKQMJuArsSinmYmkLCo
	QJDEn7OKENWCEidnPmEBsUUE1CQmth1iARnJLLCaUWLplBlsIAlhAR+JVRvWskDs+sMocezr
	C7BBnALWEme+K4CYEgLiEj2NQSDlzAI6Eu/6HjBD2PIS29/OYZ7AKDgLybpZSMpmISlbwMi8
	ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkFnh3MP5fJ3OIUYCDUYmH1+KN
	d7AQa2JZcWXuIUZJDiYlUV7NAz7BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4XycD5XhTEiur
	UovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxVR4EaBYtS01Mr0jJzShDSTByc
	IMO5pESKU/NSUosSS0sy4kHxG18MjGCQFA/Q3o0g7bzFBYm5QFGI1lOMuhwbtq1pZBJiycvP
	S5US500/AlQkAFKUUZoHtwKW+F4xigN9LMy7FGQUDzBpwk16BbSECWgJS7s3yJKSRISUVAOj
	tnCr9EXBsOW7Q27qiVn/fBfif1PO812XimL15Rofw8N3ow7vPeBe+qxgQe7vJ1+z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246273>

On 04/14/2014 11:25 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I forgot to confirm that the callers *do* verify that they don't pass
>> incorrect values to ref_transaction_create() and
>> ref_transaction_delete().  But if they wouldn't, then die("BUG:") would
>> not be appropriate either, would it?  It would have to be die("you silly
>> user...").
> 
> Having the assert() there gives a confused message to the readers
> (at least it did to this reader).
> 
> assert() implies that callers that are not buggy should not give
> input that triggers the condition, which would mean it is the
> callers' responsibility to sanity check the user-input to reject
> creating a ref at 0{40} or deleting a ref whose old value is 0{40},
> which in turn means these input are errors that need to be diagnosed
> and documented.

In v2 of this patch series, I didn't forbid calling create with new_sha
== 0{40}, because, even though it's not what the user would think of as
creating a reference, the code didn't care--it would just verify that
the reference didn't exist before and then leave it undefined.

Then in [1] you commented:

> Sounds a bit crazy that you can ask "create", which verifies the
> absense of the thing, to delete a thing.

I reacted to your comment by changing the documentation to forbid
calling "create" with new_sha1 == 0{40}, and enforced the rule using an
assert().  At the same time I added an analogous restriction that if
"delete" is called with have_old set, then old_sha1 must not be 0{40}.

In retrospect, you might have been objecting more to the misleading
docstring than to the behavior as implemented at the time.  The
docstring implied that create could actually be used to delete a
reference, but that was not true: it always checked that the reference
didn't exist beforehand.  So at worst it could leave a non-existent
reference un-created.  Sorry for the confusion.

> But as you said below...
> 
>> ... even if the preconditions are not met, nothing really crazy
>> happens.
> 
> I agree that it also is perfectly fine to treat such input as
> not-an-input-error.

That was the case in v2.

> It is a signal that these checks are not 'if (...) die()' that the
> code may take that stance.
> 
> I cannot tell which interpretation the code is trying to implement.
> 
> Any one of the following I can understand:
> 
>  (1) drop the assert(), declaring that the user input is perfectly
>      fine;
> 
>  (2) keep the assert(), reject such user input at the callers, and
>      document that these are invalid inputs;
> 
>  (3) replace the assert() with 'if (...) die("you silly user...")',
>      and document that these are invalid inputs; or
> 
>  (4) same as (3) but replace with warn(), declaring such input as
>      suspicious.
> 
> but the current assert() makes the code look "cannot decide" ;-).
> 
> I would consider the first two more sensible than the other two, and
> am leaning slightly towards (1) over (2).

The current status in v3 is that (2) is implemented.

Obviously I don't feel strongly about it, given that I implemented (1)
in v2.  But I think that this restriction makes code at the calling site
easier to understand: "create" now always means "create"; i.e., if the
transaction goes through, then the reference exists afterwards.  And
"delete" always means delete; i.e., afterwards, there is one less
reference in the world.

Michael

[1] http://mid.gmane.org/xmqqtxaczvod.fsf@gitster.dls.corp.google.com

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
