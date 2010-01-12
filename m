From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Tue, 12 Jan 2010 00:29:58 -0800
Message-ID: <7v63774tfd.fsf@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 09:30:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUc8v-0007PL-MB
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 09:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab0ALIaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 03:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038Ab0ALIaS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 03:30:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0ALIaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 03:30:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39B848EC76;
	Tue, 12 Jan 2010 03:30:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pi+FDOgTzwMzKGt5Z+iI4ZVwecc=; b=o2k2dk
	CKhRhpt4jofnzjmjSwYAqHlBokDaXJi4u4aXTbnLpmpu0KOKNbKkJkPv0+rKA0/1
	CWPYFeftE0i7XEdzDWojDFXTX3jQGF/w45CDHA2V1t5AuMVIS2Tgj92Vg8gtHhXl
	KqCsnrGYT2cmP18jItw4m2ksexSkYtuou41gU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d2p48iP1Fs1LnqvvLj12uwEoEB3QJbwL
	KRXcIEU9blGXVoFDJMx4k0v91jYlSOcmaWp1YyqCHbLS5LI+wlfVmuXqukVO4MSj
	jFH7C4Dl14x3MLcTzmbwYRKf1Qy9abbFRyeuUCuFX5MrHV2Ilgmfu4HlO4Q4KySS
	8Zal1hnPFNE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B4E5F8EC74;
	Tue, 12 Jan 2010 03:30:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 763888EC6F; Tue, 12 Jan
 2010 03:30:00 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 (Linus Torvalds's message of "Mon\, 11 Jan 2010 08\:33\:09 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0D985D4-FF54-11DE-943E-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136703>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ack. Works for me. And with that, I'd love for it to go in, and get rid of 
> the external grep. Performance is now a non-issue (it goes both ways), and 
> the internal grep doesn't have the bug with separators between multi-line 
> greps.
>
> And dropping the external one gets rid of all the issues with PATHs, crap 
> 'grep' implementations, and removes actual code. Goodie.
>
> 		Linus

Before going forward, I found two small nits that should go to maint.
