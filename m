From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
 that are corrupted in a pack file
Date: Wed, 07 Jan 2009 21:40:17 -0800
Message-ID: <7v4p0a8if2.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
 <1231292360.8870.61.camel@starfruit>
 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
 <1231314099.8870.415.camel@starfruit>
 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
 <1231368935.8870.584.camel@starfruit>
 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
 <1231374514.8870.621.camel@starfruit>
 <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain>
 <885649360901071821t2ea481b5k83ab800f6aeb897@mail.gmail.com>
 <20090108024325.GE10790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, kb@slide.com,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 06:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKnf3-00043l-TB
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 06:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758675AbZAHFk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 00:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758674AbZAHFk4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 00:40:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbZAHFk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 00:40:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D42B31C0D3;
	Thu,  8 Jan 2009 00:40:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E31AE1C0D2; Thu, 
 8 Jan 2009 00:40:33 -0500 (EST)
In-Reply-To: <20090108024325.GE10790@spearce.org> (Shawn O. Pearce's message
 of "Wed, 7 Jan 2009 18:43:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E867B560-DD46-11DD-BBD9-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104890>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> For those following along at home, Linus' 2.6 tree:
>
> $ ulimit -v `echo '150 * 1024'|bc -l`
> $ git co 56d18e9932ebf4e8eca42d2ce509450e6c9c1666

Hmm, without any "wrap zlib to die on error" patch, this step already
fails with:

    $ git checkout 56d18e9932ebf4e8eca42d2ce509450e6c9c1666
    fatal: Out of memory? mmap failed: Cannot allocate memory

I guess that is because our test repositories are packed differently.
I'll retry after repacking..
