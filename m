From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 25/25] gettextize: git-status shortstatus messages
Date: Thu, 2 Sep 2010 15:25:37 -0500
Message-ID: <20100902202537.GC2531@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-26-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:27:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGNs-0000nO-R7
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756963Ab0IBU1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:27:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35286 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab0IBU1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:27:32 -0400
Received: by fxm13 with SMTP id 13so603712fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1UuzwykmkSF2iZ5aNlbI1NXLzl2nwTuuPrt1mHoPsGQ=;
        b=s0tX02o+rMF2oVrFLggEnP2ChaKf97ChAkDmGPY8dMNlN5Dj/j5oAJH7L8AHkqRqqK
         uX+4PunzWDQFk9ni875N9W7gpQq6zsgJ/WkP5JfpNq9sD+nGqYbg8LlacihXHIrwVVJ0
         Z6PwZYcmILOYFwfwggGoXng3qhnxBBaSIlUvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uviKQs/3YaRmV0Io6PiUjUn1nkeAuimCQm76Owrc50GQQNwamflSlDnOx7foXsdh6i
         bUXWBp2NocbPKAJMzuqu8T4Y50geb84LNE8e07InNyRscsqkMLXYa0DEeZ64iMXAY+8y
         zt64MpKeMbWAp8DSv16w4xle7dvDX934dSPgA=
Received: by 10.223.118.15 with SMTP id t15mr517045faq.96.1283459251508;
        Thu, 02 Sep 2010 13:27:31 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r5sm466760faq.32.2010.09.02.13.27.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 13:27:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283456446-22577-26-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155194>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -814,15 +814,15 @@ static void wt_shortstatus_print_tracking(struc=
t wt_status *s)
[...]
>  	} else {
> -		color_fprintf(s->fp, header_color, "ahead ");
> +		color_fprintf(s->fp, header_color, _("ahead "));
>  		color_fprintf(s->fp, branch_color_local, "%d", num_ours);
> -		color_fprintf(s->fp, header_color, ", behind ");
> +		color_fprintf(s->fp, header_color, _(", behind "));
>  		color_fprintf(s->fp, branch_color_remote, "%d", num_theirs);

What we make those translators suffer through. :)  Would it be possible=
 to
(eventually) introduce an interface vaguely like

	color_fprintf2(s->fp, "%C(ahead )%C(%d)%C(, behind )%C( %d)",
				header_color,
				branch_color_local, num_ours,
				header_color,
				branch_color_remote, num_theirs);

?  I guess this would require using strbuf_expand instead of vsnprintf
for %d et al.
