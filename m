From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-branch --print-current
Date: Sun, 04 Jan 2009 19:55:34 -0800
Message-ID: <7vsknys8y1.fsf@gitster.siamese.dyndns.org>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
 <20090104033839.GD21154@genesis.frugalware.org>
 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
 <9b18b3110901040535m1f67cb7er95823d31443ee971@mail.gmail.com>
 <7v1vvitwio.fsf@gitster.siamese.dyndns.org>
 <20090105021832.GA20973@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Karl Chen <quarl@cs.berkeley.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 04:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJgaT-00071W-9f
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 04:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbZAEDzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 22:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbZAEDzs
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 22:55:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbZAEDzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 22:55:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E41351BD12;
	Sun,  4 Jan 2009 22:55:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8F4661BD18; Sun, 
 4 Jan 2009 22:55:36 -0500 (EST)
In-Reply-To: <20090105021832.GA20973@spearce.org> (Shawn O. Pearce's message
 of "Sun, 4 Jan 2009 18:18:32 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA973DAC-DADC-11DD-82DC-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104560>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> demerphq <demerphq@gmail.com> writes:
>> 
>> > The version im using, from git version 1.6.0.4.724.ga0d3a produces the
>> > following error:
>> >
>> > cut: ./HEAD: No such file or directory
>> >
>> > when in the .git/refs directory.
>> 
>> Personally, I think you are nuts to be in .git/refs and want to use that
>> information for anything useful, but if it is an easy enough fix, a patch
>> would be useful.
>
> I agree, its nuts to be there.  But this also does show up in 1.6.1.
> What's odd is the output of rev-parse --git-dir is wrong:
>
>   $ cd .git/refs
>   $ git rev-parse --git-dir
>   .
>
> Its *not* ".", its "..", I'm *in* the directory.  This throws off
> a lot of the other operations we do in __git_ps1, like detecting
> the repository state by checking MERGE_HEAD or rebase-apply.
>
> I think we should fix rev-parse --git-dir if we can, not the bash
> completion code.

Sigh, yeah, that is what I thought would be happening.
