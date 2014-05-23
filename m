From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Get rid of the non portable shell export VAR=VALUE
 costruct
Date: Fri, 23 May 2014 11:48:59 -0700
Message-ID: <20140523184858.GF12314@google.com>
References: <1400840131-966-1-git-send-email-gitter.spiros@gmail.com>
 <xmqqmwe8jr44.fsf@gitster.dls.corp.google.com>
 <xmqqegzkjq5e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	tboegi@web.de, dak@gnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 20:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnuWh-0000AU-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 20:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbaEWStD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 14:49:03 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53936 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbaEWStB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 14:49:01 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so4566328pbc.28
        for <git@vger.kernel.org>; Fri, 23 May 2014 11:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B1tR9hJaEcFlKJh15CRMFTp6w7+GS7oKiCakrVhKfh8=;
        b=QHM5Wqdhu5uDLJIWGlTt0hkqyjf+8BkjoyNoDn0dmVwFQ6S2jLb2ZkkHdX4V4GIFCf
         SD6edDIOqWHCocpffRiG3+uvUD6wtmL3R33gTcL0oVAYnUnKchSKA0xJSnn5Rd6oUqLy
         TL9Kw1kprO1dKbnKZ17giCh3ury/ZfXF3t/T1bAwSp1q3CM+HxMyUv8IkoomuflRcDC1
         kTwkYQwXOF4MKm34jSaVUbfFgOZP8kwcghMQhbk7IOC17apCdyOVt1b3+aHTrOrvk+Rz
         miFUCIyZMyh34B0X1LW+jTZDlvJ061lMSvWF6sITUERv9/ZtrUoDYFiCoAXMYUoUE9a1
         uZ9w==
X-Received: by 10.66.119.239 with SMTP id kx15mr8395649pab.51.1400870941543;
        Fri, 23 May 2014 11:49:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id au4sm5817245pbc.10.2014.05.23.11.49.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 11:49:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqegzkjq5e.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250013>

Hi,

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> Makes me wonder why these two were missed, though.
>
> Perhaps something like this?
[...]
> -	/^\s*export\s+[^=]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
> +	/(?:^|[^-a-zA-Z0-9_])export\s+[^=]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';

Messages crossed.

I think I like "\b" better for this, while I also share your lack of
enthusiasm for parsing shell with something that is not a shell.

Maybe it's worth filing bugs against "posh -n" to make it
(optionally?) notice things we want to detect with a goal of
eventually moving to that.

Thanks,
Jonathan
