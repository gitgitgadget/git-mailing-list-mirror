From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] checkout: apply Dscho's dwim even with "--" present
Date: Fri, 29 Oct 2010 19:41:44 -0500
Message-ID: <20101030004144.GA25927@burratino>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
 <20101029194639.GA1738@burratino>
 <7vsjzo691r.fsf@alter.siamese.dyndns.org>
 <20101029235358.GA21410@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 02:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBzWB-0000Wb-Qg
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 02:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762201Ab0J3Alz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 20:41:55 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62581 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758843Ab0J3Aly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 20:41:54 -0400
Received: by vws13 with SMTP id 13so541126vws.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 17:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JS2PMv71VpbvtC1C/H8LMxxgeOjgnVm59uDPJva5VIY=;
        b=L1VfG3fGg1S7c4Ux/PlCCVdohhvp/tayN2GJHg5Bg73UxXaOlYUBdl4H1qXevfjIGh
         LteM3mJv6Qa3inyF9lPIwQAtyE39yXFnOu5bEQ92ypT9URXNPC5CZUgvbat4HHpUXAR8
         8DHFCrg+DhG9WcNPTEYIjpvPeEvPUJCTRoxoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K1Ghf/UaukEVqv7tqPFXvccsKI62b90sfucRWZqayjLj1bxP3SsAtdR7pEDibYeSma
         oMAN7GKEIjYC+V97XgAzqrZfldaDvp34cbNSE+d0kF/0LbOSOMYM/ArEqiOffo3KppU8
         XSwMZ8vVH1OSsgNuxgUM/ibw6iNQeP0SvOgxU=
Received: by 10.224.180.76 with SMTP id bt12mr5723529qab.252.1288399313217;
        Fri, 29 Oct 2010 17:41:53 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m7sm2909036qck.25.2010.10.29.17.41.49
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 17:41:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101029235358.GA21410@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160370>

Jonathan Nieder wrote:

> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -808,23 +814,24 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>  			arg = "@{-1}";
>  
>  		if (get_sha1_mb(arg, rev)) {
> +			trace_printf("trace: guess = %d\n", dwim_new_local_branch);

Gah!  This line does not belong, sorry (though presumably it wouldn't interfere
with testing).
