From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] gitweb: Added syntax highlight support for golang
Date: Sat, 8 Feb 2014 04:40:59 +0530
Message-ID: <CAK9CXBWiaORDJaTam=X02UiBCsF2m_kW33_DqbQSLfoY1JphiQ@mail.gmail.com>
References: <1391807441-23049-1-git-send-email-pavan.sss1991@gmail.com>
 <xmqqiosqtwqk.fsf@gitster.dls.corp.google.com> <CAK9CXBXXge+ZGN_ocWMH5jkPJcTg74rhtWsDiOuqAeeGXDW_tg@mail.gmail.com>
 <CAK9CXBUewMhr19KarmymOXmoq1ijPuU2mq4hqc6a-W0TCq5SRg@mail.gmail.com> <xmqqa9e2ttln.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 08 00:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBuZw-0001KR-VH
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 00:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbaBGXLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 18:11:21 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:58759 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaBGXLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 18:11:20 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so6220260qaq.25
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 15:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yxU220KhEQAQawx669J7h2PAtTiUrWo3GnuixbvU1qU=;
        b=V2hTnDotxYlOKNPq8bMMD6k8x9A8WLKXA2yUBBO0dj2C8NsG2IeQB2whd6x8g3Rifn
         gSV2eapOd1kx6pe425taYxqLaeoBa4R+C+1bgUY/U4YIUc0cQVTkQ9BqIPH9fs/UoMz6
         E0d26bLO/6RasAdzZ8zwCSqCMhLdPAVOLhbX3mXQkU5mpxx7/EPFhWdqL+A4VP0jkauy
         W8r6z6pOm2dkeBzK/qlThiQrOgIuHMVVEIbhitXVy4Mb+VmO93cn/7B4jpqNwSRsmdkf
         CXFwYpTNIVISF9Gs82fsW+T8qpgONlUWuZ/jqEYjPwYbjD9P7JY3HSxN73V367L6zWZw
         CdBg==
X-Received: by 10.229.179.5 with SMTP id bo5mr9682785qcb.21.1391814679719;
 Fri, 07 Feb 2014 15:11:19 -0800 (PST)
Received: by 10.224.121.211 with HTTP; Fri, 7 Feb 2014 15:10:59 -0800 (PST)
In-Reply-To: <xmqqa9e2ttln.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241812>

Yeah. I agree with you.

I am currently looking into allowing users to customize the parameters
given to their highlighter. I will try to look into this.

Thanks

On Sat, Feb 8, 2014 at 4:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pavan Kumar Sunkara <pavan.sss1991@gmail.com> writes:
>
>> Sorry. I misunderstood your message. Yes, I guess lazy loading the
>> supported file extensions would be better. But not all highlighters
>> support `-p` option. So, I think its better to leave it to the user.
>
> Yes, those highlighters that do not support `-p` may have to rely on
> the hard-coded list %highlight_ext.
>
> But with the same line of reasoning, not all versions of highligher
> supports 'go' language, so it's better to leave that to the user,
> no?  The version of 'highlight' you may have may know about 'go',
> and somebody else's 'highlight' may not yet.  A hard-coded list that
> appears in %highlight_ext will be correct for only one of you while
> the other between you two needs to customize it to his system.
>
> Note that I was not talking about removing the configurability.
> Even with lazy loading and/or auto-genearting at build-install time
> when 'highlight -p' is available, the users still want to be able to
> customize, and supporting that is fine.
>
> But for those whose 'highlight' does support '-p', it will help to
> lazily discover the list of supported languages and/or enumarate
> them at build-install time.  They do not have to keep adding new
> language (or removing it from the list we give as the upstream) to
> adjust it to their system.
>
> In any case, the comment was not about this patch from you, but
> about the future direction for the code it touches in general.  In
> other words, it did not mean "because it does not update the
> mechanism to lazily discover the list of languages, and instead
> added yet another language to the existing one, it is not an
> acceptable solution to start supporting 'go'".



-- 
- Pavan Kumar Sunkara
