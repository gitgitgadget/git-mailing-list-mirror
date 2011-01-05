From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git fails on large repo clone on intermittent, or
 intermittently-high-latency, connections
Date: Wed, 5 Jan 2011 11:54:12 -0600
Message-ID: <20110105175412.GA21863@burratino>
References: <AANLkTinkhmHpAQjraviKjqFAczThR5GtT_qdyf6Sb3nm@mail.gmail.com>
 <m3tyhnbcf7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 18:54:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaXZ5-0005NH-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 18:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab1AERyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 12:54:23 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62315 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab1AERyW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 12:54:22 -0500
Received: by qyk12 with SMTP id 12so17628878qyk.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C8Iwe/eNFAYqlauo3sp7SQn8bj5kSD1ufubS2pUcem0=;
        b=GgkyeHTSHmoJLxvW+k2De+3o1TKfXOxTguheo+Bn4VxvEJJRWm21w7zSGsDW1Bu70x
         uPimV5jwfnjzg5Rx7aSFs5FWGZt3PP9JqWiPSAeq4Qp7+6EOPOiZuiBqqpBHXi94ZqXs
         mpP1+8E2BaR8q/tRfaTjN0yaVpesMkNhhKuM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UOq2HTxdKztNx00a7V0JlQcC1UP6iT7vGZeZeuLIS8JG3q7hKssN6zx360AcmzmzUJ
         nhzrrYKjPBlkskbqltr8eUelUZVl0Dds+r3T0h/zJehXhrKMkGRI6wzGPDrKMrB/TJ0N
         XrOwrxyU3+sWK8TUpFm8/p4FGBtt9OXexCRrk=
Received: by 10.224.73.149 with SMTP id q21mr21842996qaj.209.1294250061623;
        Wed, 05 Jan 2011 09:54:21 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id t7sm12566583qcs.4.2011.01.05.09.54.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 09:54:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3tyhnbcf7.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164577>

Jakub Narebski wrote:
> Zenaan Harkness <zen@freedbms.net> writes:

>> How hard would it be to add a wget-like mode to git, for the initial
>> repo download?
>
> Very hard; tthough "resumable clone" was often requested (25%
> responders in "Git User's Survey 2010", see [1]), and there was even
> some discussion about possible implementation, it was not implemented
> yet, even as proof of concept.
>
> The trouble is that packfile is *generated for a client*, and
> bit-for-bit representation of said pack can vary (e.g. if
> multithreaded packing is enabled; usually a good idea).

That said, one possible partial solution would be to automate
generation of a seed bundle for huge repositories (with a script or
a special parameter to "git gc", maybe) and to document serving such a
seed bundle over HTTP as part of the standard setup.  If this could be
made simple enough that e.g. all large repos on repo.or.cz had such a
seed bundle then I would call it a success. :)
