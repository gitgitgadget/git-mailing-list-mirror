From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v3] perl/Git.pm: add parse_rev method
Date: Mon, 02 Jun 2008 15:51:18 +0200
Message-ID: <4843FAD6.6020705@gmail.com>
References: <1212241932-28605-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-1-git-send-email-LeWiemann@gmail.com> <1212290243-19393-2-git-send-email-LeWiemann@gmail.com> <4842DE78.7000006@gmail.com> <20080601215449.GC29404@genesis.frugalware.org> <484327FB.8080105@gmail.com> <7vk5h8a0up.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 15:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ASV-0006le-4h
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 15:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbYFBNvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 09:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYFBNvT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 09:51:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:30068 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980AbYFBNvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 09:51:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so740991fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=qR8hjRh7WT4vfb7lEbU+0P3E1UI1VKV9NXD4YiBFelo=;
        b=KTO/ZVA0G5oqti1+Ltj22NwL3oQCkco9gURKR5EVNCSwM3i2gfgJmy5/1U/ywVSFabsJqrkhrunmU8NfPRNZnx+MA3rRJPndo191RvAz1fN8O/DrWoFs7BZMQ9vEfiBFi63uArNf4el8/rddNmKK1mq9I1Vz4lJ3UuFbmVhC5sI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=UsDY+BZMq/IKoOLvMiS8CyVoU8O4IZ6Wc+9rwj3OQmA1WBT8nmM0n1rcCGMTZd9pvbfcrQVRqhPkOTctQNn+Ok6ECG1MxzfwSXG5ge1/4MIjKtCfzB+6aux9GpZMgSHx/4WFQ//U6A9PK131p3BXGvUMLSgx3FKhyebbf4NigqI=
Received: by 10.86.23.17 with SMTP id 17mr3566698fgw.32.1212414677423;
        Mon, 02 Jun 2008 06:51:17 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.205.25])
        by mx.google.com with ESMTPS id 4sm3700428fgg.9.2008.06.02.06.51.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 06:51:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7vk5h8a0up.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83520>

Junio C Hamano wrote:
> I think that is sensible, and the method can stay parse_rev, not get_hash,
> don't you think?

I'm not sure -- on the hand hand, parse_rev resembles "rev-parse" and 
might be more intuitive for that reason.

On the other hand though, the mis-named "revision" arguments get passed 
into many methods (right now get_hash, get_type, and cat_blob, but many 
more to come).  Calling them "revision" everywhere is bound to cause 
major confusion, so I'll probably have to rename the arguments anyway. 
But then, get_hash will be much more intuitive to understand than 
parse_rev since the API won't talk about "revisions" anywhere.

Also, get_hash indicates that it returns a hash and implies that it 
takes an object name, but parse_rev indicates neither of those.  Since 
Git.pm doesn't mimic Git's command-line API anyway, I'd rather have 
clear method names.

-- Lea
