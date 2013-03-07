From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Thu, 07 Mar 2013 11:10:26 -0800
Message-ID: <7vboavm3fh.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362601978-16911-2-git-send-email-kevin@bracey.fi>
 <7vlia0nj0i.fsf@alter.siamese.dyndns.org> <513830AD.10302@bracey.fi>
 <7vd2vboepi.fsf@alter.siamese.dyndns.org> <5138CAFE.2010602@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Mar 07 20:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDgDP-0003nM-Km
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 20:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743Ab3CGTK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 14:10:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932266Ab3CGTK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 14:10:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47951BDC6;
	Thu,  7 Mar 2013 14:10:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f9a5ovNThN86iGOWuIGCWINhiac=; b=AAX2u7
	gHKLGxYiRamMERdR0r0Qr3tiMRf8TIPsRUj07xApfvSqV8Fhexd2vP430WxpYuOH
	otKUddrC2v0jtllxoUfXPUiFo1bKQClM0C7LLvg3uc0XSm/jQwKhaTLH+DSnHXFS
	kpLmyiFLPRlrc4toTbmvw3y4ircLpClHfyBzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kyV/hiSN2KDR+L37uFqk8h3XkACJGxcn
	1xcybPFufQY9tzvoH4JdTMoxn9vWphFRxG3BZD0JWzT+qj03kounI//cBygsUGLu
	HlKPTcOZ/9FoevwJKa7ujqks5TzO1q6wEk8SIRpzIuDPE9t5hwIUSV55ad0Jg+0p
	I4pXqxobmQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B6AABDC4;
	Thu,  7 Mar 2013 14:10:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 973DFBDC2; Thu,  7 Mar 2013
 14:10:27 -0500 (EST)
In-Reply-To: <5138CAFE.2010602@bracey.fi> (Kevin Bracey's message of "Thu, 07
 Mar 2013 19:14:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ABF4B66A-875A-11E2-B193-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217613>

Kevin Bracey <kevin@bracey.fi> writes:

> On 07/03/2013 09:23, Junio C Hamano wrote:
>> If p4merge GUI labels one side clearly as "theirs" and the other
>> "ours", and the way we feed the inputs to it makes the side that is
>> actually "ours" appear in p4merge GUI labelled as "theirs", then I
>> do not think backward compatibility argument does not hold water. It
>> is just correcting a longstanding 3-4 year old bug in a tool that
>> nobody noticed.
>
> It's not quite that clear-cut. Some years ago, and before p4merge was
> added as a Git mergetool, P4Merge was changed so its main GUI text
> says "left" and "right" instead of "theirs" and "ours" when invoked
> manually.
>
> But it appears that's as far as they went. It doesn't seem any of its
> asymmetric diff display logic was changed; it works better with ours
> on the right, and the built-in help all remains written on the
> theirs/ours basis. And even little details like the icons imply it (a
> square for the base, a downward-pointing triangle for their incoming
> stuff, and a circle for the version we hold).

So in short, a user of p4merge can see that left side is intended as
"theirs", even though recent p4merge sometimes calls it "left".  And
your description on the coloring (green vs blue) makes it clear that
"left" and "theirs" are still intended to be synonyms.

If that is the case I would think you can still argue such a change
as "correcting a 3-4-year old bug".

> Would it be going too far to also have "xxxtool.reverse" to choose the
> global default?

It would be a natural thing to do.  I left it out because I thought
it would go without saying, given that precedences already exist,
e.g. mergetool.keepBackup etc.

> My only reservation is that I assume it would be implemented by
> swapping what's passed in $LOCAL and $REMOTE. Which seems a bit icky:
> $LOCAL="a.REMOTE.1234.c".

Doesn't the UI show the actual temporary filename?  When merging my
version of hello.c with your version, showing them as hello.LOCAL.c
and hello.REMOTE.c is an integral part of the UI experience, I
think, even if the GUI tool does not give its own labels (and
behaviour differences as you mentioned for p4merge) to mark which
side is theirs and which side is ours.  The temporary file that
holds their version should still be named with REMOTE, even when the
mergetool.reverse option is in effect.

As to the name of the variable, I do not care too deeply about it
myself, but I think keeping the current LOCAL and REMOTE would help
people following the code, especially given the option is called
"reverse", meaning that there is an internal convention that the
order is "LOCAL and then REMOTE".

One thing to watch out for is from which temporary file we take the
merged results.  You can present the two sides swapped, but if the
tool always writes the results out by updating the second file, the
caller needs to be prepared to read from the one that gets changed.
