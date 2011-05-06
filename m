From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] tests: teach verify_parents to check for extra
 parents
Date: Fri, 6 May 2011 16:42:38 -0500
Message-ID: <20110506214238.GE20182@elie>
References: <20110503090351.GA27862@elie>
 <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org>
 <20110506205441.GA20182@elie>
 <20110506210021.GC20182@elie>
 <7vzkmzy0mk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:42:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QISnS-00056v-08
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 23:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582Ab1EFVmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 17:42:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43636 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab1EFVmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 17:42:43 -0400
Received: by iwn34 with SMTP id 34so3006808iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JlLxMJWjsP9zgAgH8zbufVbOoOCkMcc6zl7vlBA0KMM=;
        b=pTtQbIZffYSeAqAtk9lGMadaFeCbHXSxaPS6/5Rodj6QZ14Rb3FRZx1RDybxfbZP6T
         YLa33tFXVUgF4cz00CRo5DdIARzmBBNsZB3+OiNxVZxMbtuqIpIDokX6GcE0vwVyrVKK
         VqP6m8WFy8G+3y2u9xXc9V9+f4xhW1YlFFH28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iognposcZjxFjsWMQmi3pqYLEN0cEK+GjqqybEyoCiDyhzqAy/8+gybJakDJ8IA2F8
         h+1kluHylSyv908RKiAxEu970ZCXdHcctKZEdDPx9ZgGQ7pDUh9HvMGaEvglO2KstaMy
         9G2L/K7+rHYF47xVKHryqZIQmamxxgh2UWC1s=
Received: by 10.231.66.146 with SMTP id n18mr2681880ibi.14.1304718162924;
        Fri, 06 May 2011 14:42:42 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id gx2sm1488403ibb.9.2011.05.06.14.42.41
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 14:42:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkmzy0mk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173015>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/t/t7600-merge.sh
>> +++ b/t/t7600-merge.sh
>> @@ -89,6 +89,7 @@ verify_parents () {
>>  		i=$(expr $i + 1) ||
>>  		return 1
>>  	done &&
>> +	test_must_fail git rev-parse --verify HEAD^$(($# + 1)) &&
>
> Isn't $i at this point the same as that complex $(()) line noise?

Yes, that sounds better.
