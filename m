From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Tue, 15 Nov 2011 03:52:25 -0600
Message-ID: <20111115095225.GB23139@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 10:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQFgx-0007jM-OW
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 10:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab1KOJwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 04:52:30 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36629 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1KOJwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 04:52:30 -0500
Received: by iage36 with SMTP id e36so8253445iag.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 01:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jo+XZ2GybZusQP/S5I46mS2AODjetoDLoudv8uhUczA=;
        b=rpZpt7KEeOYq7DS5SyJPKP59sGHeO6/uAGOgIaiQZLVHEgxf0ZXFVnqn2EkuWPQJ40
         BPjDo2pIiKMd2o6ZJjowG0XAIUKigYPGorU5/F3dRZc9127OzsfrCH5wWdhS4dotPcW7
         jEHf6ePgd+yJC8FizwWmkGlpI8W2k45Ul6qJk=
Received: by 10.42.136.196 with SMTP id v4mr26390415ict.3.1321350749717;
        Tue, 15 Nov 2011 01:52:29 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p16sm34238215ibk.6.2011.11.15.01.52.28
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 01:52:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185450>

Ramkumar Ramachandra wrote:

> Yeah, git_path() writes to one of the four static buffers in
> path.c:get_pathname().  Which brings me to: what should (can) we do
> about it?

Just use a sane idiom.  Which means: as few git_path() values in
flight at a time as possible.

In other words, do not save the git_path() result in a variable, but
pass it directly to whatever computation needs to use it.
