From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] gitweb: Mark boundary commits in 'blame' view
Date: Fri, 24 Jul 2009 17:13:14 -0700
Message-ID: <7vocr94o2t.fsf@alter.siamese.dyndns.org>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
 <1248475450-5668-3-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 02:13:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUUtQ-0000SB-FC
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 02:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbZGYANd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 20:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbZGYANd
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 20:13:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbZGYANd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 20:13:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F076310A61;
	Fri, 24 Jul 2009 20:13:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6169810A5D; Fri, 24 Jul 2009
 20:13:22 -0400 (EDT)
In-Reply-To: <1248475450-5668-3-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Sat\, 25 Jul 2009 00\:44\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC8EA792-78AF-11DE-8A99-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123983>

Jakub Narebski <jnareb@gmail.com> writes:

> Use "boundary" class to mark boundary commits, which currently results
> in using bold weight font for SHA-1 of a commit (to be more exact for
> all text in the first cell in row, that contains SHA-1 of a commit).
> ...
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 70b7c2f..f47709b 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -242,6 +242,10 @@ tr.dark:hover {
>  	background-color: #edece6;
>  }
>  
> +tr.boundary td.sha1 {
> +	font-weight: bold;
> +}
> +

"boundary" means that "blame low..hight file" attributed the line to the
"low" commit, not because the commit introduced the line, but because the
user said not to bother digging further.

I had an assumption that in such a bounded blame, lines attributed to the
boundary commit are not very interesting (they belong to a distant stable
past that the user does not care much about, as opposed to more recent
breakages), and that is exactly the same reasoning behind the -b option of
"git blame" command.

I would have expected the boundary to be shown in weaker decoration
(e.g. gray letters as opposed to black), not in stronger annotation.

Perhaps you are talking about something different?  I am a bit puzzled.
