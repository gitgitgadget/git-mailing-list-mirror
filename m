From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix wrong xhtml option to highlight
Date: Thu, 27 Jan 2011 11:00:53 -0800
Message-ID: <7vvd1agoii.fsf@alter.siamese.dyndns.org>
References: <1295898298-9794-1-git-send-email-Jochen@herr-schmitt.de>
 <7vvd1dlxza.fsf@alter.siamese.dyndns.org>
 <1296092646.23506.10.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jochen Schmitt <Jochen@herr-schmitt.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Adam Tkac <atkac@redhat.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Jan 27 20:01:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiX65-00062L-8W
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 20:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab1A0TBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 14:01:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab1A0TBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 14:01:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CDE6E332D;
	Thu, 27 Jan 2011 14:02:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qWDojSEfiDJqRnWVrlEpFOl2+2s=; b=v3TQ5s
	2UTaJ1+/rVt9V2H4+u9ipWODkG1Fcw4kbag+EFMVR5KZSJ8HBpG9O9SH8hCKQDFX
	vYOAHJIhYz2QVLi3CuSfAg0ZsOpEdLJALlXRPmhr81iEfkbUuzdkgxgZrrzCIflJ
	/BKYE97P6kqRE8JHgrk9h/xyh8phL3lHnuLb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wjwxqYJGJ9WTs2q36tK8EbA3jKYTPguE
	MDU2E9b1k7KU1XrUo9d5nbtcdMx1dUXOul/KfIdFo5vjAUZ7n+w5r4b/Wi377gbM
	7MoBcAtawDNnKayGELkOtvus3Z4w2FwZ3ePN29SyTctvbehf+YYCIUIUaSNGp+ov
	0NuTFviP9Pw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7AA883329;
	Thu, 27 Jan 2011 14:01:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C19E83327; Thu, 27 Jan 2011
 14:01:45 -0500 (EST)
In-Reply-To: <1296092646.23506.10.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Wed\, 26 Jan 2011 20\:44\:06 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E89AEA66-2A47-11E0-87DA-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165584>

Drew Northup <drew.northup@maine.edu> writes:

>> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> > index 1025c2f..b662420 100755
>> > --- a/gitweb/gitweb.perl
>> > +++ b/gitweb/gitweb.perl
>> > @@ -3468,7 +3468,7 @@ sub run_highlighter {
>> >  	close $fd;
>> >  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>> >  	          quote_command($highlight_bin).
>> > -	          " --xhtml --fragment --syntax $syntax |"
>> > +	          " -xhtml --fragment --syntax $syntax |"
>> 
>> Curious.
>> 
>> Does the command take double-dash for the fragment and syntax options but
>> a single dash for the xhtml option?  Really...
>> 
>> A few top hits returned by Google for "highlight manual page" tells me
>> otherwise.
>
> Certainly appears to be the case that "--xhtml" is the option in Ubuntu
> 10.04.1 LTS. 
>
> Jochen,
> Did you mean "-X" (which sets the same option)?

The current proposal is to drop --xhtml and let highlight default to HTML.

Honestly speaking, I don't like the approach very much; it would have been
much better if highlight had a single way that is supported throughout its
versions to specify the output format.  But it appears that there isn't,
and relying on and hoping for its default to stay HTML is the best we
could do, if we plan to support highlight 2.4.something or older.

The copy of U10.04 I have has highlight 2.12, and according to its manual
pages, -X, --xhtml, and --out-format=xhtml mean the same thing.  HTML is
the default.

The change-log at www.andre-simon.de indicates that --out-format has
become the preferred method and the short options like -X and -H are not
supported in recent versions (3.0 beta and newer).

But as Jakub mentioned, 2.4.5 did not have --output-format; it was only in
3.0 beta that -O was redefined to mean --output-format and in old versions
the short option meant something else.

What a mess...

The next time we introduce a new dependency, we really should try hard to
assess the stability and maturity of that dependency.  In hindsight, I
think "highlight" was probably a bit too premature to be depended upon.
