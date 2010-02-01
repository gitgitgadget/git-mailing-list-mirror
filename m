From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] resolve-undo.c: silence compiler complaints by casting
 void * to char *
Date: Mon, 01 Feb 2010 15:44:49 -0800
Message-ID: <7vsk9kplla.fsf@alter.siamese.dyndns.org>
References: <qzbyPiTgRGI0lsxvEmFa0WtwK5ko5snXQDNffxC66y9v0rlie5pcKzGT28WpzfQlFd0OvJNY_jo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 02 00:45:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc5xf-0005Gu-9I
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 00:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab0BAXph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 18:45:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab0BAXph (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 18:45:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A479C96158;
	Mon,  1 Feb 2010 18:45:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PZPfbTk1UwO5OQVBWXWjGZ6GOF4=; b=JdBbU7
	1t0M7+ijwI0sjbs63mmHyd/HyPWp7KKEO0Hcm1DV9F2AwnfIrf5C7Y+2rhxEV8el
	zO5bVvfZJ1hIv7hBz6q83HmhQoJaEgPrTT++wW3SoA/WetJhZTnLx1Ef42Z2iRto
	K3MCyGOXP6PNHVyeYpSkZnfGYc/STDmLOpAqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vpCObPa+1/MkrCjnvZL5Bf7IdhkePBwp
	rROHfZyik+uf7f3Q9z/+5rJGFXXBhCghIURzeo9M5IvXvw+GUpCnku3iemp2re4/
	xVU0fdIWSbHVYHF62FiuYFvEK8mFHDENvzsY54E6bKxKpnV3Wy8ipm6fzKaqMw/X
	CC8m3src4FQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C990A96153;
	Mon,  1 Feb 2010 18:45:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4433C9614E; Mon,  1 Feb
 2010 18:45:27 -0500 (EST)
In-Reply-To: <qzbyPiTgRGI0lsxvEmFa0WtwK5ko5snXQDNffxC66y9v0rlie5pcKzGT28WpzfQlFd0OvJNY_jo@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\,  1 Feb 2010 17\:00\:00 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E302FD00-0F8B-11DF-8955-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138659>

Thanks for catching this.

In this particular case, I however suspect that it would be cleaner to
declare that the first parameter to resolve_undo_read() is a "char *"
(or even "const char *"), as we are dealing with NUL delimited list of
octal numbers and character strings.
