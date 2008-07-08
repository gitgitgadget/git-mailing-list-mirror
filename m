From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Mon, 07 Jul 2008 23:02:11 -0700
Message-ID: <7vhcb0x6ak.fsf@gitster.siamese.dyndns.org>
References: <20080701150025.GD5852@joyeux>
 <7vd4lro7ct.fsf@gitster.siamese.dyndns.org>
 <20080706161101.GB23385@jhaampe.org> <48711782.6090609@gmail.com>
 <20080707063424.GB5506@jhaampe.org> <4872CF86.5050702@gmail.com>
 <7v7ibxxfje.fsf@gitster.siamese.dyndns.org> <4872DE54.5010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Joyeux <sylvain.joyeux@dfki.de>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 08:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG6Ii-0001CO-6u
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 08:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbYGHGC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 02:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbYGHGC3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 02:02:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbYGHGC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 02:02:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EEAB28B6C;
	Tue,  8 Jul 2008 02:02:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C7EB28B6B; Tue,  8 Jul 2008 02:02:18 -0400 (EDT)
In-Reply-To: <4872DE54.5010804@gmail.com> (Mark Levedahl's message of "Mon,
 07 Jul 2008 23:26:12 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70CDFC7C-4CB3-11DD-B222-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87721>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio C Hamano wrote:
>> I'd like to hear clarifications on two counts, please?
>>  (1) If Sylvain wanted to have that appear at dir0/dir1/init not init,
>>      would it have been sufficient to give that path twice (once for
>>      <repository> and another for <path> parameter) to make things work as
>>      expected?
>>
> git-submodule really requires two arguments:
>
>    $ git submodule add <URL> <relative-path-to-module-in-tree>
>
> and supports two modes:
>
> 1) relative-path exists and is a valid repo: just add the module, it
> was created in tree, the user is expected to eventually push this to
> the given URL so other users will get this as normal. This exists to
> simplify the process of creating a repo to begin with.
>
> 2) relative-path doesn't exist: clone from the URL. This is the normal use.
> submodule supports adding a module in one of two ways:
>
> So,
>
>    $ git submodule add   dir0/dir1/init   dir0/dir1/init
>
> will add the repo, but also makes the repo its own origin. I don't
> think this makes sense.
>>  (2) Is it generally considered a sane use case to specify an existing
>>      repository inside the working tree of a superproject as a submodule
>>      using "git submodule add" like Sylvain's example did?
>>
>>      I would have understood if the command were "git add dir0/dir1/init",
>>      but I have this vague recolleciton that "git submodule add" is about
>>      telling our repository about a submodule that comes from _outside_.
>>
>>
>>
> Adding an existing in-tree repo, ala
>
> $ git submodule add <intended-URL> <path>
>
> is there to ease the initial creation of a submodule. It can be
> created and registered in-tree, and later pushed to the server. This
> is sane, but is not the normal usage (makes sense only on creation).

Thanks.

The above is quite a bit more information than I can read from
Documentation/git-submodule.txt; care to send it in in a patch form?
