From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Blaming diffs
Date: Sun, 16 Sep 2007 22:41:08 -0700
Message-ID: <7vy7f53l3f.fsf@gitster.siamese.dyndns.org>
References: <20070916163829.GA6679@glandium.org>
	<200709170659.15655.chriscool@tuxfamily.org>
	<20070917045704.GH3099@spearce.org>
	<200709170740.00917.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:41:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX9MK-0006zk-1r
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 07:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbXIQFlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 01:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbXIQFlS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 01:41:18 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:53468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXIQFlS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2007 01:41:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B759134976;
	Mon, 17 Sep 2007 01:41:32 -0400 (EDT)
In-Reply-To: <200709170740.00917.chriscool@tuxfamily.org> (Christian Couder's
	message of "Mon, 17 Sep 2007 07:40:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58389>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le lundi 17 septembre 2007, Shawn O. Pearce a =C3=A9crit :
>> Christian Couder <chriscool@tuxfamily.org> wrote:
>> > I don't know if that's what you are looking for but perhaps you co=
uld
>> > use "git bisect run". You just need to pass it a script that retur=
ns 1
>> > when it finds the changes and 0 otherwise. (See git-bisect man pag=
e.)
>>
>> That's very inefficient to search for something...
>
> Perhaps but you can search using whatever script or command you want/=
know.=20
> You are not limited by those implemented in git.
>
> You can also make it more efficient with "git bisect {start,good,bad}=
".

I _think_ the inefficiency Shawn refers to is that "git bisect"
wrapper inherently is based on checking out the revision.  It is
similar to "filter-branch --tree-filter" being much more
inefficient than "filter-branch --index-filter" (the latter only
works with index while the former does a full checkout).

The underlying "git rev-list --bisect" can be used to ask for
sequence of commits to check if your check does not require a
full checkout, but there is no wrapper like "git bisect" that=20
uses that mode of operation.
