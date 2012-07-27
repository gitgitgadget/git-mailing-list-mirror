From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Fri, 27 Jul 2012 14:38:06 -0700
Message-ID: <7vwr1ozxz5.fsf@alter.siamese.dyndns.org>
References: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 23:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SusEi-0007PB-2j
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 23:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab2G0ViK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 17:38:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab2G0ViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 17:38:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C549A10;
	Fri, 27 Jul 2012 17:38:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wl0thnsynYSH2RxESigGLTAyyAM=; b=vg14v8
	LGXseGbLAAJYmaP5nS2wia+AGBtX+DnbXGftymcbpuibkr82O8dV4Vd4AIqz46X0
	3f5R5iDu+GSudEu0FWofj4OV5YfI9pa2XSjDCsI/gPlXislj9FnA+x/lo2p26d6v
	c/mG7UH715zhtMomx/vN+tuglyjnh1/XFDmno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GJB3+E2uQPTu3vCJGwKnocx7dBeVfuMl
	KKz7p8PPH9jwpmqict1MPjoLQeANVThRAatM82gUCCqKbScV7yMx/lGAe+VB9wu3
	ThxQ5dfMO5XfHlWw1uh77VYdK7qEs/mRSrymYsaZyfyZR2Ut9OmMr0pRklM5ap9Y
	qSSOGhtILuA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E23079A0E;
	Fri, 27 Jul 2012 17:38:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 642729A0A; Fri, 27 Jul 2012
 17:38:08 -0400 (EDT)
In-Reply-To: <20120727185925.793121C0FDC@stefro.sfo.corp.google.com> (Stefan
 Zager's message of "Fri, 27 Jul 2012 11:37:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B47BD06-D833-11E1-A469-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202378>

Stefan Zager <szager@google.com> writes:

> +		module_list "$@" | awk '{print $4}' | xargs -L 1 -P "$jobs" git submodule update $orig_args

Capital-P option to xargs is not even in POSIX, no?
