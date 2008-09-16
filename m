From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Grafts workflow for a "shallow" repository...?
Date: Mon, 15 Sep 2008 23:25:10 -0700
Message-ID: <7v3ak08v5l.fsf@gitster.siamese.dyndns.org>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com>
 <20080916052425.GA14644@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 08:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfU1i-00025X-OD
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 08:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbYIPGZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 02:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYIPGZ6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 02:25:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbYIPGZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 02:25:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 171C76155C;
	Tue, 16 Sep 2008 02:25:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0FB266155B; Tue, 16 Sep 2008 02:25:11 -0400 (EDT)
In-Reply-To: <20080916052425.GA14644@spearce.org> (Shawn O. Pearce's message
 of "Mon, 15 Sep 2008 22:24:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3B293F46-83B8-11DD-8CCE-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95978>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Martin Langhoff <martin.langhoff@gmail.com> wrote:
>> Here is my attempt at a "let's publish a shallow repository for branch
>> of moodle". Let me show you what I did...
> ...
>>  # 1.7 was a significant release, anything earlier than that
>>  # is just not interesting -- even for pickaxe/annotate purposes
>>  # so add a graft point right at the branching point.
> ...
>> Is this kind of workflow (or a variation of it) supported? For this to
>> work, we should communicate the grafts in some push operations and
>> read them in clone ops - and perhaps in fetch too.
> ...
> I think that in this case the best thing to do is give users
> a shell script that does roughly:
>
> 	git init
> 	echo $BASE >.git/info/grafts
> 	git remote add -f origin $url
> 	git checkout -b master origin/master
>
> Sign the script, and let users verify it before executing.  You may
> also want a script to drag in the history behind by removing the
> graft and fetching $BASE^, but that is hard because your repository
> already "has" that.

Why not just filter-branch _once at the origin_ and publish the result?
