From: "David Frech" <david@nimblemachines.com>
Subject: Re: Another question about importing SVN with fast-import
Date: Thu, 19 Jul 2007 23:54:30 -0700
Message-ID: <7154c5c60707192354k7db677a6m4f8cbd474747ca92@mail.gmail.com>
References: <Pine.LNX.4.64.0707162204480.14971@reaper.quantumfyre.co.uk>
	 <7154c5c60707190009r6d460debs71158d4db9a028d4@mail.gmail.com>
	 <20070720051142.GO32566@spearce.org>
	 <Pine.LNX.4.64.0707200646400.18125@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Julian Phillips" <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 20 08:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBmNq-0005HT-7G
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 08:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbXGTGyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 02:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754540AbXGTGyb
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 02:54:31 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:46487 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbXGTGyb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 02:54:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so899694wah
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 23:54:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gIMrPTuYlmlb71Lir5U7/QdPi+gR9Taoxoac/w7pTzMiEIKFwVBUy6ah6lahBY4H615/eDp9xhziEaUXspRPrn6oCaMEuR9dZuhrSAwx8h6EtyfRMMyzEJO2kDA4fiPGY4G454WMa7tKamFKKMyagoJivMJV8aA7lL8EhoPDDKs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Ajuq9aXAIX+HoBGyxEAy7A2PsDyqDJWnRPfGv6YTUNCJQJHg1MhkdoDCUKKqB4W9EkO0t6S6sTliJiSCNXReVX2AagDPSde0viKtI/R9pqPIdbIk5EvMX2+4mPY4dxZMa6CNzxfeodwYLKdac7tU5EsZWTaySi/Y40FYcMrP5tk=
Received: by 10.115.93.16 with SMTP id v16mr155577wal.1184914470175;
        Thu, 19 Jul 2007 23:54:30 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Thu, 19 Jul 2007 23:54:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707200646400.18125@beast.quantumfyre.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: 93fc3134c6aa4b49
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53061>

On 7/19/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Fri, 20 Jul 2007, Shawn O. Pearce wrote:
>
> > It is possible.  I'm just not sure what the syntax for it should be.
> > Suggestions?  I really want to stay backwards compatible with the
> > current "C" command, so:
> >
> >       'C' SP commit SP path SP path
> >
> > is out because its ambiguous with the current meaning where the
> > second (destination) path can contain SP without being quoted by
> > the frontend.
>
> You could always make it part of the 'M' command?
>
> 'M' sp mode sp 'copy' sp path_str lf (ref_str | hexsha1 | sha1exp_str |
> idnum) SP path_str;
>
> Or just make it a new command, O (for other) or E (for existing) maybe? :S

Since we'll be referring to past commits via marks (with start with
":") how about this:

'C' SP srcpath:mark SP dstpath

In the case of making it a new command I can't think of any really
compelling one letter names. ;-)

- David

>
> --
> Julian
>
>   ---
> It is easier to change the specification to fit the program than vice versa.
>

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
