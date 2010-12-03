From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 6/7] web--browse: use (x-)www-browser if available
Date: Fri, 03 Dec 2010 14:15:08 -0800
Message-ID: <7vaakmmrkj.fsf@alter.siamese.dyndns.org>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:15:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdue-0008Ug-CE
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766Ab0LCWP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 17:15:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab0LCWPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 17:15:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F4033E52;
	Fri,  3 Dec 2010 17:15:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h5lOAKh37LjPToU5EO/iK5fYQW8=; b=lrcoCf
	vU9/kQFx6yH7mK5ZYkVaqPWpHzI2Nw94hfV06Bt4+A39Ue0GgZJoapG3E7cw4C+E
	DAsazrSqpMQ+Etp5AiEhucQRATfI1nCbY1WxloR+/NZLMaxgVACY0RmmavJugpeT
	aZIKmU+ebLV2uHW3BVm0othAps7C2GwSQTYc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cj5nyilhzjgoqjwZz/+6Hzj7ozwDvsKj
	LVgPeimUvDmgTn52zoJIdLe0AFYFQheoMjdSh/lzWNUzPmjRloV03MDolTkRS0M9
	RW2PrbxkA3rQCDcXLk4A/8LNedaqqdfzso1ZLJIt/Zj+6ng+hYQY7XYvoRp/X8QZ
	Htg5eKxyqeU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19F233E51;
	Fri,  3 Dec 2010 17:15:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 582AA3E4C; Fri,  3 Dec 2010
 17:15:30 -0500 (EST)
In-Reply-To: <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Fri\,  3 Dec 2010 17\:47\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC171F28-FF2A-11DF-B11C-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162867>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> Debian and derivatives have an alternatives-based default browser
> configuration that uses the /usr/bin/gnome-www-browser,
> /usr/bin/x-www-browser and /usr/bin/www-browser symlinks.
>
> When no browser is selected by the user and the Debian alternatives are
> available, try to see if they are one of our recognized selection and
> in the affermative case use it. Otherwise, warn the user about them
> being unsupported and move on with the previous detection logic.

A "please step back a bit" question.  Does the packaging guideline of
Debian say that non-browser applications should take these links as "end
user preference" when opening HTML pages?

The behaviour of unconfigured git across platforms would become less
consistent if we do this, while the behaviour of random programs on one
particular platform (Debian) would become more consistent.

I am not saying that is necessarily a bad thing.  I just want to
understand the motivation.

> +# check if a given executable is a browser we like
> +valid_exe() {

Call it valid_browser_executable or something, please.

> +	testexe="$1"
> +	basename=$(basename $(readlink -f "$testexe"))

Are we saying "readlink" must exist on the system?  This dependency is
new, I think.
