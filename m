From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Mon, 07 Jul 2008 19:42:29 -0700
Message-ID: <7v7ibxxfje.fsf@gitster.siamese.dyndns.org>
References: <20080701150025.GD5852@joyeux>
 <7vd4lro7ct.fsf@gitster.siamese.dyndns.org>
 <20080706161101.GB23385@jhaampe.org> <48711782.6090609@gmail.com>
 <20080707063424.GB5506@jhaampe.org> <4872CF86.5050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Joyeux <sylvain.joyeux@dfki.de>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 04:44:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG3Bs-0004H6-Bp
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 04:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708AbYGHCml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 22:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755582AbYGHCml
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 22:42:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbYGHCmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 22:42:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 01B6D27842;
	Mon,  7 Jul 2008 22:42:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1A19C27840; Mon,  7 Jul 2008 22:42:31 -0400 (EDT)
In-Reply-To: <4872CF86.5050702@gmail.com> (Mark Levedahl's message of "Mon,
 07 Jul 2008 22:23:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 879CA15E-4C97-11DD-96C0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87690>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Sylvain Joyeux wrote:
>>
>> Redo the prep work, the clone and now
>>
>> git submodule add dir0/dir1/init
>>
>> (i.e. don't expect dir0/dir1/init to be the clone of ./init, that was just a
>> shortcut for the test. Expect it to be a clone of "something, somewhere")
>>
>>
> Per the man-page,
>    git submodule [--quiet] add [-b branch] [--] <repository> [<path>]
>
> which means, that the *repository* url is mandatory, the path is
> optional. What you specifically asked git-submodule to do was to
> *clone* from dir0/dir1/init, and because you gave no path to put the
> submodule in, git-submodule deduced the name as "init", and cloned to
> there.

I'd like to hear clarifications on two counts, please?

 (1) If Sylvain wanted to have that appear at dir0/dir1/init not init,
     would it have been sufficient to give that path twice (once for
     <repository> and another for <path> parameter) to make things work as
     expected?

 (2) Is it generally considered a sane use case to specify an existing
     repository inside the working tree of a superproject as a submodule
     using "git submodule add" like Sylvain's example did?

     I would have understood if the command were "git add dir0/dir1/init",
     but I have this vague recolleciton that "git submodule add" is about
     telling our repository about a submodule that comes from _outside_.
