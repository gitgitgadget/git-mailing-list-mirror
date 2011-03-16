From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] diff --submodule: split into bite-sized pieces
Date: Wed, 16 Mar 2011 14:33:50 -0500
Message-ID: <20110316193350.GA8179@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
 <20110316071411.GI5988@elie>
 <4D8104DC.2010700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 20:34:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzwTw-0001JO-F3
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 20:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab1CPTeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 15:34:00 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40438 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab1CPTd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 15:33:58 -0400
Received: by qyk7 with SMTP id 7so3751952qyk.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 12:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tXNuSqO6nQIUORiE2x/D1ynMbQjE2ZLBAPwNezkce0w=;
        b=TN70dsGDS4Z2wwKzfGQr+Uo3r0BLPd7jYbvXAnSzSSGCoTGe6SDCx/MxfCRPxmrB1y
         IZKXdBok9tRsjsmGHOgYYQqvX9kVl7Qm0Jd9Rd6KO5xuZkHoZ9+x8Kv9psl1auSiuTQA
         1eChgX8aKs4YrKP/2Cm3VvlOhcQDglJZIVNdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xnDgdMAdT1MgJq6xMLFUtd8h2cBmhfc63gJN04ubfpQ7u3wWGzRUhKftl85C1THy4P
         BlxYR1Hou1/SqzWC40btVJ4pYwVpEuTb+CyfyfWBqtT/ku4Kj5xtiEJ4tHtF/SsZiOtu
         3Rx2cJgvLHKHROzfWdO0DwtHoLowW0Smg2DEY=
Received: by 10.229.66.151 with SMTP id n23mr352950qci.268.1300304038162;
        Wed, 16 Mar 2011 12:33:58 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id y17sm920040qci.33.2011.03.16.12.33.54
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 12:33:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8104DC.2010700@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169183>

Jens Lehmann wrote:
> Am 16.03.2011 08:14, schrieb Jonathan Nieder:

>> Introduce two functions:
>> 
>>  - prepare_submodule_summary prepares the revision walker
>>    to list changes in a submodule.  That is, it:
>> 
>>    * finds merge bases between the commits pointed to this
>>      path from before ("left") and after ("right") the change;

pointed to at this path before [missing "at", spurious "from"]

>>    * checks whether this is a fast-forward or fast-backward;
>>    * prepares a revision walk to list commits in the symmetric
>>      difference between the commits at each endpoint.
>>
>>    It returns nonzero on error.
>>
>>  - print_submodule_summary runs the revision walk and saves
>>    the result to a strbuf in --left-right format.

runs the revision walk and prints the result in --left-right format
[the strbuf is an implementation detail; not sure how it snuck into
the commit message]

>> The goal is just readability.  No functional change intended.
>
> Ack, looks good and makes sense to me.

Thanks, Jens.  Looking back over the commit message I see I left in
some typos but the patch still looks good to me fwiw.
