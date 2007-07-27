From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH 2/2] gitk: Markup many strings for translation.
Date: Fri, 27 Jul 2007 13:19:08 -0700 (PDT)
Message-ID: <959247.27950.qm@web38905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 22:19:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEWHX-0008DU-Fy
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 22:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936127AbXG0UTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 16:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936130AbXG0UTL
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 16:19:11 -0400
Received: from web38905.mail.mud.yahoo.com ([209.191.125.111]:47709 "HELO
	web38905.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S936127AbXG0UTK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 16:19:10 -0400
Received: (qmail 28170 invoked by uid 60001); 27 Jul 2007 20:19:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=XyRPmdkZUFver3tkeco0dXcemgAvxyd9i92PntFPuxgs4udkIO0UFRKiJViy3CKWSceBgzVA7/N84nhNS8vMlWO41kLTykbM56jj+jbDN/h5iq4v91IqU7KbE18iMhzxr5sDMFLw7wUpIKi4DkDCkGkexwaADKPHtwHQXw58h0Q=;
X-YMail-OSG: su56iTIVM1kksAf59Z2v7VxciBRRRBQVBbzfNmwhtOPb_1CCL9k0OKYTkv5y05RFpemH3un1rektyTgJv96aSRHLyBCjjOUbgwkVrHmvYtfzs0ukVW.FE79wmw--
Received: from [128.251.88.135] by web38905.mail.mud.yahoo.com via HTTP; Fri, 27 Jul 2007 13:19:08 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53963>

> 
> ----- Original Message ----
> From: Christian Stimming <stimming@tuhh.de>
> To: Paul Mackerras <paulus@samba.org>
> Cc: git@vger.kernel.org
> Sent: Friday, July 27, 2007 8:03:00 AM
> Subject: [PATCH 2/2] gitk: Markup many strings for translation.
> 
> Similar to the discussion in git-gui, all user-visible strings are  
> passed through the [mc ...] procedure to have them translated by msgcat.
> 
> Signed-off-by: Christian Stimming <stimming@tuhh.de>
> ---

<snip>

>   proc getcommitlines {fd view}  {
> @@ -273,7 +273,7 @@ proc chewcommits {view} {
>           #set ms [expr {[clock clicks -milliseconds] - $startmsecs}]
>           #puts "overall $ms ms for $numcommits commits"
>           } else {
> -        show_status "No commits selected"
> +        show_status [mc "No commits selected"]
>           }
>           notbusy layout
>           set phase {}
> @@ -378,7 +378,7 @@ proc getcommit {id} {
>       } else {
>       readcommit $id
>       if {![info exists commitinfo($id)]} {
> -        set commitinfo($id) {"No commit information available"}
> +        set commitinfo($id) {[mc "No commit information available"]}

I think this is probably a typo (on the original), and carrying that forward will probably result in what was not intended.

The original has the {} and "". I don't know if this was intended (it will keep the quotes).

The translated version, will result in a literal string [mc "No commit information available"], and unless it is explicitly eval'ed later, it will not result in the translated string.

So, if the quotes need to stay in the string, then the translation will have to be:

  set commitinfo($id) \"[mc "No commit information available"]\"

Or, if the quotes are not needed:

  set commitinfo($id) [mc "No commit information available"]


Regards,
    --brett


       
____________________________________________________________________________________
Pinpoint customers who are looking for what you sell. 
http://searchmarketing.yahoo.com/
