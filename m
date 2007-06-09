From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 07/21] Copy the remaining differences from verify_tag() to parse_tag_buffer_internal()
Date: Sat, 9 Jun 2007 23:31:51 +0200
Message-ID: <81b0412b0706091431h3a786aaew342693a667938d9@mail.gmail.com>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	 <200706090210.36270.johan@herland.net>
	 <200706090215.31731.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 23:31:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8XK-0007nq-Qf
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486AbXFIVbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbXFIVbx
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:31:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:1553 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbXFIVbx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:31:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1202530ugf
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 14:31:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rtGsWhVMqP9+vUAgaG6nFrHvTqpYHyjbTPFv+ZQozn/04+DZPrWc46rdI8dZkt8GsAlaqCwFnRBpOQ2vJOFOB5AoX8fe3W3X4/8/rhRxJBNqKq4OiXxlIdTDeFSODJeGvfzNA6LWdam0sWnUJsv0w7xFiyyiQl8Lnxndh4t8sq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=psTfUR+WmUUj++dv3/ZqEOcICAFcakCY4o61bE529IQ0Sr0ENsy6axOBPFZ/ZbmB7FhdkmpAqSG4P11ZiPSITg2krS5fW4W9NPbHchtDG9ecgf/jGQFvattfXTbNoARIWk4E3cjyMkYjRiRK0lHfHc1vOmjkIiKHleA04TMVWp8=
Received: by 10.78.166.7 with SMTP id o7mr1216348hue.1181424711516;
        Sat, 09 Jun 2007 14:31:51 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Sat, 9 Jun 2007 14:31:51 -0700 (PDT)
In-Reply-To: <200706090215.31731.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49617>

On 6/9/07, Johan Herland <johan@herland.net> wrote:
> +               /* Verify the tag-name: we don't allow control characters or spaces in it */
> +               for (i = 4;;) {
> +                       unsigned char c = tag_line[i++];
> +                       if (c == '\n')
> +                               break;
> +                       if (c > ' ')
> +                               continue;
> +                       return error("char" PD_FMT ": could not verify tag name", tag_line + i - data);
> +               }

This looks very familiar. Haven't you just made a very useless patch
which had this very same code? How about putting it in its own
function and just call it from these two places? And what problem
do you have with pointers?!
