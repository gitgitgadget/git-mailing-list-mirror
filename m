From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative paths don't work in .gitignore as would be expected.
Date: Tue, 03 Feb 2015 12:11:37 -0800
Message-ID: <xmqqtwz2rc06.fsf@gitster.dls.corp.google.com>
References: <CAKU1PAWMh_3x9OoFmXG4+5b=7PRckC47k-MAq++SXahxAP5V7g@mail.gmail.com>
	<54CF11CA.6000308@gmail.com>
	<xmqqsieot999.fsf@gitster.dls.corp.google.com>
	<CALbm-Ea7X3dDrMUw0sDhWf0sg+zs7oRUkRD+aPzD9fHqB=ZuWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "\/#!\/JoePea" <trusktr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 21:19:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIjwa-0005r0-6W
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 21:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933924AbbBCUT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 15:19:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752213AbbBCUT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 15:19:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CEFC346EB;
	Tue,  3 Feb 2015 15:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/K4uj0H4NtJ9MbmGMFcdxquCg78=; b=kQomCy
	m5coQiUgybMCDHbJM0lNqOeuOzc8hxK1P3jzHM2TNZCge4DBc9pFSxAlzq4309MG
	Z1y+RfkyTv+FrgBCAnKZf69rZuJ8UKHiv1COx6XaS4ZX+JT1zCsucdG7yRc5zd3c
	iKVd05LRnxQb6JjLfHzLgBoXdXdJZvNwHXWGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9WOhuCstUdLXdpljcN7gtyh611ffYLG
	4+xlR+UoMUBWzStihJtm6tQ4aIEQb1AcmM/aciV2PDFVEJxoIqrfLAFp50fsiSDu
	R0mFT3HXaAoRJZWyjgHBKNRKm+YsdedEzMpRco9uKFA8bAUQHEUakdP1EJ5MGG5h
	lSaosdOsJ6c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51160346EA;
	Tue,  3 Feb 2015 15:19:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5E1B34528;
	Tue,  3 Feb 2015 15:11:39 -0500 (EST)
In-Reply-To: <CALbm-Ea7X3dDrMUw0sDhWf0sg+zs7oRUkRD+aPzD9fHqB=ZuWQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 2 Feb 2015 18:18:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD2A76FA-ABE0-11E4-B7CC-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263329>

Stefan Beller <stefanbeller@gmail.com> writes:

> 2015-02-02 11:15 GMT-08:00 Junio C Hamano <gitster@pobox.com>:
>
>> Isn't gitignore(5) documentation reasonably clear?
>> ...
>>  - A leading slash matches the beginning of the pathname. For
>>    example, "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
>>
>>> That's true, though you'd never (barely?) git version control an entire
>>> file system?
>>
>> When you have the entire file system under /.git, "/var/" still
>> would be the right way to spell a pattern to match ...
>> ... and lives in the root level of the filesystem (because of the
>> leading '/' anchors
>> the pattern to the same level as the file the pattern appears in,
>> i.e. /.gitignore) and no other place.
>
> ... Now I realize git treats the repository
> root literally as the root and hence absolute paths starting with "/"
> make totally sense inside git as the world stops for git outside its
> work directory.

Only when the pattern appears in .gitignore at the top-level of the
project, you can say: "/*.js" matches files with ".js" suffix at the
root level of the project because '/' means 'root'.

But that explanation breaks down for "t/.gitignore" that has entries
like "/.prove".  It is not excluding ".prove" at the top-level of
the project.  It is excluding those that appear at the same level as
that ignore file in question lives in, i.e. the "t/" directory.  It
excludes "t/.prove", it excludes neither ".prove" at the top-level
nor "t/tt/ttt/.prove".

In hindsight, using '/' prefix as a way to anchor the patter to the
same directory the .gitignore file appears in was suboptimal,
exactly because it would invite the above reaction.  But I do not
know if using "./" as the prefix to denote the same thing would have
been better.
