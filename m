From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] add a Makefile switch to avoid gettext translation
 in shell scripts
Date: Mon, 23 Jan 2012 16:40:16 -0600
Message-ID: <20120123224016.GH20833@burratino>
References: <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz>
 <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org>
 <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
 <20120123221256.GG20833@burratino>
 <7vehuq6ote.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpSYx-0000oE-Qq
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab2AWWk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:40:27 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50494 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab2AWWk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:40:26 -0500
Received: by ggnb1 with SMTP id b1so1667442ggn.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PaCnchA/L2zwA2fQ1vUAtOND8VybqUZaGZoyRd26BRw=;
        b=oEGm0aC/sqNT2KWLBdXs+KSH9zVaWh5FZ4dBVGrnZOwsIpGzk3NEkMHjXNbHazM0zO
         klsUWo2rSikfvlzVIY4jOCs2DCETvVna/5olmdRVfhQLfpHxm2lAdiODNNTb9AhVM+PD
         63JuABEQ6kGDKIp91IypPlzFSxRKH3bNeRImw=
Received: by 10.101.159.4 with SMTP id l4mr4386730ano.62.1327358426209;
        Mon, 23 Jan 2012 14:40:26 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z3sm23712254yhd.3.2012.01.23.14.40.24
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jan 2012 14:40:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vehuq6ote.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189023>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Nice implementation.  I still don't understand why NO_GETTEXT=YesPlease
>> should not imply this.
>
> Should be easy to do so, like this?
>
> diff --git a/Makefile b/Makefile
> index a782409..c4c1066 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1521,6 +1521,7 @@ ifdef GETTEXT_POISON
>  endif
>  ifdef NO_GETTEXT
>  	BASIC_CFLAGS += -DNO_GETTEXT
> +	USE_GETTEXT_SCHEME = fallthrough
>  endif

Yep, that would make my worries about intuitive behavior evaporate. :)
(Maybe "USE_GETTEXT_SCHEME ?= fallthrough" to make it easier to
override in config.mak.)

Thanks.  I also would not actually mind the behavior without that
tweak, as long as it's explained somewhere.

Ciao,
Jonathan
