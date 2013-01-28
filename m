From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 14:29:14 -0800
Message-ID: <7v7gmxuekl.fsf@alter.siamese.dyndns.org>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
 <20130128205834.GC7759@google.com> <7vfw1lug6f.fsf@alter.siamese.dyndns.org>
 <20130128221026.GE7759@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrej Andb <admin@andrej-andb.ru>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 23:29:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzxCu-0001yz-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 23:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab3A1W3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 17:29:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755155Ab3A1W3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 17:29:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86ED9C629;
	Mon, 28 Jan 2013 17:29:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KSWZ1LImvGJDodfVhJet+JBBq4s=; b=iDtCTv
	KK+40s1dX7ofF9ZbbL/89Q+AWNFGp4G+NWjUYvALxp/U3utym/48T8tkKZ6TLNH5
	sswZ9hCDCAnMmdzQlmQq4bfmnp8TZrysXpMsR3+X3zGM7iWpvOqu+8kOpbfxdbDW
	0+u2ZAb7E8uX54bqTtZcC6taV13CG0OIbjvIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sHdJpC4jjXeJ7Elw/ak+S+F66GTSBdZi
	VmZ/7+N+lqwXhkK+pQVIQsOGkG5xTPVynt4L1VAVDApEReA/akTfpwXGDdPwBS2U
	g5Y2YtGn1FLtBF4paOb0CjTrubkw0p42VS3Llz8jHbcZPB0i6moBkx0OBU2bXoez
	SiKwnP3m1Ag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD82C627;
	Mon, 28 Jan 2013 17:29:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D976DC622; Mon, 28 Jan 2013
 17:29:16 -0500 (EST)
In-Reply-To: <20130128221026.GE7759@google.com> (Jonathan Nieder's message of
 "Mon, 28 Jan 2013 14:10:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26A87218-699A-11E2-8077-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214882>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>>> Andrej Andb wrote:
>
>>>> --- a/gitweb/gitweb.perl
>>>> +++ b/gitweb/gitweb.perl
>>>> @@ -2068,7 +2068,7 @@ sub picon_url {
>>>>  	if (!$avatar_cache{$email}) {
>>>>  		my ($user, $domain) = split('@', $email);
>>>>  		$avatar_cache{$email} =
>>>> -			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>>>> +			"//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
> [...]
>> Intuitively it feels strange that the above lets the site that gave
>> you the base URL dictate over what scheme sites unrelated to it has
>> to serve their resources.
>
> The main effect is to slightly improve privacy.  A man in the middle
> can still see the size of avatars and when you fetched them, but at
> least this way when you are using HTTPS they do not see the names of
> authors of commits you are looking at.
>
> It also avoids a mixed content warning.
>
> On the other hand, it hurts caching by proxies.

I am sure mixed content warning was the primary motivation of the
patch.  Do we know these external sites actually server what we want
over https://?
