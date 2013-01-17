From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 20:19:28 -0600
Message-ID: <CAEUsAPY8T9TYCrZLWB-0Mwae_NtnqqVvGwY+4jGfqh5Lh3=Dgw@mail.gmail.com>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
	<DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
	<20130116160131.GB22400@sigill.intra.peff.net>
	<7vfw21xde5.fsf@alter.siamese.dyndns.org>
	<20130116174325.GA27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvf55-0006i0-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 03:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795Ab3AQCTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 21:19:31 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61669 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab3AQCTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 21:19:30 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so4176407wib.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 18:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=I2zb5+uSDxtXcRPMN+8T5wE9DDmpZmWhW3UJHVUlxgc=;
        b=l1bFkDeKv2YIBkezHzTrADX2eYVGCBYBaIL2fYqrWK0ZH4JdfpJRout4QJ54oZrc5Z
         VeRg+ocWVeAorxZp5Zvy/hmVzStRAerGcGl+43jbnjoxFwl8/5TO+OFhlbyaflow7zDo
         MsWLVxU4zPrGAn1G7jQ8VW6JjPs8wLyj3leQGc8isJMT1pcbEeAUgxl7QXzD98RLMuIS
         8OzVWVS5KeVx53a9ad01tAjK6U8z7CS7YzBZTLEO5GXRskKAj3MRWO1cvrfkrt0P+LKm
         JwKmvExfsK1fwxejtf2i+yqm3FEV3RygraEs2dcI6SfO5loIEIuCFDc/jVykMVOiIqie
         QafA==
X-Received: by 10.194.240.233 with SMTP id wd9mr5539368wjc.54.1358389168813;
 Wed, 16 Jan 2013 18:19:28 -0800 (PST)
Received: by 10.216.66.71 with HTTP; Wed, 16 Jan 2013 18:19:28 -0800 (PST)
In-Reply-To: <20130116174325.GA27525@sigill.intra.peff.net>
X-Google-Sender-Auth: vvVRnA6EeIPB7VV5DiPOCa4OIqs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213836>

On Wed, Jan 16, 2013 at 11:43 AM, Jeff King <peff@peff.net> wrote:
> I think that is a reasonable rule that could be applied across all parts
> of the namespace hierarchy. And it could be applied by the client,
> because all you need to know is whether ref->old_sha1 is reachable from
> ref->new_sha1.

is_forwardable() did solve a UI issue.  Previously all instances where
old is not reachable by new were assumed to be addressable with a
merge.  is_forwardable() attempted to determine if the concept of
forwarding made sense given the inputs.  For example, if old is a blob
it is useless to suggest merging it.

Chris
