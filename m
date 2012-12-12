From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Hardcoded python and install on solaris
Date: Wed, 12 Dec 2012 15:08:21 -0800
Message-ID: <7v1ueu3m3e.fsf@alter.siamese.dyndns.org>
References: <1870c3d3587281b436cddb33cca1e822.squirrel@www.pkts.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "P Fudd" <pfudd@mailinator.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:08:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivPt-0002gK-G6
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2LLXIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:08:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149Ab2LLXIY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:08:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82D2DA364;
	Wed, 12 Dec 2012 18:08:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oik2Zjj/KG5TB3uYqBuKqWNgg0c=; b=hkitLx
	gziSoXPO+Pd+raZ7IKNHsv6PnAf1HM8I533xo5f9szMh9SKvDTvoMwvJy/BN5SJE
	WFB0lX6LE9TuB5SPGEhNLy/pPkezEzgl9XchMasPX3oEuh1xTeZzQmPnGrdcZeBM
	m3EG0OORfBK3RQT2+Xmeag5cj0s4phHau8SLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hy9bQw9h4+F7c8DKXAgxP9LRYNmVxt6l
	zcLHRqkJbZ3tTXeb0CFBMd3gMCFDcrAcp0cc6VpjlmIu9JQ2iX9/afx0rib+sd56
	zQd+19UPd/QWCgOJJo7TiP0HC7DSFrnYAhmBjktaaHmZLyytOviASuNylo7vJJKM
	VkxhKXWVpIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 704BCA363;
	Wed, 12 Dec 2012 18:08:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E39E7A362; Wed, 12 Dec 2012
 18:08:22 -0500 (EST)
In-Reply-To: <1870c3d3587281b436cddb33cca1e822.squirrel@www.pkts.ca> (P.
 Fudd's message of "Wed, 12 Dec 2012 14:34:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3978428-44B0-11E2-8EFF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211413>

"P Fudd" <pfudd@mailinator.com> writes:

> When compiling git-1.8.0.2 on a moderately old OpenIndiana machine, I had
> to install a few things (m4, autoconf, coreutils, xz, python).
>
> Even though I started the configuration fresh (make distclean; configure),
> the makefile still wanted to use /usr/bin/python (instead of
> /usr/local/bin/python) and /usr/usb/install (instead of
> /usr/local/bin/install).

You need to specify PYTHON_PATH on the build command line, something
like:

    $ make PYTHON_PATH=/usr/local/bin/python
    $ make PYTHON_PATH=/usr/local/bin/python install

We don't really rely on configure, and it sometimes is the case
where ./configure output does not know some knobs you can tweak in
the Makefile, but this one is not.

I think you can use --with-python=/usr/local/bin/python when running
the ./configure script.  ./configure --help may tell you more about
what you can tweak.
