From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Install issues
Date: Tue, 11 Nov 2008 09:47:00 -0800
Message-ID: <7vhc6e17fv.fsf@gitster.siamese.dyndns.org>
References: <20081110121739.15f77a01@pc09.procura.nl>
 <20081110113924.GR24201@genesis.frugalware.org>
 <20081110173101.3d76613b@pc09.procura.nl>
 <20081110175123.GV24201@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzxMW-0003i2-63
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbYKKRr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYKKRr4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:47:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbYKKRr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:47:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 845EB7B91A;
	Tue, 11 Nov 2008 12:47:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9ED97B918; Tue,
 11 Nov 2008 12:47:40 -0500 (EST)
In-Reply-To: <20081110175123.GV24201@genesis.frugalware.org> (Miklos Vajna's
 message of "Mon, 10 Nov 2008 18:51:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DE3E0612-B018-11DD-8C85-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100661>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Mon, Nov 10, 2008 at 05:31:01PM +0100, "H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
>> --- Makefile.org	2008-11-10 17:29:53.000000000 +0100
>> +++ Makefile	2008-11-10 17:29:39.000000000 +0100
>> @@ -1329,6 +1329,10 @@ check-sha1:: test-sha1$X
>>  	./test-sha1.sh
>>  
>>  check: common-cmds.h
>> +	@`sparse </dev/null 2>/dev/null` || (\
>> +	    echo "The 'sparse' command is not available, so I cannot make the 'check' target" ;\
>> +	    echo "Did you mean 'make test' instead?" ;\
>> +	    exit 1 )
>>  	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
>
> Please read Documentation/SubmittingPatches, your patch lacks a signoff
> and a commit message.

Heh, for something small and obvious like this, that's asking a tad too
much, although a properly formatted message does reduce my workload and is
appreciated.

I said "obvious" not in the sense that it is "obviously good".  It is
obvious what issue the patch wants to address.

Having said that, it is far from clear if special casing "make check" like
this is a good thing, though.  The crufts resulting from "Four extra lines
won't hurt" kind of reasoning can accumulate and snowball.  Is reading the
Makefile when your build fails in order to see if the target was what you
really wanted to invoke (ideally, it should rater be "_before_ running
make, reading the Makefile to find out what you want to run") a lost art
these days?
