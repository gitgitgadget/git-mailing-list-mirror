From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remote branches
Date: Sun, 13 Feb 2011 22:12:04 -0800
Message-ID: <7vmxlzuouj.fsf@alter.siamese.dyndns.org>
References: <4D578B6D.9090803@inria.fr>
 <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
 <20110213103156.GB4202@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Imbert <matthieu.imbert@inria.fr>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 14 07:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Porfa-0008Bf-1R
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 07:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab1BNGMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 01:12:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1BNGMQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 01:12:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D17913FD2;
	Mon, 14 Feb 2011 01:13:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IOHAZnJPDOMR
	oMLunZVFDzMzU0o=; b=wrmbcgchrkp35g8r19XQ0JocNFJqk1pNYyPxRX56+4O5
	faq67Vja8jfON8+YNEosOUVAB+/kQlb9+oRPNe0RYK8QDz4nZcg2vjgjN3AWyg8J
	CdF/xA7GGHUw+KhcFqJi9WpVMJ06odvoyk+ax3Yd6/V1RzS63X4F+q7J6x0+1cA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QJAibQ
	Zg1Hff5+wW4lhemTqQfNW0CAewMSzzYzHItqnbtT59RK4P+VSwJFvLZ35/UZ4Qc1
	7D0+cImklcw9oT8wVuuY7LEB2iIUf+ctb8veiLUwD80//2MG4MoXfV9BWiMDW2By
	1+k6UfxZdWVzBzDLU9QzrlGEyTth78RLMA5Kw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F2563FD0;
	Mon, 14 Feb 2011 01:13:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C3293FCF; Mon, 14 Feb 2011
 01:13:09 -0500 (EST)
In-Reply-To: <20110213103156.GB4202@atjola.homenet> (=?utf-8?Q?=22Bj=C3=B6?=
 =?utf-8?Q?rn?= Steinbrink"'s message of "Sun\, 13 Feb 2011 11\:31\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 826DA04A-3801-11E0-91B1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166690>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> It's ok for fetch to treat --tags like a refspec and to have it overr=
ide
> the defaults from the config when the user manually specifies it on t=
he
> command line. But when it is part of the default configuration it sho=
uld
> add to remote.<name>.fetch, not override it.
>
> IOW with this configuration:
> remote.foo.url =3D git://host/repo.git
> remote.foo.fetch =3D +refs/heads/*:refs/remotes/foo/*
> remote.foo.tagopt =3D --tags
>
> "git fetch foo" acts like:
>
> git fetch --tags git://host/repo.git
>
> instead of
>
> git fetch --tags git://host/repo.git +refs/heads/*:refs/remotes/foo/*

I would agree that the behaviour of tagopt acting exactly as if the
options were given from the command line is an ungly hack, not an inten=
ded
behaviour.  Interested in coming up with a proposed approach for a fix?

I would say --tags from the command line probably outlived its original
purpose; back when we didn't have the reliable automatic following,
sometimes people needed to say "fetch --tags" to complete the set of ta=
gs.
The description in config.txt for --tags also cites another purpose,
namely, to fetch tags otherwise totally unrelated to the branches you a=
re
following, but in reality there is no sensible use case to require such=
 a
feature.  Yes, you may have many unrelated lines of development with
separate set of tags on them, but then --tags to fetch _all_ tags from
all of these unrelated lines of development is a too coarse-grained too=
l
to be useful.

Note that "fetch --tags" without following any of the branches _is_ a
sensible setting for a rather common workflow.

=46or every active developer who will have his own private changes in t=
he
repository, there would be 100 passive followers who would fetch the
branches of the project and build the bleeding edge (i.e. nightly
builders) and these two classes of people would benefit from having
"refs/heads/*:refs/remotes/origin/*" refspec.  And for each of these
people, there would be 100 people who would be interested only in tagge=
d
releases.  They of course could download tarballs, but they can instead
say "fetch --tags", check out the latest tagged release and use it.
