From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4 v8] Git configuration directory
Date: Fri, 22 Jun 2012 14:19:21 -0700
Message-ID: <7vbokbnixy.fsf@alter.siamese.dyndns.org>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 23:19:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiBGL-0003R5-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 23:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab2FVVTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 17:19:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529Ab2FVVTY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 17:19:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EC2487D0;
	Fri, 22 Jun 2012 17:19:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=u6Vz//o2dgWst/KfgOo5uTdSH80=; b=C9Afgpv9eJw5lafMcjBV
	b5h+DIvq7bDe/Mt4MTT/9daaUMBJH1zL9lCZZiQTS075k4b63sUdUZtisrZDwy0u
	EsrihnKea/2sNuLOumvojtT684m+WiOefi2IOkx7n3/P4McQxemEWrNAgNcVTXLP
	hrN6vYtQAzwUXIon7/7IIcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=l/PFRfNE/POfIQ10k2+iSgTOop1GO7nOyj+vRBESeOoKWe
	AW9KPrs+S+t0g6+kgjVB8jLmo3OiOAK7GL3wDahKiDN1ptActwpsea+BrWtfmcDY
	fqUhrZvyMVZiu9TQdA5NKecMIPoEu4EhmPUDwE5YghT3AaqvuDdR8VynNdQQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 950ED87CF;
	Fri, 22 Jun 2012 17:19:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0841687CE; Fri, 22 Jun 2012
 17:19:23 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F01A7B20-BCAF-11E1-8895-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200470>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I took the liberty of rewording the commit messages, and change a few
> words in the documentation (changed some "will be used" to "is used
> instead", which sounded more consistant with the context).

Thanks; the series overall looks good.

I may have made further tweaks by the time I push the result
out.  Please watch 'pu' and holler if you find anything objectionable.



> A reminder of the context and objectives of the serie:
>
> Git currently stores its configuration file in ~/.gitconfig, which is
> nice and customary on Unix, as long as one has only one configuration
> file.
>
> But a typical user may want to store not only the config file, but
> also the files pointed to by core.excludesfile and
> core.attributesfile, which currently have no default values. To store
> several configuration files, it makes sense to have a configuration
> _directory_ instead of a set of configuration files, all right into
> $HOME. Calling this configuration directory ~/.git or ~/.gitconfig is
> not an option, since these paths already have another meaning. Using
> the XDG specification (in short: ~/.config/git) doesn't have this
> drawback, and allows the user to store his configuration files right
> next to files from other applications following the XDG standard.
>
> The first 3 patches add read support for this "configuration
> directory", and the last one gives opt-in write support, allowing
> users to make this "configuration directory" their way of life, and
> never hear again about ~/.gitconfig if (and only if) they do not want to.
>
> None of the patches change the behavior for people who do not create
> the new configuration files.
>
> Huynh Khoi Nguyen Nguyen (4):
>   config: read (but not write) from $XDG_CONFIG_HOME/git/config file
>   Let core.excludesfile default to $XDG_CONFIG_HOME/git/ignore
>   Let core.attributesfile default to $XDG_CONFIG_HOME/git/ignore
>   config: write to $XDG_CONFIG_HOME/git/config file if appropriate
>
>  Documentation/config.txt        |   8 +-
>  Documentation/git-config.txt    |  15 +++-
>  Documentation/gitattributes.txt |   2 +
>  Documentation/gitignore.txt     |   4 +-
>  attr.c                          |  17 +++--
>  builtin/config.c                |  25 ++++---
>  cache.h                         |   3 +
>  config.c                        |  23 +++---
>  dir.c                           |   7 +-
>  path.c                          |  41 +++++++++++
>  t/t1306-xdg-files.sh            | 158 ++++++++++++++++++++++++++++++++++++++++
>  11 files changed, 270 insertions(+), 33 deletions(-)
>  create mode 100755 t/t1306-xdg-files.sh
