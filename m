From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 19/27] refs: add a concept of a reference transaction
Date: Mon, 14 Apr 2014 12:54:31 +0200
Message-ID: <534BBE67.3040100@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>	<1396878498-19887-20-git-send-email-mhagger@alum.mit.edu> <xmqq8urhlzr1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 12:55:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZeXj-0005jL-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 12:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbaDNKyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 06:54:37 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56326 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993AbaDNKyg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 06:54:36 -0400
X-AuditID: 12074412-f79d46d000002e58-f1-534bbe6a52cf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 28.8B.11864.A6EBB435; Mon, 14 Apr 2014 06:54:34 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EAsVBI002965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 06:54:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqq8urhlzr1.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqJu1zzvYYMdxS4ud6yQsuq50M1k0
	9F5htph3dxeTxY+WHmaLj50LmB3YPHbOusvucenldzaPj8+Ws3s8693D6HHxkrLH501yAWxR
	3DZJiSVlwZnpefp2CdwZi//vZSqYL1Sx+IBjA+NNvi5GTg4JAROJ898uskPYYhIX7q1nA7GF
	BC4zStz5nAxhX2CSeLu1BMTmFdCWuP5wLVg9i4CqxPyGOywgNpuArsSinmamLkYODlGBIIk/
	ZxUhygUlTs58AlYiIqAmMbHtEJDNxcEssJpRYumUGWC7hAV8JFZtWAuWEBJYyyjx7sFdFpBB
	nALWEks/yoGYEgLiEj2NQSDlzAI6Eu/6HjBD2PIS29/OYZ7AKDgLybpZSMpmISlbwMi8ilEu
	Mac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0EyMkDoR2MK4/KXeIUYCDUYmHt2OOd7AQ
	a2JZcWXuIUZJDiYlUV7b3UAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryuW4FyvCmJlVWpRfkw
	KWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvK/2ADUKFqWmp1akZeaUIKSZODhBhnNJ
	iRSn5qWkFiWWlmTEg2I3vhgYvSApHqC9QntB9hYXJOYCRSFaTzHqcmzYtqaRSYglLz8vVUqc
	1xmkSACkKKM0D24FLOm9YhQH+liYNxCkigeYMOEmvQJawgS0hKUdbElJIkJKqoHR/fryJPMj
	JkzLppQ6v36131LtnIqF7N+z8z61z1Ftzc0NyliQK/dwuoaQ1WFbjTNLbTtY3118 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246220>

On 04/07/2014 09:13 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +void ref_transaction_create(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *new_sha1,
>> +			    int flags)
>> +{
>> +	struct ref_update *update = add_update(transaction, refname);
>> +
>> +	assert(!is_null_sha1(new_sha1));
>> +	hashcpy(update->new_sha1, new_sha1);
>> +	hashclr(update->old_sha1);
>> +	update->flags = flags;
>> +	update->have_old = 1;
>> +}
>> +
>> +void ref_transaction_delete(struct ref_transaction *transaction,
>> +			    const char *refname,
>> +			    unsigned char *old_sha1,
>> +			    int flags, int have_old)
>> +{
>> +	struct ref_update *update = add_update(transaction, refname);
>> +
>> +	update->flags = flags;
>> +	update->have_old = have_old;
>> +	if (have_old) {
>> +		assert(!is_null_sha1(old_sha1));
>> +		hashcpy(update->old_sha1, old_sha1);
>> +	}
>> +}
> 
> These assert()s will often turn into no-op in production builds.  If
> it is a bug in the code (i.e. the callers are responsible for
> catching these conditions and issuing errors, and there are actually
> such checks implemented in the callers), it is fine to have these as
> assert()s, but otherwise these should be 'if (...) die("BUG:")', I
> think.

I forgot to confirm that the callers *do* verify that they don't pass
incorrect values to ref_transaction_create() and
ref_transaction_delete().  But if they wouldn't, then die("BUG:") would
not be appropriate either, would it?  It would have to be die("you silly
user...").

Another reason I'm comfortable with only having assert()s in this case
is that even if the preconditions are not met, nothing really crazy
happens.  If I were guarding against something nastier, like a buffer
overflow, then I would more likely have used die("BUG:") instead.


It is not material to this discussion, but I wonder how often production
builds use NDEBUG.  I just checked that Debian does not; i.e.,
assertions are enabled for git there.  Personally I wouldn't run code
built with NDEBUG unless building for a severely resource-constrained
device, and even then I'd be pretty nervous about it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
