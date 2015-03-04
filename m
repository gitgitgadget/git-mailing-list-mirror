From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 04 Mar 2015 12:56:10 -0800
Message-ID: <xmqq385k8ot1.fsf@gitster.dls.corp.google.com>
References: <CACsJy8AM=W4f6u_7YpvmfiBwrJjqfJMJoq6CQYfKOh+qD6rF3Q@mail.gmail.com>
	<20150225143116.GA13567@peff.net>
	<xmqqk2z5on72.fsf@gitster.dls.corp.google.com>
	<20150225185128.GA16569@peff.net>
	<xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
	<20150225191108.GA17467@peff.net>
	<20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
	<xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
	<20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com>
	<xmqqr3t8fgm4.fsf@gitster.dls.corp.google.com>
	<20150302125017.GA4464@tsaunders-iceball.corp.tor1.mozilla.com>
	<54F6EB96.6080500@peralex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Noel Grandin <noel@peralex.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 21:57:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGME-0007SR-VW
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 21:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbbCDU50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 15:57:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751096AbbCDU5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 15:57:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 999D93B9F5;
	Wed,  4 Mar 2015 15:57:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=86swNClCJmFFRiTdrGGWKg6aByg=; b=foGTZB
	aRu0r7V4yQCBxDuNb/0EFzlO07EDd01SkxLvbpb1P5uy3mDZu7ILLeTWyvOlDak3
	EcKfpMMYL8Tu1kYkcmp2fk78p/uil3CmKb+ePhNdkIZyYu/JgO9QeNf9jotO/qdK
	UUKbv5qBTDwRnWHG3/mqty/0SnXexsZ2Qb0wg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AWTQ9JjLQTp6jOIj6y++m4w6ZXd9iFcD
	o/epuc8uV80EY+ogia/hbcom4mRhpm2c8tZ37jISgihTRKusR2cz4zy8JoQldz5q
	zrfcEOOM2bGn1IVTbTQdTzHRWDDjS5Zs0HnKcWQ4aY5TVo8jVN85Y6vNKQe5lPjk
	QaTJLb4ev+U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90DED3B9F4;
	Wed,  4 Mar 2015 15:57:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6537A3B984;
	Wed,  4 Mar 2015 15:56:11 -0500 (EST)
In-Reply-To: <54F6EB96.6080500@peralex.com> (Noel Grandin's message of "Wed,
	04 Mar 2015 13:25:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3827BCE-C2B0-11E4-9F46-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264775>

Noel Grandin <noel@peralex.com> writes:

> On 2015-03-02 02:50 PM, Trevor Saunders wrote:
>> I think they solve somewhat different problems, but maybe my problem
>> is so specialized I should just have a wrapper around grep that
>> changes defaults. Trev 
>
> I'm with Trevor on this one. While I see the appeal of the generality
> of a macro solution, this is really just about convenience for me on a
> per-project basis.
>
> As in, while working on a specific project, I sometimes just want to
> exclude, for the time being, a bunch of stuff from 'git grep'.

The key word here is "for the time being", though.  What would you
do once you are done with the "for the time being" activity?  "git
config --unset"?

If you forget to do so when the "for the time being" activity ends,
and then you try to run 'git grep' and see that you did not get
expected hits from hierarchies that you set to exclude earlier, you
either (1) get misled to a wrong decison based on that false
non-hit, or (2) start scratching your head, wasting time trying to
figure out why 'git grep' is not hitting, no?

I expect the answer might be "No, I won't forget; I am very well
organized and you do not have to worry for me".  But a feature is an
invitation for people other than yourself, so...
