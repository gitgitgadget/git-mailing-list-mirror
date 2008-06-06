From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA recountdiff)
Date: Fri, 6 Jun 2008 00:18:56 -0500
Message-ID: <5d46db230806052218r67e79a46rd0150cd9fe2af970@mail.gmail.com>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
	 <4847F49F.8090004@viscovery.net>
	 <alpine.DEB.1.00.0806051548140.21190@racer>
	 <48480123.7030903@viscovery.net>
	 <alpine.DEB.1.00.0806051719170.21190@racer>
	 <alpine.DEB.1.00.0806051720070.21190@racer>
	 <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0806052304300.21190@racer>
	 <alpine.DEB.1.00.0806060005581.21190@racer>
	 <alpine.DEB.1.00.0806060006370.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 07:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4UMr-0005RF-BF
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 07:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbYFFFS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 01:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbYFFFS5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 01:18:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:10547 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbYFFFS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 01:18:57 -0400
Received: by yw-out-2324.google.com with SMTP id 9so598890ywe.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 22:18:56 -0700 (PDT)
Received: by 10.150.122.13 with SMTP id u13mr2854513ybc.69.1212729536183;
        Thu, 05 Jun 2008 22:18:56 -0700 (PDT)
Received: by 10.150.12.16 with HTTP; Thu, 5 Jun 2008 22:18:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806060006370.21190@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84023>

On Thu, Jun 5, 2008 at 6:06 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> +
> +               switch (*line) {
> +               case ' ': case '\n':
> +                       fragment->newlines++;
> +                       /* fall through */
> +               case '-':
> +                       fragment->oldlines++;
> +                       break;
> +               case '+':
> +                       fragment->newlines++;
> +                       if (line_nr == 0) {
> +                               fragment->leading = 1;
> +                               fragment->oldpos = 1;
> +                       }
> +                       fragment->trailing = 1;
> +                       break;
> +               case '@':
> +                       return size < 3 || prefixcmp(line, "@@ ");
> +               case 'd':
> +                       return size < 5 || prefixcmp(line, "diff ");
> +               default:
> +                       return -1;
> +               }
> +               line_nr++;
> +       }
> +}

Perhaps this is accounted for and I did not see, but I believe that
a backslash is used for the "no newline at end of file" line.  Does that
need to be allowed here?

Thanks,
Govind.
