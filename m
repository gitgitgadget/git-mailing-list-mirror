From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: name-rev --stdin is slow
Date: Fri, 20 Jun 2008 00:09:18 +0200
Message-ID: <485AD90E.6000309@gmail.com>
References: <485ACB34.2020901@gmail.com> <alpine.LNX.1.00.0806191755510.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 00:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9SKh-000534-W2
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 00:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYFSWJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 18:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbYFSWJW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 18:09:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:47904 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYFSWJW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 18:09:22 -0400
Received: by fk-out-0910.google.com with SMTP id 18so956298fkq.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 15:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=JtcBCl+momTvB9+6Ml+ZRWLMl6XFtak06Zpqek8cyHA=;
        b=PWHgFbpdouVmarivJjSJ5x13TWTu9blM82TtpuNQoMTkjXXf6fC9MNEECsbi4Gjo62
         8n0GcpS3IJxj+TD2utfrbQWvBhJqeuh75wFD5toBfNhW+C2YfqkdtbeS1xA9Jgj+isQ+
         VQrz3uPv5u++hlZkGeorBha+7g/iJGhJS/QYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=TQI3YJMN68UZCJB2A49PEkMdn4Bei8qVkwAf5JjlaZH3dU54Gx3IuznuQ2Surgol+1
         YOr9RIVNoXhFnxuGghq+TEaJZNOcrQ50BoRBiGaAvpUJtB7A1yvbE8LVTav4m4YESlVz
         xs3e/NtmfcIA/R8zxhmcqhoDylEsN/xtH8mTc=
Received: by 10.78.165.16 with SMTP id n16mr1278202hue.53.1213913360506;
        Thu, 19 Jun 2008 15:09:20 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.204.94])
        by mx.google.com with ESMTPS id 39sm1944950hui.60.2008.06.19.15.09.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Jun 2008 15:09:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LNX.1.00.0806191755510.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85547>

Daniel Barkalow wrote:
> Actually, I think it's the reverse: without --stdin, name-rev can do a 
> first pass that lets it eliminate a lot of data from consideration; with 
> --stdin, it doesn't know if an item it hasn't seen is going to need some 
> data, and so it's conservative and doesn't eliminate anything,

Are you sure that's the case?  time git-name-rev --stdin < /dev/null 
gives the same high startup time without looking up anything.

Anyways, it would be great if someone could try to fix that, since a 
6-second startup time on a repository like linux-2.6 makes the --stdin 
option unusable for applications like gitweb (for which it would 
actually be quite useful to reduce the number of forks).

-- Lea
