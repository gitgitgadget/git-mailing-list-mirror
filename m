From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Fri, 31 Aug 2012 13:01:41 -0700
Message-ID: <7vk3wen84a.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 22:02:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7XPo-0006kA-J4
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 22:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab2HaUB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 16:01:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755009Ab2HaUBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 16:01:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36E1C9BA6;
	Fri, 31 Aug 2012 16:01:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n3LCjm8ZT1yLvXtKbdb4qAUCLpA=; b=MDIQLu
	+E6OL3OSFiPu+7NJzkvlLDocI5kb5tu1FF/6BVU8AMFbNhMfqcXcMt0FnOMMJ4e9
	qFM8n7qRdgt8/pOJrgPHRr1bmfeK7lH+mAMhcLDhxFUbl+sFoGepyl5Xwpbvb3mS
	zKCcTtAuSfLc75/VOx6HAuONcXUTLFakLByA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tK5d9H23GXf2NtEY2UgkT2RflXEIfl1c
	dbrbM/8Gr0tsBCWU0AaDQL38IgLhpf5pwtfffUEjoE4d3pBojOBNAn5m3QTs3Av0
	m9WHTBel987w1N2JdqhVANvkHl0/F9uLf8x+m4O+YENcLawfiATFatFyX3OndzIL
	DqRzwQSZNgc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24D479BA5;
	Fri, 31 Aug 2012 16:01:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96E1A9BA4; Fri, 31 Aug 2012
 16:01:44 -0400 (EDT)
In-Reply-To: <5040C59A.6090303@gmail.com> (Marco Stornelli's message of "Fri,
 31 Aug 2012 16:09:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0544592-F3A6-11E1-970F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204607>

Marco Stornelli <marco.stornelli@gmail.com> writes:

> +PATCHTMP="${PATCH}.tmp"
> +
> +echo $MAILHEADER > $PATCHTMP
> +
> +export PATCHTMP
> +CCS=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
> +close FILE; $addr = $1 if $text =~ /Cc: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
> +print $addr;'`
> +
> +TO=`perl -e 'local $/=undef; open FILE, $ENV{'PATCHTMP'}; $text=<FILE>;
> +close FILE; $addr = $1 if $text =~ /To: (.*?(,\n .*?)*)\n/s; $addr =~ s/\n//g;
> +print $addr;'`
>  
> -CCS=`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp' \
> -	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
> +rm -rf $PATCHTMP

One thing I forgot to say.  Make sure you quote your variables (when
in doubt, quote).  Also make it a habit not to say "rm -r" when you
know you are removing a regular file you created.  I.e.

	rm -f "$PATCHTMP"
