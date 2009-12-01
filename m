From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale 
 list
Date: Mon, 30 Nov 2009 23:34:51 -0800
Message-ID: <7vy6ln2llw.fsf@alter.siamese.dyndns.org>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com> <7viqcrbl22.fsf@alter.siamese.dyndns.org> <36ca99e90911302249r5f77f031o73cc7bb13dc375cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 08:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNH0-0007up-73
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZLAHfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 02:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZLAHfD
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:35:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785AbZLAHe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 02:34:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 085F0A2BEA;
	Tue,  1 Dec 2009 02:35:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PMjfIOafAMFFZaC9rzUzqIASYog=; b=Gcx7hA
	TtM82ryvBj24H9+OllVjJt/Qxvfg+xSkpAbEnompYVKfWc7sOxF5tKD7L8D6M15h
	+FikowogbY/G7JRvFfUsaRAYnUYdt4RFg4hD9qCefW24/4d5zTddeHhJvomE2di0
	RK7Xp/lulVu/ozUjZUKOevNd/dRaM76ez9teI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bKmThdfoOleRjikgASv0DiT1lBh3zRUT
	jb1SVAPCRJtTGGZMjj7krRol4i0dGO8AP8h4RC/yJVlbf7fM2lrjBQ0gXOU28af/
	msDe6mbeCMKgRQngUdlPgNWPPA9kFn27aF9G5SUr0kgf0dF4QbJNCbHI018Uh9JW
	PrDPuoT0Uh4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC806A2BE9;
	Tue,  1 Dec 2009 02:35:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B052A2BE6; Tue,  1 Dec 2009
 02:34:53 -0500 (EST)
In-Reply-To: <36ca99e90911302249r5f77f031o73cc7bb13dc375cf@mail.gmail.com>
 (Bert Wesarg's message of "Tue\, 1 Dec 2009 07\:49\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08633982-DE4C-11DE-B351-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134170>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Tue, Dec 1, 2009 at 01:21, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Hmm, the Subject: matches what the code does, but nobody mentions why it
>> is necessary (iow, what breaks in the current code and what becomes better
>> if the patch is applied). The blank space before your "S-o-b:" line is
>> for you to describe these things.
> Sure. unfortunately the code where the string list is filled is not in
> the patch. But if you look at the code it should be self-explanatory.

That is _exactly_ why I want the description in the commit log message.  I
don't want commit messages (or lack thereof) to force people to look at
the code outside the patch.

Otherwise I'll have to ask _you_ to personally give the 7-line explanation
you just gave us to anybody who runs "git log -p" with the default context
size after this patch is applied.  I do not think you have the bandwidth
to handle that ;-).

> There is actually also an other solution: we could first strdup the
> ref name to the .util member and take this as the input for the
> abbrev_ref()/string list entry and safe there the strdup.

I too thought something like that may make sense, but it doesn't look like
so, for two reasons:

 - string-list API is a bit cumbersome to use if you allocate the string
   yourself.  You will be made responsible for freeing them, and often you
   do so by setting strdup_strings to true immediately before calling
   string_list_clear(), which is kind of ugly;

 - The ref abbrev_branch() is called and the address of whose substring is
   taken to be used as "name" in handle_one_branch() is refspec.src, but
   what goes to .util is refname that is refspec.dst---they are different
   strings and one is not a substring of the other.

IOW, your patch text is good; it just would have been better with a bit
more explanation.

Thanks, will queue in 'maint'.
