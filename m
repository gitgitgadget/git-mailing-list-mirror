From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 22:14:43 -0800
Message-ID: <20130211061442.GI15329@elie.Belkin>
References: <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:15:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mfa-0007d2-Kf
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab3BKGOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:14:52 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:51717 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab3BKGOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:14:51 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so552048pbc.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PdsV5GJL4/krckV3aRDjTZlxGpm5h5fwmYl42r2s1I0=;
        b=sK0Qr94w+19J1r2WfPB5BiV3qM9SYa4i41I9ZVLIsiYmZ9MGcUF/4hd0QhUwtogVvC
         ANXgE8gfeUbhBGf6EsuhQOQ1agTPCZlzxgMJa/wE8y+Rccox0lLPcPhJx+EM9bn/UucY
         bljHyuSxC/GS+XJHObWUH/jqN0+GcBDYdd6K6kl6HYspTZX5EbCAv137FKB7FgOShE9i
         1D6pugSIe/V4TFJxnMLj26waLIpogVm+hCZhVmC1IfRbxHt3ia9SzC9t8HA36Szk3BgY
         vx54ERe0hSgS9UpiVeaFhA6BqmQiRnLwxBttoov67cjjeuvIAAaPQH1G1SuFJzn5DUdw
         QsnQ==
X-Received: by 10.68.0.101 with SMTP id 5mr15791995pbd.22.1360563290760;
        Sun, 10 Feb 2013 22:14:50 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id sf2sm6632756pbb.8.2013.02.10.22.14.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 22:14:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216001>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Junio C Hamano wrote:

>>>               Are you shooting for customizability?
>>
>> Yes, and the ability to generate the message dynamically.
>
> Hmph, if that is the case, wouldn't it be a better direction to give
> a better help for majority of the case where git-shell is used as
> the login shell to allow push and fetch but not for interactive
> access at all?
>
> The first step in that direction may be to give a better canned
> message, followed by a mechanism (perhaps a hook) that lets a
> message customized for the site's needs, no?

The trouble is that I can't imagine a canned message that everyone
will like.  (For example, I quite dislike the current one.)  That's
exactly the situation in which some configurability is helpful.

Some configurability is nice for other situations, anyway.  For
example, sites serving a multilingual audience may want the message to
vary based on the user's language (or even source IP).  The message
can include a list of available repositories or extra information that
changes over time.  And so on.

Hope that helps,
Jonathan
