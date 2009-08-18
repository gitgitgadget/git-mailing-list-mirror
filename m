From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 09:51:18 -0700
Message-ID: <7vtz05dq0p.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
 <1250600335-8642-1-git-send-email-mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,
	kusmabite@googlemail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRuL-0001X8-8G
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397AbZHRQv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759390AbZHRQv3
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:51:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759388AbZHRQv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:51:28 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A9D9FDF5;
	Tue, 18 Aug 2009 12:51:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23998FDF1; Tue, 18 Aug
 2009 12:51:20 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60B3F158-8C17-11DE-8FFB-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126417>

Marius Storm-Olsen <mstormo@gmail.com> writes:

Marius Storm-Olsen <mstormo@gmail.com> writes:

> +ARFLAGS = rcs\ # whitespace intentional
> +COMPFLAG = -c
> +COBJFLAG = -o\ # whitespace intended
> +LOBJFLAG = -o\ # whitespace intended
> ...
> +ifneq (,$(findstring Microsoft Visual Studio, $(INCLUDE)))
> +	CC = cl 
> +	COBJFLAG = -Fo
> +	LOBJFLAG = -OUT:
> +	CFLAGS =
>  git.o: git.c common-cmds.h GIT-CFLAGS
> ...
> -		$(ALL_CFLAGS) -c $(filter %.c,$^)
> +		$(ALL_CFLAGS) $(COMPFLAG) $(COBJFLAG)git.o $(filter %.c,$^)

Since use of make implies use of shell, this makes me wonder if it would
make sense to go one step further by giving msvc users a thin shell
wrapper mcvc-cc that turns bog-standard cc command line into whatever cl
uses.
