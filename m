From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 16/21] Introduce optional "keywords" on tag objects
Date: Sat, 9 Jun 2007 23:52:29 +0200
Message-ID: <81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	 <200706090210.36270.johan@herland.net>
	 <200706090219.37289.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8rJ-0002ai-Ni
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbXFIVwb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756072AbXFIVwb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:52:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:17817 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606AbXFIVwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:52:30 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1204777ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 14:52:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XTAw2qIvfzSiWfRxTkFrtcSAccKdmkrSc16HoxxI00UnEjeDojK/UD0TWlpqR1sqpls4wbQv/BbJwDThum1npl+1YHE1oVVmPmKfv417HbtduT9T9z1YIGOzgbXEyAcsnMYUgKCUst1GBIpxtqNuY2xOYAPjKJxPoadsAxPGsmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j/xgbtxS0qCa8fwT5NghJXsf3KZw2lIaTO86aWqdSDXLqoz2fWQsfisVR1DmD21KCL1dwMjWeFFOTCG0GMWG1eREJbMS5sQV696/pX4XmK1Xr+ET6v5az2yZn8Av7TWC2R+qWManUoaE76smzUVJ5EKMKJ4QwAAgT2hchb9GG4M=
Received: by 10.78.176.20 with SMTP id y20mr1681242hue.1181425949236;
        Sat, 09 Jun 2007 14:52:29 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Sat, 9 Jun 2007 14:52:29 -0700 (PDT)
In-Reply-To: <200706090219.37289.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49630>

On 6/9/07, Johan Herland <johan@herland.net> wrote:
> This patch introduces a new optional header line to the tag object, called
> "keywords". The "keywords" line may contain a comma-separated list of
> custom keywords associated with the tag object.

What is the character set for the keywords?

> +                       for (i = 0; i < keywords_len; ++i) {
> +                               unsigned char c = keywords_line[i];
> +                               if (c == ',' && keywords_line[i + 1] == ',')
> +                                       /* consecutive commas */
> +                                       return error("Tag object (@ char "
> +                                               PD_FMT "): Found empty keyword",
> +                                               keywords_line + i - data);
> +                               if (c > ' ' && c != 0x7f)
> +                                       continue;

And what is so special about 0x7f?


> +               if (keywords_len) { /* optional keywords string was given */
> +                       item->keywords = xmalloc(keywords_len + 1);

Who frees the keywords and what's wrong with strndup?
