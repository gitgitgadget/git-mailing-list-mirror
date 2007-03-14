From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 18:15:32 +0100
Message-ID: <81b0412b0703141015m1f7cb68dkf89fe13a968a30d0@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
	 <7v6494dwms.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140701h60982fddw3ed8fa71288cb220@mail.gmail.com>
	 <7v1wjrby4w.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0703140933v5c684aa9g1f61d61e502c6783@mail.gmail.com>
	 <7vodmvah5e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRX51-0004o8-6D
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 18:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbXCNRPq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 13:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbXCNRPp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 13:15:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:64691 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbXCNRPe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 13:15:34 -0400
Received: by nf-out-0910.google.com with SMTP id o25so309057nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 10:15:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XZ/giLOzfcKiD5vFIK8Q3NdjR85xVQzbejw+OZm1FM1lTNMtwlrywNM3iOIraIZW+U2qp7k6jRqauZYW9mpApnuZX7Ynb7XYH6Vx4dEa359HbJxk0BEib4gWH8xPn3wE0WE17PxRalqp3S267uaT0ZpS4m7xvK6uApvcXec0QAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=svS9N2lO6qSmWXe2x0BwOuooG1JmJM+3EA6VKJe5U6HEpt2kOyR96LA2mkxO2MiXcGB0+hb4T0RuiqKVaziJ49CBCFd7e63CWHuPhQOrmlg8ZiQkgXeShKERnQlcxHlXkWJVK2/GuRywSWvcFcfG8C7gd8NOfyQLzcqC/Os9vwM=
Received: by 10.78.201.2 with SMTP id y2mr1323441huf.1173892532906;
        Wed, 14 Mar 2007 10:15:32 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 10:15:32 -0700 (PDT)
In-Reply-To: <7vodmvah5e.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42216>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> >> > -     return run_diff_files_cmd(&rev, argc, argv);
> >> > +     result = run_diff_files_cmd(&rev, argc, argv);
> >> > +     return rev.diffopt.diff_exit_code ? rev.diffopt.exit_code: result;
> >> >  }
> >>
> >> Yuck.  Let's call the former "exit_with_status" (meaning, the
> >> caller instructed us to do that) and the latter "has_changes".
> >
> > I like "exit_with_status". But has_changes looks confusing
> > good near return value of run_diff_files_cmd, which "has"
> > nothing. Or do you mean to highlight this "difference"?
>
> Maybe 'found_changes' would be a better name, then?
>
>         if (exit_with_status)
>                 return !!found_changes;
>         else
>                 return result;

Nah... has_changes has almost the same meaning,
and I'm weary regarding making it a changing counter
(which one can assume it to be when seeing !!found_changes).
And I already sent the patch off.
