From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in
 incremental blame
Date: Wed, 25 Nov 2009 13:39:23 -0800
Message-ID: <7vd436s2r8.fsf@alter.siamese.dyndns.org>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
 <4B0CAC2E.1060105@gmail.com> <200911251536.08993.jnareb@gmail.com>
 <200911252155.59318.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 22:40:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDPbF-0003R4-27
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 22:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934922AbZKYVjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 16:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934918AbZKYVja
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 16:39:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934901AbZKYVj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 16:39:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15908A1BB8;
	Wed, 25 Nov 2009 16:39:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=57cXPdEw8LHy98sU39mvaPXw/xU=; b=iFufUG
	40FMJ7kGPav1ABiLs/PtjsupeuNyseTw7trKxIBfztw0DNxM7bOPYU207ucDDBjo
	2YJ49sv1yLgfAIu6FLbvyDvJeSkvW1vLeSbcuc8x9DZw/V7Iut/1FNjZ+osTNjSP
	htNZ93A4ZoOjsovZSF6McutP5ZSwNCRIV58Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OOS3rvk1fnwT+pbW2KrVzrPoTloNt3mU
	kZiMg+3HOB1dYaEpOZasFtJ8cQBrpT0TwNa11JTmf6dEke3i/tNb4+Ol3gInONDv
	tcCWRPh+aofxn0ObitLZOlQoWKXuwJV2EnY8vrnIDJQO5Y1i7d9bPfFeDKmxOfZu
	zCDlCX6vMp0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA2D0A1BB4;
	Wed, 25 Nov 2009 16:39:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D5E6A1BB3; Wed, 25 Nov 2009
 16:39:25 -0500 (EST)
In-Reply-To: <200911252155.59318.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 25 Nov 2009 21\:55\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 030F0118-DA0B-11DE-B85A-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133678>

Jakub Narebski <jnareb@gmail.com> writes:

> It was 'Unspecified error.' shown in xhr watch.  Accessing xhr.status
> causes an error.

As to the topic, it does not seem to break _existing_ features; if that is
not the case, please let me know.

Otherwise I'm inclined to merge the entire series to 'master' by 1.6.6-rc1.

    6821dee gitweb.js: fix padLeftStr() and its usage
    6aa2de5 gitweb.js: Harden setting blamed commit info in incremental blame
    e42a05f gitweb.js: fix null object exception in initials calculation
    63267de gitweb: Minify gitweb.js if JSMIN is defined
    c4ccf61 gitweb: Create links leading to 'blame_incremental' using JavaScript
    e206d62 gitweb: Colorize 'blame_incremental' view during processing
    4af819d gitweb: Incremental blame (using JavaScript)
    aa7dd05 gitweb: Add optional "time to generate page" info in footer
    -aef3768 gitweb: Use light/dark for class names also in 'blame' view

and treat it as a new feature with known breakages, to give it wider
audience.  That way you will hopefully get more people who are willing to
help debug/fix things for you.
