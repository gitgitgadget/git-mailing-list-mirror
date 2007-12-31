From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] Working files created in bare repository when pushing to a rewound bare repository
Date: Sun, 30 Dec 2007 22:50:29 -0800
Message-ID: <7vd4sn73yi.fsf@gitster.siamese.dyndns.org>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 07:51:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9EUI-00069B-BW
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 07:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbXLaGug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 01:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbXLaGug
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 01:50:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbXLaGuf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 01:50:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 28C198907;
	Mon, 31 Dec 2007 01:50:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AF0318906;
	Mon, 31 Dec 2007 01:50:31 -0500 (EST)
In-Reply-To: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com>
	(Ping Yin's message of "Mon, 31 Dec 2007 14:42:42 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69388>

"Ping Yin" <pkufranky@gmail.com> writes:

> Following scripts can reproduce the problem: in the final line,
> foo.txt is generated in bare foo.git

> # reset bare and then push
> cd foo.git && git reset --hard HEAD^ && cd ..

"git reset" is about resetting *both* the branch tip and the
work tree.  Doesn't it create unwanted work tree files when
misused this way at this point already?

> cd foo && git push && cd ..

"git push" never touches the work tree.  It is possible that
there is a PEBCAK hook enabled in that bare repository that
creates random files upon receiving a push, but that is hardly
worth reporting _here_ on the list ;-).

Puzzled...
