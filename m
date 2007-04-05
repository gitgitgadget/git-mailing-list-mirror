From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-gui blame dividing by zero
Date: Thu, 5 Apr 2007 09:44:22 +0100
Message-ID: <200704050944.23500.andyparkins@gmail.com>
References: <200704041621.51390.andyparkins@gmail.com> <20070404161101.GF4628@spearce.org> <200704050933.14154.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 10:44:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZNa5-00024m-Gd
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 10:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbXDEIoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbXDEIoa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 04:44:30 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:12862 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964863AbXDEIo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 04:44:29 -0400
Received: by mu-out-0910.google.com with SMTP id g7so759582muf
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 01:44:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cLMt8ONSav0Ko47dOXuLhjqHpMt4+BMUJG71kBH3p+HimLNdED8uSvo11gPYGXDvJtcROLLu9Xc5TvMq410xApboeTDypbHdjsQ3iemPIgbpq8hxODygSsaiayZD3SzjpQlQhwnglLsaLWWL6oGApKRINCODmDsI+GI0+fsJfO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oBxqbSaLoFWRSnNp5EDHf/X+FmkZRln4rTNfbmO1dwAcQfJYhy5SfBDM9fpf3cWZBvOXCgNXEmwL88iDNJdK/XuZ7LmGoKBel7ivAX2f5tCRsmy8WHS94rHCtXWbqsdzHyOd1odUwdpDg1GY1VzxrtUxVHJKvndByMUYpMjD4rs=
Received: by 10.82.138.6 with SMTP id l6mr2158544bud.1175762667926;
        Thu, 05 Apr 2007 01:44:27 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id c25sm3114792ika.2007.04.05.01.44.25;
        Thu, 05 Apr 2007 01:44:25 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <200704050933.14154.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43809>

On Thursday 2007 April 05 09:33, Andy Parkins wrote:

> So; I think you've fixed a nasty bug, but that bug was only presenting
> because something else is messed up.  I'll poke around and see what I can
> discover (however, I don't understand tk so what I discover might be that I
> don't understand tk :-)).

Okay - got it.  Try this in the git repository:

 # this works
 $ git-gui blame HEAD templates/hooks--commit-msg
 $ cd templates
 # this doesn't work
 $ git-gui blame HEAD hooks--commit-msg
 # this works
 $ git-gui blame HEAD templates/hooks--commit-msg

The problem is that git-gui is calling git-cat-file to read the file, but 
git-cat-file expects a path from the repository root.  The current directory 
doesn't matter - you always have to type the path as if you're in the working 
dir root.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
