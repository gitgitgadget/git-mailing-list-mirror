From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4 v8] Let core.attributesfile default to
 $XDG_CONFIG_HOME/git/ignore
Date: Fri, 22 Jun 2012 14:20:19 -0700
Message-ID: <7v4nq3niwc.fsf@alter.siamese.dyndns.org>
References: <7vfw9oshpz.fsf@alter.siamese.dyndns.org>
 <1340355806-6894-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340355806-6894-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr,
	Valentin.Duperray@ensimag.imag.fr, Franck.Jonas@ensimag.imag.fr,
	Lucien.Kong@ensimag.imag.fr, Thomas.Nguy@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 23:20:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiBHG-0004g7-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 23:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab2FVVUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 17:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529Ab2FVVUW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 17:20:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 100EE8802;
	Fri, 22 Jun 2012 17:20:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=iKVHMHCqcyCW3eTsgmZy2BlvmD0=; b=c2BrOXsdnaA3g/XiQWdI
	e+vlQKgNZy3WOSXu3hbwBPE86AjRCAmOv+3rhoUPTubi+6Q8tyfxo7MudrbECCfI
	dBd1S6EoK320Dkd5DSBXSe+WLVB+7CEx7+jSLnjLv36Wjsa1glrGd196k/DAqn7c
	rPw4RZ1tjF6XjJvrKalUdBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MxrcC5O1FL9xw5+Jh5gN009YeJqR2Gzeo25OftwWcFMdLD
	kqhyJVNjPUXtTMCpYAURHqw+wca9QXioOzOEr5UWSlvWq0IHSxPCMV40ukcVrUxT
	Wf/VqfpjxF/8F1DisfyOr5lWRelYf66Beh52weRTTLh1UFoLyAWfoPdoIJWb4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F0D87FF;
	Fri, 22 Jun 2012 17:20:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46FD087F9; Fri, 22 Jun 2012
 17:20:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12C9BECE-BCB0-11E1-AF96-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200471>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> From: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
>
> To use the feature of core.attributesfile, the user needs:
>
>  1. to create such a file,
>
>  2. and add configuration variable to point at it.
>
> Instead, we can make this a one-step process by choosing a default value
> which points to a filename in the user's $HOME, that is unlikely to
> already exist on the system, and only use the presence of the file as a
> cue that the user wants to use that feature.
>
> We use "${XDG_CONFIG_HOME:-$HOME/.config/git}/ignore" as a default value.
> It goes in the same directory as the newly added configuration
> file ("${XDG_CONFIG_HOME:-$HOME/.config/git}/config), and follows the XDG
> specification.

The patch text may be OK but look at the Subject: line and notice
something funny ;-)

Given the root cause of that "something funny", I'll reduce the log
message of this one down to:

    Let core.attributesfile default to $XDG_CONFIG_HOME/git/attributes
    
    This gives the default value for the core.attributesfile variable
    following the exact same logic of the previous change for the
    core.excludesfile setting.
    
    Signed-off-by: Huynh Khoi Nguyen Nguyen <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
    ...
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

I am not sure about use of git/ignore in [2/2], though.

Shouldn't the default value for core.excludesfile be git/exclude,
not git/ignore?
