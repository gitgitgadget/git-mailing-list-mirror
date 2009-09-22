From: Junio C Hamano <gitster@pobox.com>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Tue, 22 Sep 2009 09:29:02 -0700
Message-ID: <7vk4zrt035.fsf@alter.siamese.dyndns.org>
References: <20090921160551.GD8173@gryning.com>
 <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com> <7vocp4ulq2.fsf@alter.siamese.dyndns.org> <20090922113151.GO8173@gryning.com> <Hfm4AdtlXpMutgmdj0vm7yb0ucfu_cijUloasBDWh6NfRCwLhP4OCA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: c@gryning.com, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:29:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq8Ez-00051p-4y
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 18:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbZIVQ3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 12:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbZIVQ3L
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 12:29:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756939AbZIVQ3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 12:29:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4B5D5B14B;
	Tue, 22 Sep 2009 12:29:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PcIeBXbDR0TedJbK6rL53SfhPhc=; b=JPrT63
	OzA8LFWC1fS7zDf/1fmhIQPC/4wUcqt2JsBUZQvjDDdf6l3G/+C42XiusSrrhgNF
	iQVV/wqu+ETNuaKmjy0rGpAbNdnn3vCYPfPm5UrlAL9okGJ+p3M42xY5W0qSUsRD
	3XluwJG5UAIgqRsnC+cumceWK4Sw/U4+WIdT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JP/E6xJO3MNHLka/vvrj4kN7AouL+qiw
	CMFy1YY7p0TrfPhv8g2tKspNfkHDrtgHX1sIEaJ/V1ogv/EuzHIpKKoakt+VCHKO
	jM1Uu1zUDCKk77ME3hew/bhYDswbqP1P0Seqkj89x6elrr1fURHO9w4jS0oF8Ze4
	+0W0yj1gptE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C2485B14A;
	Tue, 22 Sep 2009 12:29:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28FFA5B149; Tue, 22 Sep 2009
 12:29:03 -0400 (EDT)
In-Reply-To: <Hfm4AdtlXpMutgmdj0vm7yb0ucfu_cijUloasBDWh6NfRCwLhP4OCA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 22 Sep 2009 09\:52\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D70FF9C-A795-11DE-A8B1-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128948>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> Possibly it is related to the version of MakeMaker?  I am using version
> 6.17 (Revision: 1.133) along with Perl 5.8.4 on Solaris 10 x86.  The
> MakeMaker version should be in the header at the top of the perl.mak
> file.

I think that is it.  DESTDIR support in MakeMaker seems to be lacking in
medieval versions of Perl.  It appears that it started being usable at
around its 6.11 (and 6.17 you have is fine).

    http://kobesearch.cpan.org/htdocs/ExtUtils-MakeMaker/Changes.html
    https://issues.apache.org/SpamAssassin/show_bug.cgi?id=6131#c7
