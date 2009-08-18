From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 10:05:59 -0700
Message-ID: <7vpratdpc8.fsf@alter.siamese.dyndns.org>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
 <alpine.LFD.2.00.0908181240400.6044@xanadu.home>
 <bdca99240908180959h69f37671k4d526fbf4814e8d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 19:06:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdS8f-0007nA-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693AbZHRRGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 13:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754758AbZHRRGL
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 13:06:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbZHRRGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 13:06:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FAC92E2E9;
	Tue, 18 Aug 2009 13:06:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DC4AC2E2E6; Tue, 18 Aug 2009
 13:06:00 -0400 (EDT)
In-Reply-To: <bdca99240908180959h69f37671k4d526fbf4814e8d1@mail.gmail.com>
 (Sebastian Schuberth's message of "Tue\, 18 Aug 2009 18\:59\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E362DC6-8C19-11DE-9E51-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126422>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> I like the idea of making bswap available more globally, but I'm not
> sure if it's worth to introduce a new file for only that purpose.
> Isn't there already a central header for such things?
>
> Moreover, including compat/bswap.h would only give you ntohl()/htonl()
> on one platform.

We do not include compat/ directly from the source; git-compat-util.h is
supposed to be the first thing included (as some platforms have peculiar
requirements on the order in which system header files are included, and
one of the reasons git-compat-util.h is there).  Hence by including it,
you get ntohl/htonl everywhere.

To reduce confusion, you may want to rename compat/bswap.h to something
like compat/ntohl-htonl-fix.h ;-)
