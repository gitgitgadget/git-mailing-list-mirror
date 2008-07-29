From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodules
Date: Tue, 29 Jul 2008 07:53:08 -0700
Message-ID: <7v7ib4ivxn.fsf@gitster.siamese.dyndns.org>
References: <20080728162003.GA4584@artemis.madism.org>
 <20080728205923.GC10409@artemis.madism.org>
 <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
 <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
 <20080729082135.GB32312@artemis.madism.org>
 <20080729083755.GC32312@artemis.madism.org>
 <20080729085125.GJ32184@machine.or.cz>
 <alpine.DEB.1.00.0807291413460.4631@eeepc-johanness>
 <20080729130713.GF32312@artemis.madism.org>
 <alpine.DEB.1.00.0807291511400.4631@eeepc-johanness>
 <320075ff0807290631l1f9a1e70jcb73bde7e2c86000@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Petr Baudis" <pasky@suse.cz>,
	"Benjamin Collins" <aggieben@gmail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Git ML" <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 16:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNqak-0005NI-9J
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 16:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbYG2OxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 10:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbYG2OxV
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 10:53:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYG2OxU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 10:53:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A5613DB05;
	Tue, 29 Jul 2008 10:53:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6F73F3DB01; Tue, 29 Jul 2008 10:53:10 -0400 (EDT)
In-Reply-To: <320075ff0807290631l1f9a1e70jcb73bde7e2c86000@mail.gmail.com>
 (Nigel Magnay's message of "Tue, 29 Jul 2008 14:31:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 149F36D8-5D7E-11DD-A1CA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90643>

"Nigel Magnay" <nigel.magnay@gmail.com> writes:

>> I do not understand.  We are talking about three different things here:
>>
>> 1) the committed state of the submodule
>> 2) the local state of the submodule
>> 3) the state of the "tracks" branch
>>
>> We always have 1) and we have 2) _iff_ the submodule was checked out.  We
>> only will have 3) if "tracks" is set in .git/config (for consistency's
>> sake, we should not read that information directly from the .gitmodules
>> file, but let the user override it in .git/config after "submodule init".
>
> I think the implication is that .gitconfig states "I'm expecting that
> submodule X will always be tracking branch name 'Y'" and that you
> wouldn't ever override it in .git/config. If you then switched
> submodule X to branch Z, then committed the superproject, that commit
> would contain a change to .gitconfig also (to say I'm expecting to
> track Z rather than X') ?

You are right.  I think letting the user override with .git/config is a
good idea, but it shouldn't be ".gitmodules may say X or whatever, but I
want to use Y".

Instead, it should be more like "On branches where .gitmodules says X, I
want to use Y."

This comment actually applies to the existing override of .gitmodules item
with .git/config (I think I've been saying it since the design phase).
