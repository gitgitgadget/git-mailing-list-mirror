From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Explicitly set X to avoid potential build breakage
Date: Sun, 05 Feb 2012 14:14:27 -0800
Message-ID: <7v39apexmk.fsf@alter.siamese.dyndns.org>
References: <9854382.GTBzd7D6AT@telegraph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael <kensington@astralcloak.net>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:14:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuALz-0002by-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab2BEWOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:14:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60824 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654Ab2BEWOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:14:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D10FA62E6;
	Sun,  5 Feb 2012 17:14:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Qzkof7cqTeSyQsT6ttRBA+Hqxk=; b=XjkxQo
	naBiV7i2pdmjxW9+Wmkf3Bw3SToFwoVBrJuACOBAcRqAF9Q2djKaqHsPJAJI0Vc/
	F66FB279MxvVPIR8zLf0V9KXDDtJHJW3QMsI6rAdQ4//yTAUU8uzfHUE6JbQrILB
	GwWsidnqSkv/Ajt/f6VHAdsH6XbqXXW1cYwOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hJlRpkZ479I+uP+x77/ZF2ihvsip/eLO
	tzwMxB07m6Ec8AQ91CtRGREyoljl52n0hYqfMgjdN8eOI+xr2ZPtKfaN3qoJ8Mpu
	VI+dbldRlSGtoMWEn7ZnGTXFo4riw/PzFP3Zpl5ZKa3OpcHhCaGRtHCAUp8ZQbLR
	eqgPZ9XTL1c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79D962E5;
	Sun,  5 Feb 2012 17:14:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CCB462E4; Sun,  5 Feb 2012
 17:14:29 -0500 (EST)
In-Reply-To: <9854382.GTBzd7D6AT@telegraph> (Michael's message of "Sun, 05
 Feb 2012 21:41:11 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5C6E190-5046-11E1-91EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189975>

Michael <kensington@astralcloak.net> writes:

> $X is appended to binary names for Windows builds (ie. git.exe).
> Pollution from the environment can inadvertently trigger this behaviour,
> resulting in 'git' turning into 'gitwhatever' without warning.
>
> Signed-off-by: Michael <kensington@astralcloak.net>

Unless there is a compelling reason not to, could we have your name here,
not just half a name, please?  

It is not particularly a good reason to say "I go by 'Michael' among my
friends". The output from "git shortlog -s --author=Michael" shows more
than 20 Michaels already, and it would be nice for us if we can easily
differenciate you among this group of people you are now joining with this
patch.

> ---
>  Makefile |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c457c34..380d96f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -388,6 +388,9 @@ SCRIPT_SH =
>  SCRIPT_LIB =
>  TEST_PROGRAMS_NEED_X =
>  
> +# Binary suffix used for Windows builds
> +X =
> +

The patch looks good to me, although it might make sense to move it down
before this line

	PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))

where it matters most as the documentation of what $X is being used for.
