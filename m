From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Hooks
Date: Wed, 16 Sep 2009 16:31:31 -0700
Message-ID: <7vzl8uv54c.fsf@alter.siamese.dyndns.org>
References: <25482688.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: daicoden <daicoden@copypastel.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3yS-0001Wo-3V
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 01:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760490AbZIPXbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 19:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760425AbZIPXbe
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 19:31:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327AbZIPXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 19:31:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 793B535CAD;
	Wed, 16 Sep 2009 19:31:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4aPFApw7GEU2wxG9a4/k4ZuWqG8=; b=NCSTkQ
	9b8RdNBANJ6MktZgKIJOZgYJwIPVWMlIpLhUa+/H2sofukOMlhnC4t6RNe/GMe3N
	5zDNeLuPw2uRa3iER7/S+yia6PGx2un3I5zVdDGH53URC1Uoy+mZ/vOdcJRfkT/Z
	5KX8Ir5Mt/pfuon4ENYQzWh5sNbqMy7z6+IfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lappe/dgJmCpUzr7N3UTOz8ULTxssJP1
	xjJrcLbRNzXKvgZDvLiLEKydrMcCSFxTnEXybc4nSmQScL1bw0MCTMrvbT6tc5rb
	p4o4xavtYHW9WM+vrRlKp2HXubKHMaLS1nztQ+HxVFZQ9LfBLU56ZhUkl8RNvowV
	Q6NYvs70Pb8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CBA235CA9;
	Wed, 16 Sep 2009 19:31:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D2935CA6; Wed, 16 Sep
 2009 19:31:32 -0400 (EDT)
In-Reply-To: <25482688.post@talk.nabble.com> (daicoden@copypastel.com's
 message of "Wed\, 16 Sep 2009 16\:24\:11 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 12DAFFF8-A319-11DE-A8F1-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128697>

daicoden <daicoden@copypastel.com> writes:

> cd /var/www/blog
> thin -s 2 -C config.yml -R config.ru stop
> cd .git
> git pull origin master
> cd ..
> thin -s 2 -C config.yml -R config.ru start 

Unless you have a strange configuration in which you have work tree files
inside a .git directory of another repository, running "git pull" after
going into .git directory does not make any sense.

Perhaps add this

	unset GIT_DIR

at the very beginning of your original script would make it work better?
