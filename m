From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: Always set 'from_file' and 'to_file' in parse_difftree_raw_line
Date: Fri, 2 Nov 2007 00:46:25 +0100
Message-ID: <200711020046.26083.jnareb@gmail.com>
References: <1193917089-15920-1-git-send-email-jnareb@gmail.com> <1193917089-15920-2-git-send-email-jnareb@gmail.com> <7v7il18twn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 00:46:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InjkT-0002Ul-4H
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 00:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbXKAXqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 19:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbXKAXqh
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 19:46:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:43699 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbXKAXqg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 19:46:36 -0400
Received: by ug-out-1314.google.com with SMTP id z38so563473ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Yrg+TiKWwJEi3sNHyfB8jrjIuDDzz/8zVMHCx8FiMik=;
        b=XTtjI8nRJdzJZ1h3KCAEA1OepiAV/twNYQUtnCIWO4IJ4xFav8kOW1JmuqVU0Ik2axLph1g67fIFPfZj8BOKxnIHQP8ODaDqvDsPH3dE2rLc62H+BOWlOgudhMQy31/elKesXSzFseOMcJ3UTZ1mURFQX9vkOhfPpouENN1On7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KAecwYTC9XWEI9x7JnL1pOvLmK99fbrpVAK1C+l6oscYiMes2cP0Oy+DnBQbzdebh8yCQ1LmpgYtXL/bQ1k+CYWshG9PB6o2R6XTb0c0/+mBhHiDleEclXWWq3X9y0P1sTA4Oubhu2POKZZAt93i25MvpLzFRS8ssptkZvYZdwM=
Received: by 10.66.221.6 with SMTP id t6mr3010018ugg.1193960794975;
        Thu, 01 Nov 2007 16:46:34 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.154])
        by mx.google.com with ESMTPS id 30sm6935158ugf.2007.11.01.16.46.32
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 16:46:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v7il18twn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63035>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Always set 'from_file' and 'to_file' keys when parsing raw diff output
>> format line, even if filename didn't change (file was not renamed).
>> This allows for simpler code (and no problems with file named '0').
>>
>> Use
>>   $diffinfo->{'from_file'}
>> instead of
>>   $diffinfo->{'from_file'} || $diffinfo->{'file'}
>> from now on.
> 
> Isn't this description the other way around?

Description is in good direction, although I agree that it is
a bit awkward. Perhaps it should read:

Instead of
  $diffinfo->{'from_file'} || $diffinfo->{'file'}
it is now enough to use
  $diffinfo->{'from_file'}

(because $diffinfo->{'from_file'} is now _always_ set, not only for
renames and copies, when from_name and to_name differ).

-- 
Jakub Narebski
Poland
