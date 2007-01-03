From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Possible regression in git-rev-list --header
Date: Wed, 3 Jan 2007 11:21:33 +0100
Message-ID: <8c5c35580701030221w5c04e2eaq757d12c4ca0b0780@mail.gmail.com>
References: <e5bfff550612300956mef4691fqf607fad173c571da@mail.gmail.com>
	 <7v7iw9jftv.fsf@assigned-by-dhcp.cox.net>
	 <7vlkkphvrb.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0612310211300.25709@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64bsj0s4.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550612310345j4c882b7av51879ca1175a1c6b@mail.gmail.com>
	 <Pine.LNX.4.63.0612311613180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550612310743t4ca1b017ubceddffafd06ac59@mail.gmail.com>
	 <7vodpja0u8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 03 11:22:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H23G9-00055m-2T
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 11:22:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbXACKVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 05:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbXACKVf
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 05:21:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:57568 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbXACKVe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 05:21:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5128591uga
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 02:21:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CLdUfEr6akOY6TPYaA5Ez/FxWKsYL717cQKERpYGQMDldvkoBKDJv/Hjysi0GBHe4NJe6GLoBlen//z41REsesiCXAlsOOcglSyA2QQTPKFPkmbSMGo7Q9ZOIRJZdNlp+Or2RbGmO0ATipaPyHbs8BfaYcJz47xFGZi7rJlGDOI=
Received: by 10.82.169.4 with SMTP id r4mr1694630bue.1167819693290;
        Wed, 03 Jan 2007 02:21:33 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Wed, 3 Jan 2007 02:21:33 -0800 (PST)
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550701030121n700fab25x63278457c884a3f7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35854>

On 1/3/07, Marco Costalba <mcostalba@gmail.com> wrote:
>         - one blank line
>         - zero or one line with log title
>         - zero or more lines with log message
>         - a terminating '\0'

I think the should be:
  -zero or more blank lines
  -zero or more non-blank lines with log title
  -zero or more blank lines
  -zero or more lines with log message
  -a terminating '\0'

...which implies that all of these rules (except the last) are
optional and only triggers if the _previous_ rule triggered.

In other words:

  commit ::= header [blank+ [title+ [blank+ text*]]] '\0'
  header ::= tree parent* author committer

-- 
larsh
