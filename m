From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 15:28:36 -0800
Message-ID: <7vfwr7hh7f.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <20110228122335.GB5197@sigill.intra.peff.net>
 <7vy650hvwa.fsf@alter.siamese.dyndns.org>
 <20110228222352.GC5854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Mart =?utf-8?Q?S=C3=B5mermaa?= <mrts.pydev@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:28:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuCWQ-0005K7-RF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832Ab1B1X2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 18:28:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab1B1X2x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 18:28:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7697A47AE;
	Mon, 28 Feb 2011 18:30:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+R9b9L/gkAYfLHHCdTh3Q4Xk1Y=; b=of6B9t
	bhllCu3cS8y8TvwrOsoUsY5l4wsrHL1kCkeyRtk2eycIXC2akyCqNHvVlq6wcD+/
	EX07eTtGd1JamEFSPrzLm0KuaASsvJqg7otUWwiLiszxS35E/Whj1Umq0mtYwS2w
	TnPPdw2J4xuJk6o5lmNHZw4IODA7A1Duf3Tvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rwti3Dl6Un5XzrBiVZP6dWLC2k0T2PsQ
	UqFW/IBKAZ54HjZOprIks/XAHvWFHrLNZQCSpNl56nJLZEj5sMtA/iuIfoTCS85e
	sX0l6xgLlAMMthgOF64zKly6I+PzGT/bnYxUQHf2B2Sk864c9E6EAPnd63ObvmOY
	1RDW4w6LOSU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2FB9F47AA;
	Mon, 28 Feb 2011 18:30:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8150D47A5; Mon, 28 Feb 2011
 18:29:57 -0500 (EST)
In-Reply-To: <20110228222352.GC5854@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 28 Feb 2011 17\:23\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AAD4CFC6-4392-11E0-9399-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168163>

Jeff King <peff@peff.net> writes:

> Yeah, I guess I am just curious whether "similar enough" is really
> relevant with file deletion. Obviously if you have the sha1 then
> everything applies, no problem. But if you don't, how useful is the
> patch text? The patch application will error out with a conflict. You
> know in either case that the person wanted the file deleted. The patch
> text shows you what _their_ version of the file looked like. But that's
> not likely to be useful; what you really care about is what's in _your_
> version of the file, and whether that should be deleted or not.

Exactly; in order to intelligently decide if that should be deleted or
not, you need to be able to judge if the deletion makes sense in the
context of _your_ tree.  Hopefully proposed commit log message alone may
clarify if the change applies to your situation, or you need to be able to
see if their version and yours are still serving similar purposes in the
system (e.g. you don't want to lose the definition of a function they
didn't have when they decided to remove the file saying "nobody calls any
function in this library anymore").

> If you did really care about what was in their file, the giant deletion
> diff is almost certainly not interesting. What you really care about is
> what's different in their version versus yours.

Correct; the deletion diff has half of the necessary information (the
other half being what you have).

> I'm not quite sure what lossage you mean. On the recipient's end? They
> can just "git revert", no?

No, I was not particularly interested in limiting the discussion to
git-using population.  As I said, just like rename patch can be manually
applied by first moving and then eyeballing, you can see "an instruction
to delete--ok, 'rm'" to apply it and the file is gone (unlike the case
where you manually did "mv").  That is what I meant by "additionally -D
has lossage".

>> It may make sense to show such a patch still with a bit of context,
>> perhaps like this:
>> 
>>      README |   54 ------------------------------------------------------
>>      1 files changed, 0 insertions(+), 54 deletions(-)
>> 
>>     diff --git -D a/README b/README
>>     deleted file mode 100644
>>     index 67cfeb2..0000000
>>     --- a/README
>>     +++ /dev/null
>>     @@ -1,54 +0,0 @@
>>     -////////////////////////////////////////////////////////////////
>>     -
>>     -	GIT - the stupid content tracker
>>     -...
>>     -the discussion following them on the mailing list give a good
>>     -reference for project status, development direction and
>>     -remaining tasks.
>> 
>> so that the reader can have some warm and fuzzy feeling that the correct
>> file is being deleted, though.
>
> Hmm. I think that is even worse. It's _still_ spammy, and it's broken as
> a diff (the sha1 in the index line doesn't match the preimage that the

That is very much intentional; I don't think we want the format to apply
mechanically.  I was not talking about patch application safety at all in
this thread; I already dismissed "-D" as too unreliable as a patch format
to be used for conveying a change for mechanical consumption, didn't I?
When you want to do so, you just generate the output without -D.

The suggestion to give some context is only for people who want to eyeball
their own patches, helping them to make sure that they are removing what
they wanted to remove.  If they can tell from the filename alone, that is
just as fine.  I am not interested that deeply here; the only thing I care
about is to make sure we don't have to keep carrying crappy options as if
they are sane.
