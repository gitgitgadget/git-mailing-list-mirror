From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/6] gitweb: Add combined diff support
Date: Tue, 8 May 2007 03:50:25 +0200
Message-ID: <200705080350.26061.jnareb@gmail.com>
References: <11784930091585-git-send-email-jnareb@gmail.com> <7vvef45cev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 03:46:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlEmF-0004Qj-5U
	for gcvg-git@gmane.org; Tue, 08 May 2007 03:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934599AbXEHBqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 21:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934540AbXEHBqA
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 21:46:00 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:41511 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934599AbXEHBp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 21:45:59 -0400
Received: by py-out-1112.google.com with SMTP id a29so1354620pyi
        for <git@vger.kernel.org>; Mon, 07 May 2007 18:45:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rdgVmo3oQnoRG6NqHr6J17GDWSt4jqyhK7oQS2eoYCk14d27cvfI2IXyA2jnsHeK3DW6/hcAYLj+tg8aJUG5qDSCdfYRY1aTPbHe1tlkmr9VpLZ2mdNaBg5Z86rVgWmIIkZ5R2W+QWOn2U31tb1+sv4dUzA8WrSzAo1z6ST8vnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HnZuCBBuHwOytQiruGr46XRfTIHNr741UppG18bd7x6Cb804EwAtbPPAwbEuau++x8atX+OfekmIsCbc98yeJzxtzvvCHC24cnjCocwXGQyDYRupm+TJydaanuR9cnJHnMJzZhIuyRrExtRtbYmj9na3sO9mI2CX98gQ4pu7OaM=
Received: by 10.65.180.7 with SMTP id h7mr11166937qbp.1178588758910;
        Mon, 07 May 2007 18:45:58 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e17sm6240672qbe.2007.05.07.18.45.55;
        Mon, 07 May 2007 18:45:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvef45cev.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46510>

Junio C Hamano wrote:

> I've minimally tried this on my private machine.  Looks pretty
> nice for simple merges, but I think we would want --cc not -c
> most of the time.

Please note that --cc would need some changes to both git_difftree_body 
and git_patchset_body; it is not just matter of replacing 
'-c' by '--cc'. Hunk simplification might mean that whole patch 
vanishes. So sometimes we have difftree (raw diff, whatchanged) line 
which does not have corresponding patch, and there should be no "patch" 
link (this is harder part). This mean also that in git_patchset_body we 
need sometimes to skip some difftree line / difftree info line (this is 
easier part).

-- 
Jakub Narebski
Poland
