From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'Unable to find remote helper'
Date: Mon, 8 Nov 2010 13:37:27 -0600
Message-ID: <20101108193727.GA6348@burratino>
References: <F815EC90C848458886E418CB6DE1DA8B@ssipboulton>
 <20101104224010.GA18693@burratino>
 <7vzktjprwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Boulton <philipb@ssimicro.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:38:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXXb-0000UH-6V
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab0KHThy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:37:54 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62966 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab0KHThq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:37:46 -0500
Received: by bwz15 with SMTP id 15so299963bwz.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HDeTuLSLGHH8ZjRPT294/vtvNCwJ7J624x5j29OVY1I=;
        b=UQl4Q1RHGd+g8esdE656pouJZ/lpsTFdieJ3TVmHcyvYVaDNBzpj6QpsfV0Gsvjz7v
         mMF9swrNeg3sk005mq2Om+TD+EVEf458zRzVCXmFbgZOgDtiQo7cSpCucAmyiXU6Ac6D
         ZVlUo4h0VboMhMW6xM4ugrB4Ow5AXYoOBqcUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mfFRF1s6BxH+FYlzohmC0UO4d17Pyjua4fBKPCPNVmNjce8cBqCkKmx99eQ/AV/SV1
         7kKVhSTEbXP9tjbE9iTX7yIedhSreE+uWw5GdiovCqbgN4XkJIFq/weQmAHV+STPfdwK
         i7/4vPihV9RQso1UQKCGHng/l1g1l4w77KXZg=
Received: by 10.204.24.144 with SMTP id v16mr5253596bkb.137.1289245065405;
        Mon, 08 Nov 2010 11:37:45 -0800 (PST)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id c40sm49446fay.0.2010.11.08.11.37.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 11:37:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzktjprwt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160974>

Junio C Hamano wrote:

> You diagnosed the problem correctly, but I do not think the patch is
> correct.  Why should the generated file *.autogen be kept around across
> "clean"?

Fair enough.  The thought was that most autoconfiscated packages
support

	./configure
	make clean
	make
	make install

since "make clean" does not remove the generated Makefile.  But the
patch was incomplete anyway, since it did not keep config.mak.append
around.

> I do understand why we keep "configure" around (it is common for everybody
> once it is generated), though.

Hmm, isn't the usual scheme something like

 - "make clean" undoes the effect of "make"
 - "make distclean" removes all generated files that are not common
   to everyone
 - "make maintainer-clean" removes all generated files

?
