From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] send-email: make annotate configurable
Date: Sat, 06 Apr 2013 20:32:17 -0700
Message-ID: <7vr4in818e.fsf@alter.siamese.dyndns.org>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
 <1365239012-15079-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 05:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOgLB-000604-Ib
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 05:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161575Ab3DGDcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 23:32:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161375Ab3DGDcU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 23:32:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B46CFF065;
	Sun,  7 Apr 2013 03:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=2YYZY9NsjH7D5SQ5ahn7w/HJJs8=; b=deWM06mwc5lpE4KgnTxz
	6hUA/xE7mteAxJdSf8ONkMybFF7CUilaUlJkDP/11Y6238VvJ3FvJsWczRygN2sY
	svE7P/8W2Asp401NUqwRF9Yi9LON0rTmt4XLdnbFSt5dlmKyj3+vvpT/1j6ImSrc
	m9Yns5HO/rZSo7b5H3N2CWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=yMBqP7ezkBifvTjl5Q8oyr/PZcpkTTSKmx/7Hiiwic/PYK
	HfcHF6iOruavpCbjZ7Lap+OCeRndVv29HJVh4KZ9cGEBwi/c8EFfALnw8CIUEEMb
	WsBFzX4kuYG4wLwNJXsgYcJpyVkFd9B7XbHSb8kIu5EzehX//YwhQopoHCr6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABEF9F064;
	Sun,  7 Apr 2013 03:32:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26F7AF061; Sun,  7 Apr 2013
 03:32:19 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C039B5F8-9F33-11E2-B0D0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220276>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> @@ -305,6 +306,7 @@ my $rc = GetOptions("h" => \$help,
>  		    "smtp-domain:s" => \$smtp_domain,
>  		    "identity=s" => \$identity,
>  		    "annotate" => \$annotate,
> +		    "no-annotate" => \$no_annotate,

Wouldn't it be much better to let GetOptions know that --no-annotate
is allowed by saying

	"annotate!" => \$annotate

which also let us lose an extra $no_annotate variable?
