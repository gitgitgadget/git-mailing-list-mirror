From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
Date: Tue, 30 Apr 2013 10:00:02 -0700
Message-ID: <7v1u9seyy5.fsf@alter.siamese.dyndns.org>
References: <517C1BF9.2050604@ramsay1.demon.co.uk>
	<7vip36qxui.fsf@alter.siamese.dyndns.org>
	<517EF9D4.50105@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tboegi@web.de, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:00:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXDuW-00042E-EQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760825Ab3D3RAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:00:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759368Ab3D3RAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:00:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EF4D18534;
	Tue, 30 Apr 2013 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Zag1A+QKNO+jR/SvFlpo0wxZ5A=; b=lWLwlB
	IzCFbaizXeJqlYcLhwxNuLD6veMGmo/o0S6jVmji1KDOFPSS3rIS/ruWqxhz6EE7
	qQlMCcf2S/549ICxeu5EdRLuzHzBjq2+syE+ezFpf6xzJp+WFPlI3DNhEoYBadGf
	8S4Ct6OHILcqYgkQ+Fn4IwrgE4X+/LAMpL1/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UY4Xr3D7gs7CfGlgepUVCClQ2Rcf12EA
	Ha7MMyvbBRlG1cSWiEdchhfrsjkyl01TZO5nwC+t0IkTBHc7/c4E5o+QxE7CwVqO
	CAB62XTd+YHFnEQFvnKHubmI0jR05seupZMlvk8yY4Us8U3FtMLmU6JhHjOhvedH
	spIcHJ609kQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75A4518533;
	Tue, 30 Apr 2013 17:00:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E57841852F;
	Tue, 30 Apr 2013 17:00:03 +0000 (UTC)
In-Reply-To: <517EF9D4.50105@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 29 Apr 2013 23:53:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66FC2E1C-B1B7-11E2-B2B9-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222949>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> However, I'm always a little wary when I hear someone say "this may be
> useful to others in the future, so lets do X to make it easier ...".
> I have noticed that, much more often than not, that future user never
> does materialise ... ;-)

I do not think you are reading the reason for the function
correctly.  It is not "We may find it useful elsewhere".

It is "We knew Windows benefits from having a 'quick, incorrect, but
the incorrectness happens not matter to the caller' hack, and we
used to use it everywhere.  But we identified one location we need
to disable the hack for correctness, hence this 'slow-but-correct'
function.  There may still be other places that needs fixing by
calling it".
