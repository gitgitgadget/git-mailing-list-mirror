From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need
 before updating our ref) breaks fetch
Date: Wed, 28 Sep 2011 11:50:07 -0700
Message-ID: <7vsjngzelc.fsf@alter.siamese.dyndns.org>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Sep 28 20:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8zD1-0003Ur-69
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 20:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab1I1SuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 14:50:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab1I1SuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 14:50:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06C304EE4;
	Wed, 28 Sep 2011 14:50:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8BktMCwh0nRJ
	+vKh4b3yoOxVr5U=; b=x5xjj5yw4OfcRGT4srLjEB0fW7WlRpva07KYlqYqJKBZ
	FtIfa2OmwuyaQmfqf2OnQsM6C5115zvi5h+0V/+TOAOeVtEzK0xo2M1NFM+5X3a3
	zi6p5oTtAfA4C6LCTM3Uz4f2yt3HrnNOsdOBURB+Y/tJe7zptr2c3+/f4ZVlfyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=puXlQO
	AI6mrTgF82TMjoilnpVCVKlwwYgknx1VSGFdSmEKz0qgPtj1Hyg9tE7qtJ1NkvjT
	jkW2S+NHx2Qaa0cOamilMCbFtnkbjJGtwx/Exe2Y6YBjXX0cnV1pSMZY+WIt+hz4
	o+Sk7B9Bnf1OjComoQvB3z8pum8IW6X4Rs0kY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F33B44EE3;
	Wed, 28 Sep 2011 14:50:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E63D4EE2; Wed, 28 Sep 2011
 14:50:09 -0400 (EDT)
In-Reply-To: <1317225869.30267.18.camel@bee.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 28 Sep 2011 18:04:27
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B078E7AC-EA02-11E0-B47B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182356>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Whilst trying to do some work related to fetch, I came across a
> regression in the 'next' branch....
>
> $ ./git-fetch git://repo.or.cz/git

That invocation of ./git-fetch looks suspicious.

Are you sure that it internally invokes ./git-rev-list from the same
version that knows --verify-objects option (you just built in your curr=
ent
directory), or is it invoking an old git-rev-list that is installed and=
 is
reachable from your usual $PATH, which does not know that option yet?

When I try a new version that was just built in my current directory, h=
ere
is an incantation I use:

    GIT_EXEC_PATH=3D`pwd`
    PATH=3D`pwd`:/usr/bin:/bin
    GITPERLLIB=3D`pwd`/perl/blib/lib

    export GIT_EXEC_PATH PATH GITPERLLIB
